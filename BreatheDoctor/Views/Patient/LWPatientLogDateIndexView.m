//
//  LWPatientLogDateIndexView.m
//  BreatheDoctor
//
//  Created by comv on 15/11/22.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWPatientLogDateIndexView.h"
#import "NSDate+Extension.h"

@interface LWPatientLogDateIndexView ()
@property (nonatomic, strong) UILabel *rightLabel;
@property (nonatomic, strong) UILabel *leftLabel;

@property (nonatomic, assign) NSInteger changeIndex;
@end

@implementation LWPatientLogDateIndexView

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
        
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectZero];
        line.backgroundColor = RGBA(0, 0, 0, .3);
        [self addSubview:line];
        
        left.sd_layout.topSpaceToView(self,0).leftSpaceToView(self,0).bottomSpaceToView(self,0).widthIs(45);
        right.sd_layout.topSpaceToView(self,0).rightSpaceToView(self,0).bottomSpaceToView(self,0).widthIs(45);
        
        line.sd_layout.topSpaceToView(self,5).bottomSpaceToView(self,5).widthIs(.5).centerXEqualToView(self);
        
        
        _leftLabel = [self allocLabel];
        _leftLabel.text = [NSDate stringWithDate:[NSDate dateAfterDate:[NSDate date] day:-6] format:[NSDate ymdFormat]];
        [self addSubview:_leftLabel];
        
        _rightLabel = [self allocLabel];
        _rightLabel.text = [NSDate stringWithDate:[NSDate date] format:[NSDate ymdFormat]];
        [self addSubview:_rightLabel];
        
        
        _leftLabel.sd_layout.leftSpaceToView(left,0).rightSpaceToView(line,0).centerYEqualToView(self).heightIs(30);
        _rightLabel.sd_layout.leftSpaceToView(line,0).rightSpaceToView(right,0).centerYEqualToView(self).heightIs(30);

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
    _leftLabel.text = [NSDate stringWithDate:[NSDate dateAfterDate:[NSDate date] day:(-6-(self.changeIndex*6))] format:[NSDate ymdFormat]];
    _rightLabel.text = [NSDate stringWithDate:[NSDate dateAfterDate:[NSDate date] day:-(self.changeIndex*6)] format:[NSDate ymdFormat]];
    if (_delegate && [_delegate respondsToSelector:@selector(indexDateChnageLeftDate:RightDate:)]) {
        [_delegate indexDateChnageLeftDate:_leftLabel.text RightDate:_rightLabel.text];
    }
}

- (void)indexButtonClick:(UIButton *)sender
{
    [self changeTimerLable:sender.tag];
}



@end
