//
//  LWPatientRecordsCtr.m
//  ComveeBreathe
//
//  Created by comv on 15/11/9.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWPatientRecordsCtr.h"
#import "CDMacro.h"
#import "LWPersonalMessageCell.h"
#import "LWTool.h"
#import <MJRefresh/MJRefresh.h>

@interface LWPatientRecordsCtr ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSMutableDictionary *patientTypeDic;
@property (nonatomic, strong) NSArray *allKeys;

@property (nonatomic, strong) LWPatientRecordsBaseModel *patientRecordsModel;
@end

@implementation LWPatientRecordsCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initProperty];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self addNavBar];
    [self loadPatientRecords];
    [self xialarefreshData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark- 导航控件
-(void)addNavBar
{
    [super addNavBar:@"个人基本档案"];
    [super addBackButton:@"nav_btnBack.png"];
    
}
- (void)xialarefreshData
{
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadPatientRecords];
    }];
    
    // 设置文字
    [header setTitle:@"下拉刷新数据" forState:MJRefreshStateIdle];
    //    [header setTitle:@"Release to refresh" forState:MJRefreshStatePulling];
    [header setTitle:@"正在加载 ..." forState:MJRefreshStateRefreshing];
    
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    
    [self.tableView setMj_header:header];
    
}

-(void)navLeftButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - void

- (void)loadPatientRecords
{
    if (!self.patientRecordsModel){
        [LWProgressHUD displayProgressHUD:self.view displayText:@"加载中..."];
    }
    [LWHttpRequestManager httpPantientArchivesWithPantientID:self.patient.patientId success:^(LWPatientRecordsBaseModel *patientRecordsBaseModel) {
        [self.tableView.mj_header endRefreshing];
        [LWProgressHUD closeProgressHUD:self.view];
        self.patientRecordsModel = patientRecordsBaseModel;
        [self.tableView reloadData];

    } failure:^(NSString *errorMes) {
        [self.tableView.mj_header endRefreshing];
        [LWProgressHUD closeProgressHUD:self.view.window];
        [LWProgressHUD showALAlertBannerWithView:self.view.window Style:SALAlertBannerStyleWarning  Position:SALAlertBannerPositionTop Subtitle:errorMes ];
    }];
}

#pragma mark - init
- (NSMutableDictionary *)patientTypeDic
{
    if (!_patientTypeDic) {
        _patientTypeDic = [NSMutableDictionary dictionary];
    }
    return _patientTypeDic;
}
- (void)initProperty
{
    
    NSArray *arr1 = @[@"姓名",@"性别",@"出生日期"];
    NSArray *arr2 = @[@"身高",@"体重"];
    NSArray *arr3 = @[@"是否有以下症状",@"是否有以下症状诱导因素",@"是否有以下并发症"];
    NSArray *arr4 = @[@"是否有以下病史",@"是否有以下家族史"];
    NSArray *arr5 = @[@"FVC",@"FVC%",@"FEV1%",@"FEV1",@"舒张实验",@"激发实验"];
    NSArray *arr6 = @[@"过敏原检测",@"FeNO"];
    
    [self.patientTypeDic setObject:arr1 forKey:@"head下"];
    [self.patientTypeDic setObject:arr2 forKey:@"基本信息"];
    [self.patientTypeDic setObject:arr3 forKey:@"基本信息下"];
    [self.patientTypeDic setObject:arr4 forKey:@"病历及家族史"];
    [self.patientTypeDic setObject:arr5 forKey:@"肺功能记录"];
    [self.patientTypeDic setObject:arr6 forKey:@"肺功能记录下"];
    
    self.allKeys = @[@"head下",@"基本信息",@"基本信息下",@"病历及家族史",@"肺功能记录",@"肺功能记录下"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.rowHeight = 90;
    
}
#pragma mark - void

- (NSString *)sectionHeaderTitle:(NSInteger)section
{
    NSString *key = self.allKeys[section];
    
    if([key rangeOfString:@"下"].location !=NSNotFound)//包含“下”得话就是空
    {
        return @"";
    }
    return key;
}


#pragma mark - tableViewdelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.allKeys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *key = self.allKeys[section];
    NSArray *array = [self.patientTypeDic objectForKey:key];
    return array.count;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self sectionHeaderTitle:section];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return .1;
    }else if (section == 2 || section == 5)
    {
        return 15;
    }
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = self.allKeys[indexPath.section];
    NSArray *array = [self.patientTypeDic objectForKey:key];
    NSString *title = array[indexPath.row];
    
    return [LWTool personalMessageSource:title WithLabel:nil WithModel:self.patientRecordsModel];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *key = self.allKeys[indexPath.section];
    NSArray *array = [self.patientTypeDic objectForKey:key];
    NSString *title = array[indexPath.row];
    
    LWPersonalMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LWPersonalMessageCell" forIndexPath:indexPath];
    cell.M_titleLabel.text = title;
    [LWTool personalMessageSource:title WithLabel:cell WithModel:self.patientRecordsModel];
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
