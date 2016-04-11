//
//  PushMgrInfo.h
//  LarkDoctor
//
//  Created by 郑建武 on 15/3/27.
//  Copyright (c) 2015年 com.comvee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PushMgrInfo : NSObject<UIAlertViewDelegate>


+ (PushMgrInfo *)sharedInstance;

@property(nonatomic,retain) NSMutableDictionary *pushDic;
//记录前一次的通知信息
@property(nonatomic,retain) UILocalNotification *localNotifyPrev;

//launchType:1,启动，2应用在后台，3应用在前台
- (void)showRemotePushAction:(NSDictionary*)userInfo launchType:(int)launchType;

- (void)showLocalPushAction:(UILocalNotification *)notification;

- (void)didRegisterDeviceToken:(NSData *)deviceToken;
/**
 *  判断是否注册通知未注册提示用户
 *
 *  @param application application description
 *  @param isDate      是否需要时间判断
 */
- (void)isRegisterUserNotification:(UIApplication *)application
                     theisInfoDate:(BOOL)isDate;

@end
