//
//  KLPEFItmLineView.h
//  BreatheDoctor
//
//  Created by comv on 16/3/28.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWPEFLineView.h"
#import "LWLineButton.h"
@interface KLPEFItmLineView : LWPEFLineView


@property (nonatomic, copy) void(^choosItmButtonClickBlock)(LWLineButton *sender);

/**
 *  @author li_yong
 *
 *  构建方法
 *
 *  @param dataSource  数据源
 *  @param color       折线点和折线的颜色
 *  @param isAnimation 是否动态绘制
 *
 *  @return
 */
- (id)initWithDataSource:(NSMutableArray *)dataSource
   withLineAndPointColor:(UIColor *)color
           withAnimation:(BOOL)isAnimation withFram:(CGRect)rect;

@end
