//
//  KLIndicatorViewManager.h
//  COButton
//
//  Created by comv on 16/5/4.
//  Copyright © 2016年 comv. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^showErrorViewSuccessBlock)(void);

@interface KLIndicatorViewManager : NSObject

+ (KLIndicatorViewManager *)standardIndicatorViewManager;

- (void)hiddenIndicatorView;

- (void)showErrorWith:(NSString *)string
              theView:(UIView *)view
             theImage:(UIImage *)image
             showSucc:(showErrorViewSuccessBlock)showErrorViewSuccessBlock;

- (void)showErrorWith:(NSString *)string
              theView:(UIView *)view
             theImage:(UIImage *)image;

- (void)showLoadingWithContent:(NSString *)string
                       theView:(UIView *)view;

@end
