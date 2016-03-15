//
//  LWOrderCollectionViewCell.h
//  BreatheDoctor
//
//  Created by comv on 16/2/22.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "LWOrderCell.h"
#import "LWOrderViewCell.h"

@protocol LWOrderCollectionViewCellDelegate <NSObject>

@optional
- (void)didSelectRowIndexPath:(NSIndexPath *)indexPath andOrderModel:(LWOrderListModel *)model;

@end

@interface LWOrderCollectionViewCell : UICollectionViewCell<LWOrderViewCellDelegate>

@property (nonatomic, weak) id<LWOrderCollectionViewCellDelegate>delegate;
@property (nonatomic, strong) LWOrderViewCell *orderCell;

@end
