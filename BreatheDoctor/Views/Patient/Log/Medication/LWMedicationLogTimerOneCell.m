//
//  LWMedicationLogTimerOneCell.m
//  BreatheDoctor
//
//  Created by comv on 15/11/26.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWMedicationLogTimerOneCell.h"

@implementation LWMedicationLogTimerOneCell

- (void)awakeFromNib {
    // Initialization code
    for (NSLayoutConstraint *contstraint in self.heights) {
        contstraint.constant = .5;
    }
}

- (void)setModel:(LWMedicationModel *)model
{
    _model = model;
    
    self.dateLabel.text = _model.recordDt;
    self.PeriodTimeLabel.text = _model.timeFrame == 1?@"上午":@"下午";
    self.ctrLabel.text = _model.pharmacyControl == 1?@"是":@"否";
    self.ctrLabel.textColor = _model.pharmacyControl == 1?[UIColor colorWithHexString:@"#6396ea"]:RGBA(0, 0, 0, .6);
    self.emyLabel.text = _model.pharmacyUrgency == 1?@"是":@"否";
    self.emyLabel.textColor = _model.pharmacyUrgency == 1?[UIColor colorWithHexString:@"#ff3b4a"]:RGBA(0, 0, 0, .6);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
