//
//  LWOrderCollectionViewCell.m
//  BreatheDoctor
//
//  Created by comv on 16/2/22.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWOrderCollectionViewCell.h"

@implementation LWOrderCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        
        _orderCell = [[LWOrderViewCell alloc] initWithFrame:self.bounds];
        [self addSubview:_orderCell];
        _orderCell.delegate = self;
        //        __weak typeof(self)weakSelf = self;
        //        [_orderCell setDidSelectRowBlock:^(NSIndexPath *indexPath) {
        //            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(didSelectRowIndexPath:)]) {
        //                [weakSelf.delegate didSelectRowIndexPath:indexPath];
        //            }
        //        }];
        
    }
    return self;
}
- (void)didSelectRowIndex:(NSIndexPath *)index andOrderModel:(LWOrderListModel *)model
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectRowIndexPath:andOrderModel:)]) {
        [self.delegate didSelectRowIndexPath:index andOrderModel:model];
    }
}


@end
