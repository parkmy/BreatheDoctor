//
//  LWScrollMenuView.m
//  BreatheDoctor
//
//  Created by comv on 16/3/16.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWScrollMenuView.h"

@implementation LWScrollMenuView

- (id)initWithContentViews:(NSArray *)array
{
    if ([super init])
    {
        self.pagingEnabled = YES;

        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.bounces = NO;
        self.delegate = self;
        self.contentWidth = array.count*screenWidth;
        
        for (int i = 0; i < array.count; i++)
        {
            UIView *view = nil;
            if ([array[i] isKindOfClass:[UIViewController class]])
            {
                UIViewController *vc = (UIViewController *)array[i];
                view = vc.view;
            }else if ([array[i] isKindOfClass:[UIView class]])
            {
                view = array[i];
            }
            [self addSubview:view];
            
            view.sd_layout.leftSpaceToView(self,i*screenWidth).topSpaceToView(self,0).bottomSpaceToView(self,0).widthIs(screenWidth);
        }
    }
    return self;
}
- (void)setscrollViewIndex:(NSInteger)index
{
    [self setContentOffset:CGPointMake(index*screenWidth, 0) animated:YES];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger tag = self.contentOffsetX/screenWidth;
    _scrollViewDidEndDeceleratingBlock?_scrollViewDidEndDeceleratingBlock(tag):nil;

}

@end
