//
//  CDPromptView.m
//  ComveeDoctor
//
//  Created by JYL on 15-1-5.
//  Copyright (c) 2015年 zhengjw. All rights reserved.
//

#import "CDPromptView.h"
#import "CDCommontConvenient.h"
#import "CDMacro.h"

@implementation CDPromptView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        
        self.backgroundColor = [UIColor blackColor];
        self.layer.opacity= 0.7;
        self.layer.borderWidth =1;
        self.layer.borderColor = [UIColor clearColor].CGColor;
        self.layer.cornerRadius = 10;
        msgLable =  [CommentConvenient creatLable:CGRectMake(10, 10, self.frame.size.width-20, self.frame.size.height-20) text:nil Color:[UIColor colorWithRed:0xff/255.0 green:0xff/255.0 blue:0xff/255.0 alpha:1.0] Font:[UIFont systemFontOfSize:13] textAliment:NSTextAlignmentCenter Sv:self];
        msgLable.numberOfLines = 0;
        
    }
    return self;
}

- (void)hideView
{
    _btn.userInteractionEnabled = YES;

    [UIView animateWithDuration:0.1 animations:^{
        self.transform = CGAffineTransformMakeScale(0.3f, 0.3f);//将要显示的view按照正常比例显示出来
    } completion:^(BOOL finished)
     {
          NSLog(@"后走");
        if (timer)
        {
            [timer invalidate];
            timer = nil;
        }
        [self removeFromSuperview];
        [LWPublicDataManager shareInstance].ifRemoveFromSuperview = NO;
    }];

}

- (void)showViewWithMsg:(NSString *)Msg
{
    self.transform = CGAffineTransformMakeScale(1.2f, 1.2f);//将要显示的view按照正常比例显示出来
    [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut]; //InOut 表示进入和出去时都启动动画
    [UIView setAnimationDuration:0.1f];//动画时间
    self.transform=CGAffineTransformMakeScale(1.f, 1.f);//先让要显示的view最小直至消失
    msgLable.text = Msg;
    timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(hideView) userInfo:nil repeats:NO];
    
    [UIView commitAnimations];
  
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
