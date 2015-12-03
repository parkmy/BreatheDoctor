//
//  NavManager.h
//  NavManager
//
//  Created by suyushen on 14-10-14.
//  Copyright (c) 2014年 suyushen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIViewController+Factory.h"


typedef void (^completionBlock)(UIViewController *curController);

typedef enum {
    ControllerShowModeRoot = 0,                 //root
    ControllerShowModePush,                     //nav push
    ControllerShowModeModel,                    //model
}ControllerShowMode;

typedef enum {
    ControllerTypeModeMessage = 0,                 //消息
    ControllerTypeModePatient,                     //患者
    ControllerTypeModeMy,                           //我
}ControllerTypeMode;

@interface NavManager : NSObject{
    
}

//share Instance of NavManager
+ (NavManager *)shareInstance;

- (void)setRootController:(UIViewController*)controller;

- (void)showViewController:(UIViewController*)controller isAnimated:(BOOL)isAnimated;     //默认使用ControllerShowModePush
- (void)showViewController:(UIViewController*)controller isAnimated:(BOOL)isAnimated showType:(ControllerShowMode)showMode;

- (void)returnToFrontView:(BOOL)isAnimated;

- (void)returnToFrontView:(BOOL)isAnimated completion:(completionBlock)completionBlock;

- (void)returnToLoginView:(BOOL)isAnimated;

- (void)returnToMainView:(BOOL)isAnimated;

- (UINavigationController*)rootNavigationController;

#pragma mark 返回当前显示controller
- (UIViewController*)curViewController;

@end
