//
//  LWYerChangIndexView.m
//  DrawTool
//
//  Created by comv on 15/11/27.
//  Copyright © 2015年 li_yong. All rights reserved.
//

#import "LWYerChangIndexView.h"
#import "NSDate+Extension.h"

@interface LWYerChangIndexView ()

@property (nonatomic, strong) UILabel *centerLabel;

@property (nonatomic, assign) NSInteger changeIndex;
@end

@implementation LWYerChangIndexView

- (id)initWithFrame:(CGRect)frame WithDelegate:(id)delegate
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.delegate = delegate;
        
        UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
        left.tag = 0;
        [left setImage:kImage(@"left_blue") forState:UIControlStateNormal];
        
        UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
        [right setImage:kImage(@"right_blue") forState:UIControlStateNormal];
        right.tag = 1;
        [left addTarget:self action:@selector(indexButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [right addTarget:self action:@selector(indexButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:left];
        [self addSubview:right];
        
        left.sd_layout.topSpaceToView(self,0).leftSpaceToView(self,0).bottomSpaceToView(self,0).widthIs(45);
        right.sd_layout.topSpaceToView(self,0).rightSpaceToView(self,0).bottomSpaceToView(self,0).widthIs(45);
        
        
        _centerLabel = [self allocLabel];
        _centerLabel.text = [NSDate stringWithDate:[NSDate date] format:@"yyyy年MM月"];

        
        [self addSubview:_centerLabel];
        _centerLabel.sd_layout.leftSpaceToView(left,0).rightSpaceToView(right,0).centerYEqualToView(self).heightIs(30);

        
    }
    return self;
}
- (UILabel *)allocLabel
{
    UILabel *Label = [[UILabel alloc] initWithFrame:CGRectZero];
    Label.backgroundColor = [UIColor clearColor];
    Label.textAlignment = NSTextAlignmentCenter;
    Label.textColor = RGBA(0, 0, 0, .6);
    Label.font = [UIFont systemFontOfSize:15];
    return Label;
}
- (void)indexButtonClick:(UIButton *)sender
{
    [self changeTimerLable:sender.tag];
}
- (void)changeTimerLable:(NSInteger)tag
{
    if (tag == 0) { //左边
        self.changeIndex++;
    }else //右边
    {
        if (self.changeIndex == 0) {
            return;
        }
        self.changeIndex--;
    }
    
    _centerLabel.text = [NSDate stringWithDate:[NSDate offsetMonths:-(int)self.changeIndex fromDate:[NSDate date]] format:@"yyyy年MM月"];

    if (_delegate && [_delegate respondsToSelector:@selector(indexDateChnagecenterLabelDate:)]) {
        [_delegate indexDateChnagecenterLabelDate:[NSDate offsetMonths:-(int)self.changeIndex fromDate:[NSDate date]]];
    }
}
@end
