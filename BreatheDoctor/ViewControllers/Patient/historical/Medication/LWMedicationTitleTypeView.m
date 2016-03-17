//
//  LWMedicationTieleTypeView.m
//  BreatheDoctor
//
//  Created by comv on 16/3/17.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWMedicationTitleTypeView.h"

@implementation LWMedicationTitleTypeView

- (id)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *contenView = [UIView new];
        contenView.layer.borderWidth = .5;
        contenView.layer.borderColor = appLineColor.CGColor;
        [self addSubview:contenView];
        contenView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 10, 0, 10));

        
//        UIView *line = [UIView allocAppLineView];
//        [contenView addSubview:line];
//        line.sd_layout.bottomSpaceToView(contenView,0).leftSpaceToView(contenView,0).rightSpaceToView(contenView,0).heightIs(.5);
        
        UILabel *date = [self allocLabel];
        date.text = @"日期";
        [contenView addSubview:date];
        date.sd_layout.leftSpaceToView(contenView,0).topSpaceToView(contenView,0).bottomSpaceToView(contenView,0).widthRatioToView(contenView,.25);
        
        UIView *line1 = [UIView allocAppLineView];
        [contenView addSubview:line1];
        line1.sd_layout.leftSpaceToView(date,0).topSpaceToView(contenView,0).bottomSpaceToView(contenView,0).widthIs(.5);
        
        UILabel *timer = [self allocLabel];
        timer.text = @"时间";
        [contenView addSubview:timer];
        timer.sd_layout.leftSpaceToView(line1,0).topSpaceToView(contenView,0).bottomSpaceToView(contenView,0).widthRatioToView(contenView,.25);
        
        UILabel *ctr = [self allocLabel];
        ctr.text = @"控制用药";
        [contenView addSubview:ctr];
        ctr.sd_layout.leftSpaceToView(timer,0).topSpaceToView(contenView,0).bottomSpaceToView(contenView,0).widthRatioToView(contenView,.25);
        
        UILabel *jingji = [self allocLabel];
        jingji.text = @"紧急用药";
        [contenView addSubview:jingji];
        jingji.sd_layout.leftSpaceToView(ctr,0).topSpaceToView(contenView,0).bottomSpaceToView(contenView,0).widthRatioToView(contenView,.25);

        
    }
    return self;
}

- (UILabel *)allocLabel
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.font = kNSPXFONT(26);
    label.textAlignment = 1;
    label.textColor = [UIColor colorWithHexString:@"#333333"];
    return label;
}

@end
