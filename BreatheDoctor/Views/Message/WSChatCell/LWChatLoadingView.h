//
//  LWChatLoadingView.h
//  BreatheDoctor
//
//  Created by comv on 15/12/21.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , showLoadingType) {

    showLoadingTypeLoading = 0,
    showLoadingTypeError = 1,
};

@interface LWChatLoadingView : UIView
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, strong) UIImageView *errorImageView;

@property (nonatomic, assign) showLoadingType showType;
@end
