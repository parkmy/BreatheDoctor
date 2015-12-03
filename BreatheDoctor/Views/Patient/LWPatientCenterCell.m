//
//  LWPatientCenterCell.m
//  BreatheDoctor
//
//  Created by comv on 15/11/10.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWPatientCenterCell.h"
#import "LWTool.h"
#import <UIImageView+WebCache.h>

@implementation LWPatientCenterCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPatient:(LWPatientRows *)patient
{
    _patient = patient;
    
    [LWTool atientControlLevel:_patient.controlLevel withLayoutConstraint:self.typeWidth withLabel:self.patientLabel];
    if ([_patient.remark isEqualToString:@""] || !_patient.remark) {
        self.patientNameLabel.text = stringJudgeNull(_patient.patientName);
    }else
    {
        self.patientNameLabel.text = [NSString stringWithFormat:@"%@(%@)",stringJudgeNull(_patient.patientName),stringJudgeNull(_patient.remark)];
    }
    [self.patientIcon sd_setImageWithURL:kNSURL(stringJudgeNull(_patient.headImgUrl)) placeholderImage:kImage(@"yishengzhushousy_03.png")];
    
}

@end
