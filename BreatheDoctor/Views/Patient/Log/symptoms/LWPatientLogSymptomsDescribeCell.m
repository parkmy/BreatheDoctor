//
//  LWPatientLogSymptomsDescribeCell.m
//  BreatheDoctor
//
//  Created by comv on 15/11/22.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWPatientLogSymptomsDescribeCell.h"
#import "LWTool.h"

@interface LWPatientLogSymptomsDescribeCell ()

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UIView *centerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineHight;

@property (nonatomic, strong) NSMutableArray *labelArray;
@end
@implementation LWPatientLogSymptomsDescribeCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
    self.lineHight.constant = .5;
    [self.bgView setCornerRadius:5.0f];
}
- (NSMutableArray *)labelArray
{
    if (!_labelArray) {
        _labelArray = [NSMutableArray array];
    }
    return _labelArray;
}

- (void)setModel:(LWPEFRecordList *)model
{
    
    _model = model;
    
    self.timerLabel.text = _model.recordDt;
    
    for (UIView *view in self.labelArray) {
            [view removeFromSuperview];
        }
    [self.labelArray removeAllObjects];
    
    self.labelArray = [LWTool LoglabelsCount:model];
    
    CGFloat w = 0;
    CGFloat h = 30/2 + 10;
    for (int i = 0; i < self.labelArray.count; i++) {
        UILabel *label = (UILabel *)self.labelArray[i];
        [label setCornerRadius:label.height/2];
        [self.centerView addSubview:label];
        label.xCenter = w + label.width/2 ;
        label.yCenter = h;
        w = label.width + w + 20;
        if (i > 4) {
            w = 0;
            h = 30/2 + 10 + 30;
        }

    }
    if (self.labelArray.count > 3) {
        _model.rowHight = 150;
    }else
    {
        _model.rowHight = 130;
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
