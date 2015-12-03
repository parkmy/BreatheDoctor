//
//  LWMedicationLogCountCell.m
//  BreatheDoctor
//
//  Created by comv on 15/11/26.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWMedicationLogCountCell.h"

@implementation LWMedicationLogCountCell

- (void)awakeFromNib {
    // Initialization code
    [self.controlCountLabel setCornerRadius:self.controlCountLabel.width/2];
    self.controlCountLabel.layer.borderWidth = .5;
    self.controlCountLabel.layer.borderColor = [UIColor colorWithHexString:@"#6396ea"].CGColor;
    self.controlCountLabel.textColor = [UIColor colorWithHexString:@"#6396ea"];
    
    [self.emergencyCountLabel setCornerRadius:self.controlCountLabel.width/2];
    self.emergencyCountLabel.layer.borderWidth = .5;
    self.emergencyCountLabel.layer.borderColor = [UIColor colorWithHexString:@"#ff3b4a"].CGColor;
    self.emergencyCountLabel.textColor = [UIColor colorWithHexString:@"#ff3b4a"];
}
- (void)reloadData
{
    LWPEFLineModel *lineModel = [LWPublicDataManager shareInstance].logModle;

    NSInteger controlCount = 0;
    NSInteger emergencyCount = 0;
    
    for (LWPEFRecordList *model in lineModel.body.recordList) {
        if (model.pharmacyControl == 1) {
            controlCount++;
        }
        if (model.pharmacyUrgency == 1) {
            emergencyCount++;
        }
    }
    self.controlCountLabel.text = [NSString stringWithFormat:@"%@次",kNSNumInteger(controlCount)];
    self.emergencyCountLabel.text = [NSString stringWithFormat:@"%@次",kNSNumInteger(emergencyCount)];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
