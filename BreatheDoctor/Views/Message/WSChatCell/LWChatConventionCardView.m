
//
//  LWChatConventionCardView.m
//  COButton
//
//  Created by comv on 16/2/26.
//  Copyright © 2016年 comv. All rights reserved.
//

#import "LWChatConventionCardView.h"
#import "UIView+SDAutoLayout.h"
#import "UIColor+HexString.h"

@interface LWChatConventionCardView ()
{
    UIView      *_mBubbleView;
    UIImageView *iconImageView;
    UILabel     *titleLabel;
    UITextView  *contentView;
    UIImageView *starImageView;
}
@end

@implementation LWChatConventionCardView


- (id)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame])
    {
        
        _mBubbleView = [[UIView alloc] initWithFrame:CGRectZero];
        _mBubbleView.backgroundColor = [UIColor whiteColor];
        _mBubbleView.layer.borderWidth = .3f;
        _mBubbleView.layer.borderColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.2].CGColor;
        _mBubbleView.layer.cornerRadius = 5.0f;
        _mBubbleView.layer.masksToBounds = YES;
        [self addSubview:_mBubbleView];
        
        iconImageView = [UIImageView new];
        [_mBubbleView addSubview:iconImageView];
        
        titleLabel = [UILabel new];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        [_mBubbleView addSubview:titleLabel];
        
        contentView = [UITextView new];
        contentView.textAlignment = NSTextAlignmentLeft;
        contentView.textColor = [UIColor colorWithHexString:@"#999999"];
        contentView.editable = NO;
        contentView.userInteractionEnabled = NO;
        [_mBubbleView addSubview:contentView];
        
        
  
        
        
        starImageView = [UIImageView new];
        [_mBubbleView addSubview:starImageView];
        
        UIView *line = [UIView new];
        line.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.3];
        [_mBubbleView addSubview:line];
        
        UILabel *xiangq = [[UILabel alloc] initWithFrame:CGRectZero];
        xiangq.font = [UIFont systemFontOfSize:15];
        xiangq.textAlignment = NSTextAlignmentRight;
        xiangq.text = @"详情";
        [_mBubbleView addSubview:xiangq];
        
        UIImageView *jiantou = [[UIImageView alloc] initWithFrame:CGRectZero];
        jiantou.image =  [UIImage imageNamed:@"yishengzhushou_14"];
        [_mBubbleView addSubview:jiantou];
        
        _mBubbleView.sd_layout.leftSpaceToView(self,20).rightSpaceToView(self,20).topSpaceToView(self,40).bottomSpaceToView(self,10);

        jiantou.sd_layout.rightSpaceToView(_mBubbleView,10).bottomSpaceToView(_mBubbleView,10).widthIs(10).heightIs(13);
        xiangq.sd_layout.rightSpaceToView(jiantou,10).bottomSpaceToView(_mBubbleView,10).heightIs(13).widthIs(60);
        line.sd_layout.bottomSpaceToView(jiantou,10).leftSpaceToView(_mBubbleView,5).rightSpaceToView(_mBubbleView,5).heightIs(.5);
        iconImageView.sd_layout.leftSpaceToView(_mBubbleView,10).topSpaceToView(_mBubbleView,10).widthIs(50).heightIs(50);
        titleLabel.sd_layout.leftSpaceToView(iconImageView,15).topEqualToView(iconImageView).rightSpaceToView(_mBubbleView,0).heightIs(20);
        contentView.sd_layout.leftSpaceToView(iconImageView,10).topSpaceToView(titleLabel,0).rightSpaceToView(_mBubbleView,0).bottomSpaceToView(line,5);
        

    }
    return self;
}

- (void)setModel:(id)model
{
    _model = model;
    
    titleLabel.text = @"预约成功";
    iconImageView.image = [UIImage imageNamed:@"dianhuazixun"];

    
    contentView.text = @"预约医生：周薇\n日        期：1033-23-13\n时        间：10：22-12：33";
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 3;// 字体的行间距
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Light" size:16],
                                 NSParagraphStyleAttributeName:paragraphStyle,
                                 NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#999999"]
                                 };
    
    contentView.attributedText = [[NSAttributedString alloc] initWithString:contentView.text attributes:attributes];
    

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
