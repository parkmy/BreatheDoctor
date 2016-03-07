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
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *typeLabels;

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
    [attributed addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kNSPXFONTFLOAT(40)],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#333333"]} range:NSMakeRange(0, str1.length)];
    _orderView.dateLabel.attributedText = attributed;
    
}
- (void)setOrderCellData:(LWOrderListModel *)model
{
    self.orderView.model = model;
    
    if (model.orderSum > 0) {
        _orderView.ScaleCircle.centerLable.text = [NSString stringWithFormat:@"%ld",model.orderSum];
        _orderView.ScaleCircle.centerLable.textColor = [UIColor colorWithHexString:@"#77c75a"];
        NSLog(@"--%f----%f-----%f",model.productOrderNum/(CGFloat)model.orderSum,model.graphicOrderNum/(CGFloat)model.orderSum,model.phoneOrderNum/(CGFloat)model.orderSum);
        
        _orderView.ScaleCircle.firstScale =  model.productOrderNum/(CGFloat)model.orderSum;
        _orderView.ScaleCircle.secondScale = model.graphicOrderNum/(CGFloat)model.orderSum;
        _orderView.ScaleCircle.thirdScale = model.phoneOrderNum/(CGFloat)model.orderSum;
        [self.orderView.ScaleCircle setNeedsDisplay];
        
    }else
    {
        _orderView.ScaleCircle.centerLable.text = @"--";
        _orderView.ScaleCircle.centerLable.textColor = [UIColor colorWithHexString:@"#cccccc"];

        _orderView.ScaleCircle.firstScale = 0;
        _orderView.ScaleCircle.secondScale = 0;
        _orderView.ScaleCircle.thirdScale = 0;
        [self.orderView.ScaleCircle setNeedsDisplay];
    }
    [self setLW_DateLabelText:model.orderDate];
    [self.orderView.tableView reloadData];

    
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
    _orderView.ScaleCircle.lineWith = 5.0f;
    _orderView.ScaleCircle.animation_time = .1;
    
    _orderView.ScaleCircle.centerLable.text = @"--";
    _orderView.tableView.rowHeight = 45*MULTIPLE;
    _orderView.tableHeight.constant = 45*3*MULTIPLE;

    _orderView.dateLabel.font = [UIFont systemFontOfSize:kNSPXFONTFLOAT(24)];
//    if (iPhone6) {
//
//    }else if (iPhone6Add){
//        _orderView.tableHeight.constant = 165;
//
//    }
    if (screenHeight < 490) {

        _orderView.tableView.rowHeight = 43;
        _orderView.tableHeight.constant = 43*3;
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
//            for (NSLayoutConstraint *constraint in _orderView.scWith) {
//                constraint.constant = 180;
//            }
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
//    for (UILabel *label in _orderView.typeLabels)
//    {
//        label.font = [UIFont systemFontOfSize:kNSPXFONTFLOAT(26)];
//    }
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];

        cell.selectionStyle = 0;
        
        
        UIImageView *typeimageView = [UIImageView new];
        typeimageView.tag = 1000;
        [cell addSubview:typeimageView];
        
        UIImage *image = kImage(@"tuwendingdan");
        typeimageView.sd_layout.leftSpaceToView(cell,10).centerYEqualToView(cell).widthIs(image.size.width).heightIs(image.size.height);

        UIImageView *rightImageView = [UIImageView new];
        rightImageView.image = kImage(@"yishengzhushou_14");
        [cell addSubview:rightImageView];
        UIView *line = [UIView new];
        line.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
        line.tag = 999;
        [cell addSubview:line];
        
        rightImageView.sd_layout.rightSpaceToView(cell,8).centerYEqualToView(cell).widthIs(15).heightIs(18);
        line.sd_layout.rightSpaceToView(cell,0).leftSpaceToView(cell,0).bottomSpaceToView(cell,0).heightIs(1);
        
        UILabel *countLabel = [UILabel new];
        countLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        countLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:kNSPXFONTFLOAT(30)];
        countLabel.textAlignment = NSTextAlignmentRight;
        [cell addSubview:countLabel];
        countLabel.tag = 888;
        countLabel.sd_layout.rightSpaceToView(rightImageView,5).centerYEqualToView(cell).widthIs(80).heightIs(20);
        
        UILabel *label = [UILabel new];
        label.tag = 777;
        [cell addSubview:label];
        label.font = [UIFont fontWithName:@"Helvetica-Light" size:kNSPXFONTFLOAT(30)];
        label.textColor = [UIColor colorWithHexString:@"#666666"];
        label.sd_layout.rightSpaceToView(countLabel,10).centerYEqualToView(cell).leftSpaceToView(typeimageView,8).heightIs(18);
    }
    
    UILabel *countLabel = (UILabel *)[cell viewWithTag:888];
    UIView *line = [cell viewWithTag:999];
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:777];
    UIImageView *typeimageView = [cell viewWithTag:1000];

    if (indexPath.row == 0) {
    
        typeimageView.image = kImage(@"shangpindingdan");
        titleLabel.text = @"商品订单";
        countLabel.text = [NSString stringWithFormat:@"%@单",kNSNumInteger(self.model.productOrderNum)];
        line.sd_layout.leftSpaceToView(cell,10);
    }else if (indexPath.row == 1)
    {
        typeimageView.image = kImage(@"tuwendingdan");
        titleLabel.text = @"图文订单";
        countLabel.text = [NSString stringWithFormat:@"%@单",kNSNumInteger(self.model.graphicOrderNum)];
        line.sd_layout.leftSpaceToView(cell,10);
    }else if (indexPath.row == 2)
    {
        typeimageView.image = kImage(@"dianhuadingdan");
        titleLabel.text = @"电话订单";
        countLabel.text = [NSString stringWithFormat:@"%@单",kNSNumInteger(self.model.phoneOrderNum)];
    
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    _orderView.didSelectRowBlock?_orderView.didSelectRowBlock(indexPath):nil;
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectRowIndex:andOrderModel:)]) {
        [_delegate didSelectRowIndex:indexPath andOrderModel:self.model];
    }

}

@end
