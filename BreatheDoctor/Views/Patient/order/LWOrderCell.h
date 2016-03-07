//
//  LWOrderCell.h
//  BreatheDoctor
//
//  Created by comv on 16/2/22.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWOrderListModel.h"

@protocol LWOrderCellDelegate <NSObject>

@optional
- (void)didSelectRowIndex:(NSIndexPath *)index andOrderModel:(LWOrderListModel *)model;

@end

@interface LWOrderCell : UIView

@property (nonatomic, weak) id<LWOrderCellDelegate>delegate;

//@property (nonatomic, copy) void(^didSelectRowBlock)(NSIndexPath *indexPath);

@property (nonatomic, strong) LWOrderCell *orderView;

@property (nonatomic, strong) LWOrderListModel *model;

- (void)setOrderCellData:(LWOrderListModel *)model;

@end
