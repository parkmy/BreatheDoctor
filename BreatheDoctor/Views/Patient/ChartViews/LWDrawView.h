//
//  DrawView.h
//  DrawTool
//
//  Created by li_yong on 15/7/9.
//  Copyright (c) 2015年 li_yong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWLineChartView.h"


@interface LWDrawView : UIScrollView


//是否动态绘制
@property (assign, nonatomic) BOOL isAnimation;
@property (nonatomic, strong) LWLineChartView *lineChartView;
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
//- (id)initWithFrame:(CGRect)frame
//     withDataSource:(NSMutableArray *)dataSource
//      withAnimation:(BOOL)isAnimation;

@end
