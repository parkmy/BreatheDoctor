//
//  KLGroupSenderContentView.m
//  BreatheDoctor
//
//  Created by comv on 16/4/27.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLGroupSenderContentView.h"

@implementation KLGroupSenderContentView

- (id)initWithFrame:(CGRect)frame{

    if ([super initWithFrame:frame]) {
        
        [self sd_addSubviews:@[self.textTypeLabelView]];
        
        self.textTypeLabelView.sd_layout
        .leftSpaceToView(self,0)
        .rightSpaceToView(self,0)
        .topSpaceToView(self,0)
        .autoHeightRatio(0);
        self.textTypeLabelView.text = @"textTypeLabelViewtextTypeLabelViewtextTypeLabelView";

        [self setupAutoHeightWithBottomView:self.textTypeLabelView bottomMargin:0];
    }
    return self;
}


- (UILabel *)textTypeLabelView{
    
    if (!_textTypeLabelView) {
        _textTypeLabelView = [UILabel new];
        _textTypeLabelView.textColor = [UIColor blackColor];
        _textTypeLabelView.numberOfLines = 0;
    }
    return _textTypeLabelView;
}

@end
