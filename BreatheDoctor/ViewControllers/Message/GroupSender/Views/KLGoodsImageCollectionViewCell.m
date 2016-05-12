//
//  KLGoodsImageCollectionViewCell.m
//  BreatheDoctor
//
//  Created by comv on 16/5/3.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLGoodsImageCollectionViewCell.h"

@implementation KLGoodsImageCollectionViewCell
- (id)initWithFrame:(CGRect)frame{
    
    if ([super initWithFrame:frame]) {
        
        _goodsImageView = [UIImageView new];
        [self.contentView addSubview:_goodsImageView];
        [_goodsImageView sizeToFit];
        
        _goodsImageView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
        
        
//        [self setupAutoWidthWithRightView:_goodsImageView rightMargin:0];
    }
    return self;
}
@end
