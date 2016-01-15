//
//  LWACTAssessmentCell.m
//  BreatheDoctor
//
//  Created by comv on 15/11/23.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWACTAssessmentCell.h"
#import "NSString+Size.h"

@implementation LWACTAssessmentCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
    self.lineHight.constant = .5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(LWACTAssessmentModel *)model
{
    _model = model;
    
    self.problemLabel.text = model.wenti;
    self.resultsLabel.text = model.daan;
    self.resultsLabel.textColor = [LWThemeManager shareInstance].navBackgroundColor;
    
    CGFloat ph = [self.problemLabel.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToWidth:self.width-20].height+20;
    self.problemHight.constant = ph;
    CGFloat dh = [self.resultsLabel.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToWidth:self.width-20].height+15;
    self.resultsHight.constant = dh;
    model.rowHight = ph+dh+30;

}
@end
