//
//  LWOrderCellTypeView.m
//  BreatheDoctor
//
//  Created by comv on 16/3/9.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWOrderCellTypeView.h"

static const float typeItmW = 35;

@interface LWOrderCellTypeView ()
{
    
}
@end

@implementation LWOrderCellTypeView

- (id)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame])
    {
        [self loadSubView];
    }
    return self;
}

- (void)loadSubView
{
    
    for (int i = 0; i < 3; i++)
    {
        UIView *itmView = [UIView new];
        itmView.backgroundColor = [UIColor clearColor];
        [self addSubview:itmView];
        
        UILabel *label = [UILabel new];
        label.textAlignment = 1;
        label.textColor = [UIColor colorWithHexString:@"#999999"];
        label.font = [UIFont systemFontOfSize:kNSPXFONTFLOAT(26)];
        [itmView addSubview:label];
        
        UIView *typeLine = [UIView new];
        [itmView addSubview:typeLine];
        
        if (0 == i)
        {
            itmView.sd_layout.topSpaceToView(self,0).leftSpaceToView(self,0).bottomSpaceToView(self,0).widthIs(typeItmW);
            typeLine.backgroundColor = [UIColor colorWithHexString:@"#77c75e"];
            label.text = @"商 品";
        }else if (1 == i)
        {
            itmView.sd_layout.topSpaceToView(self,0).centerXEqualToView(self).bottomSpaceToView(self,0).widthIs(typeItmW);
            typeLine.backgroundColor = [UIColor colorWithHexString:@"#febf47"];
            label.text = @"图 文";
        }else
        {
            itmView.sd_layout.topSpaceToView(self,0).rightSpaceToView(self,0).bottomSpaceToView(self,0).widthIs(typeItmW);
            typeLine.backgroundColor = [UIColor colorWithHexString:@"#ff6666"];
            label.text = @"电 话";
        }
        
        [typeLine setCornerRadius:5.0/2];
        typeLine.sd_layout.leftSpaceToView(itmView,12).rightSpaceToView(itmView,12).topSpaceToView(itmView,10).heightIs(5.f);
        label.sd_layout.leftSpaceToView(itmView,0).rightSpaceToView(itmView,0).bottomSpaceToView(itmView,0).topSpaceToView(typeLine,5);
    }


}
@end
