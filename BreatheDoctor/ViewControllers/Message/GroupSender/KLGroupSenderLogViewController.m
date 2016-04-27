//
//  KLGroupSenderLogViewController.m
//  BreatheDoctor
//
//  Created by comv on 16/4/26.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLGroupSenderLogViewController.h"
#import "LWPatientListCtr.h"
#import "KLGroupSenderChatCell.h"

@interface KLGroupSenderLogViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)   UITableView *tableView;
@property (nonatomic, strong)   UIButton    *groupSenderButton;
@end

@implementation KLGroupSenderLogViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [super addNavBar:@"群发记录"];
    [super addBackButton:@"nav_btnBack"];
}
- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self loadSubView];
    
    [self racEvent];
}

- (void)loadSubView{
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.groupSenderButton];

    self.groupSenderButton.sd_layout
    .leftSpaceToView(self.view,10)
    .rightSpaceToView(self.view,10)
    .bottomSpaceToView(self.view,10)
    .heightIs(40*MULTIPLEVIEW);
    
    self.tableView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .bottomSpaceToView(self.groupSenderButton,10)
    .topSpaceToView(self.view,0);
}

- (void)racEvent{
    
    WEAKSELF
    [[self.groupSenderButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        LWPatientListCtr *vc = [[LWPatientListCtr alloc] initWithListType:LISTTYPEGROUPSENDER];
        [KL_weakSelf.navigationController pushViewController:vc animated:YES];

    }];

}

#pragma mark - init
- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.separatorStyle = 0;
        _tableView.backgroundColor  = [UIColor clearColor];
        _tableView.rowHeight        = 250*MULTIPLE;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[KLGroupSenderChatCell class] forCellReuseIdentifier:@"KLGroupSenderChatCell"];
    }
    return _tableView;
}
- (UIButton *)groupSenderButton{
    
    if (!_groupSenderButton) {
        _groupSenderButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _groupSenderButton.backgroundColor = [LWThemeManager shareInstance].navBackgroundColor;
        [_groupSenderButton setTitle:@"新建群发" forState:UIControlStateNormal];
        [_groupSenderButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _groupSenderButton.titleLabel.font = kNSPXFONT(30);
        [_groupSenderButton setCornerRadius:4.0f];
    }
    return _groupSenderButton;
}
#pragma mark -dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    KLGroupSenderChatCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KLGroupSenderChatCell" forIndexPath:indexPath];
    return cell;
}

#pragma mark - click
- (void)navLeftButtonAction{

    [self.navigationController popViewControllerAnimated:YES];
}
@end
