//
//  LWChatLoadingView.m
//  BreatheDoctor
//
//  Created by comv on 15/12/21.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWChatLoadingView.h"

@implementation LWChatLoadingView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addSubview:self.activityIndicatorView];
        [self addSubview:self.errorImageView];
        
        self.activityIndicatorView.sd_layout.topSpaceToView(self,0).bottomSpaceToView(self,0).leftSpaceToView(self,0).rightSpaceToView(self,0);
        self.errorImageView.sd_layout.centerXEqualToView(self).centerYEqualToView(self).widthIs(30).heightIs(30);
        
        
    }
    return self;
}
- (void)layoutSubviews
{
    
}

- (void)setShowType:(showLoadingType)showType
{
    _showType = showType;
    
    if (_showType == showLoadingTypeError) {
        self.activityIndicatorView.hidden = YES;
        self.errorImageView.hidden = NO;
    }else
    {
        self.activityIndicatorView.hidden = NO;
        self.errorImageView.hidden = YES;
    }
}

- (UIActivityIndicatorView *)activityIndicatorView
{
    if (!_activityIndicatorView) {
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [_activityIndicatorView startAnimating];
    }
    _activityIndicatorView.hidden = YES;
    return _activityIndicatorView;
}

- (UIImageView *)errorImageView
{
    if (!_errorImageView) {
        _errorImageView = [[UIImageView alloc] initWithImage:kImage(@"sendFail")];
    }
    _errorImageView.hidden = YES;
    return _errorImageView;
}

@end
