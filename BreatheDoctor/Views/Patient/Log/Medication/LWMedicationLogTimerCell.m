//
//  LWMedicationLogTimerCell.m
//  BreatheDoctor
//
//  Created by comv on 15/11/26.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWMedicationLogTimerCell.h"

@implementation LWMedicationLogTimerCell

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
    self.morningCtrLabel.text = _model.morningPharmacyControl == 1?@"是":@"否";
    self.morningCtrLabel.textColor = _model.morningPharmacyControl == 1?[UIColor colorWithHexString:@"#6396ea"]:RGBA(0, 0, 0, .6);
    self.morningMergencyLabel.text = _model.morningPharmacyUrgency == 1?@"是":@"否";
    self.morningMergencyLabel.textColor = _model.morningPharmacyControl == 1?[UIColor colorWithHexString:@"#ff3b4a"]:RGBA(0, 0, 0, .6);

    self.afternoonCtrLabel.text = _model.afternoonPharmacyControl == 1?@"是":@"否";
    self.afternoonCtrLabel.textColor = _model.afternoonPharmacyControl == 1?[UIColor colorWithHexString:@"#6396ea"]:RGBA(0, 0, 0, .6);
    self.afternoonEmergencyLabel.text = _model.afternoonPharmacyUrgency == 1?@"是":@"否";
    self.afternoonEmergencyLabel.textColor = _model.afternoonPharmacyControl == 1?[UIColor colorWithHexString:@"#ff3b4a"]:RGBA(0, 0, 0, .6);

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
