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
    
    self.tableView.sectionFooterHeight = .1;
}

#pragma mark -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (indexPath.section == 0) {
        LWPatientCenterCell *patientCenterCell = [tableView dequeueReusableCellWithIdentifier:@"LWPatientCenterCell" forIndexPath:indexPath];
        [patientCenterCell setPatient:self.patient];
        cell = patientCenterCell;
        
    }else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
            cell.accessoryType = 1;
        }
        
        cell.textLabel.text = indexPath.section == 1?@"个人基本档案":@"患者日志";
        
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
    
    if (indexPath.section == 1)
    {
        LWPatientRecordsCtr *patientRecords = (LWPatientRecordsCtr *)[UIViewController CreateControllerWithTag:CtrlTag_PatientRecords];
        patientRecords.patient = self.patient;
        [self.navigationController pushViewController:patientRecords animated:YES];
    }else if (indexPath.section == 0){
        
        LWPatientRemarksCtr *patientRemarks = (LWPatientRemarksCtr *)[UIViewController CreateControllerWithTag:CtrlTag_PatientRemarks];
        [patientRemarks setPatient:self.patient];

        [self.navigationController pushViewController:patientRemarks animated:YES];
    }else if (indexPath.section == 2)
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
