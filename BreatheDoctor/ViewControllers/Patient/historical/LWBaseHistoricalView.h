//
//  LWBaseHistoricalView.h
//  BreatheDoctor
//
//  Created by comv on 16/3/16.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWHistoricalHeardView.h"

@interface LWBaseHistoricalView : UIView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *mTableView;
+ (LWHistoricalHeardView *)historicalHeardView;

@end
