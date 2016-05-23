//
//  LWOrderListDetailedViewController.m
//  BreatheDoctor
//
//  Created by comv on 16/2/25.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWOrderDetailedListViewController.h"
#import <MJRefresh.h>

@interface LWOrderDetailedListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tabelView;
@property (nonatomic, assign) NSInteger   page;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) BOOL isPull;
@end

@implementation LWOrderDetailedListViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [super addNavBar:@"订单详情"];
    [super addBackButton:@"nav_btnBack.png"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadUI];
    [self initProperty];
    [self xialarefreshData];
}
- (void)initProperty
{
    self.page = 1;
    self.isPull = YES;
}
- (void)loadData
{
    WEAKSELF
    [LWHttpRequestManager httpLoadOrderListWithDate:self.model.date andProductType:kNSString(kNSNumInteger(self.productType)) andPage:self.page Success:^(NSMutableArray *models) {
        [KL_weakSelf.tabelView.mj_header endRefreshing];
        [KL_weakSelf.tabelView.mj_footer endRefreshing];
        [KL_weakSelf hiddenNonetWork];
        if (KL_weakSelf.isPull) {
            [KL_weakSelf.dataArray removeAllObjects];
            [KL_weakSelf.dataArray addObjectsFromArray:models];
        }else
        {
            if(models.count > 0){
                [KL_weakSelf.dataArray addObjectsFromArray:models];
            }else
            {
                [KL_weakSelf.tabelView.mj_footer endRefreshingWithNoMoreData];
            }
        }
        [KL_weakSelf.tabelView reloadData];
        if (KL_weakSelf.dataArray.count <= 0) {
            [KL_weakSelf showErrorMessage:@"暂无购买记录" isShowButton:YES type:showErrorTypeMore];
        }
    } failure:^(NSString *errorMes) {
        [KL_weakSelf.tabelView.mj_header endRefreshing];
        [KL_weakSelf.tabelView.mj_footer endRefreshing];
        if (KL_weakSelf.dataArray.count <= 0) {
            [KL_weakSelf showErrorMessage:errorMes isShowButton:NO type:showErrorTypeHttp];
        }
    }];
}
- (void)reloadRequestWithSender:(UIButton *)sender
{
    [self hiddenNonetWork];
    [self.tabelView.mj_header beginRefreshing];
}
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
#pragma mark - loadChatList

- (void)xialarefreshData
{
    __weak typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.isPull = YES;
        weakSelf.page = 1;
        [weakSelf loadData];
    }];
    
    MJRefreshAutoFooter *footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        weakSelf.isPull = NO;
        weakSelf.page ++;
        [weakSelf loadData];
    }];
    
    [header beginRefreshing];
    
    // 设置文字
//    [header setTitle:@"下拉加载数据" forState:MJRefreshStateIdle];
//    [header setTitle:@"正在加载 ..." forState:MJRefreshStateRefreshing];
    // 隐藏时间
//    header.lastUpdatedTimeLabel.hidden = YES;
    [self.tabelView setMj_header:header];
    [self.tabelView setMj_footer:footer];
    
}
- (void)loadUI
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _tabelView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:_tabelView];
    _tabelView.delegate = self;
    _tabelView.dataSource = self;
    _tabelView.rowHeight = 180;
    [_tabelView registerClass:[LWOrderDetailedLisetCell class] forCellReuseIdentifier:@"LWOrderDetailedLisetCell"];
    _tabelView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(64, 0, 0, 0));

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)navLeftButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - table delegate datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LWOrderDetailedLisetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LWOrderDetailedLisetCell" forIndexPath:indexPath];
    cell.productType = self.productType;
    [cell setModel:self.dataArray[indexPath.section]];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section == 0?.1:10;
}


@end
