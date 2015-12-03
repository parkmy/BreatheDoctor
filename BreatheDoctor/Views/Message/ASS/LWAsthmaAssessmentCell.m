//
//  LWAsthmaAssessmentCell.m
//  BreatheDoctor
//
//  Created by comv on 15/11/23.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWAsthmaAssessmentCell.h"

@implementation LWAsthmaAssessmentCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
    [self.bgView setCornerRadius:5.0f];
    [self.timeLabel setCornerRadius:5.0f];
    for (NSLayoutConstraint *constraint in self.lineHights) {
        constraint.constant = .5;
    }
    for (UILabel *label in self.starLabels) {
        [label setCornerRadius:label.width/2];
        label.layer.borderWidth = .5;
        label.layer.borderColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.5].CGColor;
    }

}

- (UIColor *)isYesColor:(double)type
{
    return type == 0?[UIColor colorWithHexString:@"#ff3b4a"]:[UIColor colorWithHexString:@"#6396ea"];
}
- (void)setModel:(LWAsthmaModel *)model
{
    _model = model;
    //lom	body	number		活动受限	1 选中 0 未选中
    //nightSymptoms	body	number		夜间症状	1 选中 0 未选中
    //cushion	body	number		使用缓解药物	1 选中 0 未选中
    //acuteAttack	body	number		急性发作	1 选中 0 未选中
    
    self.timeLabel.text = model.assessDt;
    
    for (int a = 0; a < self.starLabels.count; a++) {
        UILabel *label = self.starLabels[a];
        if (a == 0) {
            label.text = _model.lom == 1?@"是":@"否";
            label.textColor = [self isYesColor:_model.lom];
            label.layer.borderColor = [self isYesColor:_model.lom].CGColor;
        }else if (a == 1)
        {
            label.text = _model.nightSymptoms == 1?@"是":@"否";
            label.textColor = [self isYesColor:_model.nightSymptoms];
            label.layer.borderColor = [self isYesColor:_model.nightSymptoms].CGColor;
        }else if (a == 2)
        {
            label.text = _model.cushion == 1?@"使用":@"否";
            label.textColor = [self isYesColor:_model.cushion];

            label.layer.borderColor = [self isYesColor:_model.cushion].CGColor;

        }else if (a == 3)
        {
            label.text = _model.acuteAttack == 1?@"是":@"否";
            label.textColor = [self isYesColor:_model.acuteAttack];

            label.layer.borderColor = [self isYesColor:_model.acuteAttack].CGColor;
        }
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
