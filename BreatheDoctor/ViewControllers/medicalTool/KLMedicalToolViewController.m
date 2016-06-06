//
//  KLMedicalToolViewController.m
//  BreatheDoctor
//
//  Created by liaowh on 16/6/3.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLMedicalToolViewController.h"
#import "KLGroupSenderLogViewController.h"

@interface KLMedicalToolViewController ()

@end

@implementation KLMedicalToolViewController

- (void)setupWithTableStyle:(UITableViewStyle)style{

    [super setupWithTableStyle:UITableViewStyleGrouped];
    
    self.tableView.rowHeight = 45*MULTIPLEVIEW;
    [super addNavBar:@"医学工具"];
    [super addBackButton:@"nav_btnBack"];
}

#pragma mark - nav
- (void)navLeftButtonAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - delegate
- (NSInteger)KL_tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
- (UITableViewCell *)KL_tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"群发助手";
        cell.textLabel.font = kNSPXFONT(28);
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    }
    
    cell.textLabel.text = @"群发助手";
    cell.imageView.image = kImage(@"doctor_qunfa_icon");
    
    return cell;
}
- (void)KL_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
    
        KLGroupSenderLogViewController *vc = [KLGroupSenderLogViewController new];
        vc.hidesBottomBarWhenPushed = YES;
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
