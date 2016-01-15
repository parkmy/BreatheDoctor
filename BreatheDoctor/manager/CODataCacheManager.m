//
//  CADataCacheManager.m
//  CWGJCarPark
//
//  Created by mutouren on 9/7/15.
//  Copyright (c) 2015 lwh. All rights reserved.
//

#import "CODataCacheManager.h"
#import "COUserDefaultsManager.h"
#import "KSCache.h"

@implementation CODataCacheManager


//share Instance of Manager
+ (CODataCacheManager *)shareInstance
{
    static CODataCacheManager *instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^ { instance = [[CODataCacheManager alloc] init]; });
    return instance;
}

-(id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
#pragma mark 去读userDefault文件缓存
- (void)loadUserDefaultData
{
    LBLoginBaseModel *userModel = [COUserDefaultsManager shareInstance].userModel;
    if (userModel) {
        self.userModel = userModel;
    }
    self.pushTokenKey = [COUserDefaultsManager shareInstance].pushKeyId;
    self.fastReplys = [COUserDefaultsManager shareInstance].fastReply;
}

#pragma mark 保存用户信息
- (void)saveUserModel
{
    [[COUserDefaultsManager shareInstance] saveUserModel:self.userModel];
}
- (void)savePushKey
{
    [[COUserDefaultsManager shareInstance] savePushNotKey:self.pushTokenKey];
}
#pragma mark 清除用户信息
- (void)clearUserModel
{
    
    [KSCache cleanCache];
    
    LKDBHelper *db = [[LKDBHelper alloc] init];
    [db deleteWithTableName:[LKDBHelper baseTableName] where:nil];
    
    self.userModel = nil;
    [[COUserDefaultsManager shareInstance] removeUserModel];
}

- (void)updateReply:(NSArray *)replys
{
    [[COUserDefaultsManager shareInstance] updateFastReply:replys];
}

@end
