//
//  KLStateView.h
//  BreatheDoctor
//
//  Created by comv on 16/3/27.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KLStateView : UIView
- (void)stateLabelText:(NSString *)string;
@property (nonatomic, strong) UIColor *stateColor;
@end
