//
//  KLPEFItmLineView.m
//  BreatheDoctor
//
//  Created by comv on 16/3/28.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLPEFItmLineView.h"
#import "CoordinateItem.h"
#import "KLPEFBubbleView.h"

#define ANIMATION_DURING 2
#define LINE_WIDTH  1


@interface KLPEFItmLineView()
{
    LWLineButton *showButton;
}
//折线和标点的颜色
@property (strong, nonatomic) UIColor *lineAndPointColor;

//是否动态绘制
@property (assign, nonatomic) BOOL isAnimation;

@property (nonatomic, strong) NSMutableArray *lines;
@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, strong) KLPEFBubbleView *bubbleView;

@end
@implementation KLPEFItmLineView

/**
 *  @author li_yong
 *
 *  构建方法
 *
 *  @param dataSource  数据源
 *  @param color       折线点和折线的颜色
 *  @param isAnimation 是否动态绘制
 *
 *  @return
 */
- (id)initWithDataSource:(NSMutableArray *)dataSource
   withLineAndPointColor:(UIColor *)color
           withAnimation:(BOOL)isAnimation withFram:(CGRect)rect
{
    self = [super initWithDataSource:dataSource withFram:rect];
    if (self)
    {
        self.lineAndPointColor = [LWThemeManager shareInstance].navBackgroundColor;
        self.isAnimation = isAnimation;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
- (NSMutableArray *)lines
{
    if (!_lines) {
        _lines = [NSMutableArray array];
    }
    return _lines;
}
- (NSMutableArray *)buttons
{
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    
    [self removeBubbleView];
    
    CGFloat spa = (self.frame.size.height - MARGIN_TOP*2)/800;
    
    CGContextRef currentCtx = UIGraphicsGetCurrentContext();
    
    
    CGContextSetStrokeColorWithColor(currentCtx, self.lineAndPointColor.CGColor);
    CGContextSetLineWidth(currentCtx, 1);
    
    //绘制坐标点
    NSMutableArray *coordinateArray = [NSMutableArray array];
    NSMutableArray *initCoordinateArray = [NSMutableArray array];
    
    [coordinateArray removeAllObjects];
    [initCoordinateArray removeAllObjects];
    
    for (int index = 0; index<[self.dataSource count]; index++)
    {
        CoordinateItem *item = [self.dataSource objectAtIndex:index];
        /**
         *  self.dashedSpace/self.yNumberSpace:计算纵轴上点与点间距(1和2、2和3)
         */
        CGFloat x ;
        if (item.isMorning) {
            x = (MARGIN_LEFT + self.dashedSpace/2) + ([item.coordinateXValue integerValue] * (self.dashedSpace*2));
        }else
        {
            x = (MARGIN_LEFT + self.dashedSpace + self.dashedSpace/2) + (([item.coordinateXValue integerValue]) * (self.dashedSpace*2));
        }
        
        CGPoint itemCoordinate = CGPointMake(x,
                                             self.frame.size.height - (MARGIN_TOP + [item.coordinateYValue integerValue]*spa));
        //        CGContextSetFillColorWithColor(currentCtx, item.itemColor.CGColor);
        //记录坐标点
        [coordinateArray addObject:NSStringFromCGPoint(itemCoordinate)];
        //        CGContextAddArc(currentCtx, itemCoordinate.x, itemCoordinate.y, 4, 0, 2*M_PI, 1);
        CGContextFillPath(currentCtx);
        //记录初始化坐标点，方便后续动画
        itemCoordinate.y = self.frame.size.height - MARGIN_TOP;
        [initCoordinateArray addObject:NSStringFromCGPoint(itemCoordinate)];
    }
    CGContextStrokePath(currentCtx);
    
    
    
    for (CAShapeLayer *lineLayer in self.lines) {
        [lineLayer removeFromSuperlayer];
    }
    [self.lines removeAllObjects];
    
    if ([coordinateArray count] > 0) {
        
        //绘制折线
        //避免折线虚线化
        CGContextSetLineDash(currentCtx, 0, 0, 0);
        //绘图路线
        CGMutablePathRef path = CGPathCreateMutable();
        
        for (int index = 0; index<[coordinateArray count] - 1; index++)
        {
            //一段折线开始点
            NSString *startPointStr = [coordinateArray objectAtIndex:index];
            CGPoint startPoint = CGPointFromString(startPointStr);
            
            //一段折线结束点
            NSString *endPointStr = [coordinateArray objectAtIndex:index+1];
            CGPoint endPoint = CGPointFromString(endPointStr);
            
            //绘制图线方法一：每一段折线都是用一个path,动画过程就变成分动动画,而且是同时执行的。
            //        [self drawLineWithStartPoint:startPoint
            //                        withEndPoint:endPoint];
            
            //            //绘制图线方法二：所有的绘图信息放在同一个path中,动画过程就变成连续的了。
            [self drawLineWithPath:path
                    withStartPoint:startPoint
                      withEndPoint:endPoint];
            //
            //            for (CAShapeLayer *lineLayer in self.lines) {
            //                [self.layer addSublayer:lineLayer];
            //            }
            // 使用CoreGraphics直接绘制
            //             CGContextMoveToPoint(currentCtx, startPoint.x, startPoint.y);
            //             CGContextAddLineToPoint(currentCtx, endPoint.x, endPoint.y);
            
        }
        CGContextStrokePath(currentCtx);
        CGPathRelease(path);
        
    }
    
    for (UIView *view in self.buttons) {
        [view removeFromSuperview];
    }
    [self.buttons removeAllObjects];
    
    
    for (int index = 0; index<[self.dataSource count]; index++)
    {
        CoordinateItem *item = [self.dataSource objectAtIndex:index];
        /**
         *  self.dashedSpace/self.yNumberSpace:计算纵轴上点与点间距(1和2、2和3)
         */
        CGFloat x ;
        if (item.isMorning) {
            x = (MARGIN_LEFT + self.dashedSpace/2) + ([item.coordinateXValue integerValue] * (self.dashedSpace*2));
        }else
        {
            x = (MARGIN_LEFT + self.dashedSpace + self.dashedSpace/2) + (([item.coordinateXValue integerValue]) * (self.dashedSpace*2));
        }
        
        CGPoint itemCoordinate = CGPointMake(x,
                                             self.frame.size.height - (MARGIN_TOP + [item.coordinateYValue integerValue]*spa));
        
        
        CAShapeLayer *solidLine =  [CAShapeLayer layer];
        CGMutablePathRef solidPath =  CGPathCreateMutable();
        solidLine.lineWidth = 2.0f ;
        solidLine.strokeColor = item.itemColor.CGColor;
        solidLine.fillColor = item.itemColor.CGColor;
        CGPathAddEllipseInRect(solidPath, nil, CGRectMake(itemCoordinate.x-3,  itemCoordinate.y-3, 6, 6));
        solidLine.path = solidPath;
        CGPathRelease(solidPath);
        [self.layer addSublayer:solidLine];
        [self.lines addObject:solidLine];
        
        
        //这里可以修改点得颜色 item.itemColor.CGColor
        //        CGContextSetFillColorWithColor(currentCtx, item.itemColor.CGColor);
        //记录坐标点
        //        CGContextAddArc(currentCtx, itemCoordinate.x, itemCoordinate.y, 4, 0, 2*M_PI, 1);
        
        LWLineButton *button = [LWLineButton buttonWithType:UIButtonTypeCustom];
        button.bounds = CGRectMake(0, 0, 30, 30);
        button.center = CGPointMake(itemCoordinate.x, itemCoordinate.y);
        button.backgroundColor = [UIColor clearColor];
        [button addTarget:self action:@selector(linButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.itm = item;
        [self addSubview:button];
        [self.buttons addObject:button];
        
        //        CGContextFillPath(currentCtx);
        
    }
    CGContextStrokePath(currentCtx);
    
    
}

- (void)linButtonClick:(LWLineButton *)sender
{
    [self showBubbleView:sender];
}
- (void)removeBubbleView
{
    if (self.bubbleView) {
        [self.bubbleView removeFromSuperview];
        self.bubbleView = nil;
    }
}
- (void)showBubbleView:(LWLineButton *)sender{

    [self removeBubbleView];
    /**
     *  如果展示了 又是同一个 那么不展示
     */
    if (showButton == sender && sender.isShow) {
        showButton.isShow = NO;
        return;
    }
    _bubbleView = [[KLPEFBubbleView alloc] initWithFrame:CGRectMake(0, 0, 22*MULTIPLEVIEW, 14*MULTIPLEVIEW)];
    _bubbleView.fillColor = [LWThemeManager shareInstance].navBackgroundColor;
    [self addSubview:self.bubbleView];

    self.bubbleView.pefValue = sender.itm.logModel.pefValue;
    self.bubbleView.xCenter = sender.centerX;
    self.bubbleView.yCenter = sender.centerY-self.bubbleView.height/2 - 8*MULTIPLEVIEW;
    self.bubbleView.fillColor = sender.itm.itemColor;
    [self.bubbleView setNeedsDisplay];
    
    CABasicAnimation *pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    pulse.duration = .3;
    pulse.repeatCount = 1;
    pulse.autoreverses = YES;
    pulse.fromValue = [NSNumber numberWithFloat:.8];
    pulse.toValue = [NSNumber numberWithFloat:1.2];
    [self.bubbleView.layer addAnimation:pulse forKey:nil];
    
    sender.isShow  = YES;
//    isShow = YES;
    showButton = sender;
}

/**
 *  @author li_yong
 *
 *  绘制折线
 *
 *  @param startPoint     折线的开始点
 *  @param endPoint       折线的结束点
 */
- (void)drawLineWithStartPoint:(CGPoint)startPoint
                  withEndPoint:(CGPoint)endPoint
{
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.lineWidth = 1;
    lineLayer.lineCap = kCALineCapButt;
    lineLayer.strokeColor = self.lineAndPointColor.CGColor;
    lineLayer.fillColor = nil;
    
    CGMutablePathRef linePath = CGPathCreateMutable();
    CGPathMoveToPoint(linePath, nil, startPoint.x, startPoint.y);
    CGPathAddLineToPoint(linePath, nil, endPoint.x, endPoint.y);
    lineLayer.path = linePath;
    
    if (self.isAnimation)
    {
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.duration = ANIMATION_DURING;
        pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
        pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
        pathAnimation.autoreverses = NO;
        pathAnimation.fillMode = kCAFillModeForwards;
        [lineLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    }
    
    //    self.clipsToBounds = YES;
    [self.layer addSublayer:lineLayer];
    CGPathRelease(linePath);
}

/**
 *  @author li_yong
 *
 *  绘制折线
 *
 *  @param path       保存绘图信息的路径
 *  @param startPoint 折线的开始点
 *  @param endPoint   折线的结束点
 */
#define kjiange (5/2)
- (void)drawLineWithPath:(CGMutablePathRef )path
          withStartPoint:(CGPoint)startPoint
            withEndPoint:(CGPoint)endPoint
{
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.lineWidth = LINE_WIDTH;
    lineLayer.lineCap = kCALineCapButt;
    lineLayer.strokeColor = [LWThemeManager shareInstance].navBackgroundColor.CGColor;
    lineLayer.fillColor = nil;
    
    CGPathMoveToPoint(path, nil, startPoint.x, startPoint.y);
    CGPathAddLineToPoint(path, nil, endPoint.x, endPoint.y);
    lineLayer.path = path;
    
    if (self.isAnimation)
    {
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.duration = ANIMATION_DURING;
        pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
        pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
        pathAnimation.autoreverses = NO;
        pathAnimation.fillMode = kCAFillModeForwards;
        [lineLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    }
    [self.layer insertSublayer:lineLayer atIndex:0];
    //    [self.layer addSublayer:lineLayer];
    [self.lines addObject:lineLayer];
    //    self.clipsToBounds = YES;
}



@end
