//
//  LWPatientAssessmentLogVC.m
//  BreatheDoctor
//
//  Created by comv on 15/11/22.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWPatientAssessmentLogVC.h"
#import "LWAssessmentLineCell.h"
#import "LWAssessmentStarCell.h"
#import "LWAssessmentModel.h"
#import "LWTool.h"
#import "CDMacro.h"
#import "LWLineACTAssessmentVC.h"
#import "LWPatientLogViewController.h"

@interface LWPatientAssessmentLogVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, strong) LWAsthmaAssessLogModel *assessmentModel;
@property (nonatomic, copy)  NSString *patientID;
@end

@implementation LWPatientAssessmentLogVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)refreshAssessmentLog:(NSString *)patientID
{
    self.patientID = patientID;
    
    [LWHttpRequestManager httpLoadAsthmaAssessLogWithPatientId:patientID year:[LWPublicDataManager shareInstance].yer month:[LWPublicDataManager shareInstance].month success:^(LWAsthmaAssessLogModel *model) {
        [LWProgressHUD closeProgressHUD:self.view.window];
        self.assessmentModel = model;
        self.datas = [LWTool toDealWithAsthmaAssessLogModel:model];
        [self.tableView reloadData];
        if (self.datas.count <= 0) {
            [self showErrorMessage:@"本月暂无记录~" isShowButton:YES type:showErrorTypeMore];
        }else{
            [self hiddenNonetWork];
        }
    } failure:^(NSString *errorMes) {
        [LWProgressHUD closeProgressHUD:self.view.window];
        [self showErrorMessage:@"网络连接失败，点击刷新~" isShowButton:NO type:showErrorTypeHttp];
//        [LWProgressHUD showALAlertBannerWithView:self.view Style:SALAlertBannerStyleWarning  Position:SALAlertBannerPositionTop Subtitle:errorMes ];
    }];
}
- (void)reloadRequestWithSender:(UIButton *)sender
{
    [self hiddenNonetWork];

    [LWProgressHUD displayProgressHUD:self.view displayText:@"请稍后..."];
    [self refreshAssessmentLog:self.patientID];
}

#pragma mark -UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section == 0?1:self.datas.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.section == 0?320:100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section == 1?20:.1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    if (indexPath.section == 0) {
        
        LWAssessmentLineCell *AssessmentLineCell = [tableView dequeueReusableCellWithIdentifier:@"LWAssessmentLineCell" forIndexPath:indexPath];
        [AssessmentLineCell setModel:self.assessmentModel];
        [AssessmentLineCell changeTimerDate:[LWPublicDataManager shareInstance].changeDate];
        cell = AssessmentLineCell;
    }else
    {
        LWAssessmentStarCell *AssessmentStarCell = [tableView dequeueReusableCellWithIdentifier:@"LWAssessmentStarCell" forIndexPath:indexPath];
        [AssessmentStarCell setModel:self.datas[indexPath.row]];
        cell = AssessmentStarCell;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1)
    {
        LWAssessmentModel *model = self.datas[indexPath.row];
        LWLineACTAssessmentVC *lineACTAssessmentVC = (LWLineACTAssessmentVC *)[UIViewController CreateControllerWithTag:CtrlTag_LineACTAssessment];
        lineACTAssessmentVC.patientID = self.vc.patientId;
        lineACTAssessmentVC.patientName = self.vc.patientName;
        lineACTAssessmentVC.starDate = model.starDate;
        lineACTAssessmentVC.endDate = model.endDate;
        lineACTAssessmentVC.type   = model.type;
        [self.vc.navigationController pushViewController:lineACTAssessmentVC animated:YES];
    }
    
}

@end
