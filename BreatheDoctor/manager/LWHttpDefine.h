//
//  LWHttpDefine.h
//  BreatheDoctor
//
//  Created by comv on 15/11/11.
//  Copyright © 2015年 lwh. All rights reserved.
//

#ifndef LWHttpDefine_h
#define LWHttpDefine_h


#define res_msg     @"res_msg"
#define res_code    @"res_coder"
#define res_desc    @"res_desc"
#define res_body    @"body"
#pragma mark 通用 
// http://wechat.comvee.cn/comveebreath/
//"http://comvee.3322.org:8084/comveebreath/"

//正式 "https://breathintf.huxiweishi.cn
//#define Comvee_Url @"http://comvvpn.6655.la:8084/comveebreath/"
#define Comvee_Url @"http://wechat.comvee.cn/comveebreath/"

//#define Comvee_Url @"https://breathintf.huxiweishi.cn/"


#define comveeUpload_URL @"http://img.mamibon.com:8080/fileuploader/uploader.do"
//199 测试
//105 正式
#define platCode @"199"
//01 商店 03 企业 99 测试
#define LOADFROMKEY @"99"


#pragma mark 短接
/// *-- 登陆
static  NSString *HTTP_POST_LOGIN                   = @"mobile/user/login.do";

/// *-- 推送录入
static  NSString *HTTP_POST_SETPUSHKEY              = @"mobile/info/setPushKey.do";

/// *-- 首页消息
static  NSString *HTTP_POST_LOADHOMEPAGE            = @"mobile/dialogue/loadHomePage.do";

/// *-- 同意消息
static  NSString *HTTP_POST_AGREEATTENTION          = @"mobile/doctor/agreeAttention.do";

/// *-- 患者列表
static  NSString *HTTP_POST_LOADPATIENTLIST         = @"mobile/doctor/loadPatientList.do";

/// *-- 对话列表
static  NSString *HTTP_POST_LOADDIALOGUE            = @"mobile/dialogue/loadDialogue.do";

/// *-- 修改密码
static  NSString *HTTP_POST_CHANGETHEPASSWORD       = @"mobile/user/modifyPassWord.do";

/// *-- 患者档案
static  NSString *HTTP_POST_PANTIENTARCHIVES        = @"mobile/patient/loadPatientArchives.do";

/// *-- 患者备注
static  NSString *HTTP_POST_SETPATIENTREMARK        = @"mobile/doctor/setPatientRemark.do";

/// *-- 医生回复
static  NSString *HTTP_POST_DOCTORREPLY             = @"mobile/dialogue/doctorReply.do";

/// *-- 获取ACT评估
static  NSString *HTTP_POST_GETACTBYID              = @"mobile/assess/getACTById.do";

/// *-- 获取哮喘评估
static  NSString *HTTP_POST_GETASTHMABYID           = @"mobile/assess/getAsthmaById.do";

/// *-- 获取PEF记录
static  NSString *HTTP_POST_LOADPEFRECORD           = @"mobile/patient/loadPEFRecord.do";

/// *-- 获取lineACT日志
static  NSString *HTTP_POST_LOADACTASSESSLOG        = @"mobile/assess/loadACTAssessLog.do";

/// *-- 获取ACT哮喘日志
static  NSString *HTTP_POST_LOADASTHMAASSESSLOG     = @"mobile/assess/loadAsthmaAssessLog.do";

/// *-- 获取购买记录
static  NSString *HTTP_POST_LOADSHOPORDERLOG        = @"mobile/shop/loadShopOrderLog.do";

/// *-- 获取医生服务时间
static  NSString *HTTP_POST_LOADDOCTORSERVERTIM     = @"mobile/doctor/loadDoctorServerTime.do";

/// *-- 提交医生服务时间
static  NSString *HTTP_POST_SUBMITDOCTORSERVERTIME  = @"mobile/doctor/submitDoctorServerTime.do";

/// *-- 加载诊断表单详细信息
static  NSString *HTTP_POST_LOADFIRSTDIAGNOSTICINFO = @"mobile/patient/loadFirstDiagnosticInfo.do";

/// *-- 加载表单日至信息
static  NSString *HTTP_POST_LOADPATIENTFIRSTDIAGNOSTICLIST = @"mobile/patient/loadPatientFirstDiagnosticList.do";

/// *-- 提交患者病情相关
static  NSString *HTTP_POST_SUBMITDISEASERELATE     = @"mobile/doctor/submitDiseaseRelate.do";
/// *-- 加载患者病情相关
static  NSString *HTTP_POST_LOADDISEASERELATE       = @"mobile/doctor/loadDiseaseRelate.do";
/// *-- 修改患者病情相关
static  NSString *HTTP_POST_UPDATEDISEASERELATE     = @"mobile/doctor/updateDiseaseRelate.do";
/// *-- 拒绝患者
static  NSString *HTTP_POST_REFUSEATTENTION         = @"/mobile/doctor/refuseAttention.do";

/// *-- 加载订单记录首页
static  NSString *HTTP_POST_LOADDOCTORRELATEORDERINDEX     = @"/mobile/shop/loadDoctorRelateOrderIndex.do";
/// *-- 加载购买记录(根据订单类型)
static  NSString *HTTP_POST_LOADORDERLIST                  = @"/mobile/shop/loadOrderList.do";

/// *-- 加载预约详情
static  NSString *HTTP_POST_LOADORDERAPPOINTMENTINFO       = @"/mobile/shop/loadOrderAppointmentInfo.do";


#endif /* LWHttpDefine_h */
