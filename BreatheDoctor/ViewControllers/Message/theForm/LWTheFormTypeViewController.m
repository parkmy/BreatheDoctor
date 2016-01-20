//
//  LWTheFormTypeViewController.m
//  BreatheDoctor
//
//  Created by comv on 15/12/30.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWTheFormTypeViewController.h"
#import "LWTheFormViewController.h"
#import "YRJSONAdapter.h"
#import "LWPatientBiaoDanBody.h"

@interface LWTheFormTypeViewController ()
@property (nonatomic, strong) NSMutableArray *dataArray;
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
    
    [self loadData];
}
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)loadData
{
    if (self.showType == showTheFormTypeBiaoDan) {
        [LWProgressHUD displayProgressHUD:self.view displayText:@"请稍后..."];
        [LWHttpRequestManager httploadPatientFirstDiagnosticList:self.patientId Success:^(NSMutableArray *models) {
            [LWProgressHUD closeProgressHUD:self.view];
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:models];
            [self.tableView reloadData];
        } failure:^(NSString *errorMes) {
            [LWProgressHUD closeProgressHUD:self.view];
        }];
    }
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
    return _showType == showTheFormTypeMouKuai?1:self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.accessoryType = 1;
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.textLabel.textColor  = [UIColor colorWithHexString:@"#333333"];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.adjustsFontSizeToFitWidth = YES;
        UIView *line = [[UIView alloc] initWithFrame:CGRectZero];
        line.backgroundColor = RGBA(0, 0, 0, .3);
        [cell addSubview:line];
        
        line.sd_layout.bottomSpaceToView(cell,0).leftSpaceToView(cell,0).rightSpaceToView(cell,0).heightIs(.5);
    }
    if (self.showType == showTheFormTypeMouKuai)
    {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"哮喘患者初诊模块";
            cell.imageView.image = kImage(@"biaodan2");
        }
    }else{
        LWPatientBiaoDanBody *model = self.dataArray[indexPath.row];
        cell.textLabel.text = @"哮喘患者初诊模块";
        cell.imageView.image = kImage(@"biaodan2");
        cell.detailTextLabel.text = model.createDt;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    LWTheFormViewController *vc = (LWTheFormViewController *)[UIViewController CreateControllerWithTag:CtrlTag_TheForm];
    vc.showType = self.showType;
    vc.patientId = self.patientId;
    if (self.showType != showTheFormTypeMouKuai)
    {
        LWPatientBiaoDanBody *model = self.dataArray[indexPath.row];
        vc.foreignId = model.sid;
        vc.model = model;
    }
    [self.navigationController pushViewController:vc animated:YES];
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
