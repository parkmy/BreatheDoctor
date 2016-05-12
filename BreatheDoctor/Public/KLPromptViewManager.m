//
//  KLPromptViewManager.m
//  BreatheDoctor
//
//  Created by comv on 16/4/19.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLPromptViewManager.h"

#define MIN_PROMPTHEIGHT  75
#define TITLEHEIGHT       20
#define MERG               5

@interface KLPromptView : UIView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIColor *klbackgroundColor;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *contentColor;

@end

@implementation KLPromptView

- (id)initWithFrame:(CGRect)frame{

    if ([super initWithFrame:frame]) {
        
        self.frame = CGRectMake(0, 0, screenWidth, MIN_PROMPTHEIGHT);
        self.backgroundColor = [LWThemeManager shareInstance].navBackgroundColor;
        
        _titleLabel = [UILabel new];
        _titleLabel.textAlignment = 1;
        _titleLabel.font = kNSPXFONT(28);
        _titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        
        _contentLabel = [UILabel new];
        _contentLabel.textAlignment = 1;
        _contentLabel.font = kNSPXFONT(26);
        _contentLabel.textColor =[UIColor whiteColor];
        _contentLabel.numberOfLines = 0;
        
        [self sd_addSubviews:@[_titleLabel,_contentLabel]];

    }
    return self;
}
- (void)layoutSubviews{
    
    self.titleLabel.frame = CGRectMake(MERG,20+MERG, self.width-MERG*2, TITLEHEIGHT);
    self.contentLabel.frame = CGRectMake(MERG, self.titleLabel.maxY+MERG, self.titleLabel.width, self.height-self.titleLabel.maxY-MERG);
}
- (void)setTtileText:(NSString *)text{
    
    self.titleLabel.text = [NSString stringJudgeNullInfoString:text];
}
- (void)setContentText:(NSString *)contentText{
    
    self.contentLabel.text = [NSString stringJudgeNullInfoString:contentText];
    
    CGFloat height = [self.contentLabel.text heightWithFont:self.contentLabel.font constrainedToWidth:screenWidth-MERG*2];
    
    if ((height + TITLEHEIGHT + MERG*3 + 20) > MIN_PROMPTHEIGHT){
        
        self.height = (height + TITLEHEIGHT + MERG*3 + 20);
    }else{
        
        self.height = MIN_PROMPTHEIGHT;
    }
    self.yOrigin = -self.height;
}
- (void)setKlbackgroundColor:(UIColor *)klbackgroundColor{
    
    _klbackgroundColor = klbackgroundColor;
    self.backgroundColor = _klbackgroundColor;
}
- (void)setTitleColor:(UIColor *)titleColor{
    
    _titleColor = titleColor;
    _titleLabel.textColor = titleColor;
}
- (void)setContentColor:(UIColor *)contentColor{
    
    _contentColor = contentColor;
    _contentLabel.textColor = contentColor;
}

@end


@interface KLPromptViewManager ()

@property (nonatomic, strong) KLPromptView *promptView;
@property (nonatomic, strong) UIWindow     *window;
@property (nonatomic, copy)   HiddenBlock  hiddenBlock;

@end

@implementation KLPromptViewManager

- (KLPromptView *)promptView{
    
    if (!_promptView) {
        _promptView = [KLPromptView new];
        _promptView.alpha = .5;
    }
    return _promptView;
}
- (UIWindow *)window{
    
    if (!_window) {
        _window = [UIApplication sharedApplication].keyWindow;
    }
    return _window;
}

+ (KLPromptViewManager *)shareInstance{

    static dispatch_once_t onceToken;
    static KLPromptViewManager *manager = nil;
    dispatch_once(&onceToken, ^{
        manager = [KLPromptViewManager new];
    });
    return manager;
}
- (void)show{
    
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:.5 animations:^{
        weakSelf.promptView.alpha = 1;
        weakSelf.promptView.yOrigin = 0;
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf hidden];
        });
    }];
}
- (void)hidden{
    
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:.5 animations:^{
        weakSelf.promptView.yOrigin = -self.promptView.height;
        weakSelf.promptView.alpha = .5;
    } completion:^(BOOL finished) {
        [weakSelf.promptView removeFromSuperview];
        weakSelf.hiddenBlock?_hiddenBlock():nil;
    }];

}
- (void)kl_showPromptViewWithTitle:(NSString *)title
                        theContent:(NSString *)content
                    theHiddenBlock:(HiddenBlock)hiddenSuccBlock{
    self.hiddenBlock = hiddenSuccBlock;
    [self kl_showPromptViewWithTitle:title theContent:content];
    
}
/**
 *  Description
 *
 *  @param title   标题
 *  @param content 内容
 */
- (void)kl_showPromptViewWithTitle:(NSString *)title
                     theContent:(NSString *)content{
    
    [self.promptView setTtileText:title.length>0?title:@"温馨提示"];
    [self.promptView setContentText:content];
    [self.window addSubview:self.promptView];
    [self show];
}
/**
 *  Description
 *
 *  @param title           标题
 *  @param content         内容
 *  @param backgroundColor 背景色
 */
- (void)kl_showPromptViewWithTitle:(NSString *)title
                     theContent:(NSString *)content
             theBackgroundColor:(UIColor *)backgroundColor{
    
    
}
/**
 *  Description
 *
 *  @param title           标题
 *  @param content         内容
 *  @param backgroundColor 背景色
 *  @param titleColor      标题颜色
 *  @param contentColor    内容颜色
 */
- (void)kl_showPromptViewWithTitle:(NSString *)title
                     theContent:(NSString *)content
             theBackgroundColor:(UIColor *)backgroundColor
                  theTitleColor:(UIColor *)titleColor
                theContentColor:(UIColor *)contentColor{
    
    
    
}


@end
