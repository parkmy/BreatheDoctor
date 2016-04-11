//
//  LWScrollMenuView.h
//  BreatheDoctor
//
//  Created by comv on 16/3/16.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWScrollMenuView : UIScrollView<UIScrollViewDelegate>
/**
 *  滑动到第几个界面
 */
@property (nonatomic, copy) void(^scrollViewDidEndDeceleratingBlock)(NSInteger index);
/**
 *  切换界面
 *
 *  @param array 界面数组
 *
 *  @return 对象
 */
- (id)initWithContentViews:(NSArray *)array;
/**
 *  设置跳转界面
 *
 *  @param index 第几个界面
 */
- (void)setscrollViewIndex:(NSInteger)index;
@end
