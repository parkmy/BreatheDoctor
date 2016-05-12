//
//  KLIndicatorViewManager.m
//  COButton
//
//  Created by comv on 16/5/4.
//  Copyright © 2016年 comv. All rights reserved.
//

#import "KLIndicatorViewManager.h"
#import "AppDelegate.h"

@interface KLIndicatorView : UIView
@property (nonatomic, strong) UIImageView *errorImageView;
@property (nonatomic, strong) UILabel     *contentLabel;
@end

@implementation KLIndicatorView

- (id)initWithShowTitle:(NSString *)title
           andShowImage:(UIImage *)image{

    if ([super init]) {
        
        self.frame = CGRectZero;
        self.backgroundColor = [UIColor colorWithRed:98/255.0 green:98/255.0 blue:98/255.0 alpha:1];
        
        self.layer.cornerRadius = 4.0f;
        self.layer.masksToBounds = YES;
        
        _errorImageView = [UIImageView new];
        _errorImageView.image = image;
        _errorImageView.frame = CGRectZero;
        [self addSubview:_errorImageView];
        
        _contentLabel = [UILabel new];
        _contentLabel.font = kNSPXFONT(22);
        _contentLabel.textColor = [UIColor whiteColor];
        _contentLabel.text = [NSString stringWithFormat:@"%@ ···",title];
        _contentLabel.frame = CGRectZero;
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_contentLabel];
        
    }
    return self;
}

#define MINLABELWIDTH 55
- (void)layoutSubviews{

//    10 15
    
    CGFloat labelY = 15;
    
    if (_errorImageView.image) {
        
        labelY = _errorImageView.image.size.height + 10;
    }
    
    if (_contentLabel.text.length > 0) {
        
        CGFloat width = [_contentLabel.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 20) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:kNSPXFONT(22)} context:nil].size.width;
        _contentLabel.width = MAX(MINLABELWIDTH, width);
        _contentLabel.height = 20;
        _contentLabel.xOrigin = 10;
        _contentLabel.yOrigin = labelY;
    }
    
    self.width = MAX(55+20, _contentLabel.width+20);
    self.height = labelY + 15 + 20;
    
    if (_errorImageView.image) {
        _contentLabel.textAlignment = 1;
        _errorImageView.xOrigin = (self.width-_errorImageView.image.size.width)/2;
        _errorImageView.yOrigin = 5;
        _errorImageView.width = _errorImageView.image.size.width;
        _errorImageView.height = _errorImageView.image.size.height;
        self.height = labelY + 15 + 5;
    }
    
    self.center = self.superview.center;
}

@end

@interface KLIndicatorViewManager ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) KLIndicatorView *showView;
@property (nonatomic, copy)   NSString *textString;
@property (nonatomic, assign) int dateCount;
@property (nonatomic, copy) showErrorViewSuccessBlock showSuccessBlock;
@end

@implementation KLIndicatorViewManager

+ (KLIndicatorViewManager *)standardIndicatorViewManager{

    static dispatch_once_t onceToken;
    static KLIndicatorViewManager *manager = nil;
    dispatch_once(&onceToken, ^{
        manager = [KLIndicatorViewManager new];
    });
    return manager;
}

- (void)hiddenIndicatorView{
    
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    if (_showView || _bgView) {
        [_bgView removeFromSuperview];
        _bgView = nil;
        [_showView removeFromSuperview];
        _showView = nil;
    }
}

- (void)showErrorWith:(NSString *)string
              theView:(UIView *)view
             theImage:(UIImage *)image
             showSucc:(showErrorViewSuccessBlock)showErrorViewSuccessBlock{
    
    _showSuccessBlock = showErrorViewSuccessBlock;
    [self showErrorWith:string theView:view theImage:image];
}

- (void)showErrorWith:(NSString *)string theView:(UIView *)view theImage:(UIImage *)image{
    
    [self hiddenIndicatorView];
    
    _showView = [[KLIndicatorView alloc] initWithShowTitle:@"" andShowImage:nil];
    _showView.contentLabel.text = string;
    _showView.errorImageView.image = [UIImage imageNamed:@"doctor_qunfa_fasong.png"];
    
    _bgView   = [UIView new];
    _bgView.backgroundColor = [UIColor clearColor];
    [view addSubview:_bgView];
    [view addSubview:_showView];
    _bgView.frame = view.bounds;
    _showView.center = view.center;
    
    
    CABasicAnimation *baseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    baseAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    baseAnimation.duration = .5;
    baseAnimation.repeatCount = 1;
    baseAnimation.autoreverses = YES;
    baseAnimation.fromValue = @.8;
    baseAnimation.toValue   = @1.1;
//    baseAnimation.byValue   = @1;
    [_showView.layer addAnimation:baseAnimation forKey:@"_showView"];
    
    __weak typeof(self)wearkSelf = self;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [wearkSelf hiddenIndicatorView];
        wearkSelf.showSuccessBlock?wearkSelf.showSuccessBlock():nil;
    });
    
}


- (void)showLoadingWithContent:(NSString *)string theView:(UIView *)view{
    
    [self hiddenIndicatorView];
    
    _textString = string;
    _dateCount = 0;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeContentLabel) userInfo:nil repeats:YES];
    
    _showView = [[KLIndicatorView alloc] initWithShowTitle:string andShowImage:nil];
    _bgView   = [UIView new];
    _bgView.backgroundColor = [UIColor clearColor];
    
    
    [view addSubview:_bgView];
    [view addSubview:_showView];
    _bgView.frame = view.bounds;
    _showView.center = view.center;
    
}
- (void)changeContentLabel{
    
    _dateCount ++;
    
    if (_showView) {
        
        if (_dateCount%3 == 1) {
            _showView.contentLabel.text = [NSString stringWithFormat:@"%@ ·",_textString];
        }else if (_dateCount%3 == 2){
            _showView.contentLabel.text = [NSString stringWithFormat:@"%@ ··",_textString];
        }else if (_dateCount%3 == 0){
            _showView.contentLabel.text = [NSString stringWithFormat:@"%@ ···",_textString];
        }
    }
    if (_dateCount == 100) {
        _dateCount = 0;
    }
}
@end
