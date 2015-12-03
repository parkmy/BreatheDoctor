//
//  PatientTaskDescribeVC.h
//  ComveeDoctor
//
//  Created by Comvee on 14-9-11.
//  Copyright (c) 2014年 zhengjw. All rights reserved.
//

#import "BaseViewController.h"

@class PatientNewAddTaskVC;
@class FastReplyVC;

@interface PatientTaskDescribeVC : BaseViewController<UITextViewDelegate>
{
    UIView *m_view;
    UIView * backView;
    CGFloat previousTextViewContentHeight;

}

@property (nonatomic,strong) NSString *NavTitle;
@property (nonatomic,strong) UITextField *textFiled;
@property (nonatomic,strong) NSString *TaskDescribe;
//@property (nonatomic,strong) PatientNewAddTaskVC *newAdd;
///快捷回复
@property (nonatomic,strong) FastReplyVC * fastVc;
@property (nonatomic,strong) UITextView *editView;
@property (nonatomic,strong) UILabel *placeLabel;
@property (nonatomic,strong) UILabel *numberLabel;
@property (nonatomic,assign) int number;
@property (nonatomic,strong) NSIndexPath *currentPath;

@end
