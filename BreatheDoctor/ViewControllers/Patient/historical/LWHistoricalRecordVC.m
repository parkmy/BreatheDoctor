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

@interface LWHistoricalRecordVC ()<JSDropmenuViewDelegate>
{
    
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SegmentTapView *segment;
@property (nonatomic, strong) LWHistoricalItmView *itmView;
@property (nonatomic, strong) JSDropmenuView *dropmenuView;
@end

@implementation LWHistoricalRecordVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [super addNavBar:@"历史记录"];
    [super addBackButton:@"nav_btnBack.png"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadUI];
    
}
- (SegmentTapView *)segment
{
    if (!_segment) {
        _segment = [[SegmentTapView alloc] initWithFrame:CGRectMake(0, 64+(40*MULTIPLE), Screen_SIZE.width, 40*MULTIPLE) withDataArray:[NSArray arrayWithObjects:@"PEF",@"症状",@"用药", nil] withFont:15];
    }
    return _segment;
}
- (LWHistoricalItmView *)itmView
{
    if (!_itmView) {
        _itmView = [[LWHistoricalItmView alloc] init];
    }
    return _itmView;
}
- (JSDropmenuView *)dropmenuView
{
    if (!_dropmenuView) {
        _dropmenuView = [[JSDropmenuView alloc] initWithFrame:CGRectMake(screenWidth-120*MULTIPLE, 64+(40*MULTIPLE), 120*MULTIPLE, 120*MULTIPLE)];
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

- (void)loadUI
{
    [self.view addSubview:self.itmView];
    [self.view addSubview:self.segment];
    [self setBlock];
    
    self.itmView.sd_layout.topSpaceToView(self.view,64).leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).heightIs(40*MULTIPLE);
    
}

- (void)setBlock
{
    __weak typeof(self)weakSelf = self;
    [self.itmView setChartButtonBlock:^{
        
        
    }];

    [self.itmView setLogButtonBlock:^{
        
        
    }];
    
    [self.itmView setTimeButtonBlock:^{
        [weakSelf.dropmenuView showViewInView:weakSelf.navigationController.view];
    }];
}
#pragma mark -JSDropmenuViewDelegate
- (void)dropmenuView:(JSDropmenuView*)dropmenuView didSelectedRow:(NSInteger)index
{
    
}
- (NSArray*)dropmenuDataSource
{
    return @[@{@"title":@"最近7天"},@{@"title":@"最近14天"},@{@"title":@"最近30天"}];
}

@end
