//
//  LWTimerRemindIndexView.m
//  BreatheDoctor
//
//  Created by comv on 15/12/31.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWTimerRemindIndexView.h"

@interface LWTimerRemindIndexView ()

@property (nonatomic, strong) UILabel *centerLabel;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, assign) NSInteger changeIndex;


@end

@implementation LWTimerRemindIndexView

- (id)initWithFrame:(CGRect)frame WithDelegate:(id)delegate
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.delegate = delegate;
        
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.tag = 0;
        [_leftButton setImage:kImage(@"left_blue") forState:UIControlStateNormal];
        
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightButton setImage:kImage(@"right_blue") forState:UIControlStateNormal];
        _rightButton.tag = 1;
        [_leftButton addTarget:self action:@selector(indexButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_rightButton addTarget:self action:@selector(indexButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _leftButton.hidden = YES;
        
        [self addSubview:_leftButton];
        [self addSubview:_rightButton];
        
        _leftButton.sd_layout.topSpaceToView(self,0).leftSpaceToView(self,0).bottomSpaceToView(self,0).widthIs(45);
        _rightButton.sd_layout.topSpaceToView(self,0).rightSpaceToView(self,0).bottomSpaceToView(self,0).widthIs(45);
        
        
        _centerLabel = [self allocLabel];
        _centerLabel.text = @"周一";
        
        
        [self addSubview:_centerLabel];
        _centerLabel.sd_layout.leftSpaceToView(_leftButton,0).rightSpaceToView(_rightButton,0).centerYEqualToView(self).heightIs(30);
        
        
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
    self.leftButton.hidden = NO;
    self.rightButton.hidden = NO;
    if (tag == 0) { //左边
        self.changeIndex--;
        self.leftButton.hidden = self.changeIndex == 0?YES:NO;
    }else //右边
    {
        self.changeIndex++;
        self.rightButton.hidden = self.changeIndex == 7?YES:NO;
    }
    NSString *index = [self chinaNumber:self.changeIndex];
    
    self.centerLabel.text = [NSString stringWithFormat:@"周%@",index];
    
}

- (NSString *)chinaNumber:(NSInteger)index
{
    if (index == 1 || index == 0) {
        return @"一";
    }else if (index == 2)
    {
        return @"二";
    }else if (index == 3)
    {
        return @"三";
    }else if (index == 4)
    {
        return @"四";
    }else if (index == 5)
    {
        return @"五";
    }else if (index == 6)
    {
        return @"六";
    }else
    {
        return @"日";
    }
}


@end
