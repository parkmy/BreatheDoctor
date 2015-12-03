//
//  PushMgrInfo.m
//  LarkDoctor
//
//  Created by 郑建武 on 15/3/27.
//  Copyright (c) 2015年 com.comvee. All rights reserved.
//
#import "PushMgrInfo.h"
#import "CDMacro.h"

@implementation PushMgrInfo

@synthesize pushDic;
@synthesize localNotifyPrev;



+ (PushMgrInfo *) sharedInstance
{
    
    static dispatch_once_t onceToken;
    static PushMgrInfo *pushMgrInfoSingleton = nil;
    dispatch_once(&onceToken, ^{
        pushMgrInfoSingleton = [[PushMgrInfo alloc] init];

    });
    
    return pushMgrInfoSingleton;
}

- (void)dealloc
{
    pushDic = nil;
    localNotifyPrev = nil;
}

- (void)didRegisterDeviceToken:(NSData *)deviceToken
{
    NSString *str = [NSString stringWithFormat:@"%@",deviceToken];
    NSString *neirong = [str substringFromIndex:1];
    NSString *ret = [neirong substringToIndex:[neirong length]-1];
    NSString *token = [ret stringByReplacingOccurrencesOfString:@" " withString:@""];//最终
    NSLog(@"token%@",token);
    if (token) {
        [CODataCacheManager shareInstance].pushTokenKey = token;
        [[CODataCacheManager shareInstance] savePushKey];
    }
}


//launchType:1,启动，2应用在后台，3应用在前台
- (void)showRemotePushAction:(NSDictionary*)userInfo launchType:(int)launchType
{
    NSLog(@"showRemotePushAction:%d,%@",launchType,userInfo);

    if([[userInfo objectForKey:@"aps"] objectForKey:@"alert"]==nil)
    {
        return;
    }
    
    if(pushDic==nil)
    {
        pushDic = [[NSMutableDictionary alloc] init];
    }
    
    [pushDic removeAllObjects];
    [pushDic addEntriesFromDictionary:userInfo];
    
    NSString *pushStr=[userInfo objectForKey:@"customdata"];
    NSData *pushData = [pushStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:pushData options:NSJSONReadingMutableLeaves error:nil];
    
    NSLog(@"%@",dic);
    NSString* busyType = [dic objectForKey:@"busi_type"];
    
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;

    switch ([busyType intValue])
    {
        case 1: //请求创建医患关系
            
            [[NSNotificationCenter defaultCenter] postNotificationName:APP_PUSH_TYPE_REQUEST_RELATION object:nil];

            break;
            
        case 2://PEF记录
            
            [[NSNotificationCenter defaultCenter] postNotificationName:APP_PUSH_TYPE_PEF_RECORD object:nil];

            break;
        case 3://ACT评估
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:APP_PUSH_TYPE_ASSESS_ACT object:nil];
        }
            break;
        case 4://哮喘评估
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:APP_PUSH_TYPE_ASSESS_ASTHMA object:nil];

        }
            break;
        case 5://首诊
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:APP_PUSH_TYPE_FIRST_DIAGNOSE object:nil];

        }
            break;
        case 6://复诊通知
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:APP_PUSH_TYPE_REPEAT_TREATMENT_INFORM object:nil];

        }
            break;
        case 7://患者添加对话
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:APP_PUSH_TYPE_PATIENT_ADD_DIALOGUE object:nil];

        }
            break;
        default:
            break;
    }
    
}

- (void)showLocalPushAction:(UILocalNotification *)notification
{
    if (localNotifyPrev!=nil && [localNotifyPrev.alertBody isEqual:notification.alertBody]  && ![localNotifyPrev.fireDate isEqual:notification.fireDate])
    {
        [[UIApplication sharedApplication] cancelLocalNotification:localNotifyPrev];
    }
    
    localNotifyPrev = notification;
}

- (void)pushMessageDetailsCtrWithDic:(NSDictionary*)dic ContentText:(NSString*)contentText
{
    
    //    if  ([[LDGloablVar sharedGloablVar].currentControl isKindOfClass:[MessageDetailsCtr class]])
    //    {
    //        MessageDetailsCtr * detail = (MessageDetailsCtr*)[LDGloablVar sharedGloablVar].currentControl;
    //        if ([detail.patient.mid isEqualToString:[dic objectForKey:@"mid"]])
    //        {
    //            detail.ifProgress = YES;
    //            [detail getChatDetailDataWithType:@"1" WithTime:[LDSetting readLastTime]];
    //        }
    //    }
    //    else
    //    {
    //
    //        [self.navigationController popToRootViewControllerAnimated:YES];
    //        [[NSNotificationCenter defaultCenter] postNotificationName:@"ReceiveRemoteNotification" object:nil];
    //    }
}

@end
