//
//  KLHomeInforMationCollectionViewCell.m
//  COButton
//
//  Created by liaowh on 16/6/2.
//  Copyright © 2016年 comv. All rights reserved.
//

#import "KLHomeInforMationCollectionViewCell.h"

@implementation KLHomeInforMationCollectionViewCell

- (id)initWithFrame:(CGRect)frame{
    
    if ([super initWithFrame:frame]) {
        
        [self setup];
    }
    return self;
}
- (void)setup{
    
    self.backgroundColor = [UIColor whiteColor];

    _errorLabel = [UILabel new];
    _errorLabel.textAlignment = 1;
    _errorLabel.font = kNSPXFONT(28);
    _errorLabel.textColor = [UIColor colorWithHexString:@"#aaaaaa"];
    [self addSubview:_errorLabel];
    
    _errorLabel.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    
    
    _errorLabel.text = @"暂无更多内容~";
}
@end
