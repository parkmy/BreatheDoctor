//
//  LWAsthmaAssessmentViewController.m
//  BreatheDoctor
//
//  Created by comv on 15/11/23.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWAsthmaAssessmentViewController.h"
#import "LWAsthmaAssessmentCell.h"

@interface LWAsthmaAssessmentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) LWAsthmaModel *asModel;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation LWAsthmaAssessmentViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [super addNavBar:@"哮喘症状评估"];
    [super addBackButton:@"nav_btnBack.png"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.backgroundColor = [LWThemeManager shareInstance].vcBackgroundColor;
    [self loadAsthmaAssessment];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - load
- (void)loadAsthmaAssessment
{
    [LWProgressHUD displayProgressHUD:self.view displayText:@"加载中..."];
    WEAKSELF
    [LWHttpRequestManager httpLoadAsthmaAssessmentById:self.searchLoadId success:^(LWAsthmaModel *model) {
        [LWProgressHUD closeProgressHUD:KL_weakSelf.view];
        [KL_weakSelf hiddenNonetWork];
        KL_weakSelf.asModel = model;
        [KL_weakSelf.tableView reloadData];
    } failure:^(NSString *errorMes) {
        [LWProgressHUD closeProgressHUD:KL_weakSelf.view];
        [KL_weakSelf showErrorMessage:@"网络连接失败，点击重试~" isShowButton:NO type:showErrorTypeHttp];
//        [LWProgressHUD showALAlertBannerWithView:self.view Style:SALAlertBannerStyleWarning  Position:SALAlertBannerPositionTop Subtitle:errorMes ];
    }];
}

- (void)reloadRequestWithSender:(UIButton *)sender
{
    [self hiddenNonetWork];
    [self loadAsthmaAssessment];
}

#pragma mark - tableviewdelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.asModel?1:0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    LWAsthmaAssessmentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LWAsthmaAssessmentCell" forIndexPath:indexPath];
    [cell setModel:self.asModel];
    return cell;
}

#pragma mark -nav
- (void)navLeftButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
