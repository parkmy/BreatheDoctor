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
#import "KLGoodsDetailedModel.h"

@interface LWHttpRequestManager : NSObject

#pragma mark 获取http管理者
+ (AFHTTPRequestOperationManager*)httpRequestManager;
#pragma mark - 全局接口变量对象
+ (void )addPublicHeaderPost:(NSMutableDictionary *)requestParams;
+ (NSMutableDictionary *)dic;

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
                        success:(void (^)(NSMutableArray *list))success
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
              foreignId:(NSString *)foreignId
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


#pragma mark 获取医生服务时间
+ (void)httploadDoctorServerTimeSuccess:(void (^)(NSMutableArray *models))success
                                failure:(void (^)(NSString * errorMes))failure;


#pragma mark 提交医生服务时间
+ (void)httpsubmitDoctorServerTimeWithJsonString:(NSString *)array
                                         Success:(void (^)())success
                                         failure:(void (^)(NSString * errorMes))failure;

#pragma mark 加载表单详细信息
+ (void)httploadFirstDiagnosticInfowithdiagnosticId:(NSString *)diagnosticId
                                            Success:(void (^)(LWPatientBiaoDanBody *model))success
                                            failure:(void (^)(NSString * errorMes))failure;
#pragma mark 加载表单日志信息
+ (void)httploadPatientFirstDiagnosticList:(NSString *)patientId
                                   Success:(void (^)(NSMutableArray *models))success
                                   failure:(void (^)(NSString * errorMes))failure;

#pragma mark 提交患者病情相关
+ (void)httpsubmitDiseaseRelateWithPatientId:(NSString *)patientId
                             treatmentResult:(NSString *)treatmentResult
                              basicCondition:(NSString *)basicCondition
                                      images:(NSString *)images
                                     Success:(void (^)(NSMutableArray *models))success
                                     failure:(void (^)(NSString * errorMes))failure;

#pragma mark  加载患者病情相关
+ (void)httploadDiseaseRelate:(NSString *)patientId
                      Success:(void (^)(LWPatientRelatedModel *model))success
                      failure:(void (^)(NSString * errorMes))failure;

#pragma mark  修改患者病情相关
+ (void)httpupdateDiseaseRelateWithSid:(NSString *)sid
                       treatmentResult:(NSString *)treatmentResult
                        basicCondition:(NSString *)basicCondition
                                images:(NSString *)images
                               Success:(void (^)(NSMutableArray *models))success
                               failure:(void (^)(NSString * errorMes))failure;

#pragma mark  拒绝患者添加
+ (void)httprefuseAttentionWithSid:(NSString *)sid
                         patientID:(NSString *)pid
                           Success:(void (^)())success
                           failure:(void (^)(NSString * errorMes))failure;

#pragma mark  加载订单记录首页
+ (void)httpLoadDoctorRelateOrderIndexWithDate:(NSString *)date
                                       Success:(void (^)(NSMutableArray *models))success
                                       failure:(void (^)(NSString * errorMes))failure;

#pragma mark  加载购买记录(根据订单类型)
+ (void)httpLoadOrderListWithDate:(NSString *)date
                   andProductType:(NSString *)productType
                          andPage:(NSInteger)page
                          Success:(void (^)(NSMutableArray *models))success
                          failure:(void (^)(NSString * errorMes))failure;
#pragma mark  加载预约详情
+ (void)httpLoadOrderAppointmentInfoWithOrdAppid:(NSString *)ordAppid
                                         Success:(void (^)(LWReservationDetailedModel *model))success
                                         failure:(void (^)(NSString * errorMes))failure;

#pragma mark  加载患者历史记录
+ (void)httpLoadPatientRecordHistoryWithPatientId:(NSString *)pid
                                       recentDays:(NSInteger)day
                                          Success:(void (^)(KLPatientLogBodyModel *model))success
                                          failure:(void (^)(NSString * errorMes))failure;

#pragma mark  加载商品列表
+ (void)httploadProductListPage:(NSInteger)page
                       theCount:(NSInteger)count
                        Success:(void (^)(NSMutableArray *models))success
                        failure:(void (^)(NSString * errorMes))failure;

#pragma mark  加载商品详情
+ (void)httploadProductDetailWithproductId:(NSString *)productId
                                   Success:(void (^)(KLGoodsDetailedModel *models))success
                                   failure:(void (^)(NSString * errorMes))failure;

#pragma mark  群发消息
/**
 *  群发消息
 *
 *  @param content          内容
 *  @param patientIdJsonStr 患者列表
 *  @param contentType      内容类型
 *  @param voiceMin         语音秒数
 *  @param foreignId        商品或者事物ID
 *  @param success          成功
 *  @param failure          失败
 */
+ (void)httploadProductDetailWithContent:(NSString *)content
                        patientIdJsonStr:(NSString *)patientIdJsonStr
                             contentType:(NSInteger )contentType
                                voiceMin:(NSInteger )voiceMin
                               foreignId:(NSString *)foreignId
                                 Success:(void (^)())success
                                 failure:(void (^)(NSString * errorMes))failure;


#pragma mark  群发记录
+ (void)httploadMassDialogueRecordWithRefreshTime:(NSString *)refreshTime
                                          thePage:(NSInteger)page
                                          theType:(NSInteger)type
                                          Success:(void (^)(NSMutableArray *models))success
                                          failure:(void (^)(NSString * errorMes))failure;

#pragma mark  群发记录删除
+ (void)httpdeleteMassDialogueRecordWithMassDialogueId:(NSString *)massDialogueId
                                               Success:(void (^)())success
                                               failure:(void (^)(NSString * errorMes))failure;


#pragma mark  发送短信验证码
+ (void)httpSenderMessageVcoderThePhone:(NSString *)mobilePhone
                             verifyType:(NSInteger)verifyType
                                Success:(void (^)())success
                                failure:(void (^)(NSString * errorMes))failure;

#pragma mark  注册
+ (void)httpRegistDoctorWithMobilePhone:(NSString *)mobilePhone
                             theUserPsw:(NSString *)userPsw
                          theVerifyCode:(NSString *)verifyCode
                      theInvitationCode:(NSString *)invitationCode
                                Success:(void (^)())success
                                failure:(void (^)(NSString * errorMes))failure;

#pragma mark  找回密码
+ (void)httpFindPasswordWithMobilePhone:(NSString *)mobilePhone
                          theVerifyCode:(NSString *)verifyCode
                              theNewPwd:(NSString *)newPwd
                                Success:(void (^)())success
                                failure:(void (^)(NSString * errorMes))failure;
@end
