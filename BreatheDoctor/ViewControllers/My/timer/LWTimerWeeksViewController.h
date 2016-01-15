//
//  LWTimerWeeksViewController.h
//  BreatheDoctor
//
//  Created by comv on 16/1/11.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "BaseViewController.h"

@interface LWTimerWeeksViewController : BaseViewController
@property (nonatomic, strong) NSMutableArray *weeks;

@property (nonatomic, copy) void(^backBlock)(NSMutableArray *array);
@end
