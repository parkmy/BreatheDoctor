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
#import "NSDate+Extension.h"
#import "KLPatientListModel.h"

@implementation LWPatientCenterCell

- (void)awakeFromNib {
    // Initialization code
    [self.patientIcon setCornerRadius:self.patientIcon.height/2];
    for (UILabel *label in self.patientDataLabels) {
        label.backgroundColor = [UIColor colorWithHexString:@"#84b54a"];
        [label setCornerRadius:label.height/2];
    }
    
}
- (IBAction)editorbuttonClick:(id)sender
{
    _editorButtonEventBlock?_editorButtonEventBlock():nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setPatientRecordsModel:(LWPatientRecordsBaseModel *)patientRecordsModel
{
    _patientRecordsModel = patientRecordsModel;
    LWPatientRecordsPatientArchives *model = _patientRecordsModel.body.patientArchives;
    
//    [LWTool atientControlLevel:[model.controlLevel doubleValue] withLayoutConstraint:self.typeWidth withLabel:self.patientTypeButton];
//    
//    if ([model.remark isEqualToString:@""] || !model.remark) {
//        self.patientNameLabel.text = stringJudgeNull(model.patientName);
//    }else
//    {
//        self.patientNameLabel.text = [NSString stringWithFormat:@"%@(%@)",stringJudgeNull(model.patientName),stringJudgeNull(model.remark)];
//    }
//    CGFloat w = [self.patientNameLabel.text sizeWithFont:[UIFont systemFontOfSize:16] constrainedToHeight:24].width;
//    self.patientNameWidth.constant = w + 10 + 45;
    
//    [self.patientIcon sd_setImageWithURL:kNSURL(stringJudgeNull(model.headImgUrl)) placeholderImage:kImage(@"yishengzhushousy_03.png")];

    for (int i = 0; i < self.patientDataLabels.count; i++)
    {
        UILabel *label = self.patientDataLabels[i];
        if (i == 0) {
           label.text = model.sex == 1?@"男":@"女";
        }else if (i == 1)
        {
            NSTimeInterval dateDiff = [[NSDate dateWithString:model.birthday format:[NSDate ymdFormat]] timeIntervalSinceNow];
            int age = fabs(dateDiff/(60*60*24))/365;
            label.text = [NSString stringWithFormat:@"%d岁",age];
        }else if (i == 2)
        {
            label.text = [NSString stringWithFormat:@"%@cm",kNSString(kNSNumDouble(model.height))];
        }else if (i == 3)
        {
            label.text = [NSString stringWithFormat:@"%@kg",kNSString(kNSNumDouble(model.weight))];
        }
        
        
    }
    
}

- (void)setPatient:(KLPatientListModel *)patient
{
    _patient = patient;
    
    self.patientTypeButton.titleLabel.font = [UIFont systemFontOfSize:kNSPXFONTFLOAT(26)];
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
