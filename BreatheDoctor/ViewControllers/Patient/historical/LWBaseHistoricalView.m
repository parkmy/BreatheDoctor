//
//  LWBaseHistoricalView.m
//  BreatheDoctor
//
//  Created by comv on 16/3/16.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWBaseHistoricalView.h"

@implementation LWBaseHistoricalView

- (id)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame])
    {
        [self addSubview:self.mTableView];
        setExtraCellLineHidden(self.mTableView);
        self.mTableView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
       
//        self.mTableView.contentInset = UIEdgeInsetsMake(180*MULTIPLEVIEW, 0, 0, 0);
//        self.mTableView.scrollIndicatorInsets = UIEdgeInsetsMake(180*MULTIPLEVIEW, 0, 0, 0);

    }
    return self;
}

- (UITableView *)mTableView
{
    if (!_mTableView) {
        _mTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    }
    return _mTableView;
}
+ (LWHistoricalHeardView *)historicalHeardView
{
    LWHistoricalHeardView *view = [LWHistoricalHeardView new];
    return view;
}

//- (LWHistoricalHeardView *)historicalHeardView
//{
//    if (!_historicalHeardView) {
//        _historicalHeardView = [[LWHistoricalHeardView alloc] init];
//    }
//    return _historicalHeardView;
//}


@end
