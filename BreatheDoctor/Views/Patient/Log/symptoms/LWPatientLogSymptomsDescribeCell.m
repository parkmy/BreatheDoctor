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
    
    self.timerLabel.text = _model.insertDt;
    
    for (UIView *view in self.labelArray) {
            [view removeFromSuperview];
        }
    [self.labelArray removeAllObjects];
    
    self.labelArray = [LWTool LoglabelsCount:model];
    
    CGFloat w = 10;
    CGFloat h = 30/2 + 10;
    for (int i = 0; i < self.labelArray.count; i++) {
        
        UILabel *label = (UILabel *)self.labelArray[i];
        [label setCornerRadius:label.height/2];
        [self.centerView addSubview:label];
        label.xCenter = w + label.width/2;
        label.yCenter = h;
        w = label.maxX + 20;

        UILabel *label2 ;
        if ((i+1) < self.labelArray.count) {
            label2 = self.labelArray[i+1];
        }
        CGFloat wid = label2.width;
        if ((w + wid) >= Screen_SIZE.width-20) {
            w = 10;
            h = 30/2 + 10 + 30 +10;
        }
        
    }
    if (h == 30/2 + 10 + 30 +10) {
        _model.rowHight = 170;
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
