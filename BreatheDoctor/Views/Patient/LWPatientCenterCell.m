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
    [self.patientIcon setCornerRadius:self.patientIcon.height/2];
    for (UILabel *label in self.patientDataLabels) {
        [label setCornerRadius:label.height/2];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPatient:(LWPatientRows *)patient
{
    _patient = patient;
    
    [LWTool atientControlLevel:_patient.controlLevel withLayoutConstraint:self.typeWidth withLabel:self.patientTypeButton];
    if ([_patient.remark isEqualToString:@""] || !_patient.remark) {
        self.patientNameLabel.text = stringJudgeNull(_patient.patientName);
    }else
    {
        self.patientNameLabel.text = [NSString stringWithFormat:@"%@(%@)",stringJudgeNull(_patient.patientName),stringJudgeNull(_patient.remark)];
    }
    CGFloat w = [self.patientNameLabel.text sizeWithFont:[UIFont systemFontOfSize:16] constrainedToHeight:24].width;
    self.patientNameWidth.constant = w + 10 + 45;
    
    [self.patientIcon sd_setImageWithURL:kNSURL(stringJudgeNull(_patient.headImgUrl)) placeholderImage:kImage(@"yishengzhushousy_03.png")];
    
}

@end
