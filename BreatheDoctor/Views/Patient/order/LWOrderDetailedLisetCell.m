//
//  LWReservationHeardCell.m
//  BreatheDoctor
//
//  Created by comv on 16/2/25.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWOrderDetailedLisetCell.h"
#import "LWDetailedOrderListModel.h"
#import <UIImageView+WebCache.h>

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
        orderNamelLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:kNSPXFONTFLOAT(30)];
        orderNamelLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        [self addSubview:orderNamelLabel];

        moneyLabel = [UILabel new];
        moneyLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:kNSPXFONTFLOAT(28)];
        moneyLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        [self addSubview:moneyLabel];
        
        orderTimerLabel = [UILabel new];
        orderTimerLabel.font = [UIFont systemFontOfSize:kNSPXFONTFLOAT(30)];
        orderTimerLabel.textColor = orderNamelLabel.textColor;
        [self addSubview:orderTimerLabel];

        orderTotalMoneyLabel = [UILabel new];
        orderTotalMoneyLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:kNSPXFONTFLOAT(34)];
        orderTotalMoneyLabel.textColor = orderNamelLabel.textColor;
        [self addSubview:orderTotalMoneyLabel];

        UIView *topLine = [UIView new];
        topLine.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
        UIView *bottomLine = [UIView new];
        bottomLine.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
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
    LWDetailedOrderListModel *detailedOrderListModel = _model;
    
    if (self.productType == ProductTypePhoneOrder) {
        iconImageView.image = kImage(@"dianhuazixun");        
    }else if (self.productType == ProductTypeGraphicOrder)
    {
        iconImageView.image = kImage(@"tuwenzixun");
    }else
    {
        [iconImageView sd_setImageWithURL:kNSURL(detailedOrderListModel.imageUrl) placeholderImage:kImage(@"defaultIconImage@2x")];

    }
    orderNamelLabel.text = stringJudgeNull(detailedOrderListModel.fullName);
    orderTimerLabel.text = [NSString stringWithFormat:@"订单时间：%@",detailedOrderListModel.createDt];
    
    NSInteger  quantity = [detailedOrderListModel.quantity integerValue];
    double  accountPaid = [detailedOrderListModel.accountPaid doubleValue];
    
    orderTotalMoneyLabel.text = [NSString stringWithFormat:@"总价：¥ %.2f",(accountPaid/100.0)];
    moneyLabel.text = [NSString stringWithFormat:@"价格： ¥ %.2f  数量：%@",(accountPaid/quantity)/100.0,detailedOrderListModel.quantity];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:orderTotalMoneyLabel.text];
    
    CGFloat moneyLabelheight = [moneyLabel.text sizeWithFont:[UIFont fontWithName:@"Helvetica-Light" size:kNSPXFONTFLOAT(34)] constrainedToWidth:moneyLabel.width].height;
    moneyLabel.sd_layout.heightIs(moneyLabelheight*2);
    
    CGFloat orderNamelLabelheight = [orderNamelLabel.text sizeWithFont:[UIFont systemFontOfSize:kNSPXFONTFLOAT(30)] constrainedToWidth:orderNamelLabel.width].height;
    orderNamelLabel.sd_layout.heightIs(orderNamelLabelheight*2);
    
//    NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#666666"]]
    
    [attributedString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kNSPXFONTFLOAT(26)],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#666666"]} range:NSMakeRange(0, 3)];
    
    orderTotalMoneyLabel.attributedText = attributedString;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
