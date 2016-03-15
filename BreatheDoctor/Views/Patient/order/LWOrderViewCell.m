//
//  LWOrderViewCell.m
//  BreatheDoctor
//
//  Created by comv on 16/3/9.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWOrderViewCell.h"
#import "DZ_ScaleCircle.h"
#import "LWOrderCellTypeView.h"

static const CGFloat dateLabelHeight = 25.f;
static const CGFloat scaleCircleWH  = 144.f;

@interface LWOrderViewCell ()<UITableViewDataSource,UITableViewDelegate>
{
    UIView         *circleView;
    DZ_ScaleCircle *scaleCircle;
    
    UITableView    *footTableView;
    LWOrderCellTypeView *typeView;
    UILabel        *dateLabel;
}
@property (nonatomic, strong) LWOrderListModel *model;

@end

@implementation LWOrderViewCell


- (id)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        [self setCornerRadius:8.0f];
        
        dateLabel = [UILabel new];
        dateLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        dateLabel.font = [UIFont systemFontOfSize:kNSPXFONTFLOAT(24)];
        [self addSubview:dateLabel];
        
        circleView = [UIView new];
        scaleCircle = [DZ_ScaleCircle new];
        scaleCircle.lineWith = 5.0f;
        scaleCircle.animation_time = .1;
        scaleCircle.centerLable.text = @"--";
        [circleView addSubview:scaleCircle];
        [self addSubview:circleView];
        
        UIView *line = [UIView new];
        line.backgroundColor = appLineColor;
        [self addSubview:line];
        
        CGFloat a = iPhone6?1.2:iPhone6Add?1.5:1;

        CGFloat rowHeight = 45*a * .8;
        footTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        footTableView.scrollEnabled = NO;
        footTableView.separatorStyle = 0;
        footTableView.dataSource= self;
        footTableView.delegate = self;
        footTableView.rowHeight = rowHeight;
        [self addSubview:footTableView];
        
        typeView = [LWOrderCellTypeView new];
        [self addSubview:typeView];
        
        dateLabel.sd_layout.leftSpaceToView(self,appMargin).rightSpaceToView(self,appMargin).topSpaceToView(self,appMargin).heightIs(dateLabelHeight);
        footTableView.sd_layout.leftSpaceToView(self,0).rightSpaceToView(self,0).bottomSpaceToView(self,0).heightIs(rowHeight*3);
        line.sd_layout.leftSpaceToView(self,0).rightSpaceToView(self,0).bottomSpaceToView(footTableView,0).heightIs(1);
        typeView.sd_layout.centerXEqualToView(self).bottomSpaceToView(footTableView,iPhone4?5:20).heightIs(35*MULTIPLE).widthIs(scaleCircleWH*a*1.3);
        circleView.sd_layout.leftSpaceToView(self,0).rightSpaceToView(self,0).topSpaceToView(dateLabel,0).bottomSpaceToView(typeView,0);
        scaleCircle.sd_layout.widthIs(scaleCircleWH*a).heightIs(scaleCircleWH*a).centerXEqualToView(circleView).centerYEqualToView(circleView);

    }
    return self;
}

- (void)setOrderCellData:(LWOrderListModel *)model
{
    self.model = model;
    scaleCircle.model = self.model;

    if (model.orderSum > 0) {
        scaleCircle.centerLable.text = [NSString stringWithFormat:@"%ld",model.orderSum];
        scaleCircle.centerLable.textColor = [UIColor colorWithHexString:@"#77c75a"];
        scaleCircle.firstScale  =  model.productOrderNum/(CGFloat)model.orderSum;
        scaleCircle.secondScale = model.graphicOrderNum/(CGFloat)model.orderSum;
        scaleCircle.thirdScale  = model.phoneOrderNum/(CGFloat)model.orderSum;
        [scaleCircle setNeedsDisplay];
        
    }else
    {
        scaleCircle.centerLable.text = @"--";
        scaleCircle.centerLable.textColor = [UIColor colorWithHexString:@"#cccccc"];
        
        scaleCircle.firstScale = 0;
        scaleCircle.secondScale = 0;
        scaleCircle.thirdScale = 0;
        [scaleCircle setNeedsDisplay];
    }
    [self setLW_DateLabelText:model.orderDate];
    [footTableView reloadData];

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
    dateLabel.attributedText = attributed;
    
}

#pragma mark -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
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
        line.backgroundColor = appLineColor;
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
    
    if (indexPath.row == 0)
    {
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
