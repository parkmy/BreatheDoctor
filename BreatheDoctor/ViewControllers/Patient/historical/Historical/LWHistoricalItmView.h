//
//  LWHistoricalItmView.h
//  BreatheDoctor
//
//  Created by comv on 16/3/14.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWHistoricalItmView : UIView

@property (nonatomic, copy) void(^leftButtonBlock)();
@property (nonatomic, copy) void(^rightButtonBlock)();

- (id)initWithSize:(CGSize)size leftTitle:(NSString *)left rightTitle:(NSString *)right;
@end
