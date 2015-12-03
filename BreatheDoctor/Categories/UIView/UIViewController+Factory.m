//
//  UIViewController+Factory.m
//  BaseMVVM
//
//  Created by suyushen on 15/8/14.
//  Copyright (c) 2015年 suyushen. All rights reserved.
//

#import "UIViewController+Factory.h"
#import "LWPatientRecordsCtr.h"
#import "LWChatViewController.h"
#import "PatientAddVC.h"
#import "AboutUsVC.h"
#import "PersonalPassModifyVC.h"
#import "PatientTaskDescribeVC.h"
#import "FastReplyVC.h"
#import "LWPatientLogViewController.h"

@implementation UIViewController (Factory)


+(UIViewController*)CreateControllerWithTag:(CtrlTag)tag
{
    UIViewController *resCtrl = nil;
    
    switch (tag) {
        case CtrlTag_Login:
        {
            resCtrl = (UIViewController *)StoryboardCtr(@"LWLoginViewController");
            break;
        }
        case CtrlTag_PatientCenter:
        {
            resCtrl = (UIViewController *)StoryboardCtr(@"LWPatientCententCtr");
            break;
        }
        case CtrlTag_PatientRecords:
        {
            resCtrl = (UIViewController *)StoryboardCtr(@"LWPatientRecordsCtr");
            break;
        }
        case CtrlTag_PatientRemarks:
        {
            resCtrl = (UIViewController *)StoryboardCtr(@"LWPatientRemarksCtr");
            break;
        }
        case CtrlTag_PatientGroups:
        {
            resCtrl = (UIViewController *)StoryboardCtr(@"LWPatientGroupsCtr");
            break;
        }
        case CtrlTag_PersonalSeting:
        {
            resCtrl = (UIViewController *)StoryboardCtr(@"LWPersonalSetingCtr");
            break;
        }
        case CtrlTag_PersonalCenter:
        {
            resCtrl = (UIViewController *)StoryboardCtr(@"LWPersonalCenterCtr");
            break;
        }
        case CtrlTag_AddPatient:
        {
            //            resCtrl = (UIViewController *)StoryboardCtr(@"LWAddPatientCtr");
            resCtrl = [[PatientAddVC alloc] init];
            break;
        }
        case CtrlTag_PatientDialogue:
        {
            //            resCtrl = (UIViewController *)StoryboardCtr(@"LWDialogueViewController");
            resCtrl = [[LWChatViewController alloc] init];
            break;
        }
        case CtrlTag_PassModify:
        {
            resCtrl = [[PersonalPassModifyVC alloc] init];
            break;
        }
        case CtrlTag_AboutUser:
        {
            resCtrl = [[AboutUsVC alloc] init];
            break;
        }
        case CtrlTag_FastReply:
        {
            resCtrl = [[FastReplyVC alloc] init];
            break;
        }
        case CtrlTag_PatientTaskDescribe:
        {
            resCtrl = [[PatientTaskDescribeVC alloc] init];
            break;
        }
        case CtrlTag_PatientLog:
        {
            resCtrl = [[LWPatientLogViewController alloc] init];
            break;
        }
        case CtrlTag_ACTAssessment:
        {
            resCtrl = (UIViewController *)StoryboardCtr(@"LWACTAssessmentViewController");;
            break;
        }
        case CtrlTag_AsthmaAssessment:
        {
            resCtrl = (UIViewController *)StoryboardCtr(@"LWAsthmaAssessmentViewController");;
            break;
        }
        case CtrlTag_LineACTAssessment:
        {
            resCtrl = (UIViewController *)StoryboardCtr(@"LWLineACTAssessmentVC");;
            break;
        }
        default:
            break;
    }
    
    return resCtrl;
}


@end
