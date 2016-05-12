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
#import "KLGroupSenderChatModel.h"
#import "KLGroupSenderChatView.h"
#import <MJRefresh.h>
#import "KLGroupSenderViewCtr.h"
#import "KLGroupSenderChatModel.h"
#import "KLGroupSenderPatientListModel.h"
#import "KLIndicatorViewManager.h"
#import "KLGoodsDetailedViewController.h"
#import "LWVoiceManager.h"
#import "NSDate+Extension.h"
#import "KLGroupSenderOperation.h"


@interface KLGroupSenderLogViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)   UITableView *tableView;
@property (nonatomic, strong)   UIButton    *groupSenderButton;
@property (nonatomic, strong)   NSMutableArray *messageArray;
@property (nonatomic, copy)     NSString       *refTimer;
@property (nonatomic, strong)   UIView  *notMessageView;
@property (nonatomic, assign) RefreshType refreshType;
@property (nonatomic, assign)   BOOL  fistShowVC;
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
    
    [self initProperty];
    
    [self racEvent];
    
    [self xialarefreshData];
    
}
- (void)initProperty
{
    self.refreshType = RefreshTypeTypeOld;
    
    [self refTimerUpdate];
}
- (NSMutableArray *)messageArray
{
    if (!_messageArray) {
        _messageArray = [NSMutableArray array];
    }
    return _messageArray;
}

- (void)updateData:(NSMutableArray *)array{
    
    [self.messageArray addObjectsFromArray:array];
    
    [self.messageArray sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        
        
        KLGroupSenderChatModel *model1 = obj1;
        KLGroupSenderChatModel *model2 = obj2;
        
        NSDate *time1 = [NSDate dateWithString:model1.createDt format:[NSDate ymdHmsFormat]];
        NSDate *time2 = [NSDate dateWithString:model2.createDt format:[NSDate ymdHmsFormat]];
        
        NSComparisonResult result = [time1 compare:time2];
        
        return result;
        
    }];

    [self.tableView reloadData];
    
    if (self.messageArray.count <= 0) {
        
        [self showNotMessageView];
        return;
    }else{
        
        [self hiddenNotMessageView];
    }

    if (self.refreshType == RefreshTypeNew) {
        
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.messageArray.count-1 inSection:0] atScrollPosition:0 animated:false];

    }else{
        
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:array.count-1 inSection:0] atScrollPosition:0 animated:false];
    }

}

- (void)refTimerUpdate{
    
    /**
     *  内存中寻找
     */
    if (self.messageArray.count > 0) {
        
        NSString *reftdate = nil;
        
        if (self.refreshType == RefreshTypeNew) {
            
            reftdate = [(KLGroupSenderChatModel *)[self.messageArray lastObject] createDt];
        }else{
            
            reftdate = [(KLGroupSenderChatModel *)[self.messageArray firstObject] createDt];
        }
        
        NSMutableArray *array = [KLGroupSenderChatModel loadSqlDataTheReftimerWhere:[KLGroupSenderChatModel refWhereTheRefTimer:reftdate theRefType:self.refreshType]];
        
        if (array.count > 0) {
            
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            [self updateData:array];
        }else{
            
            [self loadHttpGroupSenderDataTheRefTimer:reftdate];
        }
    }else
    {
        
        NSMutableArray *array = [KLGroupSenderChatModel loadSqlDataTheReftimerWhere:[KLGroupSenderChatModel refWhereTheRefTimer:[NSDate stringWithDate:[NSDate date] format:[NSDate ymdHmsFormat]] theRefType:self.refreshType]];
                /**
         *  本地有取本地时间
         */
        if (array.count > 0) {
            
            [self updateData:array];
            /**
             *  第一次进来的进行刷新新数据
             */
            if (!self.fistShowVC) {
                self.fistShowVC = YES;
                [self reloadNewData];
            }
            
        }else{
            /**
             *  本地没有默认 nil
             */
            self.refTimer = nil;
            /**
             *  加载旧数据
             */
            self.refreshType = RefreshTypeTypeOld;
            /**
             *  请求网络
             */
            [self loadHttpGroupSenderDataTheRefTimer:nil];
        }
    }
    
}
- (void)xialarefreshData
{
    __weak typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        weakSelf.refreshType = RefreshTypeTypeOld;
        [weakSelf refTimerUpdate];
    }];
    
    // 设置文字
    [header setTitle:@"下拉加载数据" forState:MJRefreshStateIdle];
    [header setTitle:@"正在加载 ..." forState:MJRefreshStateRefreshing];
    // 隐藏时间
    //    header.lastUpdatedTimeLabel.hidden = YES;
    [self.tableView setMj_header:header];
    
}
- (void)loadHttpGroupSenderDataTheRefTimer:(NSString *)refDate{
    
    WEAKSELF
    [LWHttpRequestManager httploadMassDialogueRecordWithRefreshTime:refDate thePage:0 theType:self.refreshType Success:^(NSMutableArray *models) {
        
        [KL_weakSelf.tableView.mj_header endRefreshing];
        [KL_weakSelf.tableView.mj_footer endRefreshing];
        if (models.count > 0) {
            
            [self updateData:models];
            return ;
        }
        if (self.messageArray.count <= 0) {
            
            [self showNotMessageView];
            return;
        }else{
            
            [self hiddenNotMessageView];
        }
    } failure:^(NSString *errorMes) {
        
        [KL_weakSelf.tableView.mj_header endRefreshing];
        [KL_weakSelf.tableView.mj_footer endRefreshing];
        [[KLPromptViewManager shareInstance] kl_showPromptViewWithTitle:@"温馨提示" theContent:errorMes];
    }];
}
- (void)reloadRequestWithSender:(UIButton *)sender{
    
    [self hiddenNonetWork];
    [self.tableView.mj_header beginRefreshing];
}
- (void)hiddenNotMessageView{
    
    if (_notMessageView) {
        [_notMessageView removeFromSuperview];
        _notMessageView = nil;
    }
}
- (void)showNotMessageView{
    
    _notMessageView = [UIView new];
    
    UIImageView *icon = [UIImageView new];
    icon.image = kImage(@"groupsender_notmessgae.png");
    [_notMessageView addSubview:icon];
    UILabel *label = [UILabel new];
    label.textAlignment = 1;
    label.textColor = [UIColor colorWithHexString:@"#999999"];
    label.font = kNSPXFONT(26);
    label.numberOfLines = 0;
    label.text = @"你可以把消息，文章，商品，发送给您的每一位患者朋友！";
    [_notMessageView addSubview:label];
    label.frame = CGRectZero;
    icon.frame = CGRectZero;
    _notMessageView.frame = CGRectZero;
    
    _notMessageView.width = 200;
    _notMessageView.height = icon.image.size.height+ [label.text heightWithFont:label.font constrainedToWidth:200]+30;
    _notMessageView.center = self.view.center;
    
    icon.size = icon.image.size;
    icon.centerX = _notMessageView.width/2;
    icon.centerY = icon.height/2+10;
    
    label.width = 200;
    label.height = [label.text heightWithFont:label.font constrainedToWidth:200];
    label.yOrigin = icon.maxY + 10;
    
    [self.view addSubview:_notMessageView];
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
    
    /**
     *  新建群发
     */
    WEAKSELF
    [[self.groupSenderButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        LWPatientListCtr *vc = [[LWPatientListCtr alloc] initWithListType:LISTTYPEGROUPSENDER];
        [KL_weakSelf.navigationController pushViewController:vc animated:YES];
        /**
         *  群发成功
         */
        [[vc rac_signalForSelector:@selector(patientListGuoupSenderSuccess)] subscribeNext:^(id x) {
            
            [KL_weakSelf reloadNewData];
            [KL_weakSelf.navigationController popToViewController:KL_weakSelf animated:YES];
        }];
    }];
}
/**
 *  刷新新数据
 */
- (void)reloadNewData{
    
    self.refreshType = RefreshTypeNew;
    [self refTimerUpdate];
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
    
    return self.messageArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    KLGroupSenderChatCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KLGroupSenderChatCell" forIndexPath:indexPath];
    
    KLGroupSenderChatModel *model = self.messageArray[indexPath.row];
    [cell setModel:model];
    /**
     *  再次群发
     *
     */
    WEAKSELF
    [cell setAgainSenderEventBlock:^{
        
        KLGroupSenderViewCtr *vc = [[KLGroupSenderViewCtr alloc] initWithGroupSenderPatientListModel:[KLGroupSenderPatientListModel againSenderPatientListModelWith:model]];
        vc.pushType = PUSHTYPEAGAIN;
        [KL_weakSelf.navigationController pushViewController:vc animated:YES];
        
        [[vc rac_signalForSelector:@selector(guoupSenderSuccess)] subscribeNext:^(id x) {
            
            [KL_weakSelf reloadNewData];
            [KL_weakSelf.navigationController popToViewController:KL_weakSelf animated:YES];
        }];
        
    }];
    /**
     *  删除
     */
    [cell setRemoveEventBlock:^(KLGroupSenderChatModel *deleModel){
        
        [[KLIndicatorViewManager standardIndicatorViewManager] showLoadingWithContent:@"正在删除" theView:KL_weakSelf.view];
        [LWHttpRequestManager httpdeleteMassDialogueRecordWithMassDialogueId:deleModel.sid Success:^{
            
            [[KLIndicatorViewManager standardIndicatorViewManager] hiddenIndicatorView];
            
            if (KL_weakSelf.messageArray.count <= 0) {
                return ;
            }
            
            NSInteger index = [KL_weakSelf.messageArray indexOfObject:deleModel];
            NSIndexPath *dele_indexPath = [NSIndexPath indexPathForRow:index inSection:0];

            /**
             *  删除内存
             */
            [KL_weakSelf.messageArray removeObject:deleModel];

            /**
             *  删除缓存
             */
            [[LKDBHelper getUsingLKDBHelper] deleteToDB:deleModel];
            
            /**
             *  清除缓存
             */
            [KL_weakSelf.tableView.cellAutoHeightManager clearHeightCache];
            
            [KL_weakSelf.tableView beginUpdates];
            [KL_weakSelf.tableView deleteRowsAtIndexPaths:@[dele_indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [KL_weakSelf.tableView endUpdates];
            /**
             *  判断是否没数据了
             */
            if (KL_weakSelf.messageArray.count <= 0) {
                
                [KL_weakSelf.tableView.mj_header beginRefreshing];
            }else{
                
                [[KLIndicatorViewManager standardIndicatorViewManager] showErrorWith:@"删除成功" theView:KL_weakSelf.view theImage:nil];
            }
        } failure:^(NSString *errorMes) {
            
        }];
    }];
    /**
     *  点击商品查看预览
     */
    [cell setTapGoodsBlock:^(NSString *goodsId) {
        
        KLGoodsDetailedViewController *vc = [[KLGoodsDetailedViewController alloc] initWithGoodsId:goodsId theFootButtonHidden:YES];
        [KL_weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    
    /**
     *  语音播放
     */
    [cell setVoiceTapBlock:^(id model ,id view) {
        
        KLGroupSenderChatModel *palyModel = model;
        [[LWVoiceManager shareInstance] playVoiceWithPlayModel:palyModel withPlayImageView:view];
        
    }];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id model = self.messageArray[indexPath.row];
    CGFloat height = [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[KLGroupSenderChatCell class] contentViewWidth:[self cellContentViewWith]];
    
    return height;
}
- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && systemVersion < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}
#pragma mark - click
- (void)navLeftButtonAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
