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
/**
 *  左右切换按钮
 *
 *  @param size  大小
 *  @param left  左边标题
 *  @param right 右边标题
 *
 *  @return 按钮
 */
- (id)initWithSize:(CGSize)size
         leftTitle:(NSString *)left
        rightTitle:(NSString *)right;
@end
