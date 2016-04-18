//
//  KLHistoricalHeardCell.m
//  BreatheDoctor
//
//  Created by comv on 16/4/7.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLHistoricalHeardCell.h"
#import "LWHistoricalCountModel.h"

@implementation KLHistoricalHeardCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = 0;
        
        _titleLabel = [UILabel new];
        _titleLabel.font = kNSPXFONT(30);
        _titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        
        _countLabel = [UILabel new];
        _countLabel.font = kNSPXFONT(38);
        _countLabel.textAlignment = 1;
        
        UILabel *kl_ci = [UILabel new];
        kl_ci.text = @"次";
        kl_ci.font = kNSPXFONT(24);
        kl_ci.textColor = [UIColor colorWithHexString:@"#333333"];
        
        [self sd_addSubviews:@[_titleLabel,_countLabel,kl_ci]];
        
        _titleLabel.sd_layout
        .leftSpaceToView(self,0)
        .topSpaceToView(self,0)
        .bottomSpaceToView(self,0);
        
        _countLabel.sd_layout
        .leftSpaceToView(_titleLabel,0)
        .topEqualToView(_titleLabel)
        .bottomEqualToView(_titleLabel)
        .widthIs(45);
        
        kl_ci.sd_layout
        .leftSpaceToView(_countLabel,0)
        .bottomEqualToView(_countLabel)
        .heightRatioToView(_countLabel,1)
        .widthIs(20);
        
    }
    return self;
}
- (void)setModel:(id)model{
    
    _model = model;
    
    LWHistoricalCountModel *historicalCountModel = model;
    
    CGFloat width = [[NSString stringJudgeNullInfoString:historicalCountModel.typeTitle] sizeWithFont:_titleLabel.font constrainedToHeight:CGFLOAT_MAX].width;
    _titleLabel.sd_layout.widthIs(width);
    _titleLabel.text = historicalCountModel.typeTitle;
    
    _countLabel.text = kNSString(kNSNumInteger(historicalCountModel.count));
    _countLabel.textColor = historicalCountModel.countColor;
    
}

@end
