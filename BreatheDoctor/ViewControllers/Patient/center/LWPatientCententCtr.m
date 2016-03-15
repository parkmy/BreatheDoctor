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
#import "LWTheFormTypeViewController.h"
#import "LWPatientRelatedViewController.h"
#import "LWHistoricalRecordVC.h"

@interface LWPatientCententCtr ()
@property (nonatomic, strong) LWPatientRecordsBaseModel *patientRecordsModel;
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
    [UMSAgent event:@"patientCenter" label:@"患者个人中心"];
    
    setExtraCellLineHidden(self.tableView);
    [self loadPatientRecords];
    
}
- (void)loadPatientRecords
{
    if (!self.patientRecordsModel){
        [LWProgressHUD displayProgressHUD:self.view displayText:@"加载中..."];
    }
    [LWHttpRequestManager httpPantientArchivesWithPantientID:self.patient.patientId success:^(LWPatientRecordsBaseModel *patientRecordsBaseModel) {
        //        [self.tableView.mj_header endRefreshing];
        [LWProgressHUD closeProgressHUD:self.view];
        self.patientRecordsModel = patientRecordsBaseModel;
        [self.tableView reloadData];
        
    } failure:^(NSString *errorMes) {
        //        [self.tableView.mj_header endRefreshing];
        [LWProgressHUD closeProgressHUD:self.view.window];
        [LWProgressHUD showALAlertBannerWithView:self.view.window Style:SALAlertBannerStyleWarning  Position:SALAlertBannerPositionTop Subtitle:errorMes ];
    }];
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
        [patientCenterCell setPatientRecordsModel:self.patientRecordsModel];
        [patientCenterCell setPatient:self.patient];
        cell = patientCenterCell;
        
        [patientCenterCell setEditorButtonEventBlock:^{
            LWPatientRemarksCtr *patientRemarks = (LWPatientRemarksCtr *)[UIViewController CreateControllerWithTag:CtrlTag_PatientRemarks];
            [patientRemarks setPatient:self.patient];
            [self.navigationController pushViewController:patientRemarks animated:YES];
            [UMSAgent event:@"patientNote" label:@"患者备注"];

        }];
    }else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
            UIView *line = [[UIView alloc] initWithFrame:CGRectZero];
            line.backgroundColor = [UIColor  colorWithHexString:@"#cccccc"];
            [cell addSubview:line];

            line.sd_layout.leftSpaceToView(cell,0).rightSpaceToView(cell,0).bottomSpaceToView(cell,0).heightIs(.5);
            
            
            UIImageView *typeimageView = [UIImageView new];
            typeimageView.tag = 999;
            [cell addSubview:typeimageView];
            
            UIImage *image = kImage(@"bingqingxiangguan");
            typeimageView.sd_layout.leftSpaceToView(cell,10).centerYEqualToView(cell).widthIs(image.size.width).heightIs(image.size.height);
            
            UIImageView *rightImageView = [UIImageView new];
            rightImageView.image = kImage(@"yishengzhushou_14");
            [cell addSubview:rightImageView];
            rightImageView.sd_layout.rightSpaceToView(cell,10).centerYEqualToView(cell).widthIs(15).heightIs(18);

            UILabel *label = [UILabel new];
            label.tag = 888;
            [cell addSubview:label];
            label.font = [UIFont systemFontOfSize:14];
            label.textColor = [UIColor colorWithHexString:@"#333333"];
            label.sd_layout.rightSpaceToView(rightImageView,10).centerYEqualToView(cell).leftSpaceToView(typeimageView,10).heightIs(18);
        }
        UILabel *label = [cell viewWithTag:888];
        UIImageView *typeimageView  = [cell viewWithTag:999];
        
        typeimageView.image = indexPath.row == 1?kImage(@"biaodan2"):indexPath.row == 2?kImage(@"bingqingxiangguan"):kImage(@"huanzherizhi");
        label.text = indexPath.row == 1?@"已填表单":indexPath.row == 2?@"患者病情相关":@"患者日志";
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return (280/2)*MULTIPLE;
    }
    return 50*MULTIPLE;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 1)
    {        
        LWTheFormTypeViewController *vc = (LWTheFormTypeViewController *)[UIViewController CreateControllerWithTag:CtrlTag_TheFormType];
        vc.patientId = self.patient.patientId;
        vc.showType = showTheFormTypeBiaoDan;
        [self.navigationController pushViewController:vc animated:YES];
        [UMSAgent event:@"patientHaveTheform" label:@"患者已填表单"];

    }else if (indexPath.row == 0){
        
    }else if (indexPath.row == 2)
    {
        LWPatientRelatedViewController *vc = (LWPatientRelatedViewController *)[UIViewController CreateControllerWithTag:CtrlTag_PatientRelated];
        vc.patientId = self.patient.patientId;
        [self.navigationController pushViewController:vc animated:YES];
        [UMSAgent event:@"patientRelated" label:@"患者病情相关"];

    }else if (indexPath.row == 3)
    {
        LWPatientLogViewController *patientLog = (LWPatientLogViewController *)[UIViewController CreateControllerWithTag:CtrlTag_PatientLog];
        patientLog.patientId = self.patient.patientId;
        patientLog.patientName = self.patient.patientName;
        [self.navigationController pushViewController:patientLog animated:YES];
        [UMSAgent event:@"patientLOG" label:@"患者日志"];

//        LWHistoricalRecordVC *vc = [LWHistoricalRecordVC new];
//        [self.navigationController pushViewController:vc animated:YES];

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
