//
//  PatientAddViewController.h
//  ComveeDoctor
//
//  Created by JYL on 14-8-1.
//  Copyright (c) 2014年 zhengjw. All rights reserved.
//  添加患者

#import "BaseViewController.h"


@interface PatientAddVC : BaseViewController
{
    UIView *m_view;
    UIImageView * scanView;
    UIImageView * codeImg;
    UIView * footView;
    NSString * memberId;
    UIButton * addBtn;
    
}

@property (nonatomic, strong) UIViewController * fatherControl;
@property (nonatomic, strong) UIImage * imgName;
@end
