//
//  LWMessageCtr.m
//  BreatheDoctor
//
//  Created by comv on 15/11/10.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWMessageCtr.h"
#import "LWMessageCell.h"
#import "LWMessageTakeCell.h"
#import "LWLoginManager.h"
#import "LWChatViewController.h"

@interface LWMessageCtr ()<LWMessageTakeCellDelegate>
@property (nonatomic, strong) NSMutableArray *messageArray;
@property (nonatomic, copy) NSString *refreshTime;
@end

@implementation LWMessageCtr
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [super addNavBar:@"消息"];
    [super addRightButton:@"nav_btnAdd.png"];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUI];
    [self loginjudge];
    [self registNotificationCenter];
}
- (void)registNotificationCenter
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appNotification:) name:APP_PUSH_TYPE_ASSESS_ACT object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appNotification:) name:APP_PUSH_TYPE_ASSESS_ASTHMA object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appNotification:) name:APP_PUSH_TYPE_FIRST_DIAGNOSE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appNotification:) name:APP_PUSH_TYPE_PATIENT_ADD_DIALOGUE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appNotification:) name:APP_PUSH_TYPE_PEF_RECORD object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appNotification:) name:APP_PUSH_TYPE_REPEAT_TREATMENT_INFORM object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appNotification:) name:APP_PUSH_TYPE_REQUEST_RELATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appNotification:) name:APP_TABBAR_ITM_MESSAGE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appNotification:) name:APP_LOGIN_SUCC object:nil];

}
- (void)appNotification:(NSNotification *)sender
{
    [self refreshHomeMsg];
}

- (void)setUI
{
    self.tableView.rowHeight = 60;
    self.tableView.backgroundColor = [UIColor whiteColor];
    setExtraCellLineHidden(self.tableView);
    
}
- (void)loginjudge
{    
    BOOL isLogin = [LWLoginManager isLogin];
    if (!isLogin) {
        [[LWLoginManager shareInstance] showLoginViewNav:self];
    }else
    {
        if ([[self sqlCacheMessages] count] > 0) {
            [self.messageArray removeAllObjects];
            [self.messageArray addObjectsFromArray:[self sqlCacheMessages]];
        }else
        {
            [self refreshHomeMsg];
        }
    }
}

#pragma mark - init
- (NSMutableArray *)messageArray
{
    if (!_messageArray) {
        _messageArray = [NSMutableArray array];
    }
    return _messageArray;
}

#pragma mark - tableviewdelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messageArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    LWMainRows *message = self.messageArray[indexPath.row];
    
    if (message.msgType != 2) {
        LWMessageCell *messageCell = [tableView dequeueReusableCellWithIdentifier:@"LWMessageCell" forIndexPath:indexPath];
        
        [messageCell setMessage:message];
        cell = messageCell;
        
    }else
    {
        LWMessageTakeCell *messageTakeCell = [tableView dequeueReusableCellWithIdentifier:@"LWMessageTakeCell" forIndexPath:indexPath];
        messageTakeCell.delegate = self;
        [messageTakeCell setMessage:message];
        cell = messageTakeCell;
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LWChatViewController *vc = (LWChatViewController *)[UIViewController CreateControllerWithTag:CtrlTag_PatientDialogue];
    vc.patient = self.messageArray[indexPath.row];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (NSMutableArray *)sqlCacheMessages
{
    return [[LKDBHelper getUsingLKDBHelper] search:[LWMainRows class] where:nil orderBy:@"insertDt DESC" offset:0 count:100000];
}

- (void)loadCacheMes
{
    NSMutableArray *array = [[LKDBHelper getUsingLKDBHelper] search:[LWMainRows class] where:nil orderBy:nil offset:0 count:10000];
    if (array.count <= 0) {
        return;
    }
    [self.messageArray removeAllObjects];
    [self.messageArray addObjectsFromArray:array];
    [self.tableView reloadData];

}

-(void)refreshHomeMsg
{
    if (self.messageArray.count > 0) {
        LWMainRows *model = [self.messageArray firstObject];
        self.refreshTime = model.insertDt;
    }

    [LWHttpRequestManager httpMaiMesggaeWithPage:1 size:100000 refreshDate:self.refreshTime  success:^(LWMainMessageBaseModel *mainMessageBaseModel) {
        [self.messageArray removeAllObjects];
        [self.messageArray addObjectsFromArray:[self sqlCacheMessages]];
        if (self.messageArray.count <= 0) {
            [self showErrorMessage:@"您还没有患者，去添加吧~"];
            return ;
        }
        [self hiddenNonetWork];
        [self.tableView reloadData];
    } failure:^(NSString *errorMes) {
        [LWProgressHUD showALAlertBannerWithView:self.view Style:SALAlertBannerStyleWarning  Position:SALAlertBannerPositionTop Subtitle:errorMes ];        
    }];
}

#pragma mark - nav
- (void)navRightButtonAction
{
    UIViewController *vc = [UIViewController CreateControllerWithTag:CtrlTag_AddPatient];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark -LWMessageTakeCellDelegate
- (void)tapAcceptButtonEventWith:(LWMainRows *)row
{
    [LWHttpRequestManager httpagreeAttentionWithPatientId:row.memberId sid:row.sid Success:^{
        [self refreshHomeMsg];
    } failure:^(NSString *errorMes) {
        [LWProgressHUD showALAlertBannerWithView:self.view Style:SALAlertBannerStyleWarning  Position:SALAlertBannerPositionTop Subtitle:errorMes ];
    }];
}

@end
