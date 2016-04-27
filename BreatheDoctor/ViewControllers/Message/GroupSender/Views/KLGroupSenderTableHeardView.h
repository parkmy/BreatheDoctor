//
//  KLGroupSenderTableHeardView.h
//  BreatheDoctor
//
//  Created by comv on 16/4/25.
//  Copyright © 2016年 lwh. All rights reserved.
//  

#import <UIKit/UIKit.h>

@interface KLGroupSenderTableHeardView : UIView

@property (nonatomic, copy) void(^backBlock)();

- (instancetype)initWithPatientArray:(NSMutableArray *)array;

- (CGFloat)getHeight;

- (void)backClick;

@end
