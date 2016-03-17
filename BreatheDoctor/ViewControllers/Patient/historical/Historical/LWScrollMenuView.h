//
//  LWScrollMenuView.h
//  BreatheDoctor
//
//  Created by comv on 16/3/16.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWScrollMenuView : UIScrollView<UIScrollViewDelegate>

@property (nonatomic, copy) void(^scrollViewDidEndDeceleratingBlock)(NSInteger index);

- (id)initWithContentViews:(NSArray *)array;
- (void)setscrollViewIndex:(NSInteger)index;
@end
