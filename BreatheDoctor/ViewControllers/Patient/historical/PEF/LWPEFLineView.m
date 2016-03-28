//
//  LWPEFLineView.m
//  BreatheDoctor
//
//  Created by comv on 16/3/22.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWPEFLineView.h"
#import "CoordinateItem.h"
#import "NSDate+Extension.h"
#import "LWHistoricalCountModel.h"

@interface LWPEFLineView()
@property (nonatomic, strong) NSMutableArray *monthLabels;
@property (nonatomic, strong) NSMutableArray *yNumbers;
@property (nonatomic, strong) NSMutableArray *morningEveningArray;
@end

@implementation LWPEFLineView

- (id)initWithDataSource:(NSMutableArray *)dataSource withFram:(CGRect)rect
{
    self = [super initWithFrame:rect];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        
        self.dataSource = dataSource;
        
        for (int index = 0; index<3; index++)
        {
            CGPoint centerPoint = CGPointMake(0, 0);
            CGRect bounds = CGRectMake(0, 0, 0, 0);
            //            NSString *labelText = @"800";
            UILabel *yNumber = [self createLabelWithCenter:centerPoint
                                                withBounds:bounds
                                                  withText:@""
                                         withtextAlignment:NSTextAlignmentRight];
            [self addSubview:yNumber];
            [self.yNumbers addObject:yNumber];
            
        }
        
        
        for(int index = 1; index<14; index++)
        {
            
            CGPoint centerPoint = CGPointMake(0, 0);
            CGRect bounds = CGRectMake(0, 0, 0, 0);
            if (index%2 == 1){
                UILabel *xNumber = [self createLabelWithCenter:centerPoint
                                                    withBounds:bounds
                                                      withText:@"0/0"
                                             withtextAlignment:NSTextAlignmentCenter];
                [self.monthLabels addObject:xNumber];
                [self addSubview:xNumber];
            }
            
        }
        
        for(int index = 1; index<15; index++)
        {
            
            CGPoint centerPoint = CGPointMake(0, 0);
            CGRect bounds = CGRectMake(0, 0, 0, 0);
            NSString *str = index%2 == 1?@"早":@"晚";
            UILabel *xNumber = [self createLabelWithCenter:centerPoint
                                                withBounds:bounds
                                                  withText:str
                                         withtextAlignment:NSTextAlignmentCenter];
            [self addSubview:xNumber];
            [self.morningEveningArray addObject:xNumber];
        }
        
    }
    return self;
}
- (void)layoutSubviews
{
    //3.设置纵坐标值
    self.maxYValue = 800;
    self.yNumberSpace = self.maxYValue/10;
    self.dashedSpace = (CGFloat)(self.width - MARGIN_LEFT-5)/14;
    CGFloat dash = (self.height - MARGIN_TOP*2)/10;
    CGFloat spa = (self.frame.size.height - MARGIN_TOP*2)/800;

    for (int i = 0; i < self.morningEveningArray.count; i++)
    {
        UIView *view = self.morningEveningArray[i];
        CGPoint centerPoint = CGPointMake(MARGIN_LEFT + self.dashedSpace*i+self.dashedSpace/2,  MARGIN_TOP/2 + 5);
        CGRect bounds = CGRectMake(0, 0, self.dashedSpace, 15);
        view.bounds = bounds;
        view.center = centerPoint;
    }
    
    for (int i = 0; i < self.monthLabels.count; i++)
    {
        UIView *view = self.monthLabels[i];
        CGPoint centerPoint = CGPointMake(MARGIN_LEFT + self.dashedSpace*i*2+self.dashedSpace, self.height - MARGIN_TOP/2 - 4);
        CGRect bounds = CGRectMake(0, 0, self.dashedSpace, 15);
        view.bounds = bounds;
        view.center = centerPoint;
    }
    
    for (int i = 0; i < self.yNumbers.count; i++) {
        UILabel *label = self.yNumbers[i];
        CGPoint centerPoint = CGPointMake(MARGIN_LEFT/2, MARGIN_TOP + dash * i);
        CGRect bounds = CGRectMake(0, 0, MARGIN_LEFT - 10, 15);
        label.bounds = bounds;
        label.center = centerPoint;
        CGFloat y = self.frame.size.height - (MARGIN_TOP + [stringJudgeNull(label.text)  integerValue]*spa);
        label.yCenter = y;
    }
}

- (UILabel *)createLabelWithCenter:(CGPoint)centerPoint
                        withBounds:(CGRect)bounds
                          withText:(NSString *)labelText
                 withtextAlignment:(NSTextAlignment)textAlignment
{
    UILabel *label = [[UILabel alloc] init];
    label.adjustsFontSizeToFitWidth = YES;
    label.center = centerPoint;
    label.bounds = bounds;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor grayColor];
    label.font = kNSPXFONT(20);
    label.textAlignment = textAlignment;
    label.text = labelText;
    
    return label;
}
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    //绘制坐标系
    [self drawCoordinate];
}
- (void)drawCoordinate
{
    CGContextRef currentCtx = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(currentCtx, [[UIColor grayColor] CGColor]);
    CGContextSetLineWidth(currentCtx, 0.5);
    
    //1.绘制X轴和y轴
    //第一种方法绘制四条线
    CGPoint poins[] = {CGPointMake(MARGIN_LEFT, MARGIN_TOP),
        CGPointMake(self.frame.size.width -5, MARGIN_TOP),
        CGPointMake(self.frame.size.width -5, self.frame.size.height - MARGIN_TOP),
        CGPointMake(MARGIN_LEFT, self.frame.size.height - MARGIN_TOP)};
    CGContextAddLines(currentCtx,poins,4);
    CGContextClosePath(currentCtx);
    CGContextStrokePath(currentCtx);
    
    /*
     //第二种方法绘制一个矩形
     CGContextMoveToPoint(currentCtx, MARGIN_LEFT, MARGIN_TOP);
     CGContextSetLineWidth(currentCtx, 0.1);
     CGContextSetRGBStrokeColor(currentCtx, 0.5, 0.5, 0.5, 1);
     CGContextAddRect(currentCtx, CGRectMake(MARGIN_LEFT, MARGIN_TOP, self.frame.size.width - 2*MARGIN_LEFT, self.frame.size.height - 2*MARGIN_TOP));
     CGContextClosePath(currentCtx);
     CGContextStrokePath(currentCtx);
     */
    
    //2.绘制虚线(暂时设置纵坐标分5个区间)
    //虚线间距
    self.dashedSpace = (CGFloat)(self.width - MARGIN_LEFT-5)/14;
    CGFloat dash = (self.frame.size.height - MARGIN_TOP*2)/10;
    //设置虚线属性
    CGFloat lengths[2] = {1,1};
    CGContextSetLineDash(currentCtx, 0, lengths, 1);
    for(int index = 1; index<10; index++)
    {
        CGContextMoveToPoint(currentCtx, MARGIN_LEFT, MARGIN_TOP + dash * index);
        CGContextAddLineToPoint(currentCtx, self.frame.size.width - 5, MARGIN_TOP + dash * index);
    }
    CGContextStrokePath(currentCtx);
    
    
    for(int index = 1; index<14; index++)
    {
        CGContextMoveToPoint(currentCtx, self.dashedSpace * index +MARGIN_LEFT, self.frame.size.height-MARGIN_TOP);
        
        CGContextAddLineToPoint(currentCtx, self.dashedSpace * index + MARGIN_LEFT, MARGIN_TOP);
    }
    CGContextStrokePath(currentCtx);
    
}

- (NSMutableArray *)monthLabels
{
    if (!_monthLabels) {
        _monthLabels = [NSMutableArray array];
    }
    return _monthLabels;
}
- (NSMutableArray *)yNumbers
{
    if (!_yNumbers) {
        _yNumbers = [NSMutableArray array];
    }
    return _yNumbers;
}
- (NSMutableArray *)morningEveningArray
{
    if (!_morningEveningArray) {
        _morningEveningArray = [NSMutableArray array];
    }
    return _morningEveningArray;
}

- (void)changeYnumber:(double)pefPredictedValue
{
    NSString *number1 = kNSString(kNSNumDouble(pefPredictedValue));
    NSString *number2 = kNSString(kNSNumInteger(pefPredictedValue*.8));
    NSString *number3 = kNSString(kNSNumInteger(pefPredictedValue*.6));
    
    //    CGFloat dash = (self.frame.size.height - MARGIN_TOP*2)/10;
    
    CGFloat spa = (self.frame.size.height - MARGIN_TOP*2)/800;
    
    for (int i = 0; i < self.yNumbers.count; i++) {
        UILabel *label = self.yNumbers[i];
        CGFloat Y;
        if (i == 0) {
            label.text = number1;
            label.textColor = [LWHistoricalCountModel normalColor];
            Y = self.frame.size.height - (MARGIN_TOP + [number1 integerValue]*spa);
            
        }else if (i == 1)
        {
            label.text = number2;
            label.textColor = [LWHistoricalCountModel abnormalColor];
            Y = self.frame.size.height - (MARGIN_TOP + [number2 integerValue]*spa);
            
        }else
        {
            label.text = number3;
            label.textColor = [LWHistoricalCountModel warningColor];
            Y = self.frame.size.height - (MARGIN_TOP + [number3 integerValue]*spa);
        }
        label.yCenter = Y;
    }
}
/**
 *  改变时间列表的展示（以当前时间倒退）
 *
 *  @param dateCount 时间间区  7 14 30
 */
- (void)changeDateList:(NSInteger)dateCount{
    
    NSDate *nowDate = [NSDate date];
    
    NSMutableArray *array = [NSMutableArray array];
    if (dateCount == 7)
    {
        for (int i = 0; i < 7; i++) {
            [array addObject:[nowDate offsetDays:-i]];
        }
    }else if (dateCount == 14)
    {
        for (int i = 0; i < 7; i++) {
            [array addObject:[nowDate offsetDays:(-i)*2]];
        }
    }else if (dateCount == 30)
    {
        for (int i = 0; i < 7; i++) {
            [array addObject:[nowDate offsetDays:(-i)*5]];
        }
    }
    
    array = (NSMutableArray *)[[array reverseObjectEnumerator] allObjects];
    
    for (int a = 0; a < self.monthLabels.count; a++) {
        UILabel *label = self.monthLabels[a];
        NSDate *date = [array rewriteObjectAtIndex:a];
        label.text = [date stringWithFormat:@"MM/dd"];
    }
}

- (NSMutableArray *)getItms:(KLPatientLogBodyModel *)body
{
    if (body.recordList.count <= 0) {
        return nil;
    }
    
    NSInteger number2 = body.pefPredictedValue*.8;
    NSInteger number3 = body.pefPredictedValue*.6;
    
    NSMutableArray *array = [NSMutableArray array];
    @autoreleasepool {
 
        for (int monthCount = 0; monthCount < self.monthLabels.count; monthCount++)
        {
            
            UILabel *month = self.monthLabels[monthCount];
            
            for (int i = 0; i < body.recordList.count; i++)
            {
                
                KLPatientLogModel *model = body.recordList[i];
                NSString *recordDate = [[NSDate dateWithString:model.recordDt format:[NSDate ymdFormat]] stringWithFormat:@"MM/dd"];
                
                if ([recordDate isEqualToString:month.text] && model.pefValue > 0)
                {
                    CoordinateItem *itm = [[CoordinateItem alloc] init];

                    itm.logModel = model;
                    if (model.timeFrame == 1) {//早上
                        itm.isMorning = YES;
                    }else
                    {
                        itm.isMorning = NO;
                    }
                    
                    if (model.pefValue >= number2) {
                        itm.itemColor = [LWHistoricalCountModel normalColor];
                    }else if (model.pefValue >= number3 && model.pefValue < number2)
                    {
                        itm.itemColor = [LWHistoricalCountModel abnormalColor];
                    }else
                    {
                        itm.itemColor = [LWHistoricalCountModel warningColor];
                    }
                    
                    itm.coordinateYValue = [NSString stringWithFormat:@"%@",kNSNumDouble(model.pefValue)];
                    itm.coordinateXValue = kNSString(kNSNumInteger(monthCount));
                    [array addObject:itm];                 
                }
            }
            
        }
        
        
    }
    
    
    
    
    
//    //排序下
//    [array sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
//        
//        CoordinateItem *model1 = obj1;
//        CoordinateItem *model2 = obj2;
//        if ([model1.coordinateXValue integerValue] < [model2.coordinateXValue integerValue]) {
//            return (NSComparisonResult)NSOrderedDescending;
//        }
//        return (NSComparisonResult)NSOrderedSame;
//    }];
    return array;
}

@end
