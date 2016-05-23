//
//  PushMgrInfo.m
//  LarkDoctor
//
//  Created by 郑建武 on 15/3/27.
//  Copyright (c) 2015年 com.comvee. All rights reserved.
//
#import "PushMgrInfo.h"
#import "CDMacro.h"
#import "YRJSONAdapter.h"
#import "LWLoginManager.h"
#import "KLRegistPublicOperation.h"

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
    
    NSString *tokenkey = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    NSString *token = [[tokenkey stringByReplacingOccurrencesOfString:@" " withString:@""] copy];
    NSLog(@"token%@",token);
//    SHOWAlertView(@"", token)
    if (token) {
        [CODataCacheManager shareInstance].pushTokenKey = token;
        [[CODataCacheManager shareInstance] savePushKey];
    }
}


//launchType:1,启动，2应用在后台，3应用在前台
- (void)showRemotePushAction:(NSDictionary*)userInfo launchType:(int)launchType
{
    NSLog(@"showRemotePushAction:%d,%@",launchType,userInfo);

    if(![[userInfo objectForKey:@"aps"] objectForKey:@"alert"])
    {
        return;
    }
    
    if(!pushDic)
    {
        pushDic = [[NSMutableDictionary alloc] init];
    }
    
    [pushDic removeAllObjects];
    [pushDic addEntriesFromDictionary:userInfo];
    
    NSString *pushStr=[userInfo objectForKey:@"customdata"];
    NSData *pushData = [pushStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:pushData options:NSJSONReadingMutableLeaves error:nil];
    
    NSLog(@"%@",[dic JSONString]);
    NSString* busyType = [dic objectForKey:@"type"];
    
    
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
        case 8://认证通过
        {
//            [[NSNotificationCenter defaultCenter] postNotificationName:APP_PUSH_TYPE_CERTIFICATION_SUCC object:nil];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"已为您开通平台服务快去邀请您的患者吧" delegate:self cancelButtonTitle:@"这就去" otherButtonTitles:@"取消", nil];
            alert.tag = 2;
            [alert show];
            
            
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

- (void)isRegisterUserNotification:(UIApplication *)application
                     theisInfoDate:(BOOL)isDate{

    if (isDate)
    {
        NSDate *olddate = [[NSUserDefaults standardUserDefaults] objectForKey:@"UIUserNotificationTypeNoneDate"];
        NSDate *newDate = [NSDate date];
        
        double count = [newDate timeIntervalSinceReferenceDate] - [olddate timeIntervalSinceReferenceDate];
        NSInteger h = count/120;
        
        if (![LWLoginManager isLogin] || h < 12) {
            return;
        }
    }

    UIUserNotificationSettings *userNotSet = [application currentUserNotificationSettings];
    if (userNotSet.types == UIUserNotificationTypeNone)
    {
        [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"UIUserNotificationTypeNoneDate"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您的通知消息功能受到限制，这将影响您的消息推送功能，是否设置？" delegate:self cancelButtonTitle:@"是" otherButtonTitles:@"否", nil];
        alert.tag = 1;
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1) {
        if(buttonIndex == 0)
        {
            NSURL *url = [NSURL URLWithString:@"prefs:root=NOTIFICATIONS_ID&path=breatheDoctor://"];
            if ([[UIApplication sharedApplication] canOpenURL:url])
            {
                [[UIApplication sharedApplication] openURL:url];
            }
        }
    }else if (alertView.tag == 2){
    
        [KLRegistPublicOperation notCertificationAgainIfCertificationSuccess:^(BOOL isCheck) {
            
            id getCurrentVc = [self getCurrentVC];
            
            if ([getCurrentVc isKindOfClass:[UITabBarController class]]) {
                
                UITabBarController *tabar = getCurrentVc;
                UINavigationController *nav  = tabar.viewControllers[tabar.selectedIndex];
                [nav popToRootViewControllerAnimated:false];
                UIViewController *vc = [UIViewController CreateControllerWithTag:CtrlTag_AddPatient];
                vc.hidesBottomBarWhenPushed = YES;
                
                [nav pushViewController:vc animated:true];
            }

        }];
    }

}
//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}
@end
