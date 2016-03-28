//
//  KLStateCell.m
//  BreatheDoctor
//
//  Created by comv on 16/3/27.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLStateCell.h"
#import "KLStateView.h"

@implementation KLStateCell

- (id)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        
        _stateView = [KLStateView new];
        [self addSubview:_stateView];
        _stateView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    }
    return self;
}

@end
