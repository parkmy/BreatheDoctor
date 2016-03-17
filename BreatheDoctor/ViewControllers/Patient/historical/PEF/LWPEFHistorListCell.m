//
//  LWPEFHistorListCell.m
//  BreatheDoctor
//
//  Created by comv on 16/3/15.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWPEFHistorListCell.h"

@interface LWPEFHistorListCell ()
{
    UILabel *timerLabel;
    UILabel *pefMorningLabel;
    UILabel *pefEveningLabel;
}

@end

@implementation LWPEFHistorListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = 0;
        
//        UIView *bg = [UIView new];
//        bg.layer.borderWidth = .5;
//        bg.layer.borderColor = appLineColor.CGColor;
//        [self addSubview:bg];
        
//        bg.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, appMargin, 0, appMargin));
        
        timerLabel = [self allocLabel];
        [self addSubview:timerLabel];
        pefMorningLabel = [self allocLabel];
        [self addSubview:pefMorningLabel];
        pefEveningLabel = [self allocLabel];
        [self addSubview:pefEveningLabel];
        
        timerLabel.sd_layout.leftSpaceToView(self,0).topSpaceToView(self,0).bottomSpaceToView(self,0).widthRatioToView(self,.333333333333);
        pefMorningLabel.sd_layout.leftSpaceToView(timerLabel,0).topSpaceToView(self,0).bottomSpaceToView(self,0).widthRatioToView(self,.333333333333);
        pefEveningLabel.sd_layout.leftSpaceToView(pefMorningLabel,0).topSpaceToView(self,0).bottomSpaceToView(self,0).widthRatioToView(self,.333333333333);
        
    }
    return self;
}
- (UILabel *)allocLabel
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
//    label.backgroundColor = RGBA(arc4random_uniform(245), arc4random_uniform(124), arc4random_uniform(77), 1);
    label.backgroundColor = [UIColor clearColor];
    label.font = kNSPXFONT(22);
    label.textAlignment = 1;
    label.textColor = [UIColor colorWithHexString:@"#666666"];
    label.text = @"666666";
    return label;
}
- (void)setBackgroundColorWithTag:(int)tag
{
    if (tag == 0) {
        self.backgroundColor = [UIColor colorWithHexString:@"#f5f9ef"];
    }else
    {
        self.backgroundColor = [UIColor whiteColor];
    }
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
