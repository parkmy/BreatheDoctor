//
//  LWPEFLineCell.m
//  BreatheDoctor
//
//  Created by comv on 15/11/25.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWPEFLineCell.h"
#import "CoordinateItem.h"
#import "NSDate+Extension.h"


@interface LWPEFLineCell ()

@end
@implementation LWPEFLineCell


- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor whiteColor];

}

- (void)setModel:(LWPEFLineModel *)model
{
    _model = model;

    NSMutableArray *array = [self getItms:_model];
    self.PEFLineView.lineChartView.dataSource = array;
    [self.PEFLineView.lineChartView setNeedsDisplay];
    
}

- (NSMutableArray *)getItms:(LWPEFLineModel *)model
{
    if (model.body.recordList.count <= 0) {
        return nil;
    }

    NSInteger number2 = model.body.pefPredictedValue*.8;
    NSInteger number3 = model.body.pefPredictedValue*.6;
    
    NSMutableArray *array = [NSMutableArray array];
    @autoreleasepool {
        
        for (int i = 0; i < model.body.recordList.count; i++)
        {
            
            LWPEFRecordList *record = model.body.recordList[i];
            
            CoordinateItem *itm = [[CoordinateItem alloc] init];
            itm.record = record;
            if (record.timeFrame == 1) {//早上
                itm.isMorning = YES;
            }else
            {
                itm.isMorning = NO;
            }
            if (record.pefValue >= number2) {
                itm.itemColor = [UIColor colorWithRed:160/255.0 green:219/255.0 blue:28/255.0 alpha:1];
            }else if (record.pefValue >= number3 && record.pefValue < number2)
            {
                itm.itemColor = [UIColor orangeColor];
            }else
            {
                itm.itemColor = [UIColor redColor];
            }
            itm.coordinateYValue = [NSString stringWithFormat:@"%@",kNSNumDouble(record.pefValue)];
            itm.coordinateXValue = kNSString(kNSNumInteger([self chajitian:record.recordDt]));
            [array addObject:itm];
        }
        
    }
    
    //排序下
    [array sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        
        CoordinateItem *model1 = obj1;
        CoordinateItem *model2 = obj2;
        if ([model1.coordinateXValue integerValue] < [model2.coordinateXValue integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    return array;
}

- (NSInteger)chajitian:(NSString *)date
{
    NSDate *objcDate = [NSDate dateWithString:date format:[NSDate ymdFormat]];
    NSDate *imDate  = [NSDate dateWithString:[LWPublicDataManager shareInstance].starDate format:[NSDate ymdFormat]];
    NSTimeInterval time=[objcDate timeIntervalSinceDate:imDate];
    
    int days=((int)time)/(3600*24);
//    int hours=((int)time)%(3600*24)/3600;
//    NSString *dateContent=[[NSString alloc] initWithFormat:@"%i天%i小时",days,hours];
    return days;
}

- (void)changeYnumbers:(double)pefPredictedValue
{
//    self.PEFLineView.lineChartView.maxYValue = pefPredictedValue;
    [self.PEFLineView.lineChartView changeYnumber:pefPredictedValue];

}
- (void)changeTimerMonth:(NSString *)star end:(NSString *)end
{
    [self.PEFLineView.lineChartView changeMonthLabes:star EndDate:end];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
