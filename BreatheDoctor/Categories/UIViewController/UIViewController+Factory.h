//
//  UIViewController+Factory.h
//  BaseMVVM
//
//  Created by suyushen on 15/8/14.
//  Copyright (c) 2015年 suyushen. All rights reserved.
//  UIViewController 工厂类

#import <UIKit/UIKit.h>


#pragma mark - 视图控制器的类别
typedef enum {
    ///登录页面
    CtrlTag_Login,
    ///患者中心
    CtrlTag_PatientCenter,
    ///患者资料
    CtrlTag_PatientRecords,
    ///患者备注
    CtrlTag_PatientRemarks,
    ///患者分组
    CtrlTag_PatientGroups,
    ///更多设置
    CtrlTag_PersonalSeting,
     ///医生资料
    CtrlTag_PersonalCenter,
    ///添加患者
    CtrlTag_AddPatient,
    ///患者对话
    CtrlTag_PatientDialogue,
    ///密码修改
    CtrlTag_PassModify,
    ///关于我们
    CtrlTag_AboutUser,
    ///快捷回复
    CtrlTag_FastReply,
    ///添加修改快捷
    CtrlTag_PatientTaskDescribe,
    ///患者日志
    CtrlTag_PatientLog,
     ///哮喘评估
    CtrlTag_AsthmaAssessment,
    ///ACT评估
    CtrlTag_ACTAssessment,
    ///曲线ACT评估
    CtrlTag_LineACTAssessment,
    ///WEB
    CtrlTag_WEB,
    ///回复时间
    CtrlTag_TimerRemind,
    ///购买记录
    CtrlTag_OrderRecord,
    ///患者请求详细
    CtrlTag_PatientAgreed,
    ///新朋友
    CtrlTag_newFriends,
    ///表单
    CtrlTag_TheForm,
    ///患者病情相关
    CtrlTag_PatientRelated,
    ///选择表
    CtrlTag_TheFormType,
}CtrlTag;


@interface UIViewController (Factory)

+(UIViewController*)CreateControllerWithTag:(CtrlTag)tag;

@end
