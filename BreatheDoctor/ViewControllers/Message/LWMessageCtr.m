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

#define NEWTYPE 110

@interface LWMessageCtr ()<LWMessageTakeCellDelegate>
@property (nonatomic, strong)   NSMutableArray *messageArray;
@property (nonatomic, copy)     NSString *refreshTime;
@property (nonatomic, strong)   NSMutableArray *requestMessageArray;
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
- (NSMutableArray *)requestMessageArray
{
    if (!_requestMessageArray) {
        _requestMessageArray = [NSMutableArray array];
    }
    return _requestMessageArray;
}
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
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSMutableArray *array = [self sqlCacheMessages];
            if ([array count] > 0) {
                [self reloadTableView:array];
            }else
            {
                [self showErrorMessage:@"暂时没有新消息~" isShowButton:YES type:showErrorTypeMore];
                [self refreshHomeMsg];
            }
        });
    }
}

- (void)reloadTableView:(NSMutableArray *)array
{
    [self.messageArray removeAllObjects];
    [self.messageArray addObjectsFromArray:array];
    [self hiddenNonetWork];
    [self.tableView reloadData];
    [self setBadgeValue:self.messageArray];
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
        LWNewFriendsViewController *newFirends = (LWNewFriendsViewController *)[UIViewController CreateControllerWithTag:CtrlTag_newFriends];
        newFirends.requsetArray = self.requestMessageArray;
        [self.navigationController pushViewController:newFirends animated:YES];
        [newFirends setBackBlock:^{
            [self loadCacheMes];
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
            [self loadCacheMes];
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
    if (message.msgType == NEWTYPE) {
        
        NSInteger value = [self.navigationController.tabBarItem.badgeValue integerValue]-self.requestMessageArray.count;
        if (value <= 0) {
            self.navigationController.tabBarItem.badgeValue = nil;
        }else{
            self.navigationController.tabBarItem.badgeValue = [NSString stringWithFormat:@"%@",kNSNumInteger(value)];
        }
    }
    [[LKDBHelper getUsingLKDBHelper] deleteToDB:message];
    [self.messageArray removeObject:message];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
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
    NSString *wheres = [NSString stringWithFormat:@"memberId = %@",@"requestmessage"];
    
    NSMutableArray *array = [[LKDBHelper getUsingLKDBHelper] search:[LWMainRows class] where:nil orderBy:@"insertDt DESC" offset:0 count:100000];
    
    [self.requestMessageArray removeAllObjects];
    NSMutableArray *array1 = [NSMutableArray array];
    LWMainRows *requestModel = nil;
    
    for (LWMainRows *row in array) //遍历得到请求消息和对话消息以及新朋友
    {
        if (row.msgType == 2)
        { //请求消息
            if (row.isDispose == 0)
            { //拒绝的患者不添加
                [self.requestMessageArray addObject:row];
            }
        }else if (row.msgType == NEWTYPE) //新朋友
        {
            requestModel = row;
            [array1 addObject:row];
        }
        else//对话消息
        {
            [array1 addObject:row];
        }
    }
//160310144600117
    //160310144602010002
    // "160310144500116",
    // "160310144602010002",
    if (self.requestMessageArray.count > 0) { //当请求消息
        
        if (requestModel) {//如果有新朋友对象直接修改
            requestModel.insertDt = [(LWMainRows *)[self.requestMessageArray firstObject] insertDt];
            requestModel.count = self.requestMessageArray.count;;
        }else//没有救进行插入
        {
            LWMainRows *model = [[LWMainRows alloc] init];
            model.insertDt = [(LWMainRows *)[self.requestMessageArray firstObject] insertDt];
            model.msgContent = @"您有新的患者申请";
            model.patientName = @"新朋友";
            model.count = self.requestMessageArray.count;
            model.memberId = @"requestmessage";
            model.msgType = NEWTYPE;
            [array1 addObject:model];
            
            NSInteger count = [[LKDBHelper getUsingLKDBHelper] rowCount:[LWMainRows class] where:wheres];
            if (count > 0) {
                [[LKDBHelper getUsingLKDBHelper] updateToDB:model where:wheres];
            }else
            {
                [[LKDBHelper getUsingLKDBHelper] insertToDB:model];
            }
        }
    }else //没有请求消息删除新朋友
    {
        if (requestModel) {
            [[LKDBHelper getUsingLKDBHelper] deleteWithClass:[LWMainRows class] where:wheres];
            [array1 removeObject:requestModel];
        }
    }
    
    [array1 sortUsingComparator:^NSComparisonResult(LWMainRows * obj1, LWMainRows * obj2) { //时间排序
            NSDate *time1 = [NSDate dateWithString:obj1.insertDt format:[NSDate ymdHmsFormat]];
            NSDate *time2 = [NSDate dateWithString:obj2.insertDt format:[NSDate ymdHmsFormat]];
            NSComparisonResult result = [time2 compare:time1];
        return result;
    }];
    return array1;
}

- (void)loadCacheMes
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSMutableArray *array = [self sqlCacheMessages];
        if (array.count <= 0) {
            [self showErrorMessage:@"暂时没有新消息~" isShowButton:YES type:showErrorTypeMore];
            return ;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self reloadTableView:array];
        });
    });

}

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
        }else
        {
            NSMutableArray *array = [self sqlCacheMessages];//本地缓存
            if ([array count] > 0) {
                LWMainRows *model = [array firstObject];
                self.refreshTime = model.refreshTime;
            }
        }
    }
    [LWHttpRequestManager httpMaiMesggaeWithPage:1 size:100000 refreshDate:self.refreshTime  success:^(LWMainMessageBaseModel *mainMessageBaseModel) {
        self.mainMessageModel = mainMessageBaseModel;
        [self loadCacheMes];
    } failure:^(NSString *errorMes) {
//        [self showErrorMessage:errorMes isShowButton:NO type:showErrorTypeHttp];
    }];
}
- (void)reloadRequestWithSender:(UIButton *)sender
{
    [self refreshHomeMsg];
}
#pragma mark 处理角标
-(void)setBadgeValue:(NSMutableArray *)models
{
    NSInteger value = 0;
    
    for (LWMainRows *model in models) {
        value += model.count;
    }
    [UIApplication sharedApplication].applicationIconBadgeNumber = value;
    if (value <= 0)
    {
        self.navigationController.tabBarItem.badgeValue = nil;
    }
    else if (value > 99)
    {
        self.navigationController.tabBarItem.badgeValue=@"99+";
    }
    else
    {
        self.navigationController.tabBarItem.badgeValue=[NSString stringWithFormat:@"%@",kNSNumInteger(value)];
    }
}
#pragma mark - nav
- (void)navRightButtonAction
{
    UIViewController *vc = [UIViewController CreateControllerWithTag:CtrlTag_AddPatient];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
