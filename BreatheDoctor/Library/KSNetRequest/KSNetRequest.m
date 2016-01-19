//
//  KSNetRequest.m
//  Test
//
//  Created by KS on 15/11/24.
//  Copyright © 2015年 xianhe. All rights reserved.
//
#import "KSCache.h"

#import "KSNetRequest.h"
#import <AFNetworking.h>
#import "ProgressHUD.h"
#import "UIViewController+KSNoNetController.h"

//===========================请求超时时间==========================//
#define TIMEOUTINTERVAL 10
//====================是不是需要缓存==YES需要==NO不需要====================//
#define ISCACHE YES

#define res_msg     @"res_msg"
#define res_code    @"res_code"
#define res_desc    @"res_desc"
#define res_body    @"body"


@interface KSNetRequest ()

@end

@implementation KSNetRequest


+ (BOOL)httpIsOk:(NSDictionary *)res
{
    if (res && [[res objectForKey:res_code] integerValue] == 1) {
        return YES;
    }
    return NO;
}
+ (NSString *)failureMes:(NSDictionary *)res
{
    return [res objectForKey:res_desc];
}
/**
 *  判断网络状态的POST请求
 */
+ (void)requestTargetPOST:(nonnull NSString*)URLString parameters:(nullable id)parameters success:(requestSuccess)success failure:(requestFailure)failure isCache:(BOOL)isCache
{
    if ([self checkNetState]) {
        if (isCache) {
            [self requestCache:URLString parameters:parameters success:success failure:failure];
        }else
        {
            [self requestProgress:URLString parameters:parameters success:success failure:failure];
        }
    }else{
        success?success(nil,[KSCache selectObjectWithURL:URLString parameter:parameters]):nil;
        failure?failure(nil,@"网络连接错误"):nil;
    }
}

/**
 *  添加Cache
 */
+ (void)requestCache:(nonnull NSString*)URLString parameters:(nullable id)parameters success:(requestSuccess)success failure:(requestFailure)failure
{
    
    if (ISCACHE) {
        if ([KSCache selectObjectWithURL:URLString parameter:parameters]) {
            success(nil,[KSCache selectObjectWithURL:URLString parameter:parameters]);
        }
        [self requestProgress:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
//            #warning warning
            //=====这个判断需要和后台协商，什么情况下请求成功=然后才可以缓寸=====================================================//
            if ([KSNetRequest httpIsOk:responseObject[res_msg]]) {
            //======================================================//
                [KSCache updateObject:responseObject withURL:URLString parameter:parameters];
                success?success(task,responseObject):nil;
            }else
            {
                failure?failure(task,[KSNetRequest failureMes:responseObject[res_msg]]):nil;
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSString * _Nullable errorMessage) {
            failure?failure(task,errorMessage):nil;
        }];
    }else{
        [self requestProgress:URLString parameters:parameters success:success failure:failure];
    }
}
/**
 *  带活动指示器的请求
 */
+ (void)requestProgress:(nonnull NSString*)URLString parameters:(nullable id)parameters success:(requestSuccess)success failure:(requestFailure)failure
{
    [self requestPOST:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        success?success(task,responseObject):nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSString * _Nullable errorMessage) {
        
        failure?failure(task,errorMessage):nil;
    }];
}
/**
 *  基本POST请求
 */
+ (void)requestPOST:(nonnull NSString*)URLString parameters:(nullable id)parameters success:(requestSuccess)success failure:(requestFailure)failure
{
    AFHTTPSessionManager* manager = [self getManager];
    
    [manager POST:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSDictionary *resMsg = responseObject[res_msg];

        //先判断是否有回调，然后回调
        if ([KSNetRequest httpIsOk:resMsg]) {
            success?success(task,responseObject):nil;
        }else if ([[resMsg objectForKey:res_code] isEqualToString:@"20000"]){//医生信息错误
            failure?failure(task,[KSNetRequest failureMes:responseObject[res_msg]]):nil;
        }
        else
        {
            NSLog(@"%@",responseObject);
            failure?failure(task,[KSNetRequest failureMes:responseObject[res_msg]]):nil;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //如果有回调，则返回处理
        failure?failure(task,@"无法连接服务器"):NSLog(@"%@",error);
    }];
}


/**
 *  判断网络状态
 *
 *  @return 返回状态 YES 为有网 NO 为没有网
 */
+ (BOOL)checkNetState
{ 
    return [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus > 0;
}

/**
 *  创建请求者
 *
 *  @return AFHTTPSessionManager
 */
+ (AFHTTPSessionManager*)getManager
{
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    
    //设置请求超时
    manager.requestSerializer.timeoutInterval = TIMEOUTINTERVAL;
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"html/text",@"text/json",nil];
    return manager;
}
@end
