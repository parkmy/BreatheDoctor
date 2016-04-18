//
//  LWHttpRequestManager.m
//  BreatheDoctor
//
//  Created by comv on 15/11/11.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWHttpRequestManager.h"
#import <OpenUDID.h>
#import "NSString+Contains.h"
#import "LWHttpDefine.h"
#import "YRJSONAdapter.h"
#import "CODataCacheManager.h"
#import "NSDate+Extension.h"
#import "KSCache.h"
#import "KLPatientListModel.h"

@implementation LWHttpRequestManager


#pragma mark 获取http管理者
+ (AFHTTPRequestOperationManager*)httpRequestManager
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.0f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    return manager;
}

#pragma mark - 全局接口变量对象
+ (void )addPublicHeaderPost:(NSMutableDictionary *)requestParams
{
    NSString *sessionId = [CODataCacheManager shareInstance].userModel.sessionId;
    NSString *pushTokenKey = [CODataCacheManager shareInstance].pushTokenKey;;
    if (sessionId) {
        [requestParams setObject:sessionId forKey:@"sessionId"];
    }
    if (pushTokenKey) {
        [requestParams setObject:pushTokenKey forKey:@"pushTokenKey"];
    }
    [requestParams setObject:[OpenUDID value] forKey:@"dev"]; //udid
    NSString *systemVersionStr=[NSString stringWithFormat:@"%0.2f",systemVersion];
    [requestParams setObject:systemVersionStr forKey:@"sys"];
    [requestParams setObject:@"ios" forKey:@"dev_type"];
    [requestParams setObject:[NSString appVersion] forKey:@"ver"];
    //01 商店 03 企业 99 测试
    [requestParams setObject:[NSString stringWithFormat:@"10202%@",LOADFROMKEY] forKey:@"loadFrom"];
    
}

+ (NSMutableDictionary *)dic
{
    return [NSMutableDictionary dictionary];
}
+ (NSString *)urlWith:(NSString *)duanjie
{
    return [NSString stringWithFormat:@"%@%@",Comvee_Url,duanjie];
}

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
#pragma mark 登录
+ (void)httpLoginWithPhoneNumber:(NSString *)phoneNumber
                        password:(NSString*)password
                         success:(void (^)(LBLoginBaseModel *userModel))success
                         failure:(void (^)(NSString * errorMes))failure
{
    NSMutableDictionary *requestParams = [LWHttpRequestManager dic];
    [requestParams setObject:phoneNumber forKey:@"userNo"];
    [requestParams setObject:password forKey:@"userPwd"];
    
    [LWHttpRequestManager addPublicHeaderPost:requestParams];
    
    [KSNetRequest requestTargetPOST:[LWHttpRequestManager urlWith:HTTP_POST_LOGIN] parameters:requestParams success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        NSLog(@"%@",[responseObject JSONString]);
        LBLoginBaseModel *userModel = [[LBLoginBaseModel alloc] initWithDictionary:responseObject];
        [CODataCacheManager shareInstance].userModel = userModel;
        [[CODataCacheManager shareInstance] saveUserModel];
        
        if (success){ success(userModel);}
    } failure:^(NSURLSessionDataTask * _Nullable task, NSString * _Nullable errorMessage) {
        failure?failure(errorMessage):nil;
    } isCache:NO];
    
}
#pragma mark 录入推送key
+ (void)httpPushNotKeySuccess:(void (^)())success
                      failure:(void (^)(NSString * errorMes))failure
{
    NSMutableDictionary *requestParams = [LWHttpRequestManager dic];
    
    [LWHttpRequestManager addPublicHeaderPost:requestParams];
    
    [KSNetRequest requestTargetPOST:[LWHttpRequestManager urlWith:HTTP_POST_SETPUSHKEY] parameters:requestParams success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        if (success){ success();}
    } failure:^(NSURLSessionDataTask * _Nullable task, NSString * _Nullable errorMessage) {
        failure?failure(errorMessage):nil;
    } isCache:NO];
    
}
#pragma mark 主页消息
+ (void)httpMaiMesggaeWithPage:(NSInteger )page
                          size:(NSInteger)size
                   refreshDate:(NSString *)refreshDate
                       success:(void (^)(LWMainMessageBaseModel *mainMessageBaseModel))success
                       failure:(void (^)(NSString * errorMes))failure
{
    NSMutableDictionary *requestParams = [LWHttpRequestManager dic];
    [requestParams setObject:kNSNumInteger(page) forKey:@"page"];
    [requestParams setObject:kNSNumInteger(size) forKey:@"rows"];
    if (refreshDate) {
        [requestParams setObject:refreshDate forKey:@"refreshDate"];
    }
    [LWHttpRequestManager addPublicHeaderPost:requestParams];
    
    if (![CODataCacheManager shareInstance].userModel)
    {
        return;
    }
    NSLog(@"~~~~~~~~~~%@",[requestParams JSONString]);
    
    [KSNetRequest requestTargetPOST:[LWHttpRequestManager urlWith:HTTP_POST_LOADHOMEPAGE] parameters:requestParams success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        NSLog(@"%@",[responseObject
                     JSONString]);
        LWMainMessageBaseModel *mainMessageBaseModel = [[LWMainMessageBaseModel alloc] initWithDictionary:responseObject];
        
        for (LWMainRows *row in mainMessageBaseModel.body.rows)
        {
            NSString *wheres = [NSString stringWithFormat:@"memberId = %@",row.memberId];
            
            LWMainRows *messageModel = [[LKDBHelper getUsingLKDBHelper] searchSingle:[row class] where:wheres orderBy:nil];
            NSDate *oldDate = [NSDate dateWithString:messageModel.insertDt format:[NSDate ymdHmsFormat]];
            NSDate *newDate = [NSDate dateWithString:row.insertDt format:[NSDate ymdHmsFormat]];
            
            if ([newDate timeIntervalSinceReferenceDate] > [oldDate timeIntervalSinceReferenceDate])
            {
                NSInteger count = [[LKDBHelper getUsingLKDBHelper] rowCount:[LWMainRows class] where:wheres];
                if (count > 0) {
                    [[LKDBHelper getUsingLKDBHelper] updateToDB:row where:wheres];
                }else
                {
                    [[LKDBHelper getUsingLKDBHelper] insertToDB:row];
                }
            }
        }
        if (success){ success(mainMessageBaseModel);}
    } failure:^(NSURLSessionDataTask * _Nullable task, NSString * _Nullable errorMessage) {
        failure?failure(errorMessage):nil;
    } isCache:NO];
    
}

#pragma mark 同意关注
+ (void)httpagreeAttentionWithPatientId:(NSString *)pid
                                    sid:(NSString *)sid
                                Success:(void (^)())success
                                failure:(void (^)(NSString * errorMes))failure
{
    
    NSMutableDictionary *requestParams = [LWHttpRequestManager dic];
    [requestParams setObject:stringJudgeNull(pid) forKey:@"patientId"];
    [requestParams setObject:stringJudgeNull(sid) forKey:@"sid"];
    
    [LWHttpRequestManager addPublicHeaderPost:requestParams];
    
    [KSNetRequest requestTargetPOST:[LWHttpRequestManager urlWith:HTTP_POST_AGREEATTENTION] parameters:requestParams success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        if (success){ success();}
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSString * _Nullable errorMessage) {
        failure?failure(errorMessage):nil;
    } isCache:NO];
    
}

#pragma mark 患者列表
+ (void)httpPatientListWithPage:(NSInteger )page
                           size:(NSInteger)size
                    refreshDate:(NSString *)refreshDate
                        success:(void (^)(NSMutableArray *list))success
                        failure:(void (^)(NSString * errorMes))failure
{
    
    NSMutableDictionary *requestParams = [LWHttpRequestManager dic];
    [requestParams setObject:kNSNumInteger(page) forKey:@"page"];
    [requestParams setObject:kNSNumInteger(size) forKey:@"rows"];
    if (refreshDate) {
        [requestParams setObject:refreshDate forKey:@"refreshTime"];
    }
    [LWHttpRequestManager addPublicHeaderPost:requestParams];
    
    [KSNetRequest requestTargetPOST:[LWHttpRequestManager urlWith:HTTP_POST_LOADPATIENTLIST] parameters:requestParams success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        NSLog(@"%@",[responseObject
                     JSONString]);
        NSDictionary *body = responseObject[res_body];
        NSArray      *rows = body[@"rows"];
        NSString     *refTimer = body[@"refreshTime"];
        NSMutableArray *list = [NSMutableArray array];
        for (NSDictionary *dic in rows)
        {
            KLPatientListModel *model = [[KLPatientListModel alloc] initWithDictionary:dic];
            model.refTimer = refTimer;
            [list addObject:model];
            NSString *where = [NSString stringWithFormat:@"patientId = %@",model.patientId];
            if ([[LKDBHelper getUsingLKDBHelper] isExistsClass:[KLPatientListModel class] where:where]) {
                [[LKDBHelper getUsingLKDBHelper]updateToDB:model where:where];
            }
            else{
                [[LKDBHelper getUsingLKDBHelper] insertToDB:model];
            }
        }
        
        /**
         *  以后增加缓存清除处理老版本缓存
         */
//        for (LWPatientRows *model in patientBaseModel.body.rows) {
//            
//            NSString *where = [NSString stringWithFormat:@"patientId = %@",model.patientId];
//            if ([[LKDBHelper getUsingLKDBHelper] isExistsClass:[LWPatientRows class] where:where]) {
//                [[LKDBHelper getUsingLKDBHelper]updateToDB:model where:where];
//            }
//            else
//                [[LKDBHelper getUsingLKDBHelper] insertToDB:model];
//        }
//        
        if (success){ success(list);}
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSString * _Nullable errorMessage) {
        failure?failure(errorMessage):nil;
    } isCache:NO];
    
    
}

#pragma mark 对话列表
+ (void)httpChatPatientListWithPatientId:(NSString *)patientId
                                    Page:(NSInteger )page
                                    type:(NSInteger )type
                                    size:(NSInteger)size
                             refreshDate:(NSString *)refreshDate
                                 success:(void (^)(NSMutableArray *chats, LWChatBaseModel *baseModel))success
                                 failure:(void (^)(NSString * errorMes))failure
{
    NSMutableDictionary *requestParams = [LWHttpRequestManager dic];
    
    [requestParams setObject:kNSString(kNSNumInteger(1)) forKey:@"page"];
    [requestParams setObject:kNSString(kNSNumInteger(size)) forKey:@"rows"];
    [requestParams setObject:kNSNumInteger(type) forKey:@"type"];
    if (refreshDate) {
        [requestParams setObject:refreshDate forKey:@"time"];
    }
    if (patientId) {
        [requestParams setObject:patientId forKey:@"patientId"];
    }
    [LWHttpRequestManager addPublicHeaderPost:requestParams];
    
    
    [KSNetRequest requestTargetPOST:[LWHttpRequestManager urlWith:HTTP_POST_LOADDIALOGUE] parameters:requestParams success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        NSLog(@"%@",[responseObject
                     JSONString]);
        LWChatBaseModel *chat = [[LWChatBaseModel alloc] initWithDictionary:responseObject];
        if (chat.body.rows.count <= 0) {
            if (success){ success([NSMutableArray array],chat);}
            return ;
        }
        [chat updateModel];
        
        NSString *where;
        if (type == 1) {
            if (refreshDate) {
                where = [NSString stringWithFormat:@"insertDt < '%@' and memberId = %@",refreshDate,patientId];
            }else
            {
                where = [NSString stringWithFormat:@"memberId = %@",patientId];
            }
        }else
        {
            where = [NSString stringWithFormat:@"insertDt < '%@' and memberId = %@",[NSDate stringWithDate:[NSDate date] format:[NSDate ymdHmsFormat]],patientId];
        }
        
        if (success){ success([LWChatBaseModel LoadSqliteDataWhere:where Offset:0 count:size],chat);}
    } failure:^(NSURLSessionDataTask * _Nullable task, NSString * _Nullable errorMessage) {
        failure?failure(errorMessage):nil;
    } isCache:NO];
}

#pragma mark 修改密码
+ (void)httpChangeThePasswordWitholdPwd:(NSString *)oldPwd
                                 newPwd:(NSString *)newPwd
                                success:(void (^)(NSDictionary *dic))success
                                failure:(void (^)(NSString * errorMes))failure
{
    NSMutableDictionary *requestParams = [LWHttpRequestManager dic];
    
    [requestParams setObject:oldPwd forKey:@"oldPwd"];
    [requestParams setObject:newPwd forKey:@"newPwd"];
    
    [LWHttpRequestManager addPublicHeaderPost:requestParams];
    
    [KSNetRequest requestTargetPOST:[LWHttpRequestManager urlWith:HTTP_POST_CHANGETHEPASSWORD] parameters:requestParams success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        if (success){ success(responseObject);}
    } failure:^(NSURLSessionDataTask * _Nullable task, NSString * _Nullable errorMessage) {
        failure?failure(errorMessage):nil;
    } isCache:NO];
}

#pragma mark 患者基本档案
+ (void)httpPantientArchivesWithPantientID:(NSString *)pid
                                   success:(void (^)(LWPatientRecordsBaseModel *patientRecordsBaseModel))success
                                   failure:(void (^)(NSString * errorMes))failure
{
    NSMutableDictionary *requestParams = [LWHttpRequestManager dic];
    
    [requestParams setObject:stringJudgeNull(pid) forKey:@"patientId"];
    
    [LWHttpRequestManager addPublicHeaderPost:requestParams];
    
    [KSNetRequest requestTargetPOST:[LWHttpRequestManager urlWith:HTTP_POST_PANTIENTARCHIVES] parameters:requestParams success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        NSLog(@"%@",[responseObject JSONString]);
        LWPatientRecordsBaseModel *model = [[LWPatientRecordsBaseModel alloc] initWithDictionary:responseObject];
        if (success){ success(model);}
    } failure:^(NSURLSessionDataTask * _Nullable task, NSString * _Nullable errorMessage) {
        failure?failure(errorMessage):nil;
    } isCache:YES];
    
}
#pragma mark 患者备注设置
+ (void)httpPatientRemarkWithPatientId:(NSString *)pid
                               groupId:(NSString *)gid
                                remark:(NSString *)remark
                               success:(void (^)(NSDictionary *dic))success
                               failure:(void (^)(NSString * errorMes))failure
{
    
    
    NSMutableDictionary *requestParams = [LWHttpRequestManager dic];
    
    [requestParams setObject:stringJudgeNull(pid) forKey:@"patientId"];
    if (gid) {
        [requestParams setObject:stringJudgeNull(gid) forKey:@"groupId"];
    }
    [requestParams setObject:stringJudgeNull(remark) forKey:@"remark"];
    
    [LWHttpRequestManager addPublicHeaderPost:requestParams];
    
    [KSNetRequest requestTargetPOST:[LWHttpRequestManager urlWith:HTTP_POST_SETPATIENTREMARK] parameters:requestParams success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        if (success){ success(responseObject);}
    } failure:^(NSURLSessionDataTask * _Nullable task, NSString * _Nullable errorMessage) {
        failure?failure(errorMessage):nil;
    } isCache:NO];
    
}
#pragma mark 医生回复
+ (void)httpDoctorReply:(NSString *)patientId
                content:(NSString *)content
            contentType:(NSInteger )type
               voiceMin:(NSInteger)count
                success:(void (^)(LWSenderResBaseModel *senderResBaseModel))success
                failure:(void (^)(NSString * errorMes))failure
{
    
    NSMutableDictionary *requestParams = [LWHttpRequestManager dic];
    
    [requestParams setObject:stringJudgeNull(patientId) forKey:@"patientId"];
    if (content) {
        [requestParams setObject:stringJudgeNull(content) forKey:@"content"];
    }
    [requestParams setObject:kNSNumInteger(type) forKey:@"contentType"];
    if (count > 0) {
        [requestParams setObject:kNSNumInteger(count) forKey:@"voiceMin"];
    }
    [LWHttpRequestManager addPublicHeaderPost:requestParams];
    
    [KSNetRequest requestTargetPOST:[LWHttpRequestManager urlWith:HTTP_POST_DOCTORREPLY] parameters:requestParams success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        
        NSLog(@"%@",[responseObject JSONString]);
        LWSenderResBaseModel *senderResBaseModel = [[LWSenderResBaseModel alloc] initWithDictionary:responseObject];
        if ([senderResBaseModel.body.sid isEqualToString:@""] || !senderResBaseModel.body.sid) {
            if (failure) {
                failure([LWHttpRequestManager failureMes:responseObject[res_msg]]);
            }
            return ;
        }
        if (success)
        {
            success([[LWSenderResBaseModel alloc] initWithDictionary:responseObject]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSString * _Nullable errorMessage) {
        failure?failure(errorMessage):nil;
    } isCache:NO];
    
}

#pragma mark 上传图片 语音
+ (void)httpUpLoadData:(NSData *)data
              WithType:(WSChatCellType )type
               success:(void (^)(NSDictionary *dic))success
               failure:(void (^)(NSString * errorMes))failure
{
    
    AFHTTPRequestOperationManager *httpManager = [LWHttpRequestManager httpRequestManager];
    
    NSMutableDictionary *requestParams = [LWHttpRequestManager dic];
    [LWHttpRequestManager addPublicHeaderPost:requestParams];
    //199 测试
    //105 正式
    [requestParams setObject:platCode forKey:@"platCode"];
    [requestParams setObject:[NSDate stringWithDate:[NSDate date] format:@"yyyy-MM-dd HH:mm:ss"] forKey:@"req_num"];
    [httpManager POST:comveeUpload_URL parameters:requestParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:data name:type==2?@"testimage.jpg":@"testaudio.mp3" fileName:type==2?@"testimage.jpg":@"testaudio.mp3" mimeType:type==2?@"image/jpg":@"audio/mp3"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *jsDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        if ([jsDic objectForKey:res_msg]) {
            if ([[[jsDic objectForKey:res_msg] objectForKey:res_code]integerValue] == 0) {
                if (success) {
                    success(jsDic);
                }
            }else
            {
                if (failure) {
                    failure([jsDic[res_msg] objectForKey:res_msg]);
                }
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(@"无法连接到服务器");
        }
    }];
    
}

#pragma mark ACT评估
+ (void)httpLoadActById:(NSString *)byid
                success:(void (^)(LWACTModel *model))success
                failure:(void (^)(NSString * errorMes))failure
{
    
    NSMutableDictionary *requestParams = [LWHttpRequestManager dic];
    
    [requestParams setObject:stringJudgeNull(byid) forKey:@"id"];
    
    [LWHttpRequestManager addPublicHeaderPost:requestParams];
    
    [KSNetRequest requestTargetPOST:[LWHttpRequestManager urlWith:HTTP_POST_GETACTBYID] parameters:requestParams success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        if (success){ success([[LWACTModel alloc] initWithDictionary:responseObject[res_body]]);}
    } failure:^(NSURLSessionDataTask * _Nullable task, NSString * _Nullable errorMessage) {
        failure?failure(errorMessage):nil;
    } isCache:YES];
    
}

#pragma mark 哮喘评估
+ (void)httpLoadAsthmaAssessmentById:(NSString *)byid
                             success:(void (^)(LWAsthmaModel *model))success
                             failure:(void (^)(NSString * errorMes))failure
{
    NSMutableDictionary *requestParams = [LWHttpRequestManager dic];
    
    [requestParams setObject:stringJudgeNull(byid) forKey:@"id"];
    
    [LWHttpRequestManager addPublicHeaderPost:requestParams];
    
    [KSNetRequest requestTargetPOST:[LWHttpRequestManager urlWith:HTTP_POST_GETASTHMABYID] parameters:requestParams success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        NSLog(@"%@",[responseObject JSONString]);

        if (success){ success([[LWAsthmaModel alloc] initWithDictionary:responseObject[res_body]]);}
    } failure:^(NSURLSessionDataTask * _Nullable task, NSString * _Nullable errorMessage) {
        failure?failure(errorMessage):nil;
    } isCache:YES];
}

#pragma mark 加载哮喘症状评估日志录
+ (void)httpLoadAsthmaAssessLogWithPatientId:(NSString *)patientId
                                        year:(NSString *)year
                                       month:(NSString *)month
                                     success:(void (^)(LWAsthmaAssessLogModel *model))success
                                     failure:(void (^)(NSString * errorMes))failure
{
    NSMutableDictionary *requestParams = [LWHttpRequestManager dic];
    
    [requestParams setObject:stringJudgeNull(patientId) forKey:@"patientId"];
    [requestParams setObject:stringJudgeNull(year) forKey:@"year"];
    [requestParams setObject:stringJudgeNull(month) forKey:@"month"];
    
    [LWHttpRequestManager addPublicHeaderPost:requestParams];
    
    [KSNetRequest requestTargetPOST:[LWHttpRequestManager urlWith:HTTP_POST_LOADACTASSESSLOG] parameters:requestParams success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        if (success){ success([[LWAsthmaAssessLogModel alloc] initWithDictionary:responseObject]);}
    } failure:^(NSURLSessionDataTask * _Nullable task, NSString * _Nullable errorMessage) {
        failure?failure(errorMessage):nil;
    } isCache:YES];
    
}


#pragma mark 加载ACT曲线评估日志
+ (void)httpLoadAsthmaAssessLogWithPatientId:(NSString *)pid
                                    starDate:(NSString *)starDate
                                     EndDate:(NSString *)endDate
                                     success:(void (^)(NSMutableArray *models))success
                                     failure:(void (^)(NSString * errorMes))failure
{
    NSMutableDictionary *requestParams = [LWHttpRequestManager dic];
    
    [requestParams setObject:stringJudgeNull(pid) forKey:@"patientId"];
    [requestParams setObject:stringJudgeNull(starDate) forKey:@"startDt"];
    [requestParams setObject:stringJudgeNull(endDate) forKey:@"endDt"];
    
    [LWHttpRequestManager addPublicHeaderPost:requestParams];
    
    [KSNetRequest requestTargetPOST:[LWHttpRequestManager urlWith:HTTP_POST_LOADASTHMAASSESSLOG] parameters:requestParams success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        NSArray *body = responseObject[res_body];
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in body) {
            LWAsthmaModel *model = [[LWAsthmaModel alloc] initWithDictionary:dic];
            [array addObject:model];
        }
        if (success){ success(array);}
    } failure:^(NSURLSessionDataTask * _Nullable task, NSString * _Nullable errorMessage) {
        failure?failure(errorMessage):nil;
    } isCache:YES];
    
}

#pragma mark 获取医生服务时间
+ (void)httploadDoctorServerTimeSuccess:(void (^)(NSMutableArray *models))success
                                failure:(void (^)(NSString * errorMes))failure
{
    
    NSMutableDictionary *requestParams = [LWHttpRequestManager dic];
    [LWHttpRequestManager addPublicHeaderPost:requestParams];
    
    [KSNetRequest requestTargetPOST:[LWHttpRequestManager urlWith:HTTP_POST_LOADDOCTORSERVERTIM] parameters:requestParams success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        NSLog(@"%@",[responseObject JSONString]);
        NSArray *body = [responseObject objectForKey:res_body];
        NSMutableArray *array = [NSMutableArray array];
        
        for (NSDictionary *dic in body)
        {
            LWDoctorTimerModel *model = [[LWDoctorTimerModel alloc] initWithDictionary:dic];
            [array addObject:model];
        }
        
        success?success(array):nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSString * _Nullable errorMessage) {
        failure?failure(errorMessage):nil;
    } isCache:NO];
    
}

#pragma mark 提交医生服务时间
+ (void)httpsubmitDoctorServerTimeWithJsonString:(NSString *)array
                                         Success:(void (^)())success
                                         failure:(void (^)(NSString * errorMes))failure
{
    
    NSMutableDictionary *requestParams = [LWHttpRequestManager dic];
    [LWHttpRequestManager addPublicHeaderPost:requestParams];
    [requestParams setObject:array forKey:@"jsonData"];
    
    NSLog(@"%@",requestParams.JSONString);
    [KSNetRequest requestTargetPOST:[LWHttpRequestManager urlWith:HTTP_POST_SUBMITDOCTORSERVERTIME] parameters:requestParams success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        NSLog(@"%@",[responseObject JSONString]);
        success?success():nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSString * _Nullable errorMessage) {
        failure?failure(errorMessage):nil;
    } isCache:NO];
    
}

#pragma mark 加载首次诊断表单信息
+ (void)httploadFirstDiagnosticInfowithdiagnosticId:(NSString *)diagnosticId
                                            Success:(void (^)(LWPatientBiaoDanBody *model))success
                                            failure:(void (^)(NSString * errorMes))failure
{
    NSMutableDictionary *requestParams = [LWHttpRequestManager dic];
    [LWHttpRequestManager addPublicHeaderPost:requestParams];
    [requestParams setObject:stringJudgeNull(diagnosticId) forKey:@"diagnosticId"];
    
    [KSNetRequest requestTargetPOST:[LWHttpRequestManager urlWith:HTTP_POST_LOADFIRSTDIAGNOSTICINFO] parameters:requestParams success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        NSDictionary *body = [responseObject objectForKey:res_body];
        LWPatientBiaoDanBody *model = [[LWPatientBiaoDanBody alloc] initWithDictionary:body];
        NSLog(@"%@",[responseObject JSONString]);
        success?success(model):nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSString * _Nullable errorMessage) {
        failure?failure(errorMessage):nil;
    } isCache:YES];
}
#pragma mark 加载表单日志信息
+ (void)httploadPatientFirstDiagnosticList:(NSString *)patientId
                                   Success:(void (^)(NSMutableArray *models))success
                                   failure:(void (^)(NSString * errorMes))failure{
    
    
    NSMutableDictionary *requestParams = [LWHttpRequestManager dic];
    [LWHttpRequestManager addPublicHeaderPost:requestParams];
    
    [requestParams setObject:stringJudgeNull(patientId) forKey:@"patientId"];
    
    [KSNetRequest requestTargetPOST:[LWHttpRequestManager urlWith:HTTP_POST_LOADPATIENTFIRSTDIAGNOSTICLIST] parameters:requestParams success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        
        NSLog(@"%@",[responseObject JSONString]);
        
        NSArray *body = [responseObject objectForKey:res_body];
        NSMutableArray *array = [NSMutableArray array];
        
        for (NSDictionary *dic in body)
        {
            LWPatientBiaoDanBody *model = [[LWPatientBiaoDanBody alloc] initWithDictionary:dic];
            [array addObject:model];
        }
        
        success?success(array):nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSString * _Nullable errorMessage) {
        failure?failure(errorMessage):nil;
    } isCache:YES];
}

#pragma mark 提交患者病情相关
+ (void)httpsubmitDiseaseRelateWithPatientId:(NSString *)patientId
                             treatmentResult:(NSString *)treatmentResult
                              basicCondition:(NSString *)basicCondition
                                      images:(NSString *)images
                                     Success:(void (^)(NSMutableArray *models))success
                                     failure:(void (^)(NSString * errorMes))failure
{
    
    NSMutableDictionary *requestParams = [LWHttpRequestManager dic];
    [LWHttpRequestManager addPublicHeaderPost:requestParams];
    
    [requestParams setObject:stringJudgeNull(patientId) forKey:@"patientId"];
    [requestParams setObject:stringJudgeNull(treatmentResult) forKey:@"treatmentResult"];
    [requestParams setObject:stringJudgeNull(basicCondition) forKey:@"basicCondition"];
    [requestParams setObject:stringJudgeNull(images) forKey:@"images"];
    
    [KSNetRequest requestTargetPOST:[LWHttpRequestManager urlWith:HTTP_POST_SUBMITDISEASERELATE] parameters:requestParams success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        
        NSLog(@"%@",[responseObject JSONString]);
        
        success?success(nil):nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSString * _Nullable errorMessage) {
        failure?failure(errorMessage):nil;
    } isCache:NO];
    
    
}

#pragma mark  加载患者病情相关
+ (void)httploadDiseaseRelate:(NSString *)patientId
                      Success:(void (^)(LWPatientRelatedModel *model))success
                      failure:(void (^)(NSString * errorMes))failure
{
    
    NSMutableDictionary *requestParams = [LWHttpRequestManager dic];
    [LWHttpRequestManager addPublicHeaderPost:requestParams];
    
    [requestParams setObject:stringJudgeNull(patientId) forKey:@"patientId"];
    
    [KSNetRequest requestTargetPOST:[LWHttpRequestManager urlWith:HTTP_POST_LOADDISEASERELATE] parameters:requestParams success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        NSLog(@"%@",[responseObject JSONString]);
        NSDictionary *body = [responseObject objectForKey:res_body];
        LWPatientRelatedModel *model = [[LWPatientRelatedModel alloc] initWithDictionary:body];
        success?success(model):nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSString * _Nullable errorMessage) {
        failure?failure(errorMessage):nil;
    } isCache:NO];
}

#pragma mark  修改患者病情相关
+ (void)httpupdateDiseaseRelateWithSid:(NSString *)sid
                       treatmentResult:(NSString *)treatmentResult
                        basicCondition:(NSString *)basicCondition
                                images:(NSString *)images
                               Success:(void (^)(NSMutableArray *models))success
                               failure:(void (^)(NSString * errorMes))failure
{
    NSMutableDictionary *requestParams = [LWHttpRequestManager dic];
    [LWHttpRequestManager addPublicHeaderPost:requestParams];
    
    [requestParams setObject:stringJudgeNull(sid) forKey:@"sid"];
    [requestParams setObject:stringJudgeNull(treatmentResult) forKey:@"treatmentResult"];
    [requestParams setObject:stringJudgeNull(basicCondition) forKey:@"basicCondition"];
    [requestParams setObject:stringJudgeNull(images) forKey:@"images"];
    
    [KSNetRequest requestTargetPOST:[LWHttpRequestManager urlWith:HTTP_POST_UPDATEDISEASERELATE] parameters:requestParams success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        NSLog(@"%@",[responseObject JSONString]);
        
        success?success(nil):nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSString * _Nullable errorMessage) {
        failure?failure(errorMessage):nil;
    } isCache:NO];
}

#pragma mark  拒绝患者添加
+ (void)httprefuseAttentionWithSid:(NSString *)sid
                         patientID:(NSString *)pid
                           Success:(void (^)())success
                           failure:(void (^)(NSString * errorMes))failure
{
    
    NSMutableDictionary *requestParams = [LWHttpRequestManager dic];
    [LWHttpRequestManager addPublicHeaderPost:requestParams];
    
    [requestParams setObject:stringJudgeNull(sid) forKey:@"sid"];
    [requestParams setObject:stringJudgeNull(pid) forKey:@"patientId"];
    
    [KSNetRequest requestTargetPOST:[LWHttpRequestManager urlWith:HTTP_POST_REFUSEATTENTION] parameters:requestParams success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        NSLog(@"%@",[responseObject JSONString]);
        
        success?success():nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSString * _Nullable errorMessage) {
        failure?failure(errorMessage):nil;
    } isCache:NO];
    
}

#pragma mark  加载订单记录首页
+ (void)httpLoadDoctorRelateOrderIndexWithDate:(NSString *)date
                                       Success:(void (^)(NSMutableArray *models))success
                                       failure:(void (^)(NSString * errorMes))failure
{
    
    
    NSMutableDictionary *requestParams = [LWHttpRequestManager dic];
    [LWHttpRequestManager addPublicHeaderPost:requestParams];
    
    [requestParams setObject:stringJudgeNull(date) forKey:@"date"];
    
    [KSNetRequest requestTargetPOST:[LWHttpRequestManager urlWith:HTTP_POST_LOADDOCTORRELATEORDERINDEX] parameters:requestParams success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        NSLog(@"%@",[responseObject JSONString]);
        
        NSMutableArray *array = [NSMutableArray array];
            
        for (NSDictionary *dic in (NSArray *)responseObject[res_body])
        {
            LWOrderListModel *model = [[LWOrderListModel alloc] initWithOrderLisetModelDic:dic];
            NSDate *orderDate = [NSDate dateWithString:dic[@"date"] format:[NSDate ymdHmsFormat]];
            model.year = [orderDate year];
            model.month = [orderDate month];
            model.orderDate = [NSString stringWithFormat:@"%ld月/%ld年",model.month,model.year];
            [array addObject:model];
        }
        success?success(array):nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSString * _Nullable errorMessage) {
        failure?failure(errorMessage):nil;
    } isCache:NO];
    
    
}

#pragma mark  加载购买记录(根据订单类型)
+ (void)httpLoadOrderListWithDate:(NSString *)date
                   andProductType:(NSString *)productType
                          andPage:(NSInteger)page
                          Success:(void (^)(NSMutableArray *models))success
                          failure:(void (^)(NSString * errorMes))failure
{
    
    NSMutableDictionary *requestParams = [LWHttpRequestManager dic];
    [LWHttpRequestManager addPublicHeaderPost:requestParams];
    
    [requestParams setObject:stringJudgeNull(date) forKey:@"date"];
    [requestParams setObject:stringJudgeNull(productType) forKey:@"productType"];
    [requestParams setObject:stringJudgeNull(kNSString(kNSNumInteger(page))) forKey:@"page"];
    
    [KSNetRequest requestTargetPOST:[LWHttpRequestManager urlWith:HTTP_POST_LOADORDERLIST] parameters:requestParams success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        NSLog(@"%@",[responseObject JSONString]);
        
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in (NSArray *)[responseObject objectForKey:res_body])
        {
            LWDetailedOrderListModel *model = [[LWDetailedOrderListModel alloc] initWithDetailedOrderlistModelDic:dic];
            [array addObject:model];
        }
        success?success(array):nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSString * _Nullable errorMessage) {
        failure?failure(errorMessage):nil;
    } isCache:NO];
    
}
#pragma mark  加载预约详情
+ (void)httpLoadOrderAppointmentInfoWithOrdAppid:(NSString *)ordAppid
                                         Success:(void (^)(LWReservationDetailedModel *model))success
                                         failure:(void (^)(NSString * errorMes))failure
{
    
    NSMutableDictionary *requestParams = [LWHttpRequestManager dic];
    [LWHttpRequestManager addPublicHeaderPost:requestParams];
    [requestParams setObject:stringJudgeNull(ordAppid) forKey:@"ordAppId"];
    
    [KSNetRequest requestTargetPOST:[LWHttpRequestManager urlWith:HTTP_POST_LOADORDERAPPOINTMENTINFO] parameters:requestParams success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        NSLog(@"%@",[responseObject JSONString]);
        
        success?success([[LWReservationDetailedModel alloc] initWithDictionary:responseObject[res_body]]):nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSString * _Nullable errorMessage) {
        failure?failure(errorMessage):nil;
    } isCache:NO];
    
    
}

#pragma mark  加载患者历史记录
+ (void)httpLoadPatientRecordHistoryWithPatientId:(NSString *)pid
                                       recentDays:(NSInteger)day
                                          Success:(void (^)(KLPatientLogBodyModel *model))success
                                          failure:(void (^)(NSString * errorMes))failure
{
    NSMutableDictionary *requestParams = [LWHttpRequestManager dic];
    [LWHttpRequestManager addPublicHeaderPost:requestParams];
    [requestParams setObject:stringJudgeNull(pid) forKey:@"patientId"];
    [requestParams setObject:stringJudgeNull(kNSString(kNSNumInteger(day))) forKey:@"recentDays"];
    
    [KSNetRequest requestTargetPOST:[LWHttpRequestManager urlWith:HTTP_POST_LOADPATIENTRECORDHISTORY] parameters:requestParams success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        NSLog(@"%@",[responseObject JSONString]);
        
        KLPatientLogBodyModel *model = [[KLPatientLogBodyModel alloc] initWithDictionary:responseObject[res_body]];
        
        success?success(model):nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSString * _Nullable errorMessage) {
        failure?failure(errorMessage):nil;
    } isCache:YES];
}

@end
