//
//  LWOrderViewCell.h
//  BreatheDoctor
//
//  Created by comv on 16/3/9.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LWOrderViewCellDelegate <NSObject>

@optional
- (void)didSelectRowIndex:(NSIndexPath *)index andOrderModel:(LWOrderListModel *)model;

@end

@interface LWOrderViewCell : UIView
@property (nonatomic, weak) id<LWOrderViewCellDelegate>delegate;

- (void)setOrderCellData:(LWOrderListModel *)model;

@end
