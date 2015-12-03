//
//  LWPatientLogSymptomsCountCell.m
//  BreatheDoctor
//
//  Created by comv on 15/11/22.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWPatientLogSymptomsCountCell.h"

@interface LWPatientLogSymptomsCountCell ()
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *lineHights;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *countLabels;
// tag 111感觉良好 222喘息 333咳嗽 444呼吸困难 555胸闷 666其他症状
@end

@implementation LWPatientLogSymptomsCountCell

- (void)awakeFromNib {
    // Initialization code
//    self.backgroundColor = [UIColor whiteColor];

    for (NSLayoutConstraint *constraint in self.lineHights) {
        constraint.constant = .5;
    }
//    for (NSLayoutConstraint *constraint in self.ss) {
//        constraint.constant = .5;
//    }
    
}
- (void)loadData
{
    LWPEFLineModel *model = [LWPublicDataManager shareInstance].logModle;

//    NSInteger recordCount = model.body.recordList.count;
    
    NSInteger symptomGood = 0; //症状记录--感觉良好	1 选中 0 未选中
    NSInteger symptomGasp = 0;//    症状记录--喘息	1 选中 0 未选中
    NSInteger symptomCough = 0;//    症状记录--咳嗽	1 选中 0 未选中
    NSInteger symptomDyspnea = 0;//    症状记录--呼吸困难	1 选中 0 未选中
    NSInteger symptomChestdistress = 0;//    症状记录--胸闷	1 选中 0 未选中
    NSInteger symptomNightWoke = 0;
    for (LWPEFRecordList *rec in model.body.recordList)
    {
        if (rec.symptomGood == 1) {
            symptomGood++;
        }
        if (rec.symptomGasp == 1) {
            symptomGasp++;
        }
        if (rec.symptomCough == 1) {
            symptomCough++;
        }
        if (rec.symptomDyspnea == 1) {
            symptomDyspnea++;
        }
        if (rec.symptomChestdistress == 1) {
            symptomChestdistress++;
        }
        if (rec.symptomNightWoke) {
            symptomNightWoke++;
        }
    }
    
   
    for (int i = 0; i < self.countLabels.count; i++)
    {
        UILabel *label = self.countLabels[i];
        label.font = [UIFont fontWithName:@"Helvetica-Oblique" size:28];
        label.textColor = RGBA(242, 19, 23, .8);

        if (i == 0) {
            label.text = [NSString stringWithFormat:@"%@ 次",kNSNumInteger(symptomGood)];
            label.textColor = RGBA(97, 200, 54, 1);
        }else if (i == 1)
        {
            label.text = [NSString stringWithFormat:@"%@ 次",kNSNumInteger(symptomGasp)];

        }
        else if (i == 2)
        {
            label.text = [NSString stringWithFormat:@"%@ 次",kNSNumInteger(symptomCough)];

        }else if (i == 3)
        {
            label.text = [NSString stringWithFormat:@"%@ 次",kNSNumInteger(symptomDyspnea)];

        }else if (i == 4)
        {
            label.text = [NSString stringWithFormat:@"%@ 次",kNSNumInteger(symptomChestdistress)];

        }else
        {
            label.text = [NSString stringWithFormat:@"%@ 次",kNSNumInteger(symptomNightWoke)];
            label.textColor = RGBA(0, 0, 0, .5);
        }
        
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:label.text];
        [string addAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Oblique" size:13]} range:NSMakeRange(string.length-1, 1)];
        label.attributedText = string;
        
    }
    

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
