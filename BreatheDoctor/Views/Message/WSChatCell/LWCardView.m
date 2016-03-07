//
//  LWCardView.m
//  UUChatTableView
//
//  Created by comv on 15/12/2.
//  Copyright © 2015年 uyiuyao. All rights reserved.
//

#import "LWCardView.h"
#import "UUMessageFrame.h"
#import "LWChatModel.h"
#import "NSString+Size.h"
#import "LWTool.h"


@interface LWCardView ()

@end

@implementation LWCardView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        
        _mBubbleView = [[UIView alloc] initWithFrame:CGRectZero];
        _mBubbleView.backgroundColor = [UIColor whiteColor];
        [_mBubbleView setCornerRadius:3.0f];
        _mBubbleView.layer.borderWidth = .3f;
        _mBubbleView.layer.borderColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.2].CGColor;
        [self addSubview:_mBubbleView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_mBubbleView addSubview:_titleLabel];
        
        UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectZero];
        lineView1.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.2];
        [_mBubbleView addSubview:lineView1];
        
        
        _contentTexView = [[UITextView alloc] initWithFrame:CGRectZero];
        _contentTexView.scrollEnabled = NO;
        _contentTexView.font = [UIFont systemFontOfSize:14];
        _contentTexView.textColor = [UIColor colorWithHexString:@"#999999"];
        _contentTexView.editable = NO;
        _contentTexView.userInteractionEnabled = NO;
  
        [_mBubbleView addSubview:_contentTexView];
        
        
        UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectZero];
        lineView2.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.2];
        [_mBubbleView addSubview:lineView2];
        
        UILabel *xiangq = [[UILabel alloc] initWithFrame:CGRectZero];
        xiangq.textColor = [LWThemeManager shareInstance].navBackgroundColor;
        xiangq.textAlignment = NSTextAlignmentRight;
        xiangq.font = [UIFont systemFontOfSize:kNSPXFONTFLOAT(30)];
        xiangq.text = @"详情";
        [_mBubbleView addSubview:xiangq];
        
        
        UIImageView *jiantou = [[UIImageView alloc] initWithFrame:CGRectZero];
        jiantou.image =  [UIImage imageNamed:@"yishengzhushou_14"];
        [_mBubbleView addSubview:jiantou];
        
        
        _starImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _starImageView.image = [UIImage imageNamed:@"weitianxie_"];
        [_mBubbleView addSubview:_starImageView];
        
        
        _mBubbleView.sd_layout.leftSpaceToView(self,10).rightSpaceToView(self,10).topSpaceToView(self,50).bottomSpaceToView(self,10);
        
        _titleLabel.sd_layout.leftSpaceToView(_mBubbleView,0).rightSpaceToView(_mBubbleView,0).topSpaceToView(_mBubbleView,10).heightIs(20);
        
        lineView1.sd_layout.leftSpaceToView(_mBubbleView,5).rightSpaceToView(_mBubbleView,5).topSpaceToView(_titleLabel,10).heightIs(.5);
        
        _contentTexView.sd_layout.leftSpaceToView(_mBubbleView,5).rightSpaceToView(_mBubbleView,5).topSpaceToView(lineView1,5).heightIs(100);
        
        lineView2.sd_layout.leftSpaceToView(_mBubbleView,5).rightSpaceToView(_mBubbleView,5).topSpaceToView(_contentTexView,10).heightIs(.5);
        
        jiantou.sd_layout.rightSpaceToView(_mBubbleView,10).bottomSpaceToView(_mBubbleView,10).widthIs(15).heightIs(18);
        xiangq.sd_layout.rightSpaceToView(jiantou,10).bottomSpaceToView(_mBubbleView,10).heightIs(18).widthIs(60);
        
        _starImageView.sd_layout.topSpaceToView(_mBubbleView,0).rightSpaceToView(_mBubbleView,0).widthIs(40).heightIs(40);
        
    }
    
    return self;
}


- (void)setModelFram:(UUMessageFrame *)modelFram
{
    _modelFram = modelFram;
    
    LWChatModel *model  = _modelFram.model;
    
    
    if (model.chatMessageType == 21) {
        self.starImageView.image = model.isDispose == 1?kImage(@"yitianxie_"):kImage(@"weitianxie_");
    }else
    {
        self.starImageView.image = model.isDispose == 0?kImage(@""):kImage(@"");
    }
    
    NSDictionary *dic = [LWTool chatMessageCardModel:model];
    
    _titleLabel.text = dic[@"title"];
    _contentTexView.text = dic[@"content"];
    

    _contentTexView.sd_layout.heightIs(modelFram.cardContentHigh);
    
    _mBubbleView.sd_layout.topSpaceToView(self,40);

    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;// 字体的行间距
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:15],
                                 NSParagraphStyleAttributeName:paragraphStyle,
                                 NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#999999"]
                                 };
        
    _contentTexView.attributedText = [[NSAttributedString alloc] initWithString:_contentTexView.text attributes:attributes];
}


@end
