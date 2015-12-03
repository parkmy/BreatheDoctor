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
    CtrlTag_Login,                          ///登录页面
    CtrlTag_PatientCenter,                  ///患者中心
    CtrlTag_PatientRecords,                 ///患者资料
    CtrlTag_PatientRemarks,                 ///患者备注
    CtrlTag_PatientGroups,                  ///患者分组
    CtrlTag_PersonalSeting,                 ///更多设置
    CtrlTag_PersonalCenter,                 ///医生资料
    CtrlTag_AddPatient,                     ///添加患者
    CtrlTag_PatientDialogue,                ///患者对话
    CtrlTag_PassModify,                     ///密码修改
    CtrlTag_AboutUser,                      ///关于我们
    CtrlTag_FastReply,                      ///快捷回复
    CtrlTag_PatientTaskDescribe,            ///添加修改快捷
    CtrlTag_PatientLog,                     ///患者日志
    CtrlTag_AsthmaAssessment,               ///哮喘评估
    CtrlTag_ACTAssessment,                  ///ACT评估
    CtrlTag_LineACTAssessment,              ///曲线ACT评估

}CtrlTag;


@interface UIViewController (Factory)

+(UIViewController*)CreateControllerWithTag:(CtrlTag)tag;

@end
