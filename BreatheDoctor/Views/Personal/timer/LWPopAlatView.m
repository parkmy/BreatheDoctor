//
//  LWPopAlatView.m
//  BreatheDoctor
//
//  Created by comv on 16/1/19.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWPopAlatView.h"
@interface LWPopAlatView ()

@property (strong ,nonatomic) UIView *hudView;
@property (strong ,nonatomic) UIButton *comButton;
@property (strong ,nonatomic) UITextView *contentLabel;
@end
@implementation LWPopAlatView

+(LWPopAlatView *)sharedPopAlatView
{
    static LWPopAlatView *_photoHud = nil;
    if (_photoHud == nil) {
        _photoHud = [[LWPopAlatView alloc]init];
    }
    return _photoHud;
}

- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    self.backgroundColor = RGBA(0, 0, 0, .2);
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
    [self setUI];
}

- (void)setUI
{
    
    _hudView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 500*MULTIPLE/2, 360*MULTIPLE/2)];
    _hudView.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height / 2);
    _hudView.layer.cornerRadius = 10;
    _hudView.clipsToBounds = YES;
    _hudView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_hudView];
    
    
    _contentLabel = [UITextView new];
    _contentLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    _contentLabel.font = [UIFont systemFontOfSize:kNSPXFONTFLOAT(32)];
    _contentLabel.text = @"回复时间的设置，意味着在此时间段内您将对患者的提问进行解答。不设置将无法接受患者咨询。";
    _contentLabel.editable = NO;
    _contentLabel.scrollEnabled = NO;
    [_hudView addSubview:_contentLabel];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 4;// 字体的行间距
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:kNSPXFONTFLOAT(34)],
                                 NSParagraphStyleAttributeName:paragraphStyle,
                                 NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#666666"]
                                 };
    
    _contentLabel.attributedText = [[NSAttributedString alloc] initWithString:_contentLabel.text attributes:attributes];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:kNSPXFONTFLOAT(32)];
    [btn setTitle:@"我知道了" forState:UIControlStateNormal];
    [btn setTitleColor:[LWThemeManager shareInstance].navBackgroundColor forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(hiddenView) forControlEvents:UIControlEventTouchUpInside];
//    btn.layer.borderColor = [LWThemeManager shareInstance].navBackgroundColor.CGColor;
//    btn.layer.borderWidth = .5;
    [btn setCornerRadius:5.0f];
    [_hudView addSubview:btn];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectZero];
    line.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
    [_hudView addSubview:line];
    
    
    btn.sd_layout.bottomSpaceToView(_hudView,0).leftSpaceToView(_hudView,0).rightSpaceToView(_hudView,0).heightIs(45);
    line.sd_layout.bottomSpaceToView(btn,2).rightSpaceToView(_hudView,0).leftSpaceToView(_hudView,0).heightIs(.5);
    _contentLabel.sd_layout.topSpaceToView(_hudView,10).leftSpaceToView(_hudView,15).rightSpaceToView(_hudView,10).bottomSpaceToView(line,10);
    

}
- (void)hiddenView
{
    [self removeFromSuperview];
}

+ (void)showView:(NSString *)content
{
    [[[self class] sharedPopAlatView] show];
}

+ (void)dissMiss
{
    [[[self class] sharedPopAlatView] hiddenView];
}

@end
