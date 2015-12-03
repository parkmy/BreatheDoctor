//
//  CAUserDefaultsManager.m
//  CWGJCarPark
//
//  Created by mutouren on 9/7/15.
//  Copyright (c) 2015 lwh. All rights reserved.
//

#import "COUserDefaultsManager.h"


static NSString *const kUserModelKey = @"kUserModelKey";
static NSString *const kPushIDKey = @"kPushIDKey";
static NSString *const kUserFastReply = @"kUserFastReply";



@interface COUserDefaultsManager ()

@property (nonatomic, strong) NSUserDefaults *ud;

@end


@implementation COUserDefaultsManager


//share Instance of ViewManager
+ (COUserDefaultsManager *)shareInstance
{
    static COUserDefaultsManager *instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^ { instance = [[COUserDefaultsManager alloc] init]; });
    return instance;
}

-(id)init
{
    self = [super init];
    if (self) {
        self.ud = [NSUserDefaults standardUserDefaults];
    }
    return self;
}
#pragma mark 保存推送key
- (void)savePushNotKey:(NSString *)key
{
    if (key) {
        [_ud setObject:key forKey:kPushIDKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
- (NSString *)pushKeyId
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kPushIDKey];
}
#pragma mark 保存用户数据
- (void)saveUserModel:(LBLoginBaseModel*)userModel
{
    if (userModel){
        NSData * data = [NSKeyedArchiver archivedDataWithRootObject:userModel];
        [_ud setObject:data forKey:kUserModelKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
#pragma mark 删除用户数据
- (void)removeUserModel
{
        [_ud removeObjectForKey:kUserModelKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    
}

#pragma mark 返回用户数据
- (LBLoginBaseModel*)userModel
{
    return [NSKeyedUnarchiver unarchiveObjectWithData:[_ud objectForKey:kUserModelKey]];
}

- (void)updateFastReply:(NSArray *)replys
{
    [_ud setObject:replys forKey:kUserFastReply];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSArray *)morens
{
    return @[@"不能随便停药,会影响整体治疗效果的,要及时到我门诊复查",@"请做好复诊前自评,包括ACT评估,PEF记录和症状评估",@"因为哮喘症状（喘息,咳嗽,呼吸困难,胸闷或疼痛),您有多少次在夜间醒来或早上比平时起的早?"];
}
- (NSArray *)fastReply
{
    if (![_ud objectForKey:kUserFastReply]) {
        [self updateFastReply:[self morens]];
        return [self morens];
    }
    return [_ud objectForKey:kUserFastReply];

}

@end
