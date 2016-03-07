//
//  LWChatMessageMoreCollectionCell.m
//  BreatheDoctor
//
//  Created by comv on 15/11/14.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWChatMessageMoreCollectionCell.h"
#import "PureLayout.h"

@interface LWChatMessageMoreCollectionCell ()
{
    UIImageView *mImageView;
    
    UILabel     *mTitle;
}
@end

@implementation LWChatMessageMoreCollectionCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        
        mImageView = [[UIImageView alloc]initForAutoLayout];
        mImageView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:mImageView];
        
        [mImageView autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [mImageView autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.contentView withOffset:-8];
        [mImageView autoSetDimensionsToSize:CGSizeMake(50, 50)];
        
        mTitle = [[UILabel alloc]initForAutoLayout];
        mTitle.textColor = [UIColor grayColor];
        mTitle.backgroundColor = [UIColor clearColor];
        mTitle.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:mTitle];
        
        [mTitle autoAlignAxis:ALAxisVertical toSameAxisOfView:mImageView];
        [mTitle autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:mImageView withOffset:4];
        
    }
    return self;
}

-(void)setModel:(NSDictionary *)model
{
    _model = model;
    
    mTitle.text = model[@"title"];
    
    mImageView.image = [UIImage imageNamed:model[@"image"]];
    
}

@end
