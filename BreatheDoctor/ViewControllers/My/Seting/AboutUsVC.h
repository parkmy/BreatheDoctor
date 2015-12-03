//
//  AboutUsVC.h
//  ComveeDoctor
//
//  Created by SX on 14-11-3.
//  Copyright (c) 2014年 zhengjw. All rights reserved.
//

#import "BaseViewController.h"

@interface AboutUsVC : BaseViewController
{
    UIView *m_view;
    
    NSString *content;
    NSString *version;
    NSArray *titleAry;
    NSArray *btnAry;
    
    UIButton *btn1;
    UIButton *btn2;
    UIButton *btn3;
    UIButton *btn4;
}
@end
