//
//  LWPatientRemarksCtr.m
//  BreatheDoctor
//
//  Created by comv on 15/11/11.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWPatientRemarksCtr.h"
#import "LWPatientRemarksIconCell.h"
#import "LWPatientRemarksTFCell.h"
#import "LWPatientGroupsCtr.h"

@interface LWPatientRemarksCtr ()
@property (nonatomic, copy) NSString *group;

@end

@implementation LWPatientRemarksCtr
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [super addNavBar:@"备注"];
    [super addBackButton:@"nav_btnBack.png"];
    [super addRightButton:@"确认"];
}
- (void)dealloc
{

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.sectionFooterHeight = .1;
    [self showTF];
    [self initProperty];
}
- (void)initProperty
{
    if ([self.patient.groupId isEqualToString:@"1"]) {
        self.group = @"未确认";
    }else if ([self.patient.groupId isEqualToString:@"2"])
    {
        self.group = @"完全控制";
    }else if ([self.patient.groupId isEqualToString:@"3"])
    {        self.group = @"部分控制";
    }else if ([self.patient.groupId isEqualToString:@"4"])
    {        self.group = @"未控制";
    }
}
- (void)showTF
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        LWPatientRemarksTFCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
        [cell.reamkNameLabel becomeFirstResponder];
    });
    
}
- (void)navLeftButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)navRightButtonAction
{
    
    [self.view endEditing:YES];
    
    LWPatientRemarksTFCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    NSString *remk = cell.reamkNameLabel.text;
    if (remk) {
        remk = [remk stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if (remk.length > 15) {
            [LWProgressHUD showALAlertBannerWithView:self.view Style:SALAlertBannerStyleWarning  Position:SALAlertBannerPositionTop Subtitle:@"对不起，请输入15字内的备注"];
            return;
        }
    }
    
    [LWProgressHUD displayProgressHUD:self.view displayText:@"正在修改..."];
    
    [LWHttpRequestManager httpPatientRemarkWithPatientId:self.patient.patientId groupId:self.patient.groupId remark:remk success:^(NSDictionary *dic) {
        [LWProgressHUD closeProgressHUD:self.view];
        self.patient.remark = remk;
        self.patient.controlLevel = [self.patient.groupId doubleValue];
        /* 更新数据库 */
        NSString *where = [NSString stringWithFormat:@"sid = %@",self.patient.sid];
        [[LKDBHelper getUsingLKDBHelper]updateToDB:self.patient where:where];
        [[NSNotificationCenter defaultCenter] postNotificationName:APP_UPDATEPATIENT_SUCC object:nil];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSString *errorMes) {
        [LWProgressHUD closeProgressHUD:self.view];
        [LWProgressHUD showALAlertBannerWithView:self.view Style:SALAlertBannerStyleWarning  Position:SALAlertBannerPositionTop Subtitle:errorMes];
    }];
    
    
}

#pragma mark - tableviewdelegae
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
        LWPatientRemarksIconCell *patientRemarksIconCell = [tableView dequeueReusableCellWithIdentifier:@"LWPatientRemarksIconCell" forIndexPath:indexPath];
        patientRemarksIconCell.selectionStyle = 0;
        [patientRemarksIconCell setPatient:self.patient];
        cell = patientRemarksIconCell;
        
    }else if (indexPath.section == 1){
        
        LWPatientRemarksTFCell *patientRemarksTFCell = [tableView dequeueReusableCellWithIdentifier:@"LWPatientRemarksTFCell" forIndexPath:indexPath];
        patientRemarksTFCell.reamkNameLabel.text = self.patient.remark;
        cell = patientRemarksTFCell;
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"CELL"];
            cell.accessoryType = 1;
        }
        cell.textLabel.text = @"分组";
        cell.detailTextLabel.text = stringJudgeNull(self.group);
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
    return 30;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return @"";
    }
    return section == 1?@"备注":@"分组";
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 2) {
        
        LWPatientGroupsCtr *patientGroupsCtr = (LWPatientGroupsCtr *)[UIViewController CreateControllerWithTag:CtrlTag_PatientGroups];
        [patientGroupsCtr setChooseGroup:^(NSString *grs, NSInteger tag) {
            if (tag  != 0) {
                self.patient.groupId = kNSString(kNSNumInteger(tag));
            }
            if(grs)
            {
                self.group = grs;
            }else
            {
                [self initProperty];
            }
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:0];
        }];
        [self.navigationController pushViewController:patientGroupsCtr animated:YES];
    }
    
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
