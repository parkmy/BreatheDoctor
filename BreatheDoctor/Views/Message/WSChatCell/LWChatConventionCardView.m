
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
#import "NSDate+Extension.h"
#import "YRJSONAdapter.h"

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
        titleLabel.font = [UIFont systemFontOfSize:15];
        titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        [_mBubbleView addSubview:titleLabel];
        
        contentView = [UITextView new];
        contentView.textAlignment = NSTextAlignmentLeft;
        contentView.textColor = [UIColor colorWithHexString:@"#666666"];
        contentView.editable = NO;
        contentView.userInteractionEnabled = NO;
        [_mBubbleView addSubview:contentView];
        
        starImageView = [UIImageView new];
        [_mBubbleView addSubview:starImageView];
        
        UIView *line = [UIView new];
        line.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
        [_mBubbleView addSubview:line];
        
        UILabel *xiangq = [[UILabel alloc] initWithFrame:CGRectZero];
        xiangq.textColor = [UIColor colorWithHexString:@"#cccccc"];
        xiangq.font = [UIFont systemFontOfSize:kNSPXFONTFLOAT(30)];
        xiangq.textAlignment = NSTextAlignmentRight;
        xiangq.text = @"详情";
        [_mBubbleView addSubview:xiangq];
        
        UIImageView *jiantou = [[UIImageView alloc] initWithFrame:CGRectZero];
        jiantou.image =  [UIImage imageNamed:@"yishengzhushou_14"];
        [_mBubbleView addSubview:jiantou];
        
        _mBubbleView.sd_layout.leftSpaceToView(self,10).rightSpaceToView(self,10).topSpaceToView(self,50).bottomSpaceToView(self,0);

        jiantou.sd_layout.rightSpaceToView(_mBubbleView,10).bottomSpaceToView(_mBubbleView,10).widthIs(15).heightIs(18);
        xiangq.sd_layout.rightSpaceToView(jiantou,10).bottomSpaceToView(_mBubbleView,10).heightIs(18).widthIs(60);
        line.sd_layout.bottomSpaceToView(jiantou,10).leftSpaceToView(_mBubbleView,10).rightSpaceToView(_mBubbleView,5).heightIs(1);
        iconImageView.sd_layout.leftSpaceToView(_mBubbleView,15).topSpaceToView(_mBubbleView,15).widthIs(50).heightIs(50);
        titleLabel.sd_layout.leftSpaceToView(iconImageView,15).topEqualToView(iconImageView).rightSpaceToView(_mBubbleView,0).heightIs(20);
        contentView.sd_layout.leftSpaceToView(iconImageView,10).topSpaceToView(titleLabel,0).rightSpaceToView(_mBubbleView,0).bottomSpaceToView(line,5);
        starImageView.sd_layout.topSpaceToView(_mBubbleView,0).rightSpaceToView(_mBubbleView,0).widthIs(40).heightIs(40);


    }
    return self;
}

- (void)setModel:(LWChatModel *)model
{
    _model = model;
    
    NSDictionary *content = [stringJudgeNull(model.content) objectFromJSONString];
    
    titleLabel.text = @"预约成功";
    iconImageView.image = [UIImage imageNamed:@"dianhuazixun"];
    
    NSDate *starDate = [NSDate dateWithString:stringJudgeNull(content[@"startTime"]) format:[NSDate hmFormat]];
    NSDate *endDate = [NSDate dateWithString:stringJudgeNull(content[@"endTime"]) format:[NSDate hmFormat]];
    NSDate *date = [NSDate dateWithString:stringJudgeNull(content[@"date"]) format:[NSDate ymdFormat]];
    NSString *endDateString = [NSDate stringWithDate:endDate format:[NSDate hmFormat]];
    NSString *starDateString = [NSDate stringWithDate:starDate format:[NSDate hmFormat]];
    NSString *dateString = [NSDate stringWithDate:date format:@"MM月-dd日"];
    contentView.text = [NSString stringWithFormat:@"预约医生：%@\n日        期：%@\n时        间：%@-%@",stringJudgeNull(content[@"doctorName"]),stringJudgeNull(dateString),stringJudgeNull(starDateString),stringJudgeNull(endDateString)];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 3;// 字体的行间距
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Light" size:14],
                                 NSParagraphStyleAttributeName:paragraphStyle,
                                 NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#666666"]
                                 };
    
    contentView.attributedText = [[NSAttributedString alloc] initWithString:contentView.text attributes:attributes];
    
    starImageView.image = model.isDispose == 3?kImage(@"quxiao_"):nil;
    iconImageView.image = model.isDispose == 3?kImage(@"quxiaodianhuazixun"):kImage(@"dianhuazixun");
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
