//
//  KLHomeMoreConsultingCollectionReusableView.m
//  COButton
//
//  Created by liaowh on 16/6/2.
//  Copyright © 2016年 comv. All rights reserved.
//

#import "KLHomeMoreConsultingCollectionReusableView.h"

@interface KLHomeMoreConsultingCollectionReusableView ()
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *rightLabel;
@end

@implementation KLHomeMoreConsultingCollectionReusableView

- (void)setup{
    
    [super setup];
    
    self.backgroundColor = [UIColor whiteColor];
    
    _leftLabel = [UILabel new];
    _leftLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    _leftLabel.font = kNSPXFONT(30);
    
    _rightLabel = [UILabel new];
    _rightLabel.textAlignment = NSTextAlignmentRight;
    _rightLabel.textColor = [UIColor colorWithHexString:@"#aaaaaa"];
    _rightLabel.font = kNSPXFONT(28);
    
    UIImageView *moreIcon = [UIImageView new];
    moreIcon.image = [UIImage imageNamed:@"doctor_qunfa_jiantouRight.png"];
    moreIcon.alpha = .5;
    
    [self sd_addSubviews:@[_leftLabel,_rightLabel,moreIcon]];
    
    
    _leftLabel.sd_layout
    .leftSpaceToView(self,15)
    .topSpaceToView(self,0)
    .bottomSpaceToView(self,0)
    .widthIs(120);
    
    moreIcon.sd_layout
    .rightSpaceToView(self,15)
    .centerYEqualToView(self)
    .heightIs(moreIcon.image.size.height)
    .widthIs(moreIcon.image.size.width);
    
    _rightLabel.sd_layout
    .leftSpaceToView(_leftLabel,15)
    .topSpaceToView(self,0)
    .bottomSpaceToView(self,0)
    .rightSpaceToView(moreIcon,5);
    
    
    _leftLabel.text = @"最新资讯";
    _rightLabel.text = @"更多";
    
}

@end
