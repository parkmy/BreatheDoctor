//
//  KLDatePickView.m
//  COButton
//
//  Created by comv on 16/3/31.
//  Copyright © 2016年 comv. All rights reserved.
//

#import "KLDatePickView.h"
#import "KLDatePickNumberView.h"


@interface KLDatePickView ()<KLDatePickNumberViewDelegate,KLDatePickNumberViewDataSource>
{
    KLDatePickNumberView *_datePickNumberView;
    NSInteger             _indexCount;
    NSInteger             _seleIndex;
}
@end

@implementation KLDatePickView

- (id)initWithFrame:(CGRect)frame{
    
    if ([super initWithFrame:frame]) {
        
        _datePickNumberView = ({
        
            KLDatePickNumberView *view = [KLDatePickNumberView new];
            view.dataSource = self;
            view.delegate = self;
            [self addSubview:view];
            view;
        });
        _datePickNumberView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    }
    return self;
}
- (void)setDateCount:(NSInteger)indexCount{
    _indexCount = indexCount;
    [_datePickNumberView reloadData];
}
- (void)refDateCount:(NSInteger)index{
    _seleIndex = index;
    [_datePickNumberView moveIndexCountInfo:index];
}
- (void)setDatePeriodInfo:(NSString *)period{
    _datePickNumberView.period = period;
}
- (UIView *)datePickNumberView:(KLDatePickNumberView *)datePickNumberView
         cellForRowAtIndexPath:(NSInteger)index{
    
    UILabel *label = [UILabel new];
    label.text = [NSString stringWithFormat:@"%@%@",index<10?@"0":@"",[NSNumber numberWithInteger:index]];
    label.textAlignment = 1;
    label.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.7];
    return label;
}
- (NSInteger)numberDatePickNumberView:(KLDatePickNumberView *)datePickNumberView{
    return _indexCount;
}

- (void)datePickNumberView:(KLDatePickNumberView *)datePickNumberView
    didScrollToPageAtIndex:(NSInteger)index{
    _seleIndex = index;
}
- (NSString *)seleIndexString{
    return [NSString stringWithFormat:@"%@%@",_seleIndex<10?@"0":@"",[NSNumber numberWithInteger:_seleIndex]] ;
}
@end
