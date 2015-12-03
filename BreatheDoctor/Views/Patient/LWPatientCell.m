//
//  LWPatientCell.m
//  BreatheDoctor
//
//  Created by comv on 15/11/10.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWPatientCell.h"
#import <UIImageView+WebCache.h>
#import "LWTool.h"

@implementation LWPatientCell

- (void)awakeFromNib {
    // Initialization code
    [self.patientTypeLabel setCornerRadius:self.patientTypeLabel.height/2];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPatient:(LWPatientRows *)patient
{
    _patient = patient;
    
    [self.patientIcon sd_setImageWithURL:kNSURL(stringJudgeNull(_patient.headImgUrl)) placeholderImage:kImage(@"yishengzhushousy_03.png")];
    if ([_patient.remark isEqualToString:@""] || !_patient.remark) {
        self.patientNameLabel.text = stringJudgeNull(_patient.patientName);
    }else
    {
        self.patientNameLabel.text = [NSString stringWithFormat:@"%@(%@)",stringJudgeNull(_patient.patientName),stringJudgeNull(_patient.remark)];
    }
    
    [LWTool atientControlLevel:_patient.controlLevel withLayoutConstraint:self.typeWith withLabel:self.patientTypeLabel];
    
//    _patient.controlLevel
}

@end
