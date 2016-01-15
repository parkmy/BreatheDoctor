//
//  LWTheFormCell.m
//  BreatheDoctor
//
//  Created by comv on 16/1/13.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWTheFormCell.h"

@implementation LWTheFormCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _theFormView = [[LWTheFormView alloc] initWithFrame:CGRectZero];
        [self addSubview:_theFormView];
        
        _theFormView.sd_layout.topSpaceToView(self,0).leftSpaceToView(self,0).rightSpaceToView(self,0).bottomSpaceToView(self,0);
    }
    return self;
}

- (void)setModel:(LWTheFromArows *)model withType:(showTheFormType)type
{
    self.theFormView.title = model.title;
    [self.theFormView setTypes:[NSMutableArray arrayWithArray:model.rowArray] andShowType:type];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
