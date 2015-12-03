//
//  KSNetRequest.h
//  Test
//
//  Created by KS on 15/11/24.
//  Copyright © 2015年 xianhe. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger ,ErrorType) {

    ErrorTypeNetError = 0,
    ErrorTypeRequestError ,
};

@class UIViewController;
///  成功回调
typedef void (^requestSuccess)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject);
///  失败回调
typedef void (^requestFailure)(NSURLSessionDataTask * _Nullable task, NSString * _Nullable errorMessage);

@interface KSNetRequest : NSObject


/**
 *  检测网络状态下的POST请求
 *
 *  @param target     请求控制器
 *  @param URLString  请求地址
 *  @param parameters 请求参数
 *  @param success    成功回调
 *  @param failure    失败回调
 */
+ (void)requestTargetPOST:(nonnull NSString*)URLString parameters:(nullable id)parameters success:(nullable requestSuccess)success failure:(nullable requestFailure)failure isCache:(BOOL)isCache;

/**
 *  普通POST请求
 *
 *  @param URLString  请求接口
 *  @param parameters 请求参数
 *  @param success    成功回调
 *  @param failure    失败回调
 */
+ (void)requestPOST:(nonnull NSString*)URLString parameters:(nullable id)parameters success:(nullable requestSuccess)success failure:(nullable requestFailure)failure;

@end
