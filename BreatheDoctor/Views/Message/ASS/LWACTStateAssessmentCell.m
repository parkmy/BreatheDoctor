//
//  LWACTStateAssessmentCell.m
//  BreatheDoctor
//
//  Created by comv on 15/11/23.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWACTStateAssessmentCell.h"

@implementation LWACTStateAssessmentCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
}
- (void)initACTStateAssessmentCelWith:(NSString *)patienNmae actResult:(double)actResult date:(NSString *)date
{

    self.actResultsLabel.text = [NSString stringWithFormat:@"%@的评估结果: %@",patienNmae,actResult == 1?@"完全控制":actResult == 2?@"部分控制":@"未控制"];
    
    NSArray *arrar = [self.actResultsLabel.text componentsSeparatedByString:@":"];
    NSString *str1 = arrar[0];
    
    UIColor *color;
    if (actResult == 1) {
        color = [UIColor colorWithHexString:@"#42b1ff"];
    }else if (actResult == 2)
    {
        color = [UIColor orangeColor];
    }else
    {
        color = [UIColor redColor];
    }
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:self.actResultsLabel.text];
    [string addAttributes:@{NSForegroundColorAttributeName:color} range:NSMakeRange(str1.length+1,self.actResultsLabel.text.length-str1.length-1)];
    self.actResultsLabel.attributedText = string;
    
    self.timeLabel.text = [NSString stringWithFormat:@"评估时间 %@",date];
    
    NSString *imageName = [NSString stringWithFormat:@"0%@_act_",kNSNumDouble(actResult)];
    self.starImageView.image = kImage(imageName);

    


}
//- (void)setModel:(LWACTModel *)model
//{
//    _model = model;
//    // 完全控制 2部分控制 3未控制
//    self.actResultsLabel.text = [NSString stringWithFormat:@"你的评估结果: %@",model.actResult == 1?@"完全控制":model.actResult == 2?@"部分控制":@"未控制"];
//    
//    NSArray *arrar = [self.actResultsLabel.text componentsSeparatedByString:@":"];
//    NSString *str1 = arrar[0];
//    
//    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:self.actResultsLabel.text];
//    [string addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#42b1ff"]} range:NSMakeRange(str1.length+1,self.actResultsLabel.text.length-str1.length-1)];
//    self.actResultsLabel.attributedText = string;
//    
//    self.timeLabel.text = [NSString stringWithFormat:@"评估时间 %@",model.insertDt];
//    
//    NSString *imageName = [NSString stringWithFormat:@"0%ld_act_",model.actResult];
//    self.starImageView.image = kImage(imageName);
//    
//    
//}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
