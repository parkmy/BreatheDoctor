//
//  BaseChartView.m
//  DrawTool
//
//  Created by li_yong on 15/7/9.
//  Copyright (c) 2015年 li_yong. All rights reserved.
//

#import "LWBaseChartView.h"
#import "CoordinateItem.h"
#import "NSDate+Extension.h"

@interface LWBaseChartView()
@property (nonatomic, strong) NSMutableArray *yerLabels;

@end

@implementation LWBaseChartView

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
        
        NSInteger weeks = [[NSDate date] daysInMonth];
        
        CGFloat W = self.frame.size.width/(weeks/7+1);
        
        self.dashedSpace = (CGFloat)(rect.size.width - 2*MARGIN_TOP)/(weeks/7+1);

        NSDate *lastday = [[NSDate date] lastdayOfMonth];
        NSDate *beginday = [[NSDate date] begindayOfMonth];
        NSMutableArray *dateArray = [NSMutableArray arrayWithCapacity:weeks];
        [dateArray addObject:beginday];
        for (int a = 1; a < (weeks/7); a++)
        {
            [dateArray addObject:[beginday dateAfterDay:a*7]];
        }
        [dateArray addObject:lastday];
        
        //4.设置横坐标值
        for (int index = 0; index<dateArray.count; index++)
        {
            CGPoint centerPoint = CGPointMake(MARGIN_LEFT + W * index, self.frame.size.height - MARGIN_TOP/2 - 4);
            CGRect bounds = CGRectMake(0, 0, W, 15);
            //        CoordinateItem *item = [self.dataSource objectAtIndex:index];
            NSDate *yer = dateArray[index];
            
            UILabel *xNumber = [self createLabelWithCenter:centerPoint
                                                withBounds:bounds
                                                  withText:[yer stringWithFormat:@"MM/dd"]
                                                 withColor:nil
                                         withtextAlignment:NSTextAlignmentCenter];
            [self addSubview:xNumber];
            [self.yerLabels addObject:xNumber];
        }
        
        
        
        //3.设置纵坐标值
        self.maxYValue = [self compareForMaxValue];
        self.yNumberSpace = self.maxYValue/Y_SECTION;
        for (int index = 0; index<Y_SECTION+1; index++)
        {
            CGPoint centerPoint = CGPointMake(MARGIN_LEFT/2, MARGIN_TOP + (self.height/4) * index);
            CGRect bounds = CGRectMake(0, 0, MARGIN_LEFT - 10, 15);
            if (index <= 2) {
                NSString *labelText;
                UIColor *color ;
                if (index == 2) {
                    labelText = @"完全控制";
                    color = [UIColor colorWithRed:86/255.0 green:195/255.0 blue:39/255.0 alpha:1];
                    
                }else if (index == 1)
                {
                    labelText = @"部分控制";
                    color = [UIColor colorWithRed:248/255.0 green:131/255.0 blue:9/255.0 alpha:1];
                }else
                {
                    labelText = @"未控制";
                    color = [UIColor colorWithRed:243/255.0 green:24/255.0 blue:23/255.0 alpha:1];
                }
                UILabel *yNumber = [self createLabelWithCenter:centerPoint
                                                    withBounds:bounds
                                                      withText:labelText
                                                     withColor:color
                                             withtextAlignment:NSTextAlignmentRight];
                [self addSubview:yNumber];
                
            }
            
        }

        
        
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 20)];
        titleLabel.centerX = 10+MARGIN_LEFT;
        titleLabel.centerY  = 10;
        titleLabel.text = @"ACT评估";
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.textColor = [UIColor grayColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
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
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
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
                       CGPointMake(MARGIN_LEFT, self.frame.size.height - MARGIN_TOP),
                    CGPointMake(self.width-10 , self.frame.size.height - MARGIN_TOP)
    };
    CGContextAddLines(currentCtx,poins,3);
//    CGContextClosePath(currentCtx);
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
    
    //设置虚线属性
    CGFloat lengths[2] = {5,5};
    CGContextSetLineDash(currentCtx, 0, lengths, 1);
    for(int index = 0; index<Y_SECTION; index++)
    {
        CGContextMoveToPoint(currentCtx, MARGIN_LEFT, MARGIN_TOP + (self.height/4) * index);
        CGContextAddLineToPoint(currentCtx, self.frame.size.width-20, MARGIN_TOP + (self.height/4) * index);
    }
    CGContextStrokePath(currentCtx);
    
    
    NSInteger weeks = [[NSDate date] daysInMonth];
    
    CGFloat W = self.frame.size.width/(weeks/7+1);
    //设置虚线属性
    CGContextSetLineDash(currentCtx, 0, lengths, 1);
    for(int index = 1; index<(weeks/7)+1; index++)
    {
        CGContextMoveToPoint(currentCtx, W * index +MARGIN_LEFT, self.frame.size.height-MARGIN_TOP);
        
        CGContextAddLineToPoint(currentCtx, W * index + MARGIN_LEFT, self.frame.size.height-MARGIN_TOP+10);
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
                         withColor:(UIColor *)color
                 withtextAlignment:(NSTextAlignment)textAlignment
{
    UILabel *label = [[UILabel alloc] init];
    label.center = centerPoint;
    label.bounds = bounds;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor grayColor];
    if (color) {
        label.textColor = color;
    }
    label.font = [UIFont systemFontOfSize:10];
    label.textAlignment = textAlignment;
    label.text = labelText;
    
    return label;
}

- (void)changeMonthLabes:(NSDate *)date
{
    if (self.yerLabels.count <= 0) {
        return;
    }
    NSInteger weeks = [date daysInMonth];

    NSDate *lastday = [date lastdayOfMonth];
    NSDate *beginday = [date begindayOfMonth];
    NSMutableArray *dateArray = [NSMutableArray arrayWithCapacity:5];
    [dateArray addObject:beginday];
    for (int a = 1; a < (weeks/7); a++)
    {
        [dateArray addObject:[beginday dateAfterDay:a*7]];
    }
    [dateArray addObject:lastday];

    for (int i = 0; i < self.yerLabels.count; i++) {
        UILabel *label = self.yerLabels[i];
        NSDate *yer = dateArray[i];
        label.text = [yer stringWithFormat:@"MM/dd"];
    }
}

@end
