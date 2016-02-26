//
//  LWReservationHeardCell.m
//  BreatheDoctor
//
//  Created by comv on 16/2/25.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWOrderDetailedLisetCell.h"

@interface LWOrderDetailedLisetCell ()
{
    UIImageView *iconImageView;
    UILabel     *orderNamelLabel;
    UILabel     *moneyLabel;
    UILabel     *orderTimerLabel;
    UILabel     *orderTotalMoneyLabel;
    
}

@end

@implementation LWOrderDetailedLisetCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = 0;
        
        iconImageView = [UIImageView new];
        [iconImageView setImage:kImage(@"dianhuazixun")];
        [self addSubview:iconImageView];
        
        orderNamelLabel = [UILabel new];
        orderNamelLabel.numberOfLines = 0;
        orderNamelLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:16];
        orderNamelLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        [self addSubview:orderNamelLabel];

        moneyLabel = [UILabel new];
        moneyLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:15];
        moneyLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        [self addSubview:moneyLabel];
        
        orderTimerLabel = [UILabel new];
        orderTimerLabel.textColor = orderNamelLabel.textColor;
        [self addSubview:orderTimerLabel];

        orderTotalMoneyLabel = [UILabel new];
        orderTotalMoneyLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:16];
        orderTotalMoneyLabel.textColor = orderNamelLabel.textColor;
        [self addSubview:orderTotalMoneyLabel];

        UIView *topLine = [UIView new];
        topLine.backgroundColor = RGBA(0, 0, 0, .2);
        UIView *bottomLine = [UIView new];
        bottomLine.backgroundColor = RGBA(0, 0, 0, .2);
        [self addSubview:topLine];
        [self addSubview:bottomLine];
        
        orderTimerLabel.sd_layout.topSpaceToView(self,0).leftSpaceToView(self,10).rightSpaceToView(self,0).heightIs(45);
        orderTotalMoneyLabel.sd_layout.bottomSpaceToView(self,0).leftSpaceToView(self,10).rightSpaceToView(self,0).heightIs(45);
        
        topLine.sd_layout.topSpaceToView(orderTimerLabel,0).leftSpaceToView(self,0).rightSpaceToView(self,0).heightIs(.5);
        bottomLine.sd_layout.bottomSpaceToView(orderTotalMoneyLabel,0).leftSpaceToView(self,0).rightSpaceToView(self,0).heightIs(.5);
        
        iconImageView.sd_layout.leftSpaceToView(self,15).topSpaceToView(topLine,12).bottomSpaceToView(bottomLine,12).widthIs(65);
        orderNamelLabel.sd_layout.leftSpaceToView(iconImageView,10).rightSpaceToView(self,0).topEqualToView(iconImageView).heightIs(40);
        moneyLabel.sd_layout.leftSpaceToView(iconImageView,10).bottomEqualToView(iconImageView).rightSpaceToView(self,0).heightIs(20);
        
    }
    return self;
}

- (void)setModel:(id)model
{
    _model = model;
    
    orderNamelLabel.text = @"欧茉莉雾化器NE-C32S家用儿童雾化器欧茉莉雾化器NE-C32S家用儿童";
    orderTimerLabel.text = @"订单时间 ：1026-22-33 12：22";
    orderTotalMoneyLabel.text = @"总价：¥1700000";
    moneyLabel.text = @"价格：¥144444 数量：333";
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
