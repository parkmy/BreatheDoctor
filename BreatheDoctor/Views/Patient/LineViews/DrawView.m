//
//  DrawView.m
//  DrawTool
//
//  Created by li_yong on 15/7/9.
//  Copyright (c) 2015年 li_yong. All rights reserved.
//

#import "DrawView.h"


#define MARGIN_BETWEEN_X_POINT 50   //X轴的坐标点的间距
#define MAX_POINT_WITHIN_SCREEN 15   //一屏幕最多容纳的坐标数

@interface DrawView()

//数据源
@property (strong, nonatomic) NSMutableArray *dataSource;
@end

@implementation DrawView

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
- (id)initWithFrame:(CGRect)frame
     withDataSource:(NSMutableArray *)dataSource
      withAnimation:(BOOL)isAnimation
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.autoresizesSubviews = NO;
        self.dataSource = [NSMutableArray arrayWithArray:dataSource];
        self.isAnimation = isAnimation;
        
        //根据数据源设置图形的尺寸
        [self sizeForDataSource];
        
        //折线图
        _lineChartView = [[LineChartView alloc] initWithDataSource:self.dataSource
                                                           withLineAndPointColor:[UIColor colorWithRed:160/255.0 green:219/255.0 blue:28/255.0 alpha:1]
                                                                   withAnimation:self.isAnimation withFram:CGRectMake(0, 0, self.contentSize.width, self.contentSize.height)];
        [self addSubview:_lineChartView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.autoresizesSubviews = NO;
        self.backgroundColor = [UIColor whiteColor];

        //根据数据源设置图形的尺寸
        [self sizeForDataSource];
        
        //折线图
        _lineChartView = [[LineChartView alloc] initWithDataSource:self.dataSource
                                                           withLineAndPointColor:[UIColor colorWithRed:160/255.0 green:219/255.0 blue:28/255.0 alpha:1]
                                                                   withAnimation:self.isAnimation withFram:CGRectMake(0, 0, self.contentSize.width, self.contentSize.height)];
        _lineChartView.frame = CGRectMake(0, 10, self.contentSize.width, self.contentSize.height);
        __weak typeof(self) weakSelf = self;
        [_lineChartView setChoosItmButtonClickBlock:^(LWLineButton *sender) {
            if (weakSelf.drawViewdelegate && [weakSelf.drawViewdelegate respondsToSelector:@selector(chooseItmButtonClick:)]) {
                [weakSelf.drawViewdelegate chooseItmButtonClick:sender];
            }
        }];
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
        self.contentSize = CGSizeMake(MAX_POINT_WITHIN_SCREEN * MARGIN_BETWEEN_X_POINT-12, self.frame.size.height);
    }
}

@end
