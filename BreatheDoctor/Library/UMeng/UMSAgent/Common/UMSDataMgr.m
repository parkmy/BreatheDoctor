//
//  UMSDataMgr.m
//  DiabetesPatient
//
//  Created by 郑建武 on 15-2-27.
//  Copyright (c) 2015年 com.comvee. All rights reserved.
//

#import "UMSDataMgr.h"
#import "NSMutableArray+Sort.h"

@implementation UMSDataMgr

+(NSString *)getKeyInfo
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyyMMddHHmmss";
    NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"ABC"];
    [dateFormatter setTimeZone:gmt];
    NSString *timeStamp = [dateFormatter stringFromDate:[NSDate date]];
    return timeStamp;
}

+(NSString*)generalActivityKey
{
    NSString *strLastActivityLog = [[NSUserDefaults standardUserDefaults] objectForKey:@"lastActivityLog"];
    if(strLastActivityLog == nil)
    {
        strLastActivityLog = [NSString stringWithFormat:@"activity_%@",[UMSDataMgr getKeyInfo]];
        [[NSUserDefaults standardUserDefaults] setObject:strLastActivityLog forKey:@"lastActivityLog"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    return strLastActivityLog;
}

+(NSString*)generalNewActivityKey
{
    //lastActivityLog
    NSString *strActivityKey = nil;     //新文件名
    
    strActivityKey = [NSString stringWithFormat:@"activity_%@",[UMSDataMgr getKeyInfo]];

    NSString *strLastActivityLog = [[NSUserDefaults standardUserDefaults] objectForKey:@"lastActivityLog"];
    if(strLastActivityLog != nil)
    {
        NSData *activityData = [[NSUserDefaults standardUserDefaults] objectForKey:[UMSDataMgr generalActivityKey]];
        NSMutableArray *activityMutableArr = [[NSMutableArray alloc] init];
        if(activityData!=nil)
        {
            activityMutableArr = [NSKeyedUnarchiver unarchiveObjectWithData:activityData];
        }
        
        //[activityMutableArr rewriteAddObject:strLastActivityLog];
        NSData *newActivityData = [NSKeyedArchiver archivedDataWithRootObject:activityMutableArr];
        [[NSUserDefaults standardUserDefaults] setObject:newActivityData forKey:strActivityKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:strActivityKey forKey:@"lastActivityLog"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    return strActivityKey;
}

//保存数据
+(int)saveActivityLogInfo:(ActivityLogObj *)acLog
{
    NSString *strLastActivityLog = [self generalActivityKey];
    
    NSData *activityLogData = [[NSUserDefaults standardUserDefaults] objectForKey:strLastActivityLog];
    NSMutableArray * activityLogArray = [[NSMutableArray alloc] init ];
    if (activityLogData!=nil)
    {
        activityLogArray = [NSKeyedUnarchiver unarchiveObjectWithData:activityLogData];
    }
    
    NSString *strActivityKey = nil;     //新文件名
    if( [activityLogArray count]>50)
    {
        strActivityKey = [self generalNewActivityKey];
    }
    else
    {
        strActivityKey = strLastActivityLog;
    }
    
    [activityLogArray rewriteAddObject:acLog];
    
    NSData *newActivityData = [NSKeyedArchiver archivedDataWithRootObject:activityLogArray];
    [[NSUserDefaults standardUserDefaults] setObject:newActivityData forKey:strActivityKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return 0;
}

//根据KEY值删除数据
+(int)deleteActivityByKey:(NSString*)strActivityKeyName
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:strActivityKeyName];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //删除
    NSData *activityData = [[NSUserDefaults standardUserDefaults] objectForKey:@"activityLog"];
    NSMutableArray *activityMutableTmpArr = [[NSMutableArray alloc] init];
    if(activityData!=nil)
    {
        activityMutableTmpArr = [NSKeyedUnarchiver unarchiveObjectWithData:activityData];
    }
    
    for(int j=0;j<[activityMutableTmpArr count];j++)
    {
        NSString *strActivityTmpName = (NSString*)[activityMutableTmpArr rewriteObjectAtIndex:j];
        if([strActivityTmpName isEqualToString:strActivityKeyName])
        {
            [activityMutableTmpArr rewriteRemoveObjectAtIndex:j];
            break;
        }
    }
    NSData *newActivityData = [NSKeyedArchiver archivedDataWithRootObject:activityMutableTmpArr];
    [[NSUserDefaults standardUserDefaults] setObject:newActivityData forKey:@"activityLog"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return 0;
}

+(NSString*)generalEventKey
{//event_20160113160457
    NSString *strLastEventLog = [[NSUserDefaults standardUserDefaults] objectForKey:@"lastEventLog"];
    if(strLastEventLog == nil)
    {
        strLastEventLog = [NSString stringWithFormat:@"event_%@",[UMSDataMgr getKeyInfo]];
        [[NSUserDefaults standardUserDefaults] setObject:strLastEventLog forKey:@"lastEventLog"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    return strLastEventLog;
}

+(NSString*)generalNewEventKey
{
    NSString *strActivityKey = nil;     //新文件名
    
    strActivityKey = [NSString stringWithFormat:@"event_%@",[UMSDataMgr getKeyInfo]];

    NSString *strLastEventLog = [[NSUserDefaults standardUserDefaults] objectForKey:@"lastEventLog"];
    if(strLastEventLog != nil)
    {
        NSData *activityData = [[NSUserDefaults standardUserDefaults] objectForKey:[UMSDataMgr generalEventKey]];
        NSMutableArray *activityMutableArr = [[NSMutableArray alloc] init];
        if(activityData!=nil)
        {
            activityMutableArr = [NSKeyedUnarchiver unarchiveObjectWithData:activityData];
        }
        
       // [activityMutableArr rewriteAddObject:strLastEventLog];
        NSData *newActivityData = [NSKeyedArchiver archivedDataWithRootObject:activityMutableArr];
        [[NSUserDefaults standardUserDefaults] setObject:newActivityData forKey:strActivityKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:strActivityKey forKey:@"lastEventLog"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    return strActivityKey;
}

+(int)saveEventInfo:(EventInfoObj *)eventInfoObj
{
    //event_时间传
    NSString *strLastEventLog = [self generalEventKey];
    
    NSData *activityLogData = [[NSUserDefaults standardUserDefaults] objectForKey:strLastEventLog];
    NSMutableArray * eventLogArray = [[NSMutableArray alloc] init];
    if (activityLogData!=nil)
    {
        eventLogArray = [NSKeyedUnarchiver unarchiveObjectWithData:activityLogData];
    }
    
    NSString *strEventKey = nil;     //新文件名
    if( [eventLogArray count]>50)
    {
        strEventKey = [self generalNewEventKey];
    }
    else
    {
        strEventKey = strLastEventLog;
    }
    [eventLogArray rewriteAddObject:eventInfoObj];
    
    NSData *newEventData = [NSKeyedArchiver archivedDataWithRootObject:eventLogArray];
    [[NSUserDefaults standardUserDefaults] setObject:newEventData forKey:strEventKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return 0;
}


+(int)deleteEventByKey:(NSString*)strEventKeyName
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:strEventKeyName];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //删除
    NSData *activityData = [[NSUserDefaults standardUserDefaults] objectForKey:@"eventLog"];
    NSMutableArray *activityMutableTmpArr = [[NSMutableArray alloc] init];
    if(activityData!=nil)
    {
        activityMutableTmpArr = [NSKeyedUnarchiver unarchiveObjectWithData:activityData];
    }
    
    for(int j=0;j<[activityMutableTmpArr count];j++)
    {
        NSString *strActivityTmpName = (NSString*)[activityMutableTmpArr rewriteObjectAtIndex:j];
        if([strActivityTmpName isEqualToString:strEventKeyName])
        {
            [activityMutableTmpArr rewriteRemoveObjectAtIndex:j];
            break;
        }
    }
    NSData *newActivityData = [NSKeyedArchiver archivedDataWithRootObject:activityMutableTmpArr];
    [[NSUserDefaults standardUserDefaults] setObject:newActivityData forKey:@"eventLog"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return 0;
}

@end
