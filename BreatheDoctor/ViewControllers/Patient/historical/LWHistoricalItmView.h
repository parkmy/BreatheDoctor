//
//  LWHistoricalItmView.h
//  BreatheDoctor
//
//  Created by comv on 16/3/14.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWHistoricalItmView : UIView

@property (nonatomic, copy) void(^timeButtonBlock)();
@property (nonatomic, copy) void(^chartButtonBlock)();
@property (nonatomic, copy) void(^logButtonBlock)();

@end
