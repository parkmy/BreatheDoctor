//
//  LWPEFCountCell.m
//  BreatheDoctor
//
//  Created by comv on 15/11/25.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWPEFCountCell.h"

@implementation LWPEFCountCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = RGBA(245, 245, 245, 1);
    for (int i = 0; i < self.contentLabels.count; i++) {
        UILabel *label = self.contentLabels[i];
        [label setCornerRadius:label.width/2];
        label.layer.borderWidth = .5;
        if (i == 0) {
            label.text = [NSString stringWithFormat:@"0次"];
            label.layer.borderColor = RGBA(58, 175, 154, 1).CGColor;
            label.textColor = RGBA(58, 175, 154, 1);
        }else if (i == 1)
        {
            label.text = @"0";
            label.layer.borderColor = RGBA(166, 225, 35, 1).CGColor;
            label.textColor = RGBA(166, 225, 35, 1);

        }else
        {
            label.text = @"0";
            label.layer.borderColor = RGBA(234, 38, 19, 1).CGColor;
            label.textColor = RGBA(234, 38, 19, 1);
        }
    }
}

- (void)setModel:(LWPEFLineModel *)model
{
    _model = model;
    
    if (!_model) {
        return;
    }
    NSInteger count = _model.body.recordList.count; //次数
    
    NSString *max = @"0";
    NSString *min = @"0";
    
    if (count > 0) {
        NSMutableArray *array = [NSMutableArray arrayWithArray:_model.body.recordList];

        [array sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            LWPEFRecordList *model1 = obj1;
            LWPEFRecordList *model2 = obj2;
            if (model1.pefValue < model2.pefValue) {
                return (NSComparisonResult)NSOrderedDescending;
            }
            return (NSComparisonResult)NSOrderedSame;
        }];
        
        LWPEFRecordList *model1 = [array lastObject];
        min = [NSString stringWithFormat:@"%@",kNSNumDouble(model1.pefValue)];
        
        LWPEFRecordList *model2 = [array firstObject];
        max = [NSString stringWithFormat:@"%@",kNSNumDouble(model2.pefValue)];

    }
    
    for (int i = 0; i < self.contentLabels.count; i++) {
        UILabel *label = self.contentLabels[i];
        if (i == 0) {
            label.text = [NSString stringWithFormat:@"%ld次",count];
        }else if (i == 1)
        {
            label.text = max;
        }else
        {
            label.text = min;
        }
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
