//
//  LWAssessmentStarCell.m
//  BreatheDoctor
//
//  Created by comv on 15/11/27.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWAssessmentStarCell.h"

@implementation LWAssessmentStarCell

- (void)awakeFromNib {
    // Initialization code
    self.width.constant = .5;
}
- (void)setModel:(LWAssessmentModel *)model
{
    _model = model;
    //1 完全控制 2部分控制 3未控制，null为未
    self.typeLabel.text = _model.type == 1?@"完全控制":_model.type == 2?@"部分控制":@"未控制";
    self.typeLabel.textColor = _model.type == 1?RGBA(87, 198, 39, 1):_model.type == 2?RGBA(248, 131, 9, 1):RGBA(243, 34, 23, 1);
    self.contentLabel.text = stringJudgeNull(_model.content);
    self.timeLabel.text = _model.date;
    
    self.contentHeight.constant = [self.contentLabel.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToWidth:self.contentLabel.width].height+5;
    
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
