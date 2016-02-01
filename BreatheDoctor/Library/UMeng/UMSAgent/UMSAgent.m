//
//  UMSAgent.m
//  DiabetesPatient
//
//  Created by 郑建武 on 15-2-13.
//  Copyright (c) 2015年 com.comvee. All rights reserved.
//

#import "UMSAgent.h"
#import "SFHFKeychainUtils.h"
#import "OpenUDID.h"
#import <CommonCrypto/CommonDigest.h>
#import <AdSupport/AdSupport.h>
#import "ActivityLogObj.h"
#import "DeviceInfoObj.h"
#import "EventInfoObj.h"
#import "ErrorLogObj.h"
#import "CheckUpdateReturn.h"
#import <arpa/inet.h> // For AF_INET, etc.
#import <ifaddrs.h> // For getifaddrs()
#import <net/if.h> // For IFF_LOOPBACK
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTCall.h>
#import <CoreTelephony/CTCallCenter.h>
#import <sys/utsname.h>
#import "UMSNetwork.h"
#import "UMSDataMgr.h"
#import "CheckUpdateReturn.h"
#import "LWPublicDataManager.h"
//#import "ShareFun.h"
//#import "CDSetting.h"
#import "NSMutableArray+Sort.h"

@interface UMSAgent ()
{
    NSString *appKey;
    ReportPolicy policy;
    
    BOOL isLogEnabled;
    BOOL isCrashReportEnabled;
    
    NSDate *startDate;
    NSString *updateOnliWifi;
    
    NSString *sessionmillis;
    BOOL *isOnlineConfig;
    
    NSMutableArray *eventArrary;
    NSString *sessionId;
    NSString *pageName;
}

@property (nonatomic) ReportPolicy policy;
@property(nonatomic,strong) NSString *channelId;

@property (nonatomic) BOOL isLogEnabled;
@property (nonatomic) BOOL isCrashReportEnabled;

@property (nonatomic,strong) NSString *appKey;
@property (nonatomic,strong) NSString *updateOnlyWifi;
@property (nonatomic,strong) NSString *sessionmillis;
@property (nonatomic,strong) CheckUpdateReturn *updateRet;
@property (nonatomic) BOOL isOnLineConfig;
@property (nonatomic,strong) NSDate *startDate;
@property (nonatomic,strong) NSString *sessionId;
@property (nonatomic,strong) NSString *pageName;
@property (nonatomic,retain) NSDate *sessionStopDate;

@end


@implementation UMSAgent

@synthesize policy;
@synthesize channelId;

@synthesize isLogEnabled;
@synthesize isCrashReportEnabled;
@synthesize updateOnlyWifi,sessionmillis,isOnLineConfig;
@synthesize appKey;
@synthesize startDate;
@synthesize sessionId;
@synthesize pageName;
@synthesize sessionStopDate;

@synthesize updateRet;

static UMSAgent *umsAgentInstance = nil;

+(UMSAgent*)getInstance
{
    @synchronized(self)
    {
        if(umsAgentInstance == nil)
        {
            umsAgentInstance = [[[self class] alloc] init];
            umsAgentInstance.isLogEnabled = NO;
            umsAgentInstance.isCrashReportEnabled = YES;
            umsAgentInstance.policy = 1;
            umsAgentInstance.sessionmillis = @"30";
            umsAgentInstance.updateOnlyWifi =  @"1";
        }
        return umsAgentInstance;
    }
}

-(void)dealloc
{
    NSSetUncaughtExceptionHandler(NULL);
}

+ (void)setIsLogEnabled:(BOOL)isLogEnabled
{
    [UMSAgent getInstance].isLogEnabled = isLogEnabled;
}
+ (void)setCrashReportEnabled:(BOOL)value
{
    [UMSAgent getInstance].isCrashReportEnabled = value;
}

+ (void)startWithAppkey:(NSString *)appKey
{
    [[UMSAgent getInstance] initWithAppKey:appKey reportPolicy:BATCH channelId:@"App Store"];
}
+ (void)startWithAppkey:(NSString *)appKey reportPolicy:(ReportPolicy)rp channelId:(NSString *)cid
{
    [[UMSAgent getInstance] initWithAppKey:appKey reportPolicy:rp channelId:cid];
}

-(void)initWithAppKey:(NSString*)applicationKey reportPolicy:(ReportPolicy)m_policy channelId:(NSString *)cid
{
    self.appKey = applicationKey;
    self.policy = m_policy;
    self.channelId = cid;
    
    
    NSNotificationCenter *notifCenter = [NSNotificationCenter defaultCenter];
    [notifCenter addObserver:self
                    selector:@selector(resignActive:)
                        name:UIApplicationWillResignActiveNotification
                      object:nil];
    [notifCenter addObserver:self
                    selector:@selector(becomeActive:)
                        name:UIApplicationWillEnterForegroundNotification
                      object:nil];
    
    self.startDate = [[NSDate date] copy];
    NSString *currentTime = [[NSString alloc] initWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
    NSString *sessionIdentifier = [[NSString alloc] initWithFormat:@"%@%@", currentTime, [UMSAgent getUMSUDID]
                                   ];
    self.sessionId = [self md5:sessionIdentifier];
    if(isLogEnabled)
    {
        NSLog(@"Get Session ID = %@",sessionId);
    }
    
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    [[UMSAgent getInstance] performSelectorInBackground:@selector(archiveDeviceData) withObject:nil];
    [[UMSAgent getInstance] performSelectorInBackground:@selector(postErrorLogInBackGround) withObject:nil];

}

- (void)becomeActive:(NSNotification *)notification
{
    if(isLogEnabled)
    {
        NSLog(@"Application become active");
    }
    
    if(self.pageName!=nil)
    {
        [UMSAgent startTracPage:self.pageName];
        NSString *page_name = [[NSBundle mainBundle] bundleIdentifier];
        NSDate *pageStartDate = [[NSDate date] copy];
        [[NSUserDefaults standardUserDefaults] setObject:pageStartDate forKey:page_name];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    NSString *currentTime = [[NSString alloc] initWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
    if(sessionStopDate!=nil)
    {
        NSTimeInterval sessionStopInterval = -[sessionStopDate timeIntervalSinceNow];
        NSLog(@"sessionStopInterval:%f",sessionStopInterval);
        
        if(sessionStopInterval + 0.0000001 > 30)
        {
            self.sessionId = [self md5:currentTime];
            if(isLogEnabled)
            {
                NSLog(@"Stop session more than 30 seconds, so consider as new session id.");
            }
        }
        else
        {
            if(isLogEnabled)
            {
                NSLog(@"Stop session less than 30 seconds, so consider as old session.");
            }
        }
    }
    else
    {
        self.sessionId = [self md5:currentTime];
    }
    
    if(isLogEnabled)
    {
        NSLog(@"Current session ID = %@",sessionId);
    }
    
    [self performSelectorInBackground:@selector(archiveDeviceData) withObject:nil];
    [self performSelectorInBackground:@selector(processArchiveActivityLog) withObject:nil];
    [self performSelectorInBackground:@selector(postEventInBackGround) withObject:nil];
    [self performSelectorInBackground:@selector(postErrorLogInBackGround) withObject:nil];
    
    if(isLogEnabled)
    {
        NSLog(@"Application Resign Active");
    }
}

//退至后台，需保存数据
- (void)resignActive:(NSNotification *)notification
{
    if(self.pageName!=nil)
    {
        [UMSAgent endTracPage:self.pageName];
    }
    
    NSDate *curDate = [NSDate date];
    self.sessionStopDate = curDate;
    
    [UMSDataMgr generalNewActivityKey];
    [UMSDataMgr generalNewEventKey];
    
    if(isLogEnabled)
    {
        NSLog(@"Resign Active: click home button or lose focus. End Trace Page and save session stop date.");
    }
}

+(void)startTracPage:(NSString*)page_name
{
    if(page_name==nil)
    {
        return;
    }
    
    NSLog(@"page_name:%@",page_name);
    [[UMSAgent getInstance] performSelectorInBackground:@selector(recordStartTrac:) withObject:page_name];
}

-(void)recordStartTrac:(NSString*)page_name
{
    self.pageName = [[NSString alloc] initWithString:page_name];
    NSDate *pageStartDate = [NSDate date];
    [[NSUserDefaults standardUserDefaults] setObject:pageStartDate forKey:page_name];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(void)endTracPage:(NSString*)page_name
{
    if(page_name==nil)
    {
        return;
    }
    
    [[UMSAgent getInstance] performSelectorInBackground:@selector(saveActivityUsingTime:) withObject:page_name];
}

+ (void)event:(NSString *)eventId
{
    [UMSAgent event:eventId label:eventId acc:1];
}

+ (void)event:(NSString *)eventId label:(NSString *)label
{
    [UMSAgent event:eventId label:label acc:1];
}

+ (void)event:(NSString *)eventId acc:(NSInteger)accumulation
{
    [UMSAgent event:eventId label:eventId acc:accumulation];
}

+ (void)event:(NSString *)eventId label:(NSString *)label acc:(NSInteger)accumulation
{
    EventInfoObj *eventInfoObj = [[EventInfoObj alloc] init];
    eventInfoObj.event_id = eventId;
    eventInfoObj.label = label;
    eventInfoObj.acc = accumulation;
    eventInfoObj.time = [[UMSAgent getInstance] getCurrentTime];
    eventInfoObj.version = [[UMSAgent getInstance] getVersion];
    eventInfoObj.startMils = [[UMSAgent getInstance] getCurrentTime];
    eventInfoObj.duration = @"0";
    [UMSDataMgr saveEventInfo:eventInfoObj];
    
//    [[UMSAgent getInstance] performSelectorInBackground:@selector(postEventInBackGround) withObject:nil];
}

- (void)saveActivityUsingTime:(NSString*)currentPageName
{
    ActivityLogObj *acLog = [[ActivityLogObj alloc] init];
    acLog.sessionId = self.sessionId;
    NSDate *pageStartDate = [[NSUserDefaults standardUserDefaults] objectForKey:currentPageName];
    if(pageStartDate!=nil)
    {
        NSString *start_mils = [self getDateStr:pageStartDate];
        acLog.startMils = start_mils;
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:currentPageName];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else
    {
        if(isLogEnabled)
        {
            NSLog(@"Page Start time not found. in saveActivityUsingTime pagename = %@",currentPageName);
        }
        return;
    }
    
    acLog.endMils = [self getCurrentTime];
    NSTimeInterval duration = (-[pageStartDate timeIntervalSinceNow]);//*1000;(秒)
    acLog.duration = [[NSString alloc] initWithFormat:@"%.3f",duration];
    acLog.activity = currentPageName;
    acLog.version = [self getVersion];
    if(acLog)
    {
        NSLog(@"acLog sessionMils = %@",acLog.sessionId);
    }
    
    //保存数据
    [UMSDataMgr saveActivityLogInfo:acLog];
    
//    if([UMSAgent getInstance].policy == REALTIME)
//    {
//        [self processArchiveActivityLog];
//    }
}

-(void)archiveDeviceData
{
    
    DeviceInfoObj *deviceInfoObj = [self getDeviceInfo];
    NSMutableArray *deviceDataArray;
    
    NSData *oldData = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceDataArray"];
    
    if (oldData!=nil)
    {
        deviceDataArray = [NSKeyedUnarchiver unarchiveObjectWithData:oldData];
    }
    else
    {
        deviceDataArray = [[NSMutableArray alloc] init];
    }
    //第一次启动时不需要判断间隔是否超过30s
    if ([LWPublicDataManager IntoTheBackGroundtimeIsMoreThan:30 WithKey:@"UMSAgent"]||[[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"])
    {
        [deviceDataArray rewriteAddObject:deviceInfoObj];
         NSData *newData = [NSKeyedArchiver archivedDataWithRootObject:deviceDataArray];
        [[NSUserDefaults standardUserDefaults] setObject:newData forKey:@"deviceDataArray"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self performSelector:@selector(processArchiveDeviceData)];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
    }
}


-(void)processArchiveDeviceData
{
    NSData *oldData = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceDataArray"] ;
    NSMutableArray * array = nil;
    if (oldData!=nil)
    {
        array = [NSKeyedUnarchiver unarchiveObjectWithData:oldData];
    }
    
    NSMutableArray *deviceDataArray = [[NSMutableArray alloc] init];
    if ([array count]>0)
    {
        for(DeviceInfoObj *deviceData in array)
        {
            NSMutableDictionary *requestDictionary = [[NSMutableDictionary alloc] init];
            [requestDictionary setObject:@"IOS" forKey:@"platform"];
            [requestDictionary setObject:deviceData.os_version forKey:@"os_version"];
            [requestDictionary setObject:deviceData.language forKey:@"language"];
            [requestDictionary setObject:deviceData.resolution forKey:@"resolution"];
            [requestDictionary setObject:deviceData.deviceid forKey:@"deviceid"];
            if (deviceData.userid!=nil) {
                [requestDictionary setObject:deviceData.userid forKey:@"userid"];
            }
            else
            {
                [requestDictionary setObject:@"" forKey:@"userid"];
            }
            
            if(deviceData.mccmnc!=nil)
            {
                [requestDictionary setObject:deviceData.mccmnc forKey:@"mccmnc"];
            }
            else
            {
                [requestDictionary setObject:@"" forKey:@"mccmnc"];
                
            }
            [requestDictionary setObject:deviceData.version forKey:@"version"];
            [requestDictionary setObject:deviceData.network forKey:@"network"];
            [requestDictionary setObject:deviceData.devicename forKey:@"devicename"];
            [requestDictionary setObject:deviceData.modulename forKey:@"modulename"];
            [requestDictionary setObject:deviceData.time forKey:@"time"];
            [requestDictionary setObject:deviceData.isjailbroken forKey:@"isjailbroken"];
            if (deviceData.loadfrom!=nil) {
                [requestDictionary setObject:deviceData.loadfrom forKey:@"loadfrom"];
            }else{
                [requestDictionary setObject:@"" forKey:@"loadfrom"];
            }
            
            [deviceDataArray rewriteAddObject:requestDictionary];
        }
    }

  
    if([deviceDataArray count]>0)
    {
        CommonReturn *commonReturn = [UMSNetwork postDeviceInfo:appKey deviceId:[UMSAgent getUMSUDID] deviceInfo:deviceDataArray];
        if(commonReturn!=nil && commonReturn.res_code==0)
        {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"deviceDataArray"];
            
            [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"UMSAgent"];
            [[NSUserDefaults standardUserDefaults] synchronize];

//            [CDSetting writeIntPutBackgroundTime:[CommentConvenient getCurrentTime] WithKey:@"UMSAgent"];
        }
    }
}

- (void)processArchiveActivityLog
{
        
    NSData *activityData = [[NSUserDefaults standardUserDefaults] objectForKey:[UMSDataMgr generalActivityKey]];
    NSMutableArray *activityMutableArr = [[NSMutableArray alloc] init];
    if(activityData==nil)
    {
        return;
    }
    
    activityMutableArr = [NSKeyedUnarchiver unarchiveObjectWithData:activityData];
    
    if([activityMutableArr count]<=0)
    {
        return;
    }
    
     NSMutableArray *activityLogArray = [[NSMutableArray alloc] init];
    for(ActivityLogObj *mLog in activityMutableArr)
    {
        NSMutableDictionary *requestDictionary = [[NSMutableDictionary alloc] init];
        [requestDictionary setObject:mLog.sessionId forKey:@"sessionId"];
        [requestDictionary setObject:mLog.startMils forKey:@"startMils"];
        [requestDictionary setObject:mLog.endMils forKey:@"endMils"];
        [requestDictionary setObject:mLog.duration forKey:@"duration"];
        [requestDictionary setObject:mLog.activity forKey:@"activity"];
        [requestDictionary setObject:mLog.version forKey:@"version"];
        [activityLogArray rewriteAddObject:requestDictionary];
    }
    
    CommonReturn *commonReturn = [UMSNetwork postActivityInfo:appKey deviceId:[UMSAgent getUMSUDID] activityLogInfo:activityLogArray];
    if(commonReturn!=nil && commonReturn.res_code==0)
    {
        [UMSDataMgr deleteActivityByKey:[UMSDataMgr generalActivityKey]];
    }

    
   /* NSData *activityData = [[NSUserDefaults standardUserDefaults] objectForKey:@"activityLog"];
    NSMutableArray *activityMutableArr = [[NSMutableArray alloc] init];
    if(activityData==nil)
    {
        return;
    }
    
    activityMutableArr = [NSKeyedUnarchiver unarchiveObjectWithData:activityData];
    if([activityMutableArr count]<=0)
    {
        return;
    }
    
    for(int i=0;i<[activityMutableArr count];i++)
    {
        NSString *strActivityKeyName = (NSString*)[activityMutableArr objectAtIndex:i];
        
        NSData *oldData = [[NSUserDefaults standardUserDefaults] objectForKey:strActivityKeyName] ;
        NSMutableArray * array = nil;
        if (oldData!=nil)
        {
            array = [NSKeyedUnarchiver unarchiveObjectWithData:oldData];
            if(isLogEnabled)
            {
                NSLog(@"Have error data num = %lu",(unsigned long)[array count]);
            }
        }
        else
        {
            continue;
        }
        
        if([array count]<=0)
        {
            [UMSDataMgr deleteActivityByKey:strActivityKeyName];
            return;
        }
        
        NSMutableArray *activityLogArray = [[NSMutableArray alloc] init];
        for(ActivityLogObj *mLog in array)
        {
            NSMutableDictionary *requestDictionary = [[NSMutableDictionary alloc] init];
            [requestDictionary setObject:mLog.sessionId forKey:@"sessionId"];
            [requestDictionary setObject:mLog.startMils forKey:@"startMils"];
            [requestDictionary setObject:mLog.endMils forKey:@"endMils"];
            [requestDictionary setObject:mLog.duration forKey:@"duration"];
            [requestDictionary setObject:mLog.activity forKey:@"activity"];
            [requestDictionary setObject:mLog.version forKey:@"version"];
            [activityLogArray rewriteAddObject:requestDictionary];
        }
        
        CommonReturn *commonReturn = [UMSNetwork postActivityInfo:appKey deviceId:[UMSAgent getUMSUDID] activityLogInfo:activityLogArray];
        if(commonReturn!=nil && commonReturn.res_code==0)
        {
            [UMSDataMgr deleteActivityByKey:strActivityKeyName];
        }
    }*/
}

- (void) postEventInBackGround
{
    
    NSData *eventData = [[NSUserDefaults standardUserDefaults] objectForKey:[UMSDataMgr generalEventKey]];
    NSMutableArray *eventMutableArr = [[NSMutableArray alloc] init];
    if(eventData==nil)
    {
        return;
    }
    
    NSMutableArray *eventLogArray = [[NSMutableArray alloc] init];
    eventMutableArr = [NSKeyedUnarchiver unarchiveObjectWithData:eventData];
    if([eventMutableArr count]<=0)
    {
        return;
    }
    
    for(EventInfoObj *mEvent in eventMutableArr)
    {
        NSMutableDictionary *requestDictionary = [[NSMutableDictionary alloc] init];
        [requestDictionary setObject:mEvent.event_id forKey:@"event_id"];
        [requestDictionary setObject:mEvent.time forKey:@"time"];
        [requestDictionary setObject:mEvent.startMils forKey:@"startMils"];
        [requestDictionary setObject:mEvent.label forKey:@"label"];
        [requestDictionary setObject:@"0" forKey:@"duration"];
        [requestDictionary setObject:[NSNumber numberWithInt:mEvent.acc] forKey:@"acc"];
        [requestDictionary setObject:mEvent.version forKey:@"version"];
        [eventLogArray rewriteAddObject:requestDictionary];
    }
    
    CommonReturn *commonReturn = [UMSNetwork postEventInfo:appKey deviceId:[UMSAgent getUMSUDID] eventInfo:eventLogArray];
    if(commonReturn!=nil && commonReturn.res_code==0)
    {
        [UMSDataMgr deleteEventByKey:[UMSDataMgr generalEventKey]];
    }


    
  /*
    return;
    NSData *eventData = [[NSUserDefaults standardUserDefaults] objectForKey:@"eventLog"];
    NSMutableArray *eventMutableArr = [[NSMutableArray alloc] init];
    if(eventData==nil)
    {
        return;
    }
    
    eventMutableArr = [NSKeyedUnarchiver unarchiveObjectWithData:eventData];
    if([eventMutableArr count]<=0)
    {
        return;
    }
    
    for(int i=0;i<[eventMutableArr count];i++)
    {
        NSString *strEventKeyName = (NSString*)[eventMutableArr objectAtIndex:i];
        NSData *oldData = [[NSUserDefaults standardUserDefaults] objectForKey:strEventKeyName] ;
        NSMutableArray * array = nil;
        if (oldData!=nil)
        {
            array = [NSKeyedUnarchiver unarchiveObjectWithData:oldData];
            if(isLogEnabled)
            {
                NSLog(@"Have error data num = %lu",(unsigned long)[array count]);
            }
        }
        else
        {
            continue;
        }
        
        if([array count]<=0)
        {
            [UMSDataMgr deleteEventByKey:strEventKeyName];
            return;
        }
        
        NSMutableArray *eventLogArray = [[NSMutableArray alloc] init];
        for(EventInfoObj *mEvent in array)
        {
            NSMutableDictionary *requestDictionary = [[NSMutableDictionary alloc] init];
            [requestDictionary setObject:mEvent.event_id forKey:@"event_id"];
            [requestDictionary setObject:mEvent.time forKey:@"time"];
            [requestDictionary setObject:mEvent.startMils forKey:@"startMils"];
            [requestDictionary setObject:mEvent.label forKey:@"label"];
            [requestDictionary setObject:mEvent.duration forKey:@"duration"];
            [requestDictionary setObject:[NSNumber numberWithInt:mEvent.acc] forKey:@"acc"];
            [requestDictionary setObject:mEvent.version forKey:@"version"];
            [eventLogArray rewriteAddObject:requestDictionary];
        }
        
        CommonReturn *commonReturn = [UMSNetwork postEventInfo:appKey deviceId:[UMSAgent getUMSUDID] eventInfo:eventLogArray];
        if(commonReturn!=nil && commonReturn.res_code==0)
        {
            [UMSDataMgr deleteEventByKey:strEventKeyName];
        }
    }*/
}

- (void)postErrorLogInBackGround
{
    NSData *oldData = [[NSUserDefaults standardUserDefaults] objectForKey:@"errorLog"] ;
    NSMutableArray * array = nil;
    if (oldData!=nil)
    {
        array = [NSKeyedUnarchiver unarchiveObjectWithData:oldData];
        if(isLogEnabled)
        {
            NSLog(@"Have error data num = %lu",(unsigned long)[array count]);
        }
    }
    
    NSMutableArray *errorLogArray = [[NSMutableArray alloc] init];
    if ([array count]>0)
    {
        for(ErrorLogObj *errorLog in array)
        {
            NSMutableDictionary *requestDictionary = [[NSMutableDictionary alloc] init];
            [requestDictionary setObject:errorLog.time forKey:@"time"];
            [requestDictionary setObject:errorLog.stackTrace forKey:@"stackTrace"];
            [requestDictionary setObject:errorLog.version forKey:@"version"];
            [errorLogArray rewriteAddObject:requestDictionary];
        }
    }
    
    if([errorLogArray count]>0)
    {
        CommonReturn *commonReturn = [UMSNetwork postErrorLogInfo:appKey deviceId:[UMSAgent getUMSUDID] errorInfo:errorLogArray];
        if(commonReturn!=nil && commonReturn.res_code==0)
        {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"errorLog"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
}

- (void)saveErrorLog:(NSString*)stackTrace
{
    if(!isCrashReportEnabled)
    {
        return;
    }
    
    ErrorLogObj *errorLog = [[ErrorLogObj alloc] init];
    errorLog.stackTrace = stackTrace;
    errorLog.version = [self getVersion];
    errorLog.time = [self getCurrentTime];
    
    NSData *errorLogData = [[NSUserDefaults standardUserDefaults] objectForKey:@"errorLog"] ;
    NSMutableArray * errorLogArray = [[NSMutableArray alloc] init ];
    if (errorLogData!=nil)
    {
        errorLogArray = [NSKeyedUnarchiver unarchiveObjectWithData:errorLogData];
    }
    else {
        errorLogArray = [[NSMutableArray alloc] init ];
    }
    if([errorLogArray count]>30)
    {
        [errorLogArray rewriteRemoveObjectAtIndex:0];
    }
    
    [errorLogArray rewriteAddObject:errorLog];
    if(isLogEnabled)
    {
        NSLog(@"Error Log array size = %lu",(unsigned long)[errorLogArray count]);
    }
    
    NSData *newErrorData = [NSKeyedArchiver archivedDataWithRootObject:errorLogArray];
    [[NSUserDefaults standardUserDefaults] setObject:newErrorData forKey:@"errorLog"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(void)checkUpdate
{
    //if ([UMSAgent getInstance].updateOnlyWifi)
    {
        [[UMSAgent getInstance] getApplicationUpdate];
    }
}

-(void) getApplicationUpdate
{
    CheckUpdateReturn *retWrapper;
    if(isLogEnabled)
    {
        NSLog(@"Begin get application update");
    }
    
    retWrapper = [UMSNetwork postCheckUpdate:appKey version:[self getVersion] channelId:channelId];
    if ((retWrapper.res_code==0) && (retWrapper.hasNewVer==1))
    {
        updateRet = retWrapper;
        NSString *version = [[NSString alloc] initWithFormat:@"版本更新 %@",retWrapper.version];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: version
                                                        message: retWrapper.description
                                                       delegate: self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确定", nil];
        [alert show];
    }
    else
    {
        if(isLogEnabled)
        {
            NSLog(@"Update Return: Flag = %d, Msg = %@",retWrapper.res_code,retWrapper.res_msg);
        }
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:updateRet.fileurl]];
    }
}


void uncaughtExceptionHandler(NSException *exception) {
    NSLog(@"CRASH: %@", exception);
    NSLog(@"Stack Trace: %@", [exception callStackSymbols]);
    NSString *stackTrace = [[NSString alloc] initWithFormat:@"%@\n%@",exception,[exception callStackSymbols]];
    [[UMSAgent getInstance] saveErrorLog:stackTrace];
}

-(DeviceInfoObj*)getDeviceInfo
{
    DeviceInfoObj  *info = [[DeviceInfoObj alloc] init];
    info.platform = [[UIDevice currentDevice] systemName];
    info.devicename = [self machineName];
    info.modulename = [[UIDevice currentDevice] model];
    info.os_version = [NSString stringWithFormat:@"%f",systemVersion];
    info.time = [self getCurrentTime];
    if([UMSAgent isJailbroken])
    {
        info.isjailbroken = @"1";
    }
    else {
        info.isjailbroken = @"0";
    }
    
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGFloat scale = [[UIScreen mainScreen] scale];
    info.resolution = [[NSString alloc] initWithFormat:@"%.fx%.f",rect.size.width*scale,rect.size.height*scale];
    
    info.deviceid = [UMSAgent getUMSUDID];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
    info.language = [languages objectAtIndex:0];
    
    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
    if(userid==nil)
    {
        userid = @"";
    }
    
    info.userid = userid;
    info.loadfrom = self.channelId;
    
    CTTelephonyNetworkInfo *netInfo =[[CTTelephonyNetworkInfo alloc] init];
    CTCarrier*carrier =[netInfo subscriberCellularProvider];
    NSString *mcc =[carrier mobileCountryCode];
    NSString *mnc =[carrier mobileNetworkCode];
    info.mccmnc = [mcc stringByAppendingString:mnc];
    
    info.version = [self getVersion];
    BOOL isWifi = [self isWiFiAvailable];
    if(isWifi)
    {
        info.network = @"WIFI";
    }
    else
    {
        info.network = @"2G/3G";
    }
    return info;
}


+(BOOL)isJailbroken
{
    BOOL jailbroken = NO;
    NSString *cydiaPath = @"/Applications/Cydia.app";
    NSString *aptPath = @"/private/var/lib/apt/";
    if ([[NSFileManager defaultManager] fileExistsAtPath:cydiaPath]) {
        jailbroken = YES;
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:aptPath]) {
        jailbroken = YES;
    }
    return jailbroken;
}

-(BOOL)isWiFiAvailable
{
    struct ifaddrs *addresses;
    struct ifaddrs *cursor;
    BOOL wiFiAvailable = NO;
    if (getifaddrs(&addresses) != 0) return NO;
    
    cursor = addresses;
    while (cursor != NULL) {
        if (cursor -> ifa_addr -> sa_family == AF_INET
            && !(cursor -> ifa_flags & IFF_LOOPBACK)) // Ignore the loopback address
        {
            // Check for WiFi adapter
            if (strcmp(cursor -> ifa_name, "en0") == 0) {
                wiFiAvailable = YES;
                break;
            }
        }
        cursor = cursor -> ifa_next;
    }
    
    freeifaddrs(addresses);
    return wiFiAvailable;
}


-(NSString*) machineName
{
    struct utsname systemInfo;
    uname(&systemInfo);
    return  [NSString stringWithCString:systemInfo.machine
                               encoding:NSUTF8StringEncoding];
}

-(NSString *)getVersion
{
    NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    return appVersion;
}


+(NSString *)getUMSUDID
{
//    //直接返回IDFA
//     return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
   
//    [SFHFKeychainUtils deleteItemForUsername:@"UMSAgentUDID" andServiceName:@"UMSAgent" error:nil];
    
    NSString * udidInKeyChain = [SFHFKeychainUtils getPasswordForUsername:@"UMSAgentUDID" andServiceName:@"UMSAgent" error:nil];
    if(udidInKeyChain && ![udidInKeyChain isEqualToString:@""])
    {
        return udidInKeyChain;
    }
    else
    {
//        NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
//        if(idfa && ![idfa isEqualToString:@""])
//        {
//            [SFHFKeychainUtils storeUsername:@"UMSAgentUDID" andPassword:idfa forServiceName:@"UMSAgent" updateExisting:NO error:nil];
//            return idfa;
//        }
//        else
//        {
            NSString *openUDID = [OpenUDID value];
            [SFHFKeychainUtils storeUsername:@"UMSAgentUDID" andPassword:openUDID forServiceName:@"UMSAgent" updateExisting:NO error:nil];
            return openUDID;
//        }
    }
}

-(NSString *)md5:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char result[32];
    CC_MD5( cStr, strlen(cStr), result );
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

-(NSString *)getKeyInnfo
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyyMMddHHmmss";
    NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"ABC"];
    [dateFormatter setTimeZone:gmt];
    NSString *timeStamp = [dateFormatter stringFromDate:[NSDate date]];
    return timeStamp;
}

-(NSString *)getCurrentTime
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"ABC"];
    [dateFormatter setTimeZone:gmt];
    NSString *timeStamp = [dateFormatter stringFromDate:[NSDate date]];
    return timeStamp;
    
}

-(NSString *)getDateStr:(NSDate *)inputDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"ABC"];
    [dateFormatter setTimeZone:gmt];
    NSString *timeStamp = [dateFormatter stringFromDate:inputDate];
    return timeStamp;
    
}

@end
