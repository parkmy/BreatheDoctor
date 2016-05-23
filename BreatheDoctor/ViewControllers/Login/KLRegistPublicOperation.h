//
//  KLRegistPublicOperation.h
//  BreatheDoctor
//
//  Created by comv on 16/5/18.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KLTimeButton;

@interface KLRegistPublicOperation : NSObject

+ (void)senderMessageVcodeTheTimeButton:(KLTimeButton *)btn
                               thePhone:(NSString *)phone
                             verifyType:(NSInteger)type;

+ (void)loginWithPhoneNumber:(NSString *)phoneNumber
                      thePsw:(NSString *)psw
                     success:(void (^)(id userModel))success
                     failure:(void (^)(NSString * errorMes))failure;
/**
 *  判断是否认证
*/
+ (void)notCertificationAgainIfCertificationSuccess:(void (^)(BOOL isCheck))success;

@end
