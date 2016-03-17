//
//  LWSymptomsCell.m
//  BreatheDoctor
//
//  Created by comv on 16/3/17.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWSymptomsCell.h"
#import "LWSymptomsButton.h"

@interface LWSymptomsCell ()

@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, strong) UIView  *bgView;
@property (nonatomic, strong) LWSymptomsButton *bgButton;

@end

@implementation LWSymptomsCell

- (id)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame])
    {
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.bgButton];
        [self.bgView addSubview:self.countLabel];
        
        self.bgView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
        self.bgButton.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
        self.countLabel.sd_layout.topSpaceToView(self.bgView,0).rightSpaceToView(self.bgView,0).widthIs(15*MULTIPLEVIEW).heightIs(15*MULTIPLEVIEW);
        
//        __weak typeof(self)weakSelf = self;
//        [self.bgButton setDidFinishAutoLayoutBlock:^(CGRect rect)
//        {
////            [weakSelf.bgButton setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
////            [weakSelf.bgButton setImageEdgeInsets:UIEdgeInsetsMake(20, 0, 0, 0)];
//           weakSelf.bgButton.titleEdgeInsets = UIEdgeInsetsMake(71, -weakSelf.bgButton.titleLabel.bounds.size.width-50, 0, 0);//设置title在button上的位置（上top，左left，下bottom，右right）
//            
//            //    [button setContentEdgeInsets:UIEdgeInsetsMake(70, 0, 0, 0)];//
//            
//            
//            //   button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//设置button的内容横向居中。。设置content是title和image一起变化
//        }];
    }
    return self;
}

- (LWSymptomsButton *)bgButton
{
    if (!_bgButton) {
        _bgButton = [LWSymptomsButton buttonWithType:UIButtonTypeCustom];
        [_bgButton setImage:kImage(@"biyang") forState:UIControlStateNormal];
        [_bgButton setTitle:@"呼吸困难" forState:UIControlStateNormal];
        _bgButton.titleLabel.font = kNSPXFONT(28);
        [_bgButton setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        _bgButton.backgroundColor = [UIColor clearColor];
    }
    return _bgButton;
}

- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectZero];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.borderWidth = .5;
        _bgView.layer.borderColor = appLineColor.CGColor;
    }
    return _bgView;
}
- (UILabel *)countLabel
{
    if (!_countLabel) {
        _countLabel = [UILabel new];
        _countLabel.backgroundColor = [LWThemeManager shareInstance].navBackgroundColor;
        _countLabel.textAlignment = 1;
        _countLabel.textColor = [UIColor whiteColor];
        _countLabel.font = kNSPXFONT(24);
        _countLabel.text = @"99";
    }
    return _countLabel;
}


@end
