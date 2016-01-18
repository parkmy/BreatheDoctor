//
//  LWTheFormViewController.m
//  BreatheDoctor
//
//  Created by comv on 15/12/30.
//  Copyright © 2015年 lwh. All rights reserved.

//症状 symptoms
//1 是否有以下症状（多选） undersymptom
//2 症状诱因（多选）Symptomsofincentive

//病情控制程度（过去2-4周）Acontrolcondition
//1 日间症状（单选）Daytimesymptoms
//2 夜间症状/憋醒（单选）Symptomsatnight
//3 活动受限（单选）Restrictedmovement
//4 急性发作（单选）acute

//用药情况 Thedrug
//1 使用应急缓解药物（单选）emergencyreliefdrugs
//2 是否服务以下药物（多选）Whethertheservice



#import "LWTheFormViewController.h"
#import "YRJSONAdapter.h"
#import "UIResponder+Router.h"

@interface LWTheFormViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LWTheFromBaseModel *baseModel;
@end

@implementation LWTheFormViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [super addNavBar:@"哮喘患者初诊模块"];
    [super addBackButton:@"nav_btnBack"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setUI];
    [self loadData];
}

- (void)loadData
{
    if (self.showType == showTheFormTypeMouKuaiNoSucc) {
        [LWHttpRequestManager httploadFirstDiagnosticInfowithdiagnosticId:self.foreignId Success:^(NSMutableArray *models) {
            
        } failure:^(NSString *errorMes) {
            
        }];
    }else
    {
        [self setData];
    }
}

- (void)setData
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"LWVisitList" ofType:@"plist"];
    NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:path];
    _baseModel = [[LWTheFromBaseModel alloc] initWithDictionary:dic];
    
    for (LWTheFromMrows *mMrow in _baseModel.mrows) {
        
        for (LWTheFromArows *arow in mMrow.arows) {
            int a = 0;
            if (arow.rowArray.count > 3 && arow.rowArray.count < 6) {
                a = 2;
            }else if (arow.rowArray.count > 6)
            {
                a = 3;
            }else
            {
                a = 1;
            }
            CGFloat h = (35 + 15)*a + 60;
            arow.rowHight = h;
        }
        
    }
    
//    NSLog(@"%@",[dic JSONString]);
}
- (void)setUI
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height-64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 110;
    [_tableView registerClass:[LWTheFormCell class] forCellReuseIdentifier:@"LWTheFormCell"];
    [self.view addSubview:_tableView];
}
- (void)navLeftButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableviewdelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _baseModel.mrows.count+1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == _baseModel.mrows.count) {
        return 1;
    }
    LWTheFromMrows *model = _baseModel.mrows[section];
    return model.arows.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == _baseModel.mrows.count) {
        return .1;
    }
    LWTheFromMrows *model = _baseModel.mrows[indexPath.section];
    LWTheFromArows *aModel = model.arows[indexPath.row];
    return aModel.rowHight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (indexPath.section == _baseModel.mrows.count)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
    }else{
    
        LWTheFormCell *theFormCell = [tableView dequeueReusableCellWithIdentifier:@"LWTheFormCell" forIndexPath:indexPath];
        LWTheFromMrows *model = _baseModel.mrows[indexPath.section];
        [theFormCell setModel:model.arows[indexPath.row] withType:self.showType];
        cell = theFormCell;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section == _baseModel.mrows.count?60:40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"hcell"];
    if (!view) {
        view = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"hcell"];
        
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        icon.tag = 999;
        [view addSubview:icon];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.tag = 888;
        label.textColor = RGBA(0, 0, 0, .5);
        label.font = [UIFont systemFontOfSize:15];
        [view addSubview:label];
        icon.centerX = 20;
        icon.centerY = 40/2;
        label.frame = CGRectMake(icon.maxX+10, 0, screenWidth-50, 40);
        
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setCornerRadius:5.0f];
        [btn setTitle:@"提交" forState:UIControlStateNormal];
        btn.backgroundColor = [LWThemeManager shareInstance].navBackgroundColor;
        [view addSubview:btn];
        btn.tag = 10086;
        btn.sd_layout.leftSpaceToView(view,20).topSpaceToView(view,10).rightSpaceToView(view,20).bottomSpaceToView(view,10);
        
    }
    UILabel *label = [view viewWithTag:888];
    UIImageView *icon = [view viewWithTag:999];
    UIButton *btn = [view viewWithTag:10086];
    btn.hidden = YES;
    label.hidden = NO;
    icon.hidden = NO;
    
    if (section == _baseModel.mrows.count) {
        label.hidden = YES;
        icon.hidden = YES;
            if (self.showType == showTheFormTypeMouKuai) {
                btn.hidden = NO;
                [btn addTarget:self action:@selector(uploadBiaoDan) forControlEvents:UIControlEventTouchUpInside];
            }
        return view;
    }

    LWTheFromMrows *model = _baseModel.mrows[section];
    label.text = model.sectiontitle;
    icon.image = section == 0?kImage(@"jilu"):section == 1?kImage(@"bingqingkongzhi"):kImage(@"yongyao");
    return view;
}

- (void)uploadBiaoDan
{
    [LWProgressHUD displayProgressHUD:self.view displayText:@"请稍后..."];
    [LWHttpRequestManager httpDoctorReply:self.patientId content:@"哮喘诊断判定表" contentType:21 voiceMin:0 success:^(LWSenderResBaseModel *senderResBaseModel) {
        [LWProgressHUD closeProgressHUD:self.view];
        [[NSNotificationCenter defaultCenter] postNotificationName:APP_PUSH_TYPE_SENDERZHENGDUANMOKUAISUCC object:nil userInfo:@{@"message":senderResBaseModel}];
        UIViewController *vc = self.navigationController.viewControllers[1];
        [self.navigationController popToViewController:vc animated:YES];
        
    } failure:^(NSString *errorMes) {
        [LWProgressHUD closeProgressHUD:self.view];
        [LWProgressHUD showALAlertBannerWithView:self.view Style:SALAlertBannerStyleWarning  Position:SALAlertBannerPositionTop Subtitle:errorMes ];
    }];
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
