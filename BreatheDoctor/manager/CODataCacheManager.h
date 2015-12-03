//
//  CADataCacheManager.h
//  CWGJCarPark
//
//  Created by mutouren on 9/7/15.
//  Copyright (c) 2015 lwh. All rights reserved.
//  数据缓存类

#import <Foundation/Foundation.h>
#import "LBLoginBaseModel.h"

@interface CODataCacheManager : NSObject

@property (nonatomic, strong) LBLoginBaseModel *userModel;                   //用户基本信息

@property (nonatomic, strong) NSArray *fastReplys; //快捷回复

@property (nonatomic, copy)  NSString *pushTokenKey;

//share Instance of NavManager
+ (CODataCacheManager *)shareInstance;

+ (NSString *)DB_MainMessageTableName;
+ (NSString *)DB_MainPatientTbaleName;

#pragma mark 去读userDefault文件缓存
- (void)loadUserDefaultData;

#pragma mark 保存用户信息
- (void)saveUserModel;

#pragma mark 清除用户信息
- (void)clearUserModel;

#pragma mark 保存key
- (void)savePushKey;

- (void)updateReply:(NSArray *)replys;

@end
