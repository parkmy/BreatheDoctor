//
//  KLDatePickNumberView.m
//  COButton
//
//  Created by comv on 16/3/30.
//  Copyright © 2016年 comv. All rights reserved.
//

#import "KLDatePickNumberView.h"


#define DateHeight 80

@interface KLDatePickNumberView ()<UIScrollViewDelegate>
{
    UIScrollView *_ScrollView;
    UILabel      *_rightLabel;
    NSMutableArray *_cellArray;
    int     _seleIndex;
}
@end

@implementation KLDatePickNumberView

- (id)initWithFrame:(CGRect)frame{
    
    if ([super initWithFrame:frame]) {
        
        self.clipsToBounds = YES;
        
        _cellArray = [NSMutableArray array];
        _seleIndex = 0;
        
        _ScrollView = [[UIScrollView alloc] init];
        _ScrollView.delegate = self;
        _ScrollView.clipsToBounds = NO;
//        _ScrollView.pagingEnabled = YES;
        _ScrollView.showsHorizontalScrollIndicator = NO;
        _ScrollView.showsVerticalScrollIndicator = NO;
        _ScrollView.autoresizesSubviews = NO;
//        _ScrollView.layer.borderColor = [UIColor redColor].CGColor;
//        _ScrollView.layer.borderWidth = 1;
        [self addSubview:_ScrollView];
        
        _rightLabel = [UILabel new];
//        _rightLabel.text = @"时";
        _rightLabel.textAlignment = 1;
        _rightLabel.font = [UIFont systemFontOfSize:13];
        _rightLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.6];
        [self addSubview:_rightLabel];
        
        _ScrollView.sd_layout.
        centerYEqualToView(self).
        leftSpaceToView(self,0).
        rightSpaceToView(self,15).
        heightIs(DateHeight);
        
        _rightLabel.sd_layout.leftSpaceToView(_ScrollView,0)
        .rightSpaceToView(self,0)
        .topSpaceToView(self,0)
        .bottomSpaceToView(self,0);
        
    }
    return self;
}
- (void)setPeriod:(NSString *)period{
    
    _period = period;
    _rightLabel.text = _period;
}
- (void)reloadData{

    if (!self.delegate || ![self.delegate respondsToSelector:@selector(numberDatePickNumberView:)]) {
        return;
    }
    if (!self.dataSource || ![self.dataSource respondsToSelector:@selector(datePickNumberView:cellForRowAtIndexPath:)]) {
        return;
    }
    
    [_cellArray removeAllObjects];
    [[_ScrollView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSInteger indexCount = [self.delegate numberDatePickNumberView:self];
    
    _ScrollView.contentHeight = DateHeight*(indexCount);
    
    for (int count = 0; count < indexCount; count++)
    {
        UIView *view = [self.dataSource datePickNumberView:self cellForRowAtIndexPath:count];
        [_ScrollView addSubview:view];
        [_cellArray addObject:view];
        
        view.sd_layout.
        leftSpaceToView(_ScrollView,0).
        topSpaceToView(_ScrollView,count*DateHeight).
        rightSpaceToView(_ScrollView,0)
        .heightIs(DateHeight);
    }
    [self updateSeleIndexView];
}

- (void)updateSeleIndexView{

    for (int count = 0; count < _cellArray.count; count++) {
        UILabel *label = _cellArray[count];
        if (count == _seleIndex) {
            label.font = [UIFont fontWithName:@"Helvetica-Light" size:50];
            label.alpha = 1.0f;
        }else{
            label.font = [UIFont fontWithName:@"Helvetica-Light" size:35];
            //透明度
            int off = (int)labs(_seleIndex - count);
            float alpha = 0.8f - off * 0.2;
            label.alpha = alpha;
        }
    }
}
- (void)moveIndexCountInfo:(NSInteger)index{
    _seleIndex = (int)index;
    [_ScrollView setContentOffset:CGPointMake(0, index*DateHeight) animated:YES];
}
#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;                                               // any offset changes
{
    int index = scrollView.contentOffsetY / DateHeight;
    _seleIndex = index;
    if ([self.delegate respondsToSelector:@selector(datePickNumberView:didScrollToPageAtIndex:)]) {
        [self.delegate datePickNumberView:self didScrollToPageAtIndex:_seleIndex];
    }
    [self updateSeleIndexView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;      // called when scroll view grinds to a halt
{
    int index = scrollView.contentOffsetY / DateHeight;
    _seleIndex = index;
//    [_ScrollView setContentOffsetY:index*DateHeight];
    [_ScrollView setContentOffset:CGPointMake(0, index*DateHeight) animated:YES];
    if ([self.delegate respondsToSelector:@selector(datePickNumberView:didScrollToPageAtIndex:)]) {
        [self.delegate datePickNumberView:self didScrollToPageAtIndex:_seleIndex];
    }
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView; // called when setContentOffset/scrollRectVisible:animated: finishes. not called if not animating
{
    [self updateSeleIndexView];
}

@end
