//
//  KSNoNetView.m
//  Test
//
//  Created by KS on 15/11/25.
//  Copyright © 2015年 xianhe. All rights reserved.
//

#import "KSNoNetView.h"

@interface KSNoNetView ()
{
    __block UIImageView *errorImageView;
    UILabel     *errorLabel;
    UIButton    *errorButton;
}

@end

@implementation KSNoNetView

- (id)initWithFrame:(CGRect)frame{

    if ([super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        
        UIView *cententView = [UIView new];
        [self addSubview:cententView];
        
        
        
        errorImageView = [UIImageView new];
        errorImageView.image = kImage(@"nanguo2.png");
        [cententView addSubview:errorImageView];
        
        errorLabel = [UILabel new];
        errorLabel.font = kNSPXFONT(34);
        errorLabel.textAlignment = 1;
        [cententView addSubview:errorLabel];
        
        errorButton = [UIButton buttonWithType:UIButtonTypeCustom];
        errorButton.backgroundColor = [UIColor colorWithHexString:@"#9cc75e"];
        errorButton.titleLabel.font = kNSPXFONT(30);
        [errorButton setCornerRadius:3.0f];
        [errorButton addTarget:self action:@selector(reloadNetworkDataSource:) forControlEvents:UIControlEventTouchUpInside];
        [cententView addSubview:errorButton];
        
        
        cententView.sd_layout
        .widthIs(errorImageView.image.size.width*2)
        .heightIs(errorImageView.image.size.height+45+40)
        .centerXEqualToView(self)
        .centerYEqualToView(self);
        
        errorImageView.sd_layout.widthIs(errorImageView.image.size.width).heightIs(errorImageView.image.size.height).topSpaceToView(cententView,0).centerXEqualToView(cententView);
        errorLabel.sd_layout.widthRatioToView(errorImageView,2).heightIs(45).topSpaceToView(errorImageView,0).centerXEqualToView(cententView);
        errorButton.sd_layout.widthRatioToView(errorImageView,.8).heightIs(40).topSpaceToView(errorLabel,0).centerXEqualToView(cententView);

    }
    return self;
}
//- (void)layoutSubviews{
//
//}
//- (void)didFinishAutoLayout{
//
//}
- (void)setIsShowErrorButton:(BOOL)isShowErrorButton{
    _isShowErrorButton = isShowErrorButton;
    errorButton.hidden = _isShowErrorButton;
}
- (void)setErrorButtonTag:(NSInteger)ErrorButtonTag
{
    _ErrorButtonTag = ErrorButtonTag;
    errorButton.tag = ErrorButtonTag;
}
- (void)setErrorButtonTitleInfo:(NSString *)title{
    [errorButton setTitle:title forState:UIControlStateNormal];
}
- (void)setErrorLabelMessageInfo:(NSString *)messgae
{
    [errorLabel setText:messgae];
}


- (void)reloadNetworkDataSource:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(reloadNetworkDataSource:)]) {
        [self.delegate performSelector:@selector(reloadNetworkDataSource:) withObject:sender];
    }
}
@end
