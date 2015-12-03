//
//  ControllerExtraDataManager.m
//  BaseMVVM
//
//  Created by lwh on 15/8/11.
//  Copyright (c) 2015年 lwh. All rights reserved.
//

#import "ControllerExtraDataManager.h"


@interface ControllerExtraDataManager ()

@property (nonatomic, strong) NSMutableDictionary *extraDataArray;


@end


@implementation ControllerExtraDataManager


+ (ControllerExtraDataManager *)shareInstance
{
    static ControllerExtraDataManager *instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^ { instance = [[ControllerExtraDataManager alloc] init]; });
    return instance;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.extraDataArray = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

#pragma mark 存数据
- (void)setObject:(id)obj forKey:(NSString*)key
{
    [self.extraDataArray setObject:obj forKey:key];
}

#pragma mark 取数据
- (id)objectForKey:(NSString*)key
{
    
    return [self.extraDataArray objectForKey:key];
}

#pragma mark 清除所有数据
- (void)clearAllData
{
    [self.extraDataArray removeAllObjects];
}

#pragma mark 清除数据
- (void)clearDataForKey:(NSString*)key
{
    [self.extraDataArray removeObjectForKey:key];
}

@end
