//
//  LWScaleCircleView.m
//  BreatheDoctor
//
//  Created by comv on 16/3/21.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWScaleCircleView.h"

@interface LWScaleCircleView ()
{
    CGFloat radius; //  半径
    
    CGFloat first_animation_time;
    CGFloat second_animation_time;
    CGFloat third_animation_time;
    CGFloat fourth_animation_time;
    UILabel *bottomLabel;
    UILabel *topLabel;

    UIView *_orderCountView;
}

@property(nonatomic) CGPoint CGPoinCerter;
@property(nonatomic) CGFloat endAngle;
@property(nonatomic) BOOL clockwise;

@property (nonatomic, strong) NSMutableArray *layerArray;

@end

@implementation LWScaleCircleView
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
    
    self.unfillColor = RGBA(119, 199, 93, .3);
    self.clockwise = YES;
    self.backgroundColor = [UIColor clearColor];
    
    self.firstColor = [UIColor colorWithHexString:@"#77c75e"];
    self.secondColor = [UIColor colorWithHexString:@"#febf47"];
    self.thirdColor = [UIColor colorWithHexString:@"#ff6666"];
    self.fourthColor = [UIColor colorWithHexString:@"#77c75e"];
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
    
    bottomLabel.hidden = !self.isShowBottomLabel;

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
    if (self.isFourth)
    {
        dispatch_async(queue, ^{
            [NSThread sleepForTimeInterval:third_animation_time];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self drawOutCCircle_fourth];
            });
        });
    }

}

- (void)layoutSubviews
{
    CGFloat center =MIN(self.bounds.size.height/2, self.bounds.size.width/2);
    self.CGPoinCerter = CGPointMake(center, center);
    
    _orderCountView.frame = CGRectMake(0, 0, 2*center, 2*center);
    self.centerLable.centerX = _orderCountView.width/2;
    self.centerLable.centerY = _orderCountView.height/2;
    topLabel.frame = CGRectMake(0, 15*MULTIPLEVIEW, 2*center, 20);
    self.centerLable.frame = CGRectMake(0, topLabel.maxY, 2*center, _orderCountView.height-topLabel.maxY-30*MULTIPLEVIEW);
    bottomLabel.frame = CGRectMake(0, self.centerLable.maxY, 2*center, 20);

}

/*
 *中心标签设置
 */
- (void)initCenterLabel {
    
    CGFloat center =MIN(self.bounds.size.height/2, self.bounds.size.width/2);
    NSLog(@"---%@",NSStringFromCGRect(self.frame));
    
    self.CGPoinCerter = CGPointMake(center, center);
    
    _orderCountView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2*center, 2*center)];
    
    [self addSubview: _orderCountView];
    
    self.centerLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 30*MULTIPLE, 2*center, 20)];
    self.centerLable.textAlignment = NSTextAlignmentCenter;
    self.centerLable.font = [UIFont systemFontOfSize:kNSPXFONTFLOAT(40)];
    self.centerLable.textColor = _centerTextColor?_centerTextColor:[UIColor colorWithHexString:@"#999999"];
    self.centerLable.backgroundColor = [UIColor clearColor];
    [_orderCountView addSubview: self.centerLable];
    
    bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, center-5, 2*center, 20)];
    bottomLabel.font = [UIFont systemFontOfSize:kNSPXFONTFLOAT(22)];
    bottomLabel.textColor = _centerLabelColor?_centerLabelColor:[UIColor colorWithHexString:@"#333333"];
    bottomLabel.text = @"L/min";
    bottomLabel.textAlignment = NSTextAlignmentCenter;
    bottomLabel.backgroundColor = [UIColor clearColor];
    [_orderCountView addSubview: bottomLabel];
    
    topLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 2*center, 20)];
    topLabel.font = [UIFont systemFontOfSize:kNSPXFONTFLOAT(22)];
    topLabel.textColor = _centerLabelColor?_centerLabelColor:[UIColor colorWithHexString:@"#333333"];
    topLabel.text = @"最近7天内";
    topLabel.textAlignment = NSTextAlignmentCenter;
    topLabel.backgroundColor = [UIColor clearColor];
    [_orderCountView addSubview: topLabel];
    
}
- (void)setdateText:(NSString *)string
{
    topLabel.text = stringJudgeNull(string);
}
//- (void)setToptextString:(NSString *)string{
//    topLabel.text = stringJudgeNull(string);
//}
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
    UIBezierPath *bPath_fourth = [UIBezierPath bezierPathWithArcCenter: self.CGPoinCerter radius:radius+4 startAngle: 0 endAngle: M_PI * 2  clockwise: self.clockwise];
    
    CAShapeLayer *lineLayer_fourth = [CAShapeLayer layer];
    lineLayer_fourth.frame = _orderCountView.frame;
    lineLayer_fourth.fillColor = [UIColor clearColor].CGColor;
    lineLayer_fourth.path = bPath_fourth.CGPath;
    lineLayer_fourth.strokeColor = self.fourthColor.CGColor;
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

@end
