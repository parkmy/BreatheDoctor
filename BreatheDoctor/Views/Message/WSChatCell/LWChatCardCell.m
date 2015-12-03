//
//  LWChatCardCell.m
//  BreatheDoctor
//
//  Created by comv on 15/11/16.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWChatCardCell.h"
#import "PureLayout.h"

@implementation LWChatCardCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = 0;
        
        _mBubbleView = [ALView newAutoLayoutView];
        _mBubbleView.backgroundColor = [UIColor whiteColor];
        [_mBubbleView setCornerRadius:3.0f];
        _mBubbleView.layer.borderWidth = .3f;
        _mBubbleView.layer.borderColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.2].CGColor;
        
        [self addSubview:_mBubbleView];
        
        _titleLabel = [UILabel newAutoLayoutView];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_mBubbleView addSubview:_titleLabel];
        
        UIView *lineView1 = [ALView newAutoLayoutView];
        lineView1.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.2];
        [_mBubbleView addSubview:lineView1];
        
        
        _contentTexView = [UITextView newAutoLayoutView];
        _contentTexView.scrollEnabled = NO;
        _contentTexView.font = [UIFont systemFontOfSize:14];
        _contentTexView.textColor = [UIColor colorWithHexString:@"#999999"];
        _contentTexView.editable = NO;
        _contentTexView.userInteractionEnabled = NO;
        [_mBubbleView addSubview:_contentTexView];
        
        
        UIView *lineView2 = [ALView newAutoLayoutView];
        lineView2.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.2];
        [_mBubbleView addSubview:lineView2];
        
        UILabel *xiangq = [UILabel newAutoLayoutView];
        xiangq.textColor = [UIColor colorWithHexString:@"#999999"];
        xiangq.font = [UIFont systemFontOfSize:15];
        xiangq.text = @"详情";
        [_mBubbleView addSubview:xiangq];
        
        
        UIImageView *jiantou = [UIImageView newAutoLayoutView];
        jiantou.image = kImage(@"yishengzhushou_14");
        [_mBubbleView addSubview:jiantou];
        
        
        
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 10;// 字体的行间距
        
        NSDictionary *attributes = @{
                                     NSFontAttributeName:[UIFont systemFontOfSize:15],
                                     NSParagraphStyleAttributeName:paragraphStyle,
                                     NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#999999"]
                                     };
        
        

        
        _contentTexView.attributedText = [[NSAttributedString alloc] initWithString:_contentTexView.text attributes:attributes];
        
        [_mBubbleView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(10, 20, 10, 20)];
        
        [_titleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:0];
        [_titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:0];
        [_titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
        
        [lineView1 autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:5];
        [lineView1 autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:5];
        [lineView1 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_titleLabel withOffset:10];
        [lineView1 autoSetDimension:ALDimensionHeight toSize:.5f];
        
        [_contentTexView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:5];
        [_contentTexView autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:5];
        [_contentTexView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:lineView1 withOffset:5];
        [_contentTexView autoSetDimension:ALDimensionHeight toSize:90];
        
        [lineView2 autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:5];
        [lineView2 autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:5];
        [lineView2 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_contentTexView withOffset:5];
        [lineView2 autoSetDimension:ALDimensionHeight toSize:.5f];
        
        [xiangq autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:10];
        [xiangq autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:5];
        [xiangq autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
        [xiangq autoSetDimension:ALDimensionHeight toSize:20];
        
        [jiantou autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:5];
        [jiantou autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
        [jiantou autoSetDimensionsToSize:CGSizeMake(13, 15)];
        
    }
    
    return self;
}

- (void)setModel:(LWChatModel *)model
{
    _model = model;

    NSString *title ;
    NSString *content;
    switch (_model.chatMessageType) {
        case WSChatMessageType_FirstSeeDoctorRemind:
        {
            title = @"首次就诊";
            content = _model.doctorText;
        }
            break;
        case WSChatMessageType_FirstSeeDoctorReport:
        {
            title = @"首诊就诊报告";
            content = _model.doctorText;

        }
            break;
        case WSChatMessageType_VisitReport:
        {
            title = @"复诊就诊报告";
            content = _model.doctorText;
        }
            break;
        case WSChatMessageType_PEFRemind:
        {
            title = @"记录PEF提醒";
            content = _model.doctorText;
        }
            break;
        case WSChatMessageType_ACAassessment:
        {
            title = @"完成ACT评估";
            content = _model.doctorText;
        }
            break;
        case WSChatMessageType_AsthmaAassessment:
        {
            title = @"完成哮喘评估";
            content = _model.doctorText;
        }
            break;
        case WSChatMessageType_VisitRemind:
        {
            title = @"复诊提醒";
            content = _model.doctorText;
        }
            break;
        case WSChatMessageType_PEFRecord:
        {
            title = @"PEF记录通知";
            content = _model.doctorText;
        }
            break;
        default:
            break;
    }
    
    _titleLabel.text = title;
    _contentTexView.text = content;

    CGFloat height = [content sizeWithFont:[UIFont systemFontOfSize:14] constrainedToWidth:Screen_SIZE.width-50].height+15;
    height = MAX(height, 30);
    [_contentTexView autoSetDimension:ALDimensionHeight toSize:height];

    _model.rowHeight = height+110;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
