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
#import "LWWEBViewController.h"
#import "LWTimerRemindViewController.h"
#import "LWTheFormTypeViewController.h"
#import "LWTheFormViewController.h"
#import "LWPatientRelatedViewController.h"
#import "LWReservationDetailedViewController.h"
#import "LWOrderDetailedListViewController.h"

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
            resCtrl = (UIViewController *)StoryboardCtr(@"LWACTAssessmentViewController");
            break;
        }
        case CtrlTag_AsthmaAssessment:
        {
            resCtrl = (UIViewController *)StoryboardCtr(@"LWAsthmaAssessmentViewController");
            break;
        }
        case CtrlTag_LineACTAssessment:
        {
            resCtrl = (UIViewController *)StoryboardCtr(@"LWLineACTAssessmentVC");
            break;
        }
        case CtrlTag_WEB:
        {
            resCtrl = [[LWWEBViewController alloc] init];
            break;
        }
        case CtrlTag_TimerRemind:
        {
            resCtrl = (UIViewController *)StoryboardCtr(@"LWTimerRemindViewController");
            break;
        }
        case CtrlTag_OrderRecord:
        {
            resCtrl = (UIViewController *)StoryboardCtr(@"LWOrderRecordViewController");
            break;
        }
        case CtrlTag_PatientAgreed:
        {
            resCtrl = (UIViewController *)StoryboardCtr(@"LWMessageAgreedViewController");
            break;
        }
        case CtrlTag_newFriends:
        {
            resCtrl = (UIViewController *)StoryboardCtr(@"LWNewFriendsViewController");
            break;
        }
        case CtrlTag_TheForm:
        {
            resCtrl = [[LWTheFormViewController alloc] init];
            break;
        }
        case CtrlTag_PatientRelated:
        {
            resCtrl = [[LWPatientRelatedViewController alloc] init];
            break;
        }
        case CtrlTag_TheFormType:
        {
            resCtrl = [[LWTheFormTypeViewController alloc] init];
            break;
        }
        case CtrlTag_ReservationDetailed:
        {
            resCtrl = [[LWReservationDetailedViewController alloc] init];
            break;
        }
        case CtrlTag_orderListDetailed:
        {
            resCtrl = [[LWOrderDetailedListViewController alloc] init];
            break;
        }
            
            
        default:
            break;
    }
    resCtrl.hidesBottomBarWhenPushed = YES;
    
    return resCtrl;
}


@end
