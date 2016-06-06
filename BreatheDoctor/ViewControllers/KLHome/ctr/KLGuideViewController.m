//
//  KLGuideViewController.m
//  BreatheDoctor
//
//  Created by liaowh on 16/6/6.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLGuideViewController.h"
#import "KLDoctorPatientBindingViewController.h"
#import "KLPlatformServicesViewController.h"

@interface KLGuideViewController ()
@property (nonatomic, strong) UILabel *headerLabel;
@end

@implementation KLGuideViewController

- (void)setupWithTableStyle:(UITableViewStyle)style{

    [super setupWithTableStyle:style];

    [super addNavBar:@"操作指南"];
    [super addBackButton:@"nav_btnBack"];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f1f1f1"];
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"#f1f1f1"];
    self.tableView.rowHeight = 50*MULTIPLE;

    self.tableView.tableHeaderView = self.headerLabel;
}
#pragma mark - init
- (UILabel *)headerLabel{
    
    if (!_headerLabel) {
        
        _headerLabel = [UILabel new];
        _headerLabel.font = kNSPXFONT(30);
        _headerLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _headerLabel.frame = CGRectMake(0, 0, 40*MULTIPLE, 40*MULTIPLE);
        _headerLabel.text = @"   使用指南";
    }
    return _headerLabel;
}
#pragma mark - nav
- (void)navLeftButtonAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - delegate
- (NSInteger)KL_tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

- (UITableViewCell *)KL_tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = kNSPXFONT(32);
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    }
    
    if (indexPath.row == 0) {
        
        cell.textLabel.text = @"如何进行医患绑定";
    }else if (indexPath.row == 1){
    
        cell.textLabel.text = @"怎么开通平台服务";
    }
    
    return cell;
}

- (void)KL_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        
        KLDoctorPatientBindingViewController *vc = [KLDoctorPatientBindingViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 1){
        
        KLPlatformServicesViewController *vc = [KLPlatformServicesViewController new];
        [self.navigationController pushViewController:vc animated:YES];

    }
    
    
}

- (CGFloat)KL_tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return .1;
}

- (CGFloat)KL_tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return .1;
}


@end
