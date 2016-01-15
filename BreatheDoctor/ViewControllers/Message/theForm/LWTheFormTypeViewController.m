//
//  LWTheFormTypeViewController.m
//  BreatheDoctor
//
//  Created by comv on 15/12/30.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWTheFormTypeViewController.h"
#import "LWTheFormViewController.h"


@interface LWTheFormTypeViewController ()

@end

@implementation LWTheFormTypeViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [super addNavBar:@"选择量表"];
    [super addBackButton:@"nav_btnBack"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.rowHeight = 60;
    self.tableView.separatorStyle = 0;
    setExtraCellLineHidden(self.tableView);
}

- (void)navLeftButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableviewdelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.accessoryType = 1;
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.textLabel.textColor  = [UIColor colorWithHexString:@"#333333"];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectZero];
        line.backgroundColor = RGBA(0, 0, 0, .3);
        [cell addSubview:line];
        
        line.sd_layout.bottomSpaceToView(cell,0).leftSpaceToView(cell,0).rightSpaceToView(cell,0).heightIs(.5);
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"哮喘患者初诊模块";
        cell.imageView.image = kImage(@"biaodan2");
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        LWTheFormViewController *vc = (LWTheFormViewController *)[UIViewController CreateControllerWithTag:CtrlTag_TheForm];
        vc.showType = showTheFormTypeMouKuai;
        [self.navigationController pushViewController:vc animated:YES];
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
