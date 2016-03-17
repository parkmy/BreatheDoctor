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

@interface LWHistoricalRecordVC ()<JSDropmenuViewDelegate,SegmentTapViewDelegate>
{
    
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SegmentTapView *segment;
@property (nonatomic, strong) LWHistoricalItmView *itmView;
@property (nonatomic, strong) JSDropmenuView *dropmenuView;
@property (nonatomic, strong) NSMutableArray *menuArray;
@property (nonatomic, strong) LWScrollMenuView *scrollMenuView;

@property (nonatomic, strong) UIView *chartView;
@property (nonatomic, strong) UIView *logView;

@end

@implementation LWHistoricalRecordVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [super addNavBar:@"历史记录"];
    [super addRightButton:@"rili.png"];
    [super addBackButton:@"nav_btnBack.png"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self loadUI];
    
}
- (NSMutableArray *)menuArray
{
    if (!_menuArray) {
        _menuArray = [NSMutableArray arrayWithArray:@[@{@"title":@"最近7天",@"isSele":@1},@{@"title":@"最近14天",@"isSele":@0},@{@"title":@"最近30天",@"isSele":@0}]];
    }
    return _menuArray;
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
        _itmView = [[LWHistoricalItmView alloc] initWithSize:CGSizeMake(130*MULTIPLEVIEW, 30*MULTIPLEVIEW) leftTitle:@"图文" rightTitle:@"日志"];
    }
    return _itmView;
}
- (JSDropmenuView *)dropmenuView
{
    if (!_dropmenuView) {
        _dropmenuView = [[JSDropmenuView alloc] initWithFrame:CGRectMake(screenWidth-120*MULTIPLEVIEW-10, 64-12, 120*MULTIPLEVIEW, 120*MULTIPLEVIEW)];
        _dropmenuView.delegate = self;
    }
    return _dropmenuView;
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
        _scrollMenuView = [[LWScrollMenuView alloc] initWithContentViews:@[[LWPEFView new],[LWSymptomsView new],[LWMedicationView new]]];
    }
    return _scrollMenuView;
}


- (void)loadUI
{
    [self.view addSubview:self.itmView];
    
    _chartView = ({
        UIView *view = [UIView new];
        view;
    });
    
    _logView = ({
        UIView *view = [UIView new];
        view;
    });
    
    [self.view addSubview:_logView];
    [self.view addSubview:_chartView];
    
    [_chartView addSubview:self.segment];
    [_chartView addSubview:self.scrollMenuView];
    
    self.itmView.sd_layout.topSpaceToView(self.view,64).leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).heightIs(40*MULTIPLEVIEW);
    _chartView.sd_layout.topSpaceToView(self.itmView,0).leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).bottomSpaceToView(self.view,0);
    _logView.sd_layout.topSpaceToView(self.itmView,0).leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).bottomSpaceToView(self.view,0);
    self.scrollMenuView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(40*MULTIPLEVIEW, 0, 0, 0));
    
    [self setBlock];
}

- (void)setBlock
{
    __weak typeof(self)weakSelf = self;
    [self.itmView setLeftButtonBlock:^{
        
    }];
    
    [self.itmView setRightButtonBlock:^{
        
    }];
    
    [self.scrollMenuView setScrollViewDidEndDeceleratingBlock:^(NSInteger tag) {
        [weakSelf.segment selectIndex:tag+1];
    }];
}
#pragma mark - nav
- (void)navLeftButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)navRightButtonAction
{
    [self.dropmenuView showViewInView:self.navigationController.view];
    
}
#pragma mark -JSDropmenuViewDelegate
- (void)dropmenuView:(JSDropmenuView*)dropmenuView didSelectedRow:(NSInteger)index
{
    
}
- (NSArray*)dropmenuDataSource
{
    return self.menuArray;
}
#pragma mark -FlipTableViewDelegate
- (void)selectedIndex:(NSInteger)index//0123
{
    [self.scrollMenuView setscrollViewIndex:index];

}
@end
