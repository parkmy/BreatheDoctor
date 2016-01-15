//
//  LWPatientCententCtr.m
//  BreatheDoctor
//
//  Created by comv on 15/11/10.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWPatientCententCtr.h"
#import "LWPatientCenterCell.h"
#import "LWPatientRecordsCtr.h"
#import "LWPatientRemarksCtr.h"
#import "LWPatientLogViewController.h"
#import "LWTheFormViewController.h"

@interface LWPatientCententCtr ()

@end

@implementation LWPatientCententCtr

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [super addNavBar:@"患者个人中心"];
    [super addBackButton:@"nav_btnBack.png"];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    setExtraCellLineHidden(self.tableView);
}

#pragma mark -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (indexPath.row == 0) {
        LWPatientCenterCell *patientCenterCell = [tableView dequeueReusableCellWithIdentifier:@"LWPatientCenterCell" forIndexPath:indexPath];
        [patientCenterCell setPatient:self.patient];
        cell = patientCenterCell;
        
    }else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
            
            UIView *line = [[UIView alloc] initWithFrame:CGRectZero];
            line.backgroundColor = RGBA(0, 0, 0, .2);
            [cell addSubview:line];
            cell.accessoryType = 1;
            
            cell.textLabel.textColor = [UIColor colorWithHexString:@"#333333"];
            line.sd_layout.leftSpaceToView(cell,0).rightSpaceToView(cell,0).bottomSpaceToView(cell,0).heightIs(.5);
        }
        cell.imageView.image = indexPath.row == 1?kImage(@"biaodan2"):indexPath.row == 2?kImage(@"bingqingxiangguan"):kImage(@"huanzherizhi");
        cell.textLabel.text = indexPath.row == 1?@"已填表单":indexPath.row == 2?@"患者病情相关":@"患者日志";
        
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 180;
    }
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 1)
    {
        LWTheFormViewController *vc = (LWTheFormViewController *)[UIViewController CreateControllerWithTag:CtrlTag_TheForm];
        vc.showType = showTheFormTypeBiaoDan;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 0){
        
        LWPatientRemarksCtr *patientRemarks = (LWPatientRemarksCtr *)[UIViewController CreateControllerWithTag:CtrlTag_PatientRemarks];
        [patientRemarks setPatient:self.patient];

        [self.navigationController pushViewController:patientRemarks animated:YES];
    }else if (indexPath.row == 2)
    {

        
        [self.navigationController pushViewController:[UIViewController CreateControllerWithTag:CtrlTag_PatientRelated] animated:YES];
        

        
    }else if (indexPath.row == 3)
    {
                LWPatientLogViewController *patientLog = (LWPatientLogViewController *)[UIViewController CreateControllerWithTag:CtrlTag_PatientLog];
                patientLog.patientId = self.patient.patientId;
                patientLog.patientName = self.patient.patientName;
                [self.navigationController pushViewController:patientLog animated:YES];
    }
}


- (void)navLeftButtonAction
{
    if (_backBlock) {
        _backBlock ();
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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