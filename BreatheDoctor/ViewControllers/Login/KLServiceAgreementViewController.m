//
//  KLServiceAgreementViewController.m
//  BreatheDoctor
//
//  Created by comv on 16/5/18.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLServiceAgreementViewController.h"
#import "KLServiceAgreementModel.h"
#import "KLServiceAgreementCell.h"

@interface KLServiceAgreementViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation KLServiceAgreementViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [super addNavBar:@"服务协议"];
    [super addBackButton:@"nav_btnBack"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataArray = [[KLServiceAgreementModel serviceAgreements] mutableCopy];

    [self addSubViews];
    
}
- (void)addSubViews{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.separatorStyle = 0;
    _tableView.dataSource = self;
    _tableView.delegate   = self;
    [self.view addSubview:_tableView];
    _tableView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(BARHIGHT, 0, 0, 0));
    
    [_tableView registerClass:[KLServiceAgreementCell class] forCellReuseIdentifier:@"KLServiceAgreementCell"];
}
- (void)navLeftButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KLServiceAgreementCell *serviceAgreementCell = [tableView dequeueReusableCellWithIdentifier:@"KLServiceAgreementCell"];
    
    [serviceAgreementCell setModel:self.dataArray[indexPath.row]];
    
    return serviceAgreementCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KLServiceAgreementModel * model = self.dataArray[indexPath.row];
    
    return model.rowHight;
}
@end
