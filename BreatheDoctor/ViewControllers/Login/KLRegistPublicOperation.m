//
//  KLRegistPublicOperation.m
//  BreatheDoctor
//
//  Created by comv on 16/5/18.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLRegistPublicOperation.h"
#import "KLTimeButton.h"
#import "NSString+RegexCategory.h"
#import "KLRegistModel.h"

@implementation KLRegistPublicOperation

+ (void)senderMessageVcodeTheTimeButton:(KLTimeButton *)btn
                               thePhone:(NSString *)phone
                             verifyType:(NSInteger)type{
    
    if (phone.length <= 0||![phone isPhoneNumber]) {
        
        [[KLPromptViewManager shareInstance] kl_showPromptViewWithTitle:@"温馨提示" theContent:@"请输入正确的手机号码"];
        return ;
    }
    btn.text = @"正在发送..";
    btn.userInteractionEnabled = false;
    
    [LWHttpRequestManager httpSenderMessageVcoderThePhone:phone verifyType:type Success:^{
        
        [btn star];
        
    } failure:^(NSString *errorMes) {
        
        btn.userInteractionEnabled = true;
        btn.text = @"获取验证码";
        [[KLPromptViewManager shareInstance] kl_showPromptViewWithTitle:@"温馨提示" theContent:errorMes];
    }];
    
}
+ (void)loginWithPhoneNumber:(NSString *)phoneNumber
                      thePsw:(NSString *)psw
                     success:(void (^)(id userModel))success
                     failure:(void (^)(NSString * errorMes))failure{
    
    [LWHttpRequestManager httpLoginWithPhoneNumber:phoneNumber password:psw success:^(LBLoginBaseModel *userModel) {
        
        success?success(userModel):nil;
    } failure:^(NSString *errorMes) {
        failure?failure(errorMes):nil;
        [[KLPromptViewManager shareInstance] kl_showPromptViewWithTitle:@"温馨提示" theContent:errorMes];
    }];
}
+ (void)notCertificationAgainIfCertificationSuccess:(void (^)(BOOL isCheck))success{

    /**
     *  认证了就不需要判断了
     */
    if ([LBLoginBaseModel isCheckStatusTheIsShow:NO]) {
        return;
    }

    LBLoginBaseModel *userModel = [[CODataCacheManager shareInstance] userModel];
    
    if (userModel.loginZhangHao && userModel.loginMiMa) {
        
        [[self class] loginWithPhoneNumber:userModel.loginZhangHao thePsw:userModel.loginMiMa success:^(id user) {
            
            LBLoginBaseModel *userModel = user;
            
            success?success([userModel.body.CheckStatus boolValue]):nil;
            
        } failure:^(NSString *errorMes) {
            
            success?success(false):nil;
        }];
    }
    
}
@end
