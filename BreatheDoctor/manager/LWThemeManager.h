//
//  LWThemeManager.h
//  BreatheDoctor
//
//  Created by comv on 15/12/30.
//  Copyright © 2015年 lwh. All rights reserved.
//  主题管理者

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger , themeType) {
    themeTypeDefault = 0,
};

@interface LWThemeManager : NSObject

+ (LWThemeManager *)shareInstance;

//主题类型
@property (nonatomic, assign) themeType  themeType;

///导航背景色
@property (nonatomic, strong) UIColor *navBackgroundColor;

///视图背景色
@property (nonatomic, strong) UIColor *vcBackgroundColor;


@end
