//
//  LWOrderListDetailedViewController.m
//  BreatheDoctor
//
//  Created by comv on 16/2/25.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWOrderDetailedListViewController.h"
#import "LWOrderDetailedLisetCell.h"

@interface LWOrderDetailedListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tabelView;
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
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LWOrderDetailedLisetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LWOrderDetailedLisetCell" forIndexPath:indexPath];
    [cell setModel:nil];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section == 0?.1:15;
}


@end
