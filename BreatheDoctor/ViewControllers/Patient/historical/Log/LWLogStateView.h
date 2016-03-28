//
//  LWLogStateView.h
//  BreatheDoctor
//
//  Created by comv on 16/3/18.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWLogStateView : UIView

@property (nonatomic, strong) NSMutableArray *dataArray;
- (void)setStateIconImageName:(NSString *)image;
- (void)setStateTitleName:(NSString *)name;

@end
