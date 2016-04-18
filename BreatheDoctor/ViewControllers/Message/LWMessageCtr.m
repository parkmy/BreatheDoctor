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
#import "NSDate+Extension.h"
#import "LWNewFriendsViewController.h"
#import "KLMessageOperation.h"


@interface LWMessageCtr ()<LWMessageTakeCellDelegate>
@property (nonatomic, strong)   NSMutableArray *messageArray;
@property (nonatomic, copy)     NSString *refreshTime;
//@property (nonatomic, strong)   NSMutableArray *requestMessageArray;
@property (nonatomic, strong)   LWMainMessageBaseModel *mainMessageModel;
@property (nonatomic, strong)   UIView *headerErrorView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
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
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear: animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setUI];
    [self registNotificationCenter];
    [self loginjudge];
    
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSucc:) name:APP_LOGIN_SUCC object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appNotification:)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];
}
- (NSMutableArray *)messageArray{
    if (!_messageArray) {
        _messageArray = [NSMutableArray array];
    }
    return _messageArray;
}
//- (NSMutableArray *)requestMessageArray
//{
//    if (!_requestMessageArray) {
//        _requestMessageArray = [NSMutableArray array];
//    }
//    return _requestMessageArray;
//}
- (void)loginSucc:(NSNotification *)sender
{
    [self showErrorMessage:@"暂时没有新消息~" isShowButton:YES type:showErrorTypeMore];
    [self.messageArray removeAllObjects];
    [self.tableView reloadData];
    self.mainMessageModel = nil;
    [self refreshHomeMsg];
}
- (void)appNotification:(NSNotification *)sender
{
    if ([LWLoginManager isLogin])
    {
        [self refreshHomeMsg];
    }
}
- (void)setUI
{
    self.tableView.rowHeight = 65;
    self.tableView.backgroundColor = [UIColor whiteColor];
    setExtraCellLineHidden(self.tableView);
    
    [self httpReachabilityStatusChange];
}
- (void)httpReachabilityStatusChange
{
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status <= 0) {
            self.tableView.tableHeaderView = self.headerErrorView;
        }else
        {
            self.tableView.tableHeaderView = nil;
            [self refreshHomeMsg];
        }
    }];
}
- (UIView *)headerErrorView
{
    if (!_headerErrorView) {
        _headerErrorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 35)];
        _headerErrorView.backgroundColor = RGBA(252, 240, 184, 1);
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.textColor = RGBA(0, 0, 0, 6);
        label.font = [UIFont systemFontOfSize:14];
        UIImageView *erroricon = [[UIImageView alloc] initWithFrame:CGRectZero];
        erroricon.image = kImage(@"sendFail");
        [_headerErrorView addSubview:erroricon];
        [_headerErrorView addSubview:label];
        
        erroricon.sd_layout.leftSpaceToView(_headerErrorView,5).centerYEqualToView(_headerErrorView).widthIs(20).heightIs(20);
        label.text = @"世界上最遥远的距离就是没网～";
        label.sd_layout.leftSpaceToView(erroricon,5).rightSpaceToView(_headerErrorView,5).topSpaceToView(_headerErrorView,0).bottomSpaceToView(_headerErrorView,0);
        
    }
    return _headerErrorView;
}
- (void)loginjudge
{
    BOOL isLogin = [LWLoginManager isLogin];
    if (!isLogin)
    {
        [[LWLoginManager shareInstance] showLoginViewNav:self];
    }else
    {
        [self loadCacheMes];
    }
}

- (void)reloadTableView:(NSMutableArray *)array
{
    [self hiddenNonetWork];
    [self.tableView reloadData];
    [KLMessageOperation changeBadgeValueInfo:self.navigationController.tabBarItem andMessgaeArray:self.messageArray];
}

#pragma mark - tableviewdelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messageArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LWMainRows *message = self.messageArray[indexPath.row];
    LWMessageCell *messageCell = [tableView dequeueReusableCellWithIdentifier:@"LWMessageCell" forIndexPath:indexPath];
    [messageCell setMessage:message];
    return messageCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    LWMainRows *message = self.messageArray[indexPath.row];
    
    if (message.msgType == NEWTYPE) {
        [MobClick event:@"newfriend" label:@"新朋友按钮的点击量"];
        
        LWNewFriendsViewController *newFirends = (LWNewFriendsViewController *)[UIViewController CreateControllerWithTag:CtrlTag_newFriends];
        newFirends.requsetArray = message.requestArray;
        [self.navigationController pushViewController:newFirends animated:YES];
        [newFirends setBackBlock:^(LWMainRows *model){
            message.count = message.count - 1;
            if (message.count <= 0) {
                [[LKDBHelper getUsingLKDBHelper] deleteToDB:message];
                [self.messageArray removeObject:message];
                [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }else{
                
                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }
            [KLMessageOperation changeBadgeValueInfo:self.navigationController.tabBarItem andMessgaeArray:self.messageArray];
        }];
        [newFirends setAddSuccBlock:^{
            [self refreshHomeMsg];
        }];
    }else
    {
        LWChatViewController *vc = (LWChatViewController *)[UIViewController CreateControllerWithTag:CtrlTag_PatientDialogue];
        [vc setBackBlock:^(NSString *date, NSString *content) {
            if (!date || !content) {
                return ;
            }
            NSString *wheres = [NSString stringWithFormat:@"memberId = %@",message.memberId];
            message.count = 0;
            message.insertDt = date;
            message.msgContent = content;
            [[LKDBHelper getUsingLKDBHelper] updateToDB:message where:wheres];
            [KLMessageOperation reloadTableViewInfoObjcs:@[message] theMessageArray:self.messageArray theTableView:self.tableView];
            [KLMessageOperation changeBadgeValueInfo:self.navigationController.tabBarItem andMessgaeArray:self.messageArray];
        }];
        vc.patient = message;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark 滑动表格删除行


-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    LWMainRows *message = self.messageArray[indexPath.row];
    [[LKDBHelper getUsingLKDBHelper] deleteToDB:message];
    [self.messageArray removeObject:message];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [KLMessageOperation changeBadgeValueInfo:self.navigationController.tabBarItem andMessgaeArray:self.messageArray];
    if (self.messageArray.count <= 0) {
        [self showErrorMessage:@"暂时没有新消息~" isShowButton:YES type:showErrorTypeMore];
    }
}

#pragma mark - 获取缓存数据
- (void)loadCacheMes
{
    [self.messageArray removeAllObjects];
    [self.messageArray addObjectsFromArray:[KLMessageOperation sqlCacheMessages]];
    
    if (self.messageArray.count <= 0) {
        [self showErrorMessage:@"暂时没有新消息~" isShowButton:YES type:showErrorTypeMore];
        self.navigationController.tabBarItem.badgeValue = nil;
        [self refreshHomeMsg];
        
    }else{
        [self reloadTableView:nil];
    }
}
#pragma mark - 获取刷新数据
-(void)refreshHomeMsg
{
    self.refreshTime = nil;
    if (self.mainMessageModel)//内存对象
    {
        self.refreshTime = self.mainMessageModel.body.refreshDate;
    }else
    {
        if (self.messageArray.count > 0) {//内存数组
            LWMainRows *model = [self.messageArray firstObject];
            self.refreshTime = model.refreshTime;;
        }
    }
    [LWHttpRequestManager httpMaiMesggaeWithPage:1 size:100000 refreshDate:self.refreshTime  success:^(LWMainMessageBaseModel *mainMessageBaseModel) {
        self.mainMessageModel = mainMessageBaseModel;
        if (self.mainMessageModel.body.rows.count <= 0) {
            return ;
        }
        [self hiddenNonetWork];
        [KLMessageOperation reloadTableViewInfoObjcs:self.mainMessageModel.body.rows theMessageArray:self.messageArray theTableView:self.tableView];
        [KLMessageOperation changeBadgeValueInfo:self.navigationController.tabBarItem andMessgaeArray:self.messageArray];
    } failure:^(NSString *errorMes) {
        //        [self showErrorMessage:errorMes isShowButton:NO type:showErrorTypeHttp];
    }];
}

#pragma mark - nav
- (void)navRightButtonAction
{
    UIViewController *vc = [UIViewController CreateControllerWithTag:CtrlTag_AddPatient];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
