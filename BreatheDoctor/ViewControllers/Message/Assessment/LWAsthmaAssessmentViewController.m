//
//  LWAsthmaAssessmentViewController.m
//  BreatheDoctor
//
//  Created by comv on 15/11/23.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWAsthmaAssessmentViewController.h"
#import "LWAsthmaAssessmentCell.h"

@interface LWAsthmaAssessmentViewController ()
@property (nonatomic, strong) LWAsthmaModel *asModel;
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
    [self loadAsthmaAssessment];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - load
- (void)loadAsthmaAssessment
{
    [LWHttpRequestManager httpLoadAsthmaAssessmentById:self.searchLoadId success:^(LWAsthmaModel *model) {
        self.asModel = model;
        [self.tableView reloadData];
    } failure:^(NSString *errorMes) {
        [LWProgressHUD showALAlertBannerWithView:self.view Style:SALAlertBannerStyleWarning  Position:SALAlertBannerPositionTop Subtitle:errorMes ];
    }];
}
#pragma mark - tableviewdelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
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
