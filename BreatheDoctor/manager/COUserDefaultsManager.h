//
//  CAUserDefaultsManager.h
//  CWGJCarPark
//
//  Created by mutouren on 9/7/15.
//  Copyright (c) 2015 lwh. All rights reserved.
//  userDefault类 存到文件

#import <Foundation/Foundation.h>
#import "LBLoginBaseModel.h"

@interface COUserDefaultsManager : NSObject


//share Instance of NavManager
+ (COUserDefaultsManager *)shareInstance;


#pragma mark 保存推送key
- (void)savePushNotKey:(NSString *)key;

#pragma mark 返回推送key
- (NSString *)pushKeyId;

#pragma mark 保存用户数据
- (void)saveUserModel:(LBLoginBaseModel*)userModel;

#pragma mark 返回用户数据
- (LBLoginBaseModel*)userModel;

#pragma mark 删除用户数据
- (void)removeUserModel;

- (void)updateFastReply:(NSArray *)replys;
- (NSArray *)fastReply;

@end
