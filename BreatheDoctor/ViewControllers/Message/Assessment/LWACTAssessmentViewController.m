//
//  LWACTAssessmentViewController.m
//  BreatheDoctor
//
//  Created by comv on 15/11/23.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWACTAssessmentViewController.h"
#import "LWACTStateAssessmentCell.h"
#import "LWACTAssessmentCell.h"
#import "UIView+BorderLine.h"
#import "LWACTAssessmentCell.h"
#import "LWACTAssessmentModel.h"
#import "LWTool.h"

@interface LWACTAssessmentViewController ()
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) LWACTModel *ACTMdel;
@end

@implementation LWACTAssessmentViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [super addNavBar:@"ACT评估"];
    [super addBackButton:@"nav_btnBack.png"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.backgroundColor = RGBA(245, 245, 245, 1);
    
    [self loadACTbyd];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - load
- (void)loadACTbyd
{
    [LWProgressHUD displayProgressHUD:self.view displayText:@"加载中..."];
    [LWHttpRequestManager httpLoadActById:self.bayId success:^(LWACTModel *model) {
        [LWProgressHUD closeProgressHUD:self.view];
        [self hiddenNonetWork];
        self.ACTMdel = model;
        [LWTool ACTAssessmentChangeWithModel:self.ACTMdel withArray:self.dataArray];
        [self.tableView reloadData];
    } failure:^(NSString *errorMes) {
        [LWProgressHUD closeProgressHUD:self.view];
        [self showErrorMessage:@"网络连接失败，点击重试~" isShowButton:NO type:showErrorTypeHttp];
//        [LWProgressHUD showALAlertBannerWithView:self.view Style:SALAlertBannerStyleWarning  Position:SALAlertBannerPositionTop Subtitle:errorMes ];
    }];

}
- (void)reloadRequestWithSender:(UIButton *)sender
{
    [self hiddenNonetWork];
    [self loadACTbyd];
}

#pragma mark - init
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        NSArray *arr = @[@"在过去4周内，在工作、学习或家中，有多少时候哮喘妨碍您进行日常活动?",@"在过去4周内，您有多少次呼吸困难",@"在过去4周内，因为哮喘症状(喘息、咳嗽、呼吸困难、胸闷或疼痛)，您有多少次在夜间醒来或早上比平时早醒?",@"在过去4周内，您有多少次使用急救药物治疗?",@"您如何评估过去4周内您的哮喘控制情况?"];
        for (NSString *str in arr) {
            LWACTAssessmentModel *model = [[LWACTAssessmentModel alloc] init];
            model.wenti = str;
            model.daan  = @"患者选项: 未填写";
            [_dataArray addObject:model];
        }
    }
    return _dataArray;
}
#pragma mark - tableviewdelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.ACTMdel?self.dataArray.count+1:0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 200;
    }
    LWACTAssessmentModel *model = self.dataArray[indexPath.row-1];
    return model.rowHight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (indexPath.row == 0) {
        LWACTStateAssessmentCell *ACTStateAssessmentCell = [tableView dequeueReusableCellWithIdentifier:@"LWACTStateAssessmentCell" forIndexPath:indexPath];
        [ACTStateAssessmentCell initACTStateAssessmentCelWith:self.patientName actResult:self.ACTMdel.actResult date:self.ACTMdel.assessDt];
        cell = ACTStateAssessmentCell;
    }else
    {
        LWACTAssessmentCell *ACTAssessmentCell = [tableView dequeueReusableCellWithIdentifier:@"LWACTAssessmentCell" forIndexPath:indexPath];
        LWACTAssessmentModel *model = self.dataArray[indexPath.row-1];
        [ACTAssessmentCell setModel:model];
        cell = ACTAssessmentCell;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1 && [cell isKindOfClass:[LWACTAssessmentCell class]]) {
        LWACTAssessmentCell* ACTAssessmentCell = (LWACTAssessmentCell*)cell;
        [ACTAssessmentCell.bgView byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight withSize:CGSizeMake(5, 5)];
    }else if (indexPath.row == self.dataArray.count && [cell isKindOfClass:[LWACTAssessmentCell class]]){
        LWACTAssessmentCell* ACTAssessmentCell = (LWACTAssessmentCell*)cell;
        [ACTAssessmentCell.bgView byRoundingCorners:UIRectCornerBottomRight|UIRectCornerBottomLeft withSize:CGSizeMake(5, 5)];
    }else if ([cell isKindOfClass:[LWACTAssessmentCell class]])
    {
        LWACTAssessmentCell* ACTAssessmentCell = (LWACTAssessmentCell*)cell;
        [ACTAssessmentCell.bgView byRoundingCorners:UIRectCornerAllCorners withSize:CGSizeMake(0, 0)];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

    
}

#pragma mark -nav
- (void)navLeftButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
