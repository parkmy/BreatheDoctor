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
#import "LWTool.h"
#import "SVProgressHUD.h"

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
    if (self.showType == showTheFormTypeMouKuaiSucc) {
        [LWProgressHUD displayProgressHUD:self.view displayText:@"请稍后..."];
        [LWHttpRequestManager httploadFirstDiagnosticInfowithdiagnosticId:self.foreignId Success:^(LWPatientBiaoDanBody *model) {
            [LWProgressHUD closeProgressHUD:self.view];
            self.baseModel = [LWTool BiaoDanDataFenXiModel:model];
            [self baseModelgetrowHight];
            [self.tableView reloadData];
        } failure:^(NSString *errorMes) {
            [LWProgressHUD closeProgressHUD:self.view];
        }];
    }else if (self.showType == showTheFormTypeMouKuai || self.showType == showTheFormTypeMouKuaiNoSucc)
    {
        [self setData];
    }else
    {
        self.baseModel = [LWTool BiaoDanDataFenXiModel:self.model];
        [self baseModelgetrowHight];
        [self.tableView reloadData];
    }
}

- (void)setData
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"LWVisitList" ofType:@"plist"];
    NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:path];
    _baseModel = [[LWTheFromBaseModel alloc] initWithDictionary:dic];
    [self baseModelgetrowHight];
    
    
//    NSLog(@"%@",[dic JSONString]);
}

- (void)baseModelgetrowHight
{
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
            CGFloat h = (30 + 20)*a + 58;
            arow.rowHight = h;
        }
        
    }

}

- (void)setUI
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 110;
    [_tableView registerClass:[LWTheFormCell class] forCellReuseIdentifier:@"LWTheFormCell"];
    [self.view addSubview:_tableView];
    
    
    
    if (self.showType == showTheFormTypeMouKuai)
    {
        UIView *footView = [[UIView alloc] initWithFrame:CGRectZero];
        footView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:footView];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setCornerRadius:5.0f];
        [btn setTitle:@"提交" forState:UIControlStateNormal];
        btn.backgroundColor = [LWThemeManager shareInstance].navBackgroundColor;
        [btn addTarget:self action:@selector(uploadBiaoDan) forControlEvents:UIControlEventTouchUpInside];
        [footView addSubview:btn];
        footView.sd_layout.heightIs(55).leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).bottomSpaceToView(self.view,0);

        btn.sd_layout.leftSpaceToView(footView,20).topSpaceToView(footView,5).rightSpaceToView(footView,20).bottomSpaceToView(footView,5);

        _tableView.sd_layout.topSpaceToView(self.view,64).leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).bottomSpaceToView(footView,0);

    }else
    {
        _tableView.sd_layout.topSpaceToView(self.view,64).leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).bottomSpaceToView(self.view,0);

    }

    
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
        LWTheFromArows *aModel = model.arows[indexPath.row];
        [theFormCell setModel:aModel withType:self.showType];
        [theFormCell setIsMulti:aModel.isMulti];
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
    return section == _baseModel.mrows.count?.1:50;
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
        label.textColor = [UIColor colorWithHexString:@"#666666"];
        label.font = [UIFont systemFontOfSize:kNSPXFONTFLOAT(32)];
        [view addSubview:label];
        icon.centerX = 20;
        icon.centerY = 50/2;
        label.frame = CGRectMake(icon.maxX+10, 0, screenWidth-50, 50);
        
        
    }
    UILabel *label = [view viewWithTag:888];
    UIImageView *icon = [view viewWithTag:999];

    label.hidden = NO;
    icon.hidden = NO;
    
    if (section == _baseModel.mrows.count) {
        label.hidden = YES;
        icon.hidden = YES;
        return view;
    }

    LWTheFromMrows *model = _baseModel.mrows[section];
    label.text = model.sectiontitle;
    icon.image = section == 0?kImage(@"zhengzhuang"):section == 1?kImage(@"bingqingkongzhi"):kImage(@"yongyao");
    return view;
}

- (void)uploadBiaoDan
{
    [LWProgressHUD displayProgressHUD:self.view displayText:@"请稍后..."];
    [LWHttpRequestManager httpDoctorReply:self.patientId content:@"哮喘诊断判定表" contentType:21 voiceMin:0 success:^(LWSenderResBaseModel *senderResBaseModel) {
        [LWProgressHUD closeProgressHUD:self.view];
        [[NSNotificationCenter defaultCenter] postNotificationName:APP_PUSH_TYPE_SENDERZHENGDUANMOKUAISUCC object:nil userInfo:@{@"message":senderResBaseModel}];
        [SVProgressHUD showSuccessWithStatus:@"发送成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UIViewController *vc = self.navigationController.viewControllers[1];
            [self.navigationController popToViewController:vc animated:YES];
        });
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
