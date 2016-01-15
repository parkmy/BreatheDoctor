//
//  BaseChartView.m
//  DrawTool
//
//  Created by li_yong on 15/7/9.
//  Copyright (c) 2015年 li_yong. All rights reserved.
//

#import "BaseChartView.h"
#import "CoordinateItem.h"
#import "NSDate+Extension.h"

@interface BaseChartView()
@property (nonatomic, strong) NSMutableArray *yerLabels;
@property (nonatomic, strong) NSMutableArray *yNumbers;
@end

@implementation BaseChartView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
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
        CGPointMake(self.frame.size.width - MARGIN_LEFT, MARGIN_TOP),
        CGPointMake(self.frame.size.width - MARGIN_LEFT, self.frame.size.height - MARGIN_TOP),
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
    self.dashedSpace = (CGFloat)(self.width - 2*MARGIN_LEFT)/14;
    CGFloat dash = (self.frame.size.height - MARGIN_TOP*2)/10;
    //设置虚线属性
    CGFloat lengths[2] = {5,5};
    CGContextSetLineDash(currentCtx, 0, lengths, 1);
    for(int index = 1; index<10; index++)
    {
        CGContextMoveToPoint(currentCtx, MARGIN_LEFT, MARGIN_TOP + dash * index);
        CGContextAddLineToPoint(currentCtx, self.frame.size.width - MARGIN_LEFT, MARGIN_TOP + dash * index);
    }
    CGContextStrokePath(currentCtx);
    

    for(int index = 1; index<14; index++)
    {
        CGContextMoveToPoint(currentCtx, self.dashedSpace * index +MARGIN_LEFT, self.frame.size.height-MARGIN_TOP);
        
        CGContextAddLineToPoint(currentCtx, self.dashedSpace * index + MARGIN_LEFT, MARGIN_TOP);
    }
    CGContextStrokePath(currentCtx);
    
    
    

    
    
}

/**
 *  @author li_yong
 *
 *  获取最大的纵坐标值
 */
- (int)compareForMaxValue
{
    __block int maxYValue = 0;
    //获取最大的纵坐标值
    [self.dataSource enumerateObjectsUsingBlock:^(CoordinateItem *obj, NSUInteger idx, BOOL *stop) {
        if ([obj.coordinateYValue intValue] > maxYValue)
        {
            maxYValue = [obj.coordinateYValue intValue];
        }
    }];
    //获取最大的纵坐标值整数
    if((maxYValue % Y_SECTION) != 0)
    {
        maxYValue = maxYValue + (Y_SECTION - maxYValue % Y_SECTION);
    }
    return maxYValue;
}

/**
 *  @author li_yong
 *
 *  UILabel的工厂方法
 *
 *  @param centerPoint   label的中心
 *  @param bounds        label的大小
 *  @param labelText     label的内容
 *  @param textAlignment label的内容排版方式
 *
 *  @return
 */
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
    label.font = [UIFont systemFontOfSize:10];
    label.textAlignment = textAlignment;
    label.text = labelText;
    
    return label;
}

/**
 *  @author li_yong
 *
 *  构造函数
 *
 *  @param dataSource 数据源
 *
 *  @return
 */


- (id)initWithDataSource:(NSMutableArray *)dataSource withFram:(CGRect)rect
{
    self = [super initWithFrame:rect];
    if (self)
    {
        self.dataSource = dataSource;
        
        //3.设置纵坐标值
        self.maxYValue = 800;
        self.yNumberSpace = self.maxYValue/10;
        self.dashedSpace = (CGFloat)(rect.size.width - 2*MARGIN_LEFT)/14;

        CGFloat dash = (rect.size.height - MARGIN_TOP*2)/10;

        
        for (int index = 0; index<3; index++)
        {
            CGPoint centerPoint = CGPointMake(MARGIN_LEFT/2, MARGIN_TOP + dash * index);
            CGRect bounds = CGRectMake(0, 0, MARGIN_LEFT - 10, 15);
            NSString *labelText = @"0";
            UILabel *yNumber = [self createLabelWithCenter:centerPoint
                                                withBounds:bounds
                                                  withText:labelText
                                         withtextAlignment:NSTextAlignmentRight];
            [self addSubview:yNumber];
            [self.yNumbers addObject:yNumber];
        
        }
        
        
        for(int index = 1; index<14; index++)
        {
            
            CGPoint centerPoint = CGPointMake(MARGIN_LEFT + self.dashedSpace * index, rect.size.height - MARGIN_TOP/2 - 4);
            CGRect bounds = CGRectMake(0, 0, self.dashedSpace, 15);
            //        CoordinateItem *item = [self.dataSource objectAtIndex:index];
            if (index%2 == 1){
                UILabel *xNumber = [self createLabelWithCenter:centerPoint
                                                        withBounds:bounds
                                                          withText:@"0/0"
                                                 withtextAlignment:NSTextAlignmentCenter];
                [self.yerLabels addObject:xNumber];
                [self addSubview:xNumber];
            }
            
        }
        
        for(int index = 1; index<15; index++)
        {
            
            CGPoint centerPoint = CGPointMake(MARGIN_LEFT/2 + self.dashedSpace * index+5,  MARGIN_TOP/2 + 5);
            CGRect bounds = CGRectMake(0, 0, self.dashedSpace, 15);
            //        CoordinateItem *item = [self.dataSource objectAtIndex:index];
            NSString *str = index%2 == 1?@"早":@"晚";
            UILabel *xNumber = [self createLabelWithCenter:centerPoint
                                                withBounds:bounds
                                                  withText:str
                                         withtextAlignment:NSTextAlignmentCenter];
            [self addSubview:xNumber];
            
        }
        
        
        
        UILabel *titleLabel = [self createLabelWithCenter:CGPointMake(40+MARGIN_LEFT, -5)
                                               withBounds:CGRectMake(0, 0, 80, 20)
                                                 withText:@"峰流速(PEF)表"
                                        withtextAlignment:NSTextAlignmentLeft];
        [self addSubview:titleLabel];

        
    }
    return self;
}
- (NSMutableArray *)yerLabels
{
    if (!_yerLabels) {
        _yerLabels = [NSMutableArray array];
    }
    return _yerLabels;
}
- (NSMutableArray *)yNumbers
{
    if (!_yNumbers) {
        _yNumbers = [NSMutableArray array];
    }
    return _yNumbers;
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
            label.textColor = [UIColor greenColor];
             Y = self.frame.size.height - (MARGIN_TOP + [number1 integerValue]*spa);
            
        }else if (i == 1)
        {
            label.text = number2;
            label.textColor = [UIColor orangeColor];
             Y = self.frame.size.height - (MARGIN_TOP + [number2 integerValue]*spa);
            
        }else
        {
            label.text = number3;
            label.textColor = [UIColor redColor];
             Y = self.frame.size.height - (MARGIN_TOP + [number3 integerValue]*spa);
        }
        label.yCenter = Y;
    }
}
- (void)changeMonthLabes:(NSString *)starDate EndDate:(NSString *)endDate
{
    if (self.yerLabels.count <= 0) {
        return;
    }
    NSMutableArray *array = [NSMutableArray array];
    NSDate *starTime = [NSDate dateWithString:starDate format:[NSDate ymdFormat]];
    NSString *star = [NSDate stringWithDate:starTime format:@"MM/dd"];
    [array addObject:star];
    for (int a = 1; a < 7; a++) {
        NSString *string = [NSDate stringWithDate:[NSDate dateAfterDate:starTime day:a] format:@"MM/dd"];
        [array addObject:string];
    }
    for (int i = 0; i < self.yerLabels.count; i++) {
        UILabel *label = self.yerLabels[i];
        label.text = array[i];
    }
}



@end
