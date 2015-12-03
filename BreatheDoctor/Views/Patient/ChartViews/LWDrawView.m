//
//  DrawView.m
//  DrawTool
//
//  Created by li_yong on 15/7/9.
//  Copyright (c) 2015年 li_yong. All rights reserved.
//

#import "LWDrawView.h"
#import "CoordinateItem.h"


#define MARGIN_BETWEEN_X_POINT 50   //X轴的坐标点的间距
#define MAX_POINT_WITHIN_SCREEN 6   //一屏幕最多容纳的坐标数

@interface LWDrawView()

//数据源
@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation LWDrawView

/**
 *  @author li_yong
 *
 *  构造方法
 *
 *  @param frame      frame
 *  @param dataSource 数据源
 *  @param type       绘图类型
 *  @isAnimation      是否动态绘制
 *
 *  @return
 */
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        self.autoresizesSubviews = NO;
        //根据数据源设置图形的尺寸
        [self sizeForDataSource];
        //折线图
        _lineChartView = [[LWLineChartView alloc] initWithDataSource:self.dataSource
                                                               withLineAndPointColor:RGBA(248, 131, 9, 1)
                                                                       withAnimation:self.isAnimation withFram:CGRectMake(0, 0, self.contentSize.width, self.contentSize.height)];
        [self addSubview:_lineChartView];
    }
    return self;
}
/**
 *  @author li_yong
 *
 *  根据数据源设置图形的尺寸
 */
- (void)sizeForDataSource
{
    //根据数据源的个数设置DrawView的内容Size
    NSUInteger valueCount = [self.dataSource count];
    if (valueCount > MAX_POINT_WITHIN_SCREEN)
    {
        self.contentSize = CGSizeMake(self.frame.size.width + (valueCount - MAX_POINT_WITHIN_SCREEN) * MARGIN_BETWEEN_X_POINT, self.frame.size.height);
    }else
    {
        self.contentSize = CGSizeMake(Screen_SIZE.width, self.frame.size.height);
    }
}

@end
