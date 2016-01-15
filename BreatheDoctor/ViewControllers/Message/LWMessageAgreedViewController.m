//
//  LWMessageAgreedViewController.m
//  BreatheDoctor
//
//  Created by comv on 16/1/4.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWMessageAgreedViewController.h"
#import "LWMessageAgreedCell.h"
#import "LWAgreedHeadCell.h"

@interface LWMessageAgreedViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray *titleArray;


@end

@implementation LWMessageAgreedViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [super addNavBar:@"患者申请"];
    [super addBackButton:@"nav_btnBack"];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleArray = @[@"真实姓名",
                        @"出生日期",
                        @"性        别",
                        @"身        高",
                        @"体        重"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)navLeftButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - tableviewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section == 0?1:section == 1?5:1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    if (indexPath.section == 0) {
        LWAgreedHeadCell *agreedHeadCell = [tableView dequeueReusableCellWithIdentifier:@"LWAgreedHeadCell" forIndexPath:indexPath];
        cell = agreedHeadCell;
    }else if (indexPath.section == 2)
    {
        LWMessageAgreedCell *agreedButtonCell = [tableView dequeueReusableCellWithIdentifier:@"LWMessageAgreedCell" forIndexPath:indexPath];
        cell = agreedButtonCell;
    }else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"CELL"];
            cell.textLabel.font = [UIFont systemFontOfSize:17];
            cell.selectionStyle = 0;
            cell.textLabel.textColor = [UIColor colorWithHexString:@"#999999"];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:17];
            cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"#333333"];
            UIView *line = [[UIView alloc] initWithFrame:CGRectZero];
            line.backgroundColor = RGBA(0, 0, 0, .3);
            line.tag = 999;
            [cell addSubview:line];
            line.sd_layout.bottomSpaceToView(cell,0).leftSpaceToView(cell,5).rightSpaceToView(cell,0).heightIs(.5);
        }
        UIView *line = [cell viewWithTag:999];
        line.sd_layout.leftSpaceToView(cell,5);
        
        cell.textLabel.text = self.titleArray[indexPath.row];
        if (indexPath.row == 0) {
            cell.detailTextLabel.text = @"lang";
        }else if (indexPath.row == 1)
        {
            cell.detailTextLabel.text = @"lang";
            
        }else if (indexPath.row == 2)
        {
            cell.detailTextLabel.text = @"lang";
            
        }else if (indexPath.row == 3)
        {
            cell.detailTextLabel.text = @"lang";

        }else if (indexPath.row == 4)
        {
            cell.detailTextLabel.text = @"lang";
            line.sd_layout.leftSpaceToView(cell,0);
        }
        
    }
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.section == 0?90:indexPath.section == 2?90:55;
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
