//
//  UIView+BorderLine.m
//  COButton
//
//  Created by comv on 15/10/31.
//  Copyright © 2015年 comv. All rights reserved.
//

#import "UIView+BorderLine.h"

#define LINEW .5

@implementation UIView (BorderLine)

- (void)bordeLineType:(LBordeLineType)type boedeClolor:(UIColor *)color
{
    if (type & LBordeLineLEFT) {
        [self addLine:CGRectMake(0, 0, LINEW, self.height) withColor:color];
    }
    if (type & LBordeLineTOP) {
        [self addLine:CGRectMake(0, 0, self.width, LINEW) withColor:color];
    }
    if (type & LBordeLineDOWN) {
        [self addLine:CGRectMake(0, self.height-LINEW, self.width, LINEW) withColor:color];
    }
    if (type & LBordeLineRIGHT) {
        [self addLine:CGRectMake(self.width-LINEW, 0, LINEW, self.height) withColor:color];
    }

}
- (void)addLine:(CGRect)rect withColor:(UIColor *)color
{
    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = color;
    [self addSubview:view];
    [self bringSubviewToFront:view];

}

- (void)byRoundingCorners:(UIRectCorner)corners withSize:(CGSize)size
{
    CGRect f = self.bounds;
    f.size.width = Screen_SIZE.width-20;
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:f byRoundingCorners:corners cornerRadii:size];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    

    
    maskLayer.frame = f;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

@end
