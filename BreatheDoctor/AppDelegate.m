//
//  AppDelegate.m
//  BreatheDoctor
//
//  Created by comv on 15/11/10.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "AppDelegate.h"
#import "CODataCacheManager.h"
#import "CDMacro.h"
#import "PushMgrInfo.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //加载缓存
    [[CODataCacheManager shareInstance] loadUserDefaultData];
    
    //注册通知
    [self registerUserNotification:application withLaunchOptions:launchOptions];
    

    return YES;
}



- (void)registerUserNotification:(UIApplication *)application  withLaunchOptions:(NSDictionary *)launchOptions
{
    
    //这里处理应用程序如果没有启动,但是是通过通知消息打开的,此时可以获取到消息.
    if (launchOptions != nil){
        NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        NSLog(@"程序关闭时候接到推送消息=%@",userInfo);
        [self performSelector:@selector(showPushAction:) withObject:userInfo afterDelay:0.50f];
        
        //appDelegate.global.pushDic=userInfo;
        //[self performSelector:@selector(showPushAction) withObject:nil afterDelay:0.50f];
    }
    
    //取消所有已经接受的通知
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    //清除推送角标
    application.applicationIconBadgeNumber = 0;
    
    if(systemVersion>=8.0)
    {
        //8.0以后使用这种方法来注册推送通知
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        //注册推送通知功能
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
    }

}

//处理连接改变后的情况
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)pToken
{
    [[PushMgrInfo sharedInstance] didRegisterDeviceToken:pToken];
    
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
    application.applicationIconBadgeNumber = 1;
    application.applicationIconBadgeNumber+= 1;
    
    if(application.applicationState!=UIApplicationStateActive)          //后台
    {
        // 处理推送消息
        [[PushMgrInfo sharedInstance] showRemotePushAction:userInfo launchType:2];
    }
    else
    {
        application.applicationIconBadgeNumber = 0;
        
        // 处理推送消息
        [[PushMgrInfo sharedInstance] showRemotePushAction:userInfo launchType:3];
    }
 
}

-(void)showPushAction:(NSDictionary*)userInfo
{
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [[PushMgrInfo sharedInstance] showRemotePushAction:userInfo launchType:1];
}

//本地通知
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    [[PushMgrInfo sharedInstance] showLocalPushAction:notification];
}


- (void)applicationWillEnterForeground:(UIApplication *)application
{
    //取消所有已经接受的通知
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    application.applicationIconBadgeNumber = 0;
    
    //     NSDictionary * dic = [[NSDictionary alloc]initWithObjectsAndKeys:@"151030174700015",@"id",@"http://comvee.3322.org:8888/comveedoctor/information/information.html",@"url", nil];
    //    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"AdvisoryBodyPushMsg" object:dic];
    //
    //    return;
    if ([LWPublicDataManager shareInstance].currentPatientID) //对话刷新对话消息
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"QuestionGetPushMsg" object:nil];
    }
    else
    {
        //刷新主页
    }
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
