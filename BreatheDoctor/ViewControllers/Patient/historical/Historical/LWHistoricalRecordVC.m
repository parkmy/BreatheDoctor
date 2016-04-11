//
//  LWHistoricalRecordVC.m
//  BreatheDoctor
//
//  Created by comv on 16/3/14.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWHistoricalRecordVC.h"
#import "SegmentTapView.h"
#import "LWHistoricalItmView.h"
#import "JSDropmenuView.h"
#import "LWPEFView.h"
#import "LWSymptomsView.h"
#import "LWMedicationView.h"
#import "LWScrollMenuView.h"
#import "LWHistoricalLogView.h"
#import <RACChannel.h>

@interface LWHistoricalRecordVC ()<JSDropmenuViewDelegate,SegmentTapViewDelegate>
{
    NSInteger _seleIndex;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SegmentTapView *segment;
@property (nonatomic, strong) LWHistoricalItmView *itmView;
@property (nonatomic, strong) NSMutableArray *menuArray;
@property (nonatomic, strong) LWScrollMenuView *scrollMenuView;

@property (nonatomic, strong) UIView *chartView;
@property (nonatomic, strong) UIView *logView;
@property (nonatomic, strong) LWHistoricalLogView *historicalLogView;

@property (nonatomic, strong) LWPEFView        *pefView;
@property (nonatomic, strong) LWSymptomsView   *symptomsView;
@property (nonatomic, strong) LWMedicationView *medicationView;

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) KLPatientLogBodyModel *patientLogBodyModel;
@property (nonatomic, assign) BOOL isShowRight;
@property (nonatomic, assign) NSInteger requestDay;

@end

@implementation LWHistoricalRecordVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [super addNavBar:@"患者日志"];
    [super addRightButton:@"rili.png"];
    [super addBackButton:@"nav_btnBack.png"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.requestDay = 7;
    [self loadUI];
    
    [self.menuArray addObjectsFromArray:@[[NSMutableDictionary dictionaryWithDictionary:@{@"title":@"最近7天",@"isSele":@"1"}],[NSMutableDictionary dictionaryWithDictionary:@{@"title":@"最近14天",@"isSele":@"0"}],[NSMutableDictionary dictionaryWithDictionary:@{@"title":@"最近30天",@"isSele":@"0"}]]];
    
    [self setLogDateTextIndexTag:0];
    [self loadhttpDataInfo:self.requestDay];
}
- (void)loadhttpDataInfo:(NSInteger)day
{
    [self.pefView setPefDateList:day];
    
    [LWProgressHUD displayProgressHUD:self.view displayText:@"请稍后..."];
    [LWHttpRequestManager httpLoadPatientRecordHistoryWithPatientId:self.pid recentDays:day Success:^(KLPatientLogBodyModel *model) {
        [self hiddenNonetWork];
        [LWProgressHUD closeProgressHUD:self.view];
        self.patientLogBodyModel = model;
        if (self.patientLogBodyModel.recordList.count <= 0) {
            [self showErrorMessage:@"患者偷懒了，没有数据记录~" isShowButton:YES type:showErrorType64Hight];
        }else{
            [self refreshView];
        }
    } failure:^(NSString *errorMes) {
        [LWProgressHUD closeProgressHUD:self.view];
//        [LWProgressHUD showALAlertBannerWithView:nil Style:0 Position:0 Subtitle:errorMes];
        [self showErrorMessage:errorMes isShowButton:NO type:showErrorType64Hight];

    }];
}
- (void)reloadRequestWithSender:(UIButton *)sender //错误页面按钮点击事件
{
    [self loadhttpDataInfo:self.requestDay];
}
- (void)refreshView
{
    [self.pefView reloadPEFViewData:self.patientLogBodyModel];
    [self.symptomsView reloadSymptomsViewData:self.patientLogBodyModel];
    [self.medicationView reloadMedicationViewData:self.patientLogBodyModel];
    
    [self.historicalLogView reloadDataArrayInfo:_patientLogBodyModel];
}
- (NSMutableArray *)menuArray
{
    if (!_menuArray) {
        _menuArray = [NSMutableArray array];
    }
    return _menuArray;
}
- (LWPEFView *)pefView
{
    if (!_pefView) {
        _pefView = [LWPEFView new];
    }
    return _pefView;
}
- (LWSymptomsView *)symptomsView
{
    if (!_symptomsView) {
        _symptomsView = [LWSymptomsView new];
    }
    return _symptomsView;
}
- (LWMedicationView *)medicationView
{
    if (!_medicationView) {
        _medicationView = [LWMedicationView new];
    }
    return _medicationView;
}

- (LWHistoricalLogView *)historicalLogView
{
    if (!_historicalLogView) {
        _historicalLogView = [LWHistoricalLogView new];
    }
    return _historicalLogView;
}
- (SegmentTapView *)segment
{
    if (!_segment) {
        _segment = [[SegmentTapView alloc] initWithFrame:CGRectMake(0, 0, Screen_SIZE.width, 40*MULTIPLEVIEW) withDataArray:[NSArray arrayWithObjects:@"PEF",@"症状",@"用药", nil] withFont:15];
        _segment.delegate = self;
    }
    return _segment;
}
- (LWHistoricalItmView *)itmView
{
    if (!_itmView) {
        _itmView = [[LWHistoricalItmView alloc] initWithSize:CGSizeMake(130*MULTIPLEVIEW, 30*MULTIPLEVIEW) leftTitle:@"图表" rightTitle:@"日志"];
    }
    return _itmView;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    }
    return _tableView;
}
- (LWScrollMenuView *)scrollMenuView
{
    if (!_scrollMenuView) {
        _scrollMenuView = [[LWScrollMenuView alloc] initWithContentViews:@[self.pefView,self.symptomsView,self.medicationView]];
    }
    return _scrollMenuView;
}

- (void)loadUI
{
    [self.view addSubview:self.itmView];
    
    _chartView = ({
        UIView *view = [UIView new];
        [self.view addSubview:view];
        view;
    });
    
    _logView = ({
        UIView *view = [UIView new];
        view.alpha = 0;
        view.hidden = YES;
        [self.view addSubview:view];
        view;
    });
    
    [_chartView addSubview:self.segment];
    [_chartView addSubview:self.scrollMenuView];
    [_logView addSubview:self.historicalLogView];
    
    UIView *line = [UIView allocAppLineView];
    [_chartView addSubview:line];
    
    self.itmView.sd_layout.topSpaceToView(self.view,64).leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).heightIs(40*MULTIPLEVIEW);
    _chartView.sd_layout.topSpaceToView(self.itmView,0).leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).bottomSpaceToView(self.view,0);
    _logView.sd_layout.topSpaceToView(self.itmView,0).leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).bottomSpaceToView(self.view,0);
    self.scrollMenuView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(40*MULTIPLEVIEW, 0, 0, 0));
    self.historicalLogView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    [self setBlock];
    
}
- (void)showLeftView
{
    self.isShowRight = NO;
    [UIView animateWithDuration:.5 animations:^{
        self.logView.alpha = 0;
        self.chartView.alpha = 1;
        self.chartView.hidden = NO;
    } completion:^(BOOL finished) {
        self.logView.hidden = YES;
        [self showView];
    }];
    
}
- (void)showView{
    if (self.logView.hidden && self.chartView.hidden) {
        self.logView.hidden = !self.isShowRight;
        self.chartView.hidden = self.isShowRight;
    }
}
- (void)showRightView
{
    self.isShowRight = YES;
    [UIView animateWithDuration:.5 animations:^{
        self.chartView.alpha = 0;
        self.logView.alpha = 1;
        self.logView.hidden = NO;
    } completion:^(BOOL finished) {
        self.chartView.hidden = YES;
        [self showView];
    }];
}

- (void)setBlock
{
    __weak typeof(self)weakSelf = self;
    [self.itmView setLeftButtonBlock:^{
        [weakSelf showLeftView];
        [MobClick event:@"chartView" label:@"图表按钮的点击量"];
    }];
    
    [self.itmView setRightButtonBlock:^{
        [weakSelf showRightView];
        [MobClick event:@"logView" label:@"日志按钮的点击量"];
    }];
    
    [self.scrollMenuView setScrollViewDidEndDeceleratingBlock:^(NSInteger tag) {
        [weakSelf.segment selectIndex:tag+1];
        if (tag == 0){
            [MobClick event:@"pefView" label:@"PEF按钮的点击量"];
        }else if (tag == 1){
            [MobClick event:@"symptomsView" label:@"症状按钮的点击量"];
        }else if (tag == 2){
            [MobClick event:@"medicationView" label:@"用药按钮的点击量"];
        }
    }];
    
}
#pragma mark - nav
- (void)navLeftButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)navRightButtonAction
{
    JSDropmenuView *dropmenuView = [[JSDropmenuView alloc] initWithFrame:CGRectMake(screenWidth-120*MULTIPLEVIEW-10, 64-12, 120*MULTIPLEVIEW, 39*3+14)];
    dropmenuView.delegate = self;
    dropmenuView.seleIndex = _seleIndex;
    [dropmenuView showViewInView:self.navigationController.view];
}
#pragma mark -JSDropmenuViewDelegate
- (void)dropmenuView:(JSDropmenuView*)dropmenuView didSelectedRow:(NSInteger)index
{
    [self setLogDateTextIndexTag:index];
}
- (void)setLogDateTextIndexTag:(NSInteger)index
{
    NSMutableDictionary *dic = self.menuArray[index];
    [dic setObject:@"1" forKey:@"isSele"];
    
    [self.pefView setLogDateText:dic[@"title"]];
    [self.symptomsView setLogDateText:dic[@"title"]];
    [self.medicationView setLogDateText:dic[@"title"]];
    
    if (_seleIndex == index) {
        return;
    }
    NSMutableDictionary *oldDic = self.menuArray[_seleIndex];
    [oldDic setObject:@"0" forKey:@"isSele"];
    _seleIndex = index;
    self.requestDay = index==0?7:index==1?14:30;
    //刷新数据
    [self loadhttpDataInfo:self.requestDay];
    
}
- (NSArray*)dropmenuDataSource
{
    return self.menuArray;
}
#pragma mark -FlipTableViewDelegate
- (void)selectedIndex:(NSInteger)index//0123
{
    [self.scrollMenuView setscrollViewIndex:index];
    
    if (index == 0){
        [MobClick event:@"pefView" label:@"PEF按钮的点击量"];
    }else if (index == 1){
        [MobClick event:@"symptomsView" label:@"症状按钮的点击量"];
    }else if (index == 2){
        [MobClick event:@"medicationView" label:@"用药按钮的点击量"];
    }

}
@end
