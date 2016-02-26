//
//  LWOrderCell.m
//  BreatheDoctor
//
//  Created by comv on 16/2/22.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWOrderCell.h"
#import "DZ_ScaleCircle.h"

@interface LWOrderCell ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *typeViews;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableHeight;

@property (weak, nonatomic) IBOutlet DZ_ScaleCircle *ScaleCircle;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;


@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *scWith;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomHight;
@property (weak, nonatomic) IBOutlet UIView *typeView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *typeTop;
@property (weak, nonatomic) IBOutlet UIView *typeView4;

@end

@implementation LWOrderCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadXib];
    }
    
    return self;
}

- (void)setLW_DateLabelText:(NSString *)string
{
    if (string.length <= 0) {
        return;
    }
    
    NSArray *strArray = [string componentsSeparatedByString:@"月"];
    NSString *str1 = strArray[0];
    
    NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:string];
    [attributed addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:25],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#333333"]} range:NSMakeRange(0, str1.length)];
    _orderView.dateLabel.attributedText = attributed;
    
}

//- (id)initWithCoder:(NSCoder *)aDecoder
//{
//    self = [super initWithCoder:aDecoder];
//    if (self) {
//        [self loadXib];
//    }
//    return self;
//}

- (void)loadXib
{
    self.layer.cornerRadius = 5.f;
    self.layer.masksToBounds = YES;
    
    _orderView = [[[NSBundle mainBundle] loadNibNamed:@"LWOrderCell" owner:self options:nil] lastObject];
    
    //  四个区域所占的比例
    _orderView.ScaleCircle.firstScale = 0.1;
    _orderView.ScaleCircle.secondScale = 0.2;
    _orderView.ScaleCircle.thirdScale = 0.7;
    //    circle.fourthScale = 0.4;
    //  线宽
    _orderView.ScaleCircle.lineWith = 6.0f;
    _orderView.ScaleCircle.animation_time = .1;
    
    _orderView.ScaleCircle.centerLable.text = @"1234";
    _orderView.tableView.rowHeight = 40;
    if (iPhone6) {
        _orderView.tableHeight.constant = 150;
        _orderView.tableView.rowHeight = 150/3;

    }else if (iPhone6Add){
        _orderView.tableHeight.constant = 165;
        _orderView.tableView.rowHeight = 165/3;

    }
    if (screenHeight < 490) {
//        for (NSLayoutConstraint *constraint in _orderView.scWith) {
//            constraint.constant = 100;
//        }
//        _orderView.bottomHight.constant = 10.0f;
        _orderView.typeTop.constant = 5;
        _orderView.typeView.hidden = YES;
    }else
    {
        _orderView.typeView4.hidden = YES;
        if (iPhone6) {
            _orderView.typeTop.constant = 40;
            _orderView.bottomHight.constant = 33;

        }else if (iPhone6Add)
        {
            _orderView.typeTop.constant = 55;
            _orderView.bottomHight.constant = 55;
        }else if (iPhone5){
            _orderView.bottomHight.constant -= 10;
        }
    }
    for (UIView *view in _orderView.typeViews) {
        
        [view setCornerRadius:3.0f];
        UIColor *color = nil;
        if (view.tag == 0) {
            color = [UIColor colorWithHexString:@"#77c75e"];
        }else if (view.tag == 1)
        {
            color = [UIColor colorWithHexString:@"#febf47"];
        }else
        {
            color = [UIColor colorWithHexString:@"#ff6666"];
        }
        view.backgroundColor = color;
    }
    _orderView.frame = self.bounds;
    [self addSubview:_orderView];

//    __weak typeof(self)weakSelf = self;
//    
//    [_orderView setDidSelectRowBlock:^(NSIndexPath *index) {
//        weakSelf.didSelectRowBlock?weakSelf.didSelectRowBlock(index):nil;
//    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 3;

}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return .1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        cell.accessoryType = 1;
        cell.selectionStyle = 0;
    }
    
    if (indexPath.row == 0) {
    
        cell.imageView.image = kImage(@"shangpindingdan");
        cell.textLabel.text = @"商品订单";
        cell.detailTextLabel.text = @"4单";

    }else if (indexPath.row == 1)
    {
        cell.imageView.image = kImage(@"tuwendingdan");
        cell.textLabel.text = @"图文订单";
        cell.detailTextLabel.text = @"4单";

    }else if (indexPath.row == 2)
    {
        cell.imageView.image = kImage(@"dianhuadingdan");
        cell.textLabel.text = @"电话订单";
        cell.detailTextLabel.text = @"4单";
    
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    _orderView.didSelectRowBlock?_orderView.didSelectRowBlock(indexPath):nil;
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectRowIndex:)]) {
        [_delegate didSelectRowIndex:indexPath];
    }

}

@end
