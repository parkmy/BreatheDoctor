//
//  KLMessageViewController.m
//  BreatheDoctor
//
//  Created by comv on 16/4/25.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLMessageViewController.h"
#import "KLMessgaeDataSource.h"
#import "KLMessageCell.h"
#import "KLMessageOperation.h"
#import "LWLoginManager.h"
#import "LWChatViewController.h"
#import "NSDate+Extension.h"
#import "LWNewFriendsViewController.h"
#import "KLGroupSenderLogViewController.h"
#import "KLRegistPublicOperation.h"

@interface KLMessageViewController ()

@property (nonatomic, strong)   UITableView *tableView;
@property (nonatomic, strong)   KLMessgaeDataSource *messageDataSource;
@property (nonatomic, copy)     NSString *refreshTime;
@property (nonatomic, strong)   LWMainMessageBaseModel *mainMessageModel;
@property (nonatomic, strong)   UIView *headerErrorView;
@property (nonatomic, strong)   UIView *headerGroupSenderView;
@end

@implementation KLMessageViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

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
    
    [super addNavBar:@"消息"];
    [super addRightButton:@"nav_btnAdd.png"];
    
    [self addSubViews];
    
    [self loginjudge];

    [self setBlock];
    
    [self registNotificationCenter];
    
    [self httpReachabilityStatusChange];
    
}
- (void)addSubViews{
    
    [self.view addSubview:self.tableView];
    self.tableView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(BARHIGHT, 0, 0, 0));
    setExtraCellLineHidden(self.tableView);
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

- (void)loginSucc:(NSNotification *)sender
{
    [[KLPromptViewManager shareInstance] kl_showPromptViewWithTitle:@"温馨提示" theContent:@"登陆成功O(∩_∩)O~"];
    [self showErrorMessage:@"暂时没有新消息~" isShowButton:YES type:showErrorTypeMore];
    [self.messageDataSource.messageArray removeAllObjects];
    [self.tableView reloadData];
    self.mainMessageModel = nil;
    [self refreshHomeMsg];
}
- (void)httpReachabilityStatusChange
{
    WEAKSELF
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status <= 0) {
            KL_weakSelf.tableView.tableHeaderView = KL_weakSelf.headerErrorView;
        }else
        {
            KL_weakSelf.tableView.tableHeaderView = KL_weakSelf.headerGroupSenderView;
            [KL_weakSelf refreshHomeMsg];
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
- (UIView *)headerGroupSenderView{

    if (!_headerGroupSenderView) {
        
        UIView *view = [UIView new];
        _headerGroupSenderView = view;
        view.backgroundColor = [UIColor whiteColor];
        
        UIView *footView = [UIView new];
        footView.backgroundColor = [UIColor colorWithHexString:@"#dddddd"];
        
        UIImageView *icon = [UIImageView new];
        icon.image = kImage(@"doctor_qunfa_icon");
        
        UIImageView *rightJiao = [UIImageView new];
        rightJiao.image = kImage(@"doctor_qunfa_jiantouRight");
        
        UILabel     *label = [UILabel new];
        label.font = kNSPXFONT(30);
        label.text = @"群发消息";
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [view addSubview:icon];
        [view addSubview:label];
        [view addSubview:rightJiao];
        [view addSubview:footView];
        [view addSubview:btn];
        
        view.frame = CGRectMake(0, 0, screenWidth, 115/2);
        footView.frame = CGRectMake(0, view.height-8, screenWidth, 8);
        icon.frame = CGRectMake(15, 0, icon.image.size.width, icon.image.size.height);
        icon.centerY = (view.height-footView.height)/2;
        rightJiao.frame = CGRectMake(screenWidth-rightJiao.image.size.width-15, 0, rightJiao.image.size.width, rightJiao.image.size.height);
        rightJiao.centerY = (view.height-footView.height)/2;
        label.frame = CGRectMake(icon.maxX+10, 0, 80, view.height-8);
        btn.frame = view.frame;
  
        WEAKSELF
        /**
         *  群发
         */
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            KLGroupSenderLogViewController *vc = [KLGroupSenderLogViewController new];
            vc.hidesBottomBarWhenPushed = YES;
            [KL_weakSelf.navigationController pushViewController:vc animated:YES];
        }];

    }
    return _headerGroupSenderView;
}

- (void)appNotification:(NSNotification *)sender
{
    if ([LWLoginManager isLogin])
    {
        [self refreshHomeMsg];
    }
}
- (void)loginjudge
{
    BOOL isLogin = [LWLoginManager isLogin];
    if (!isLogin)
    {
        [[LWLoginManager shareInstance] showLoginViewNav:self];
    }else
    {
        [LBLoginBaseModel updateUserModel];
        
        /**
         *  延迟判断是否认证
         */
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [KLRegistPublicOperation notCertificationAgainIfCertificationSuccess:^(BOOL isCheck) {
                
            }];
        });
        [self loadCacheMes];
    }
}
#pragma mark - init
- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor  = [UIColor whiteColor];
        _tableView.rowHeight        = 65*MULTIPLE;
        _tableView.dataSource       = self.messageDataSource;
        _tableView.delegate         = self.messageDataSource;
        [_tableView registerClass:[KLMessageCell class] forCellReuseIdentifier:@"KLMessageCell"];
    }
    return _tableView;
}
- (KLMessgaeDataSource *)messageDataSource{
    
    if (!_messageDataSource) {
        _messageDataSource = [KLMessgaeDataSource new];
    }
    return _messageDataSource;
}
#pragma mark - 获取缓存数据
- (void)loadCacheMes
{
    [self.messageDataSource.messageArray removeAllObjects];
    [self.messageDataSource.messageArray addObjectsFromArray:[KLMessageOperation sqlCacheMessages]];
    
    if (self.messageDataSource.messageArray.count <= 0) {
        
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
        if (self.messageDataSource.messageArray.count > 0) {//内存数组
            LWMainRows *model = [self.messageDataSource.messageArray firstObject];
            self.refreshTime = model.refreshTime;;
        }
    }
    WEAKSELF
    [LWHttpRequestManager httpMaiMesggaeWithPage:1 size:100000 refreshDate:self.refreshTime  success:^(LWMainMessageBaseModel *mainMessageBaseModel) {
        KL_weakSelf.mainMessageModel = mainMessageBaseModel;
        if (KL_weakSelf.mainMessageModel.body.rows.count <= 0) {
            [KLMessageOperation changeBadgeValueInfo:KL_weakSelf.navigationController.tabBarItem andMessgaeArray:KL_weakSelf.messageDataSource.messageArray];
            return ;
        }
        [KL_weakSelf hiddenNonetWork];
        [KLMessageOperation reloadTableViewInfoObjcs:KL_weakSelf.mainMessageModel.body.rows theMessageArray:KL_weakSelf.messageDataSource.messageArray theTableView:KL_weakSelf.tableView];
        [KLMessageOperation changeBadgeValueInfo:KL_weakSelf.navigationController.tabBarItem andMessgaeArray:KL_weakSelf.messageDataSource.messageArray];
    } failure:^(NSString *errorMes) {
        [KLMessageOperation changeBadgeValueInfo:KL_weakSelf.navigationController.tabBarItem andMessgaeArray:KL_weakSelf.messageDataSource.messageArray];
    }];
}
- (void)reloadTableView:(NSMutableArray *)array
{
    [self hiddenNonetWork];
    [self.tableView reloadData];
    [KLMessageOperation changeBadgeValueInfo:self.navigationController.tabBarItem andMessgaeArray:self.messageDataSource.messageArray];
}
#pragma mark - click
- (void)setBlock{
    
    WEAKSELF
    [self.messageDataSource setDidSelectRowAtIndexPathBlock:^(NSIndexPath *indexPath,LWMainRows *model) {
        [KL_weakSelf selectRowAtIndexPath:indexPath theModel:model];
    }];
    
    [self.messageDataSource setDeleteRowsAtIndexPathsBlock:^(NSIndexPath *indexPath,LWMainRows *model) {
        
        [[LKDBHelper getUsingLKDBHelper] deleteToDB:model];
        [KL_weakSelf.messageDataSource.messageArray removeObject:model];
        [KL_weakSelf.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [KLMessageOperation changeBadgeValueInfo:KL_weakSelf.navigationController.tabBarItem andMessgaeArray:KL_weakSelf.messageDataSource.messageArray];
        if (KL_weakSelf.messageDataSource.messageArray.count <= 0) {
            [KL_weakSelf showErrorMessage:@"暂时没有新消息~" isShowButton:YES type:showErrorTypeMore];
        }
        
    }];
    
}
#pragma mark -新朋友
- (void)pushNewFriendsViewWithModel:(LWMainRows *)message theIndexPath:(NSIndexPath *)indexPath{

    LWNewFriendsViewController *newFirends = (LWNewFriendsViewController *)[UIViewController CreateControllerWithTag:CtrlTag_newFriends];
    newFirends.requsetArray = message.requestArray;
    [self.navigationController pushViewController:newFirends animated:YES];
    
    WEAKSELF
    [newFirends setBackBlock:^(LWMainRows *model){
        message.count = message.count - 1;
        if (message.count <= 0) {
            [[LKDBHelper getUsingLKDBHelper] deleteToDB:message];
            [KL_weakSelf.messageDataSource.messageArray removeObject:message];
            [KL_weakSelf.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }else{
            
            [KL_weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }
        
        [KLMessageOperation changeBadgeValueInfo:KL_weakSelf.navigationController.tabBarItem andMessgaeArray:KL_weakSelf.messageDataSource.messageArray];
        
    }];
    
    [newFirends setAddSuccBlock:^{
        [KL_weakSelf refreshHomeMsg];
    }];

}
#pragma mark - 对话
- (void)pushChatViewTheModel:(LWMainRows *)message{

    LWChatViewController *vc = (LWChatViewController *)[UIViewController CreateControllerWithTag:CtrlTag_PatientDialogue];
    WEAKSELF
    [vc setBackBlock:^(NSString *date, NSString *content) {
        if (!date || !content) {
            return ;
        }
        NSString *wheres = [NSString stringWithFormat:@"memberId = %@",message.memberId];
        message.count = 0;
        message.insertDt = date;
        message.msgContent = content;
        [[LKDBHelper getUsingLKDBHelper] updateToDB:message where:wheres];
        [KLMessageOperation reloadTableViewInfoObjcs:@[message] theMessageArray:KL_weakSelf.messageDataSource.messageArray theTableView:KL_weakSelf.tableView];
        [KLMessageOperation changeBadgeValueInfo:KL_weakSelf.navigationController.tabBarItem andMessgaeArray:KL_weakSelf.messageDataSource.messageArray];
    }];
    vc.patient = message;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];

}
#pragma mark -选中的消息
- (void)selectRowAtIndexPath:(NSIndexPath *)indexPath theModel:(LWMainRows *)model{

    if (model.msgType == NEWTYPE) {
        [MobClick event:@"newfriend" label:@"新朋友按钮的点击量"];
        [self pushNewFriendsViewWithModel:model theIndexPath:indexPath];
    }else
    {
        [self pushChatViewTheModel:model];
    }
    
}
#pragma mark -添加患者
- (void)navRightButtonAction
{
    if (![LBLoginBaseModel isCheckStatusTheIsShow:YES]) {
        return;
    }
    UIViewController *vc = [UIViewController CreateControllerWithTag:CtrlTag_AddPatient];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
