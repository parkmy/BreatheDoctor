//
//  KLTimerWeeksView.h
//  BreatheDoctor
//
//  Created by comv on 16/3/31.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KLTimerWeeksView : UIView
@property (nonatomic, strong) NSMutableArray *weeks;
@property (nonatomic, copy) void(^leftButtonClikBlock)();
@property (nonatomic, copy) void(^rightButtonClikBlock)(NSMutableArray *weeks);
@end
