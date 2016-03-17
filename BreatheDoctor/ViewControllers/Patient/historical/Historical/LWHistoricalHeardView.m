//
//  LWBaseHistoricalHeardView.m
//  BreatheDoctor
//
//  Created by comv on 16/3/15.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWHistoricalHeardView.h"

@implementation LWHistoricalHeardView

- (id)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor grayColor];
        
        [self addSubview:self.footLabel];
        [self addSubview:self.leftView];
        [self addSubview:self.rightView];
        
        [self.leftView addSubview:self.breadView];
        [self.rightView addSubview:self.tableView];
        
        self.footLabel.sd_layout.leftSpaceToView(self,10).rightSpaceToView(self,10).bottomSpaceToView(self,15).heightIs(25);
        self.leftView.sd_layout.leftSpaceToView(self,0).widthRatioToView(self,.5).topSpaceToView(self,0).bottomSpaceToView(self.footLabel,15);
        self.rightView.sd_layout.rightSpaceToView(self,0).leftSpaceToView(self.leftView,0).topSpaceToView(self,0).bottomSpaceToView(self.footLabel,15);
        
        self.breadView.sd_layout.widthIs(104).heightIs(104).centerYEqualToView(self.leftView).rightSpaceToView(self.leftView,10);
        self.tableView.sd_layout.widthIs(104).heightIs(104).centerYEqualToView(self.rightView).leftSpaceToView(self.rightView,10);
        
    }
    return self;
}

//- (UILabel *)fistLabel
//{
//    if (!_fistLabel) {
//        _fistLabel = [self allocLabel];
//    }
//    return _fistLabel;
//}
//- (UILabel *)secondLabel
//{
//    if (!_secondLabel) {
//        _secondLabel = [self allocLabel];
//    }
//    return _secondLabel;
//}
//- (UILabel *)thirdLabel
//{
//    if (!_thirdLabel) {
//        _thirdLabel = [self allocLabel];
//    }
//    return _thirdLabel;
//}
//- (UILabel *)allocLabel
//{
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
//    label.font = kNSPXFONT(30);
//    label.textColor = [UIColor colorWithHexString:@"#333333"];
//    return label;
//}
- (UIView *)breadView
{
    if (!_breadView) {
        _breadView = [UIView new];
        _breadView.backgroundColor = [UIColor redColor];
    }
    return _breadView;
}

- (UIView *)leftView
{
    if (!_leftView) {
        _leftView = [UIView new];
        _leftView.backgroundColor = [UIColor orangeColor];

    }
    return _leftView;
}
- (UIView *)rightView
{
    if (!_rightView) {
        _rightView = [UIView new];
        _rightView.backgroundColor = [UIColor greenColor];
    }
    return _rightView;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    }
    return _tableView;
}
- (UILabel *)footLabel
{
    if (!_footLabel) {
        _footLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _footLabel.textAlignment = 1;
        _footLabel.font = kNSPXFONT(28);
        _footLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _footLabel.text = @"[[UILabel alloc] initWithFrame:CGRectZero]";
    }
    return _footLabel;
}
@end
