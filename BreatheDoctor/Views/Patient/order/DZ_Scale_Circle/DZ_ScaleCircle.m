//
//  DZ_ScaleCircle.m
//  DZ_Scale_Circle
//
//  Created by rongxun02 on 15/12/9.
//  Copyright © 2015年 DongZe. All rights reserved.
//

#import "DZ_ScaleCircle.h"

@interface DZ_ScaleCircle ()
{
    CGFloat radius; //  半径
    
    CGFloat first_animation_time;
    CGFloat second_animation_time;
    CGFloat third_animation_time;
    CGFloat fourth_animation_time;
    
    UIView *_orderCountView;
}

@property(nonatomic) CGPoint CGPoinCerter;
@property(nonatomic) CGFloat endAngle;
@property(nonatomic) BOOL clockwise;

@property (nonatomic, strong) NSMutableArray *layerArray;
@end


@implementation DZ_ScaleCircle
//  初始化参数
- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){

        [self loadView];
    }
    return self;
}
- (NSMutableArray *)layerArray
{
    if (!_layerArray) {
        _layerArray = [NSMutableArray array];
    }
    return _layerArray;
}
- (void)loadView
{
    [self initCenterLabel];
    
    self.lineWith = 5.0f;
    self.unfillColor = RGBA(119, 199, 93, .3);
    self.clockwise = YES;
    self.backgroundColor = [UIColor clearColor];
    
    self.firstColor = [UIColor colorWithHexString:@"#77c75e"];
    self.secondColor = [UIColor colorWithHexString:@"#febf47"];
    self.thirdColor = [UIColor colorWithHexString:@"#ff6666"];
    self.fourthColor = [UIColor colorWithHexString:@"#77c75e"];
    
    self.animation_time = 5.0;
    
    self.centerLable.text = @"请初始化...";
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ([super initWithCoder:aDecoder])
    {        
        [self loadView];
    }
    
    return self;
}
#pragma mark setMethod
/**
 *  画图函数
 *
 *  @param rect rect description
 */
-(void)drawRect:(CGRect)rect{
    
    for (CAShapeLayer *layer in self.layerArray)
    {
        [layer removeFromSuperlayer];
    }
    [self.layerArray removeAllObjects];
    
    
    [self initData];
    [self drawMiddlecircle];
    
    dispatch_queue_t queue = dispatch_queue_create("ldz.demo", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self drawOutCCircle_first];
        });
    });
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:first_animation_time];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self drawOutCCircle_second];
        });
    });
    dispatch_barrier_async(queue, ^{
        [NSThread sleepForTimeInterval:second_animation_time];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self drawOutCCircle_third];
        });
    });
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:third_animation_time];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self drawOutCCircle_fourth];
        });
    });
}

/*
 *中心标签设置
 */
- (void)initCenterLabel {
    CGFloat center =MIN(self.bounds.size.height/2, self.bounds.size.width/2);

    self.CGPoinCerter = CGPointMake(center, center);
    
    _orderCountView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2*center, 2*center)];
    [self addSubview: _orderCountView];

    self.centerLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 2*center, center)];
    self.centerLable.textAlignment = NSTextAlignmentCenter;
    self.centerLable.font = [UIFont systemFontOfSize:kNSPXFONTFLOAT(72)];
    self.centerLable.textColor = [UIColor colorWithHexString:@"#77c75e"];
    self.centerLable.backgroundColor = [UIColor clearColor];
//    self.centerLable.adjustsFontSizeToFitWidth = YES;
//    self.centerLable.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    self.contentMode = UIViewContentModeRedraw;
    [_orderCountView addSubview: self.centerLable];
    
    UILabel *yerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, center-5, 2*center, center)];
    yerLabel.font = [UIFont systemFontOfSize:kNSPXFONTFLOAT(26)];
    yerLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    yerLabel.text = @"本月订单";
    yerLabel.textAlignment = NSTextAlignmentCenter;
    yerLabel.backgroundColor = [UIColor clearColor];
//    yerLabel.adjustsFontSizeToFitWidth = YES;
    yerLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.contentMode = UIViewContentModeRedraw;
    [_orderCountView addSubview: yerLabel];
}

/**
 *  参数设置
 */
-(void)initData{
    //计算animation时间
    first_animation_time = self.animation_time * self.firstScale;
    second_animation_time = self.animation_time * self.secondScale;
    third_animation_time = self.animation_time * self.thirdScale;
    fourth_animation_time = self.animation_time * self.fourthScale;
    //半径计算
    radius = MIN(self.bounds.size.height/2-self.lineWith/2, self.bounds.size.width/2-self.lineWith/2);
//    self.centerLable.font = [UIFont systemFontOfSize:radius/3];
}

/**
 *  显示圆环 -- first
 */
-(void )drawOutCCircle_first{
    UIBezierPath *bPath_first = [UIBezierPath bezierPathWithArcCenter: self.CGPoinCerter radius:radius startAngle: M_PI * 0 endAngle: M_PI * self.firstScale * 2 clockwise: self.clockwise];
    
    CAShapeLayer *lineLayer_first = [ CAShapeLayer layer ];
    lineLayer_first.frame = _orderCountView.frame;
    lineLayer_first.fillColor = [UIColor clearColor].CGColor;
    lineLayer_first.path = bPath_first.CGPath;
    lineLayer_first.strokeColor = self.firstColor.CGColor;
    lineLayer_first.lineWidth = self.lineWith;
    
    CABasicAnimation *ani = [ CABasicAnimation animationWithKeyPath : NSStringFromSelector ( @selector (strokeEnd))];
    ani.fromValue = @0;
    ani.toValue = @1;
    ani.duration = first_animation_time;
    [lineLayer_first addAnimation:ani forKey:NSStringFromSelector(@selector(strokeEnd))];
    [self.layer addSublayer: lineLayer_first];
    [self.layerArray addObject:lineLayer_first];
}
/**
 *  显示圆环 -- second
 */
-(void )drawOutCCircle_second{
    UIBezierPath *bPath_second = [UIBezierPath bezierPathWithArcCenter: self.CGPoinCerter radius:radius startAngle: M_PI * 2 * self.firstScale endAngle: M_PI * 2 * (self.firstScale + self.secondScale) clockwise: self.clockwise];
    
    CAShapeLayer *lineLayer_second = [CAShapeLayer layer];
    lineLayer_second.frame = _orderCountView.frame;
    lineLayer_second.fillColor = [UIColor clearColor].CGColor;
    lineLayer_second.path = bPath_second.CGPath;
    lineLayer_second.strokeColor = self.secondColor.CGColor;
    lineLayer_second.lineWidth = self.lineWith;
    
    CABasicAnimation *ani = [ CABasicAnimation animationWithKeyPath : NSStringFromSelector(@selector(strokeEnd))];
    ani.fromValue = @0;
    ani.toValue = @1;
    ani.duration = second_animation_time;
    [lineLayer_second addAnimation:ani forKey:NSStringFromSelector(@selector(strokeEnd))];
    [self.layer addSublayer: lineLayer_second];
    [self.layerArray addObject:lineLayer_second];
}
/**
 *  显示圆环 -- third
 */
-(void )drawOutCCircle_third{
    UIBezierPath *bPath_third = [UIBezierPath bezierPathWithArcCenter: self.CGPoinCerter radius:radius startAngle: M_PI * 2 * (self.firstScale + self.secondScale) endAngle: M_PI * 2 * (self.firstScale + self.secondScale + self.thirdScale) clockwise: self.clockwise];
    
    CAShapeLayer *lineLayer_third = [CAShapeLayer layer];
    lineLayer_third.frame = _orderCountView.frame;
    lineLayer_third.fillColor = [UIColor clearColor].CGColor;
    lineLayer_third.path = bPath_third.CGPath;
    lineLayer_third.strokeColor = self.thirdColor.CGColor;
    lineLayer_third.lineWidth = self.lineWith;
    
    CABasicAnimation *ani = [ CABasicAnimation animationWithKeyPath : NSStringFromSelector(@selector(strokeEnd))];
    ani.fromValue = @0;
    ani.toValue = @1;
    ani.duration = third_animation_time;
    [lineLayer_third addAnimation:ani forKey:NSStringFromSelector(@selector(strokeEnd))];
    [self.layer addSublayer: lineLayer_third];
    [self.layerArray addObject:lineLayer_third];
}
/**
 *  显示圆环 -- fourth
 */
-(void )drawOutCCircle_fourth{
    UIBezierPath *bPath_fourth = [UIBezierPath bezierPathWithArcCenter: self.CGPoinCerter radius:radius+7 startAngle: 0 endAngle: M_PI * 2  clockwise: self.clockwise];
    
    CAShapeLayer *lineLayer_fourth = [CAShapeLayer layer];
    lineLayer_fourth.frame = _orderCountView.frame;
    lineLayer_fourth.fillColor = [UIColor clearColor].CGColor;
    lineLayer_fourth.path = bPath_fourth.CGPath;
    lineLayer_fourth.strokeColor = RGBA(119, 199, 93, .3).CGColor;
    lineLayer_fourth.lineWidth = 1.0f;
    
    CABasicAnimation *ani = [ CABasicAnimation animationWithKeyPath : NSStringFromSelector(@selector(strokeEnd))];
    ani.fromValue = @0;
    ani.toValue = @1;
    ani.duration = fourth_animation_time;
    [lineLayer_fourth addAnimation:ani forKey:NSStringFromSelector(@selector(strokeEnd))];
    [self.layer addSublayer: lineLayer_fourth];
    [self.layerArray addObject:lineLayer_fourth];

}
/**
 *  辅助圆环
 */
-(void)drawMiddlecircle{
    UIBezierPath *cPath = [UIBezierPath bezierPathWithArcCenter:self.CGPoinCerter radius:radius startAngle:M_PI * 0 endAngle:M_PI * 2 clockwise:self.clockwise];
    cPath.lineWidth=self.lineWith;
    cPath.lineCapStyle = kCGLineCapRound;
    cPath.lineJoinStyle = kCGLineJoinRound;
    UIColor *color = self.unfillColor;
    [color setStroke];
    [cPath stroke];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
