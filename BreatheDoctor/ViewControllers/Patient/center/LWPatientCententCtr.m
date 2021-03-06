//
//  LWPatientCententCtr.m
//  BreatheDoctor
//
//  Created by comv on 15/11/10.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWPatientCententCtr.h"
#import "LWPatientCenterCell.h"
#import "LWPatientRemarksCtr.h"
#import "LWTheFormViewController.h"
#import "LWTheFormTypeViewController.h"
#import "LWPatientRelatedVC.h"
#import "LWHistoricalRecordVC.h"
#import "KLPatientListModel.h"
#import "KLHistoricalLogViewController.h"

@interface LWPatientCententCtr ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

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
    setExtraCellLineHidden(self.tableView);

    [self loadPatientRecords];
}

- (void)loadPatientRecords
{
    if (!self.patientRecordsModel){
        [LWProgressHUD displayProgressHUD:self.view displayText:@"加载中..."];
    }
    WEAKSELF
    [LWHttpRequestManager httpPantientArchivesWithPantientID:self.patient.patientId success:^(LWPatientRecordsBaseModel *patientRecordsBaseModel) {
        //        [self.tableView.mj_header endRefreshing];
        [LWProgressHUD closeProgressHUD:KL_weakSelf.view];
        KL_weakSelf.patientRecordsModel = patientRecordsBaseModel;
        [KL_weakSelf.tableView reloadData];
        
    } failure:^(NSString *errorMes) {
        //        [self.tableView.mj_header endRefreshing];
        [LWProgressHUD closeProgressHUD:KL_weakSelf.view.window];
        [LWProgressHUD showALAlertBannerWithView:KL_weakSelf.view.window Style:SALAlertBannerStyleWarning  Position:SALAlertBannerPositionTop Subtitle:errorMes ];
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
        WEAKSELF
        [patientCenterCell setEditorButtonEventBlock:^{
            
            LWPatientRemarksCtr *patientRemarks = (LWPatientRemarksCtr *)[UIViewController CreateControllerWithTag:CtrlTag_PatientRemarks];
            [patientRemarks setPatient:KL_weakSelf.patient];
            [KL_weakSelf.navigationController pushViewController:patientRemarks animated:YES];
            [MobClick event:@"patientNote" label:@"患者备注按钮的点击量"];

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
            label.font = [UIFont systemFontOfSize:kNSPXFONTFLOAT(28)];
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
        [MobClick event:@"patientHaveTheform" label:@"患者已填表单按钮的点击量"];

    }else if (indexPath.row == 0){
        
    }else if (indexPath.row == 2)
    {
        LWPatientRelatedVC *vc = (LWPatientRelatedVC *)[UIViewController CreateControllerWithTag:CtrlTag_PatientRelated];
        vc.patientId = self.patient.patientId;
        [self.navigationController pushViewController:vc animated:YES];
        [MobClick event:@"patientRelated" label:@"患者病情相关按钮的点击量"];

    }else if (indexPath.row == 3)
    {
//        LWPatientLogViewController *patientLog = (LWPatientLogViewController *)[UIViewController CreateControllerWithTag:CtrlTag_PatientLog];
//        patientLog.patientId = self.patient.patientId;
//        patientLog.patientName = self.patient.patientName;
//        [self.navigationController pushViewController:patientLog animated:YES];
        [MobClick event:@"patientLOG" label:@"患者日志按钮的点击量"];

//        LWHistoricalRecordVC *vc = [LWHistoricalRecordVC new];
//        vc.pid = self.patient.patientId;
//        [self.navigationController pushViewController:vc animated:YES];

        
        KLHistoricalLogViewController *vc = [KLHistoricalLogViewController new];
        vc.patientID = self.patient.patientId;
        [self.navigationController pushViewController:vc animated:YES];

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
