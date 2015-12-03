//
//  DrawView.h
//  DrawTool
//
//  Created by li_yong on 15/7/9.
//  Copyright (c) 2015年 li_yong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoordinateItem.h"
#import "LineChartView.h"
#import "LWLineButton.h"

@protocol DrawViewDelegate <NSObject>
@optional
- (void)chooseItmButtonClick:(LWLineButton *)sender;
@end


@interface DrawView : UIScrollView

@property (nonatomic, strong) LineChartView *lineChartView;
@property (nonatomic, assign) id<DrawViewDelegate>drawViewdelegate;
//是否动态绘制
@property (assign, nonatomic) BOOL isAnimation;

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
      withAnimation:(BOOL)isAnimation;

@end
