//
//  LWAssessmentLineCell.m
//  BreatheDoctor
//
//  Created by comv on 15/11/27.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWAssessmentLineCell.h"
#import "CoordinateItem.h"
#import "NSDate+Extension.h"

@implementation LWAssessmentLineCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(LWAsthmaAssessLogModel *)model
{
    _model = model;
    
    NSMutableArray *array = [self getItms:_model];
    self.ACTlineView.lineChartView.dataSource = array;
    [self.ACTlineView.lineChartView setNeedsDisplay];
    
}
- (NSMutableArray *)getItms:(LWAsthmaAssessLogModel *)model
{
    if (model.body.count <= 0) {
        return nil;
    }
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < model.body.count; i++)
    {
        
        LWAsthmaAssessLogBody *body = model.body[i];
        if (body.controlLevelY == 0) {
            continue;
        }
        CoordinateItem *itm = [[CoordinateItem alloc] init];

        itm.coordinateYValue = [NSString stringWithFormat:@"%@",kNSNumDouble(body.controlLevelY)];
        itm.coordinateXValue = body.dateX;
        itm.itemColor = body.controlLevelY == 1?[UIColor colorWithRed:86/255.0 green:195/255.0 blue:39/255.0 alpha:1]:body.controlLevelY == 2?[UIColor colorWithRed:248/255.0 green:131/255.0 blue:9/255.0 alpha:1]:[UIColor colorWithRed:243/255.0 green:24/255.0 blue:23/255.0 alpha:1];
        [array addObject:itm];
    }
    [array sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        CoordinateItem *model1 = obj1;
        CoordinateItem *model2 = obj2;
        
        NSDate *time1 = [NSDate dateWithString:model1.coordinateXValue format:[NSDate ymdFormat]];
        NSDate *time2 = [NSDate dateWithString:model2.coordinateXValue format:[NSDate ymdFormat]];
        if ([time1 day] < [time2 day]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];

    return array;
}
- (void)changeTimerDate:(NSDate *)date
{
    [self.ACTlineView.lineChartView changeMonthLabes:date];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
