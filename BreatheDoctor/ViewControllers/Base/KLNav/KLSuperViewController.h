//
//  KLSuperViewController.h
//  COButton
//
//  Created by comv on 16/5/16.
//  Copyright © 2016年 comv. All rights reserved.
//  控制器父类

#import <UIKit/UIKit.h>
#define BARHIGHT 64

@interface KLSuperViewController : UIViewController
/**
 *  左边
 */
@property (nonatomic, copy, readwrite) NSString *navLeftContent;
/**
 *  右边
 */
@property (nonatomic, copy, readwrite) NSString *navRightContent;
/**
 *  中心
 */
@property (nonatomic, copy, readwrite) NSString *navCenterTitle;
/**
 *  导航背景色
 */
@property (nonatomic, strong, readwrite) UIColor *navBarBackColor;
/**
 *  导航背景色透明度
 */
@property (nonatomic, assign, readwrite) CGFloat navBarAlpha;
/**
 *  自定义中心试图
 */
@property (nonatomic, strong) UIView *customCenterView;

- (void)navLeftButtonAction;
- (void)navRightButtonAction;

@end
