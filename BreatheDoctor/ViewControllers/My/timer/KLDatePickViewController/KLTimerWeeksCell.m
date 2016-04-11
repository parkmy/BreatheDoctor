//
//  KLTimerWeeksCell.m
//  BreatheDoctor
//
//  Created by comv on 16/3/31.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLTimerWeeksCell.h"

@interface KLTimerWeeksCell ()
@end

@implementation KLTimerWeeksCell
- (id)initWithFrame:(CGRect)frame{
    
    if ([super initWithFrame:frame]) {
        
        [self addSubview:self.contentButton];
        self.contentButton.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    }
    return self;
}
- (void)setItmInfo:(id)objc{
    [_contentButton setTitle:(NSString *)objc forState:UIControlStateNormal];
}
- (UIButton *)contentButton{
    
    if (!_contentButton) {
        _contentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _contentButton.titleLabel.font = kNSPXFONT(30);
        [_contentButton setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        [_contentButton setImage:kImage(@"timer_gray") forState:UIControlStateNormal];
        _contentButton.enabled = NO;
    }
    return _contentButton;
}
@end
