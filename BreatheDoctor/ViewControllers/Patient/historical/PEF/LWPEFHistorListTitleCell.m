//
//  LWPEFHistorListTitleCell.m
//  BreatheDoctor
//
//  Created by comv on 16/3/15.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWPEFHistorListTitleCell.h"

@implementation LWPEFHistorListTitleCell

- (id)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *line = [UIView allocAppLineView];
        [self addSubview:line];
        line.sd_layout.bottomSpaceToView(self,0).leftSpaceToView(self,0).rightSpaceToView(self,0).heightIs(.5);
        
        UIView *line1 = [UIView allocAppLineView];
        [self addSubview:line1];
        UIView *line2 = [UIView allocAppLineView];
        [self addSubview:line2];
        
        UILabel *month = [self allocLabel];
        month.text = @"日期";
        [self addSubview:month];
        month.sd_layout.leftSpaceToView(self,0).topSpaceToView(self,0).bottomSpaceToView(line,0).widthRatioToView(self,.333333333333);
        line1.sd_layout.leftSpaceToView(month,0).topSpaceToView(self,0).bottomSpaceToView(self,0).widthIs(.5);
        
        UILabel *morning = [self allocLabel];
        morning.text = @"早上";
        [self addSubview:morning];
        morning.sd_layout.leftSpaceToView(line1,0).topSpaceToView(self,0).bottomSpaceToView(line,0).widthRatioToView(self,.333333333333);
        line2.sd_layout.leftSpaceToView(morning,0).topSpaceToView(self,0).bottomSpaceToView(self,0).widthIs(.5);
        
        UILabel *evening = [self allocLabel];
        evening.text = @"晚上";
        [self addSubview:evening];
        evening.sd_layout.leftSpaceToView(line2,0).topSpaceToView(self,0).bottomSpaceToView(line,0).widthRatioToView(self,.333333333333);
    }
    return self;
}

- (UILabel *)allocLabel
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.font = kNSPXFONT(28);
    label.textAlignment = 1;
    label.textColor = [UIColor colorWithHexString:@"#333333"];
    return label;
}

@end
