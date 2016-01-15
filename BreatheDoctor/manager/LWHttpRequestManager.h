//
//  LWHttpRequestManager.h
//  BreatheDoctor
//
//  Created by comv on 15/11/11.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "KSNetRequest.h"
#import "DataModels.h"

@interface LWHttpRequestManager : NSObject

#pragma mark 登录
+ (void)httpLoginWithPhoneNumber:(NSString *)phoneNumber
                        password:(NSString*)password
                         success:(void (^)(LBLoginBaseModel *userModel))success
                         failure:(void (^)(NSString * errorMes))failure;

#pragma mark 录入推送key
+ (void)httpPushNotKeySuccess:(void (^)())success
                      failure:(void (^)(NSString * errorMes))failure;

#pragma mark 主页消息
+ (void)httpMaiMesggaeWithPage:(NSInteger )page
                          size:(NSInteger)size
                   refreshDate:(NSString *)refreshDate
                       success:(void (^)(LWMainMessageBaseModel *mainMessageBaseModel))success
                       failure:(void (^)(NSString * errorMes))failure;

#pragma mark 同意关注
+ (void)httpagreeAttentionWithPatientId:(NSString *)pid
                                    sid:(NSString *)sid
                                Success:(void (^)())success
                                failure:(void (^)(NSString * errorMes))failure;

#pragma mark 患者列表
+ (void)httpPatientListWithPage:(NSInteger )page
                          size:(NSInteger)size
                   refreshDate:(NSString *)refreshDate
                       success:(void (^)(LWPatientBaseModel *patientBaseModel))success
                       failure:(void (^)(NSString * errorMes))failure;

#pragma mark 对话列表
+ (void)httpChatPatientListWithPatientId:(NSString *)patientId
                                    Page:(NSInteger )page
                                    type:(NSInteger )type
                           size:(NSInteger)size
                    refreshDate:(NSString *)refreshDate
                        success:(void (^)(NSMutableArray *chats, LWChatBaseModel *baseModel))success
                        failure:(void (^)(NSString * errorMes))failure;

#pragma mark 修改密码
+ (void)httpChangeThePasswordWitholdPwd:(NSString *)oldPwd
                             newPwd:(NSString *)newPwd
                                 success:(void (^)(NSDictionary *dic))success
                                 failure:(void (^)(NSString * errorMes))failure;

#pragma mark 患者基本档案
+ (void)httpPantientArchivesWithPantientID:(NSString *)pid
                                   success:(void (^)(LWPatientRecordsBaseModel *patientRecordsBaseModel))success
                                   failure:(void (^)(NSString * errorMes))failure;

#pragma mark 患者备注设置
+ (void)httpPatientRemarkWithPatientId:(NSString *)pid
                               groupId:(NSString *)gid
                                remark:(NSString *)remark
                               success:(void (^)(NSDictionary *dic))success
                               failure:(void (^)(NSString * errorMes))failure;

#pragma mark 医生回复
+ (void)httpDoctorReply:(NSString *)patientId
                content:(NSString *)content
            contentType:(NSInteger )type
               voiceMin:(NSInteger)count
                success:(void (^)(LWSenderResBaseModel *senderResBaseModel))success
                failure:(void (^)(NSString * errorMes))failure;


#pragma mark 上传图片 语音
+ (void)httpUpLoadData:(NSData *)data
              WithType:(WSChatCellType)type
               success:(void (^)(NSDictionary *dic))success
               failure:(void (^)(NSString * errorMes))failure;

#pragma mark ACT评估
+ (void)httpLoadActById:(NSString *)byid
                success:(void (^)(LWACTModel *model))success
                failure:(void (^)(NSString * errorMes))failure;

#pragma mark 哮喘评估
+ (void)httpLoadAsthmaAssessmentById:(NSString *)byid
                success:(void (^)(LWAsthmaModel *model))success
                failure:(void (^)(NSString * errorMes))failure;

#pragma mark PEF记录
+ (void)httpLoadPEFRecordWithPatientId:(NSString *)patientId
                               StartDt:(NSString *)startDt
                                 EndDt:(NSString *)endDt
                               success:(void (^)(LWPEFLineModel *model))success
                               failure:(void (^)(NSString * errorMes))failure;

#pragma mark 加载哮喘症状评估日志录
+ (void)httpLoadAsthmaAssessLogWithPatientId:(NSString *)patientId
                               year:(NSString *)year
                                 month:(NSString *)month
                               success:(void (^)(LWAsthmaAssessLogModel *model))success
                               failure:(void (^)(NSString * errorMes))failure;

#pragma mark 加载ACT曲线评估日志
+ (void)httpLoadAsthmaAssessLogWithPatientId:(NSString *)pid
                                    starDate:(NSString *)starDate
                                     EndDate:(NSString *)endDate
                                     success:(void (^)(NSMutableArray *models))success
                                     failure:(void (^)(NSString * errorMes))failure;

#pragma mark 加载购买记录
+ (void)httpLoadShopOrderLogWithDate:(NSString *)date
                                     success:(void (^)(NSMutableArray *models))success
                                     failure:(void (^)(NSString * errorMes))failure;

#pragma mark 获取医生服务时间
+ (void)httploadDoctorServerTimeSuccess:(void (^)(NSMutableArray *models))success
                             failure:(void (^)(NSString * errorMes))failure;


#pragma mark 提交医生服务时间
+ (void)httpsubmitDoctorServerTimeWithJsonString:(NSString *)array
                                         Success:(void (^)())success
                                failure:(void (^)(NSString * errorMes))failure;

@end
