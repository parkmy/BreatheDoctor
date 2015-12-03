//
//  LWPersonalCtr.m
//  BreatheDoctor
//
//  Created by comv on 15/11/10.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWPersonalCtr.h"
#import "LWPersonalCell.h"
#import "LWPersonalHeardCell.h"
#import "CODataCacheManager.h"

@interface LWPersonalCtr ()

@end

@implementation LWPersonalCtr
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [super addNavBar:@"个人中心"];
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (indexPath.section == 0) {
        LWPersonalHeardCell *personalHeardCell = [tableView dequeueReusableCellWithIdentifier:@"LWPersonalHeardCell" forIndexPath:indexPath];
        LBLoginBaseModel *user = [CODataCacheManager shareInstance].userModel;
        [personalHeardCell setDoctorIconImage:user.body.perRealPhoto];
        [personalHeardCell setDoctordoctorName:user.body.perName];
        [personalHeardCell setDoctorType:user.body.positionText];
        
        cell = personalHeardCell;
        
    }else
    {
        LWPersonalCell *personalCell = [tableView dequeueReusableCellWithIdentifier:@"LWPersonalCell" forIndexPath:indexPath];
        cell = personalCell;
    
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 80;
    }
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return .1;
    }
    return 15;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1) {
        [self.navigationController pushViewController:[UIViewController CreateControllerWithTag:CtrlTag_PersonalSeting] animated:YES];
    }else if (indexPath.section == 0)
    {
        [self.navigationController pushViewController:[UIViewController CreateControllerWithTag:CtrlTag_PersonalCenter] animated:YES];

    }
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
