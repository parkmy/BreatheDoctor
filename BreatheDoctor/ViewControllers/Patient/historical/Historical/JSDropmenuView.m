//
//  JSDropmenuView.m
//  ###
//
//  Created by jsfu on 16/1/19.
//  Copyright © 2016年 jsfu. All rights reserved.
//

#define MenuBackgroundColor [UIColor colorWithRed:75/255.0 green:82/255.0 blue:89/255.0 alpha:1.0]
#define MenuLineColor [UIColor colorWithRed:95/255.0 green:100/255.0 blue:104/255.0 alpha:1.0]

#import "JSDropmenuView.h"
#import "UIView+BorderLine.h"

@interface JSDropmenuViewCell : UITableViewCell

//@property(nonatomic,strong) UIImageView *icoImageView;

@property(nonatomic,strong) UILabel *titleLabel;

@property(nonatomic,strong) UIView *bgView;
@end

@implementation JSDropmenuViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = 0;
        [self setupView];
    }
    return self;
}

- (void)setupView {
   
    self.titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
    [self.titleLabel setCornerRadius:5.0f];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.textAlignment = 1;
    self.titleLabel.font = kNSPXFONT(28);
    [self addSubview:self.titleLabel];

    self.titleLabel.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    
}

@end


@interface JSDropmenuView ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic,strong) UIView *touchView;
@property(nonatomic,strong) UIView *showContainerView;
@property(nonatomic,strong) UITableView *mainTableView;
@property(nonatomic,strong) NSArray *dataArray;

@property(nonatomic) CGRect showContainerViewFrame;
@end

@implementation JSDropmenuView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if (self) {
        self.showContainerViewFrame = frame;
        [self setupView];
    }
    return self;
}

- (void)setupView {
    
    self.backgroundColor = [UIColor clearColor];
    self.touchView = ({
        UIView *touchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [self addSubview:touchView];
        touchView;
    });
    
    self.showContainerView = ({
        UIView *showContainerView = [[UIView alloc] initWithFrame:self.showContainerViewFrame];
        [self addSubview:showContainerView];
        showContainerView;
    });
    
    CAShapeLayer *layer = [CAShapeLayer new];
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(0, 8)];
    [path addLineToPoint:CGPointMake(8, 0)];
    [path addLineToPoint:CGPointMake(16, 8)];
    [path closePath];
    layer.path = path.CGPath;
    layer.lineWidth = 1.0;
    layer.fillColor = RGBA(0, 0, 0, .8).CGColor;
    CGPathRef bound = CGPathCreateCopyByStrokingPath(layer.path, nil, layer.lineWidth, kCGLineCapButt, kCGLineJoinMiter, layer.miterLimit);
    layer.bounds = CGPathGetBoundingBox(bound);
    CGPathRelease(bound);
    layer.position = CGPointMake(self.showContainerView.frame.size.width-16, 8.5);
    [self.showContainerView.layer addSublayer:layer];
    
    self.mainTableView = ({
        UITableView *mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 12, self.showContainerView.frame.size.width, self.showContainerView.frame.size.height-12)];
        mainTableView.backgroundColor = [UIColor clearColor];
        mainTableView.delegate = self;
        mainTableView.dataSource = self;
        mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        mainTableView.backgroundColor = [UIColor clearColor];
        mainTableView.scrollEnabled = NO;
        [self.showContainerView addSubview:mainTableView];
        mainTableView;
    });

    self.mainTableView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(12, 0, 0, 0));
    
    UIGestureRecognizer *tapBgViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeView:)];
    [self.touchView addGestureRecognizer:tapBgViewGesture];

}

#pragma - mark UITableViewDelegate UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.delegate && [self.delegate respondsToSelector:@selector(dropmenuDataSource)]) {
        return [[self.delegate dropmenuDataSource] count];
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 35*MULTIPLE;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *optionIdentifier = @"DropMenuTableViewCell";
    JSDropmenuViewCell *cell = [tableView dequeueReusableCellWithIdentifier:optionIdentifier];
    if (!cell) {
        cell = [[JSDropmenuViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:optionIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(dropmenuDataSource)]) {
        NSDictionary *itemDic = [[self.delegate dropmenuDataSource] objectAtIndex:indexPath.row];
        cell.titleLabel.text = [NSString stringWithFormat:@"%@", [itemDic objectForKey:@"title"]];
        if([[itemDic objectForKey:@"isSele"] boolValue])
        {
            cell.backgroundColor = RGBA(1, 1, 1, 1);
        }else
        {
            cell.backgroundColor = RGBA(0, 0, 0, .7);
        }

    }
    
    if (indexPath.row == 0) {
        CGRect f = cell.titleLabel.bounds;
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:f byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = f;
        maskLayer.path = maskPath.CGPath;
        cell.titleLabel.layer.mask = maskLayer;
    }else if (indexPath.row == 2)
    {
        CGRect f = cell.titleLabel.bounds;
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:f byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = f;
        maskLayer.path = maskPath.CGPath;
        cell.titleLabel.layer.mask = maskLayer;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(dropmenuView:didSelectedRow:)]) {
        [self.delegate dropmenuView:self didSelectedRow:indexPath.row];
        [self hideView:^{
            
        }];
    }
}

#pragma mark - property

#pragma mark - action
- (void)showViewInView:(UIView*)view {
    
    [view addSubview:self];
    [self setAnchorPoint:CGPointMake(0.9, 0) forView:self.showContainerView];
    self.showContainerView.transform = CGAffineTransformMakeScale(0.05, 0.05);
    
    [UIView animateWithDuration:0.3 animations:^{
        self.showContainerView.transform = CGAffineTransformMakeScale(0.99, 0.99);
    } completion:^(BOOL finished) {
        [self setAnchorPoint:CGPointMake(0.5, 0.5) forView:self.showContainerView];
        self.showContainerView.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view
{
    CGPoint oldOrigin = view.frame.origin;
    view.layer.anchorPoint = anchorPoint;
    CGPoint newOrigin = view.frame.origin;
    
    CGPoint transition;
    transition.x = newOrigin.x - oldOrigin.x;
    transition.y = newOrigin.y - oldOrigin.y;
    
    view.center = CGPointMake (view.center.x - transition.x, view.center.y - transition.y);
}

- (void)closeView:(id)sender {
    [self hideView:^{
        
    }];
}

- (void)hideView:(void (^)(void))block{
    
    [self setAnchorPoint:CGPointMake(0.9, 0) forView:self.showContainerView];
    [UIView animateWithDuration:0.3 animations:^{
        self.showContainerView.transform = CGAffineTransformMakeScale(0.05, 0.05);
    } completion:^(BOOL finished) {
        [self setAnchorPoint:CGPointMake(0.5, 0.5) forView:self.showContainerView];
        [self removeFromSuperview];
        block();
    }];
}

@end
