//
//  LWMedicationTitleCell.m
//  BreatheDoctor
//
//  Created by comv on 16/3/17.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWMedicationTitleCell.h"
#import "LWMedicationTitleTypeView.h"

@interface LWMedicationTitleCell ()

@end

@implementation LWMedicationTitleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        LWMedicationTitleTypeView *typeView = ({
            LWMedicationTitleTypeView *view = [LWMedicationTitleTypeView new];
            view;
        });
        typeView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
