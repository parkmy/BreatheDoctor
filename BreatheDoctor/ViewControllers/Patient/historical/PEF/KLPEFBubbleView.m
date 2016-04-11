//
//  KLPEFBubbleView.m
//  BreatheDoctor
//
//  Created by comv on 16/3/28.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLPEFBubbleView.h"
#define JIAOW 8

@interface KLPEFBubbleView ()
{
    UILabel *_centerLabel;
}
@end
@implementation KLPEFBubbleView

- (id)initWithFrame:(CGRect)frame{

    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        _centerLabel = [UILabel new];
        _centerLabel.textColor = [UIColor whiteColor];
        _centerLabel.textAlignment =1;
        _centerLabel.text = @"0";
        [_centerLabel setCornerRadius:3.0f];
        _centerLabel.font = kNSPXFONT(20);
        [self addSubview:_centerLabel];
    }
    return self;
}
- (void)layoutSubviews{
    _centerLabel.frame = CGRectMake(0, 0, self.width, self.height);
}
- (void)setPefValue:(double)pefValue{
    _pefValue = pefValue;
    _centerLabel.text = kNSString(kNSNumDouble(pefValue));
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    _centerLabel.backgroundColor = self.fillColor;
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.lineWidth = .5f;
    layer.lineCap = kCALineCapButt;
    layer.strokeColor = self.fillColor.CGColor;
    layer.fillColor = self.fillColor.CGColor;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, self.width/2 - JIAOW/2, self.height-.5);
    CGPathAddLineToPoint(path, nil, self.width/2, self.height + JIAOW/2);
    CGPathAddLineToPoint(path, nil, self.width/2 + JIAOW/2, self.height-.5);
    
    layer.path = path;
    
    [self.layer addSublayer:layer];
    
}


@end
