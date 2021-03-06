//
//  LWChatViewController.m
//  BreatheDoctor
//
//  Created by comv on 15/11/14.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWChatViewController.h"
#import "LWChatMessageInputBar.h"
#import "PureLayout.h"
#import <IQKeyboardManager.h>
#import "LWChatViewControllerDataSource.h"
#import "UIResponder+Router.h"
#import "YRJSONAdapter.h"
#import "LWVoiceManager.h"
#import <MJRefresh.h>
#import "LWTool.h"
#import "FastReplyVC.h"
#import "LWPatientCententCtr.h"
#import "LWAsthmaAssessmentViewController.h"
#import "LWACTAssessmentViewController.h"
#import "UUMessageCell.h"
#import "UUMessageFrame.h"
#import "NSDate+Extension.h"
#import "MJPhotoBrowser.h"
#import "LWTheFormTypeViewController.h"
#import "LWTheFormViewController.h"
#import "LWReservationDetailedViewController.h"
#import "LWHistoricalRecordVC.h"
#import "PushMgrInfo.h"
#import "KLPatientListModel.h"
#import "KLImagePickerManager.h"
#import "LWUpLoadingManager.h"
#import "KLGoodsViewController.h"
#import "KLGoodsDetailedViewController.h"
#import "KLIndicatorViewManager.h"

#define kBkColorTableView    ([UIColor colorWithRed:0.773 green:0.855 blue:0.824 alpha:1])

typedef NS_ENUM(NSInteger ,RefreshType)
{
    RefreshTypeTypeOld = 1, //向上加载旧数据
    RefreshTypeNew = 2, //加载最新数据
};
typedef NS_ENUM(NSInteger , SenderType) {
    SenderTypeText = 1, //文字
    SenderTypeImage = 2,//图片
    SenderTypeVoice = 3,//语音
};

@interface LWChatViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,LWChatMessageInputBarDelegate,UIViewControllerTransitioningDelegate,LWChatViewControllerDataSourceDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *DataSource;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) RefreshType refreshType;

@property (nonatomic, strong) LWChatViewControllerDataSource *chatViewControllerDataSource;

@property (nonatomic, assign) SenderType senderType;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, copy) NSString *refTimer;
//@property (nonatomic, assign) long long mesageRows;
@end

@implementation LWChatViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enable = NO;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [super addNavBar:self.patient.patientName];
    [super addBackButton:@"nav_btnBack"];
    [super addRightButton:@"newR_.png"];
    [LWPublicDataManager shareInstance].currentPatientID = self.patient.memberId; //记录对话ID

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[LWVoiceManager shareInstance] stopVoice];
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    [[LWPublicDataManager shareInstance] cloesCurrentPatientID]; //清除对话ID
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[PushMgrInfo sharedInstance] isRegisterUserNotification:[UIApplication sharedApplication] theisInfoDate:NO];
    
    [self initProperty];
    [self setUI];
    [self loadSQLData];
    [self registNotificationCenter];
    [self xialarefreshData];
    [self loadHttpChatList];

}
- (void)setUI
{
    
    UIEdgeInsets inset = UIEdgeInsetsMake(BARHIGHT, 0, 0, 0);
    
    [self.view addSubview:self.tableView];
    [self.tableView autoPinEdgesToSuperviewEdgesWithInsets:inset excludingEdge:ALEdgeBottom];
    
    
    [self.view addSubview:self.inputBar];
    self.inputBar.baseTbaleView = self.tableView;
    [self.inputBar autoPinEdgesToSuperviewEdgesWithInsets:inset excludingEdge:ALEdgeTop];
    [self.inputBar autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.tableView];
    
    self.tableView.delegate             =   self.chatViewControllerDataSource;
    self.tableView.dataSource           =   self.chatViewControllerDataSource;
}

#pragma mark -NSNotificationCenter

- (void)dealloc
{
    [self backLoadMessage];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)registNotificationCenter
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appNotificationss:)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(senderZhenduanMokuai:) name:APP_PUSH_TYPE_SENDERZHENGDUANMOKUAISUCC object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appNotificationss:) name:APP_PUSH_TYPE_NEWMESSAGE object:nil];

    
}
- (void)senderZhenduanMokuai:(NSNotification *)sender
{
     LWSenderResBaseModel *model = (LWSenderResBaseModel *)sender.userInfo[@"message"];
    [self addSenderModel:model];
}
- (void)appNotificationss:(NSNotification *)sender
{
    self.refreshType = RefreshTypeNew;
    [self loadHttpChatList];
}

#pragma mark - init
- (void)initProperty
{
    self.refreshType = RefreshTypeNew;
    self.page = 1;
}

#pragma mark - loadChatList

- (void)xialarefreshData
{
    __weak typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        weakSelf.page++;
        weakSelf.refreshType = RefreshTypeTypeOld;
        if (weakSelf.DataSource.count > 0)
        {
            NSInteger count = weakSelf.DataSource.count;
            NSMutableArray *array = [weakSelf refSQLData:[weakSelf refDate]];
            if (array.count <= 0)
            {
                [weakSelf loadHttpChatList];
            }else
            {
                [weakSelf.DataSource addObjectsFromArray:array];
                
                
                [weakSelf reloadTableViewCount:count];
                [weakSelf.tableView.mj_header endRefreshing];
            }
        }else
        {
            [weakSelf loadHttpChatList];
        }
    }];

    // 设置文字
    [header setTitle:@"下拉加载数据" forState:MJRefreshStateIdle];
    [header setTitle:@"正在加载 ..." forState:MJRefreshStateRefreshing];
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    [self.tableView setMj_header:header];

    
}

- (NSMutableArray *)refSQLData:(NSString *)refTimer
{
    
    NSString *where = [NSString stringWithFormat:@"insertDt < '%@' and memberId = %@",refTimer,self.patient.memberId];
    
    NSMutableArray *array = [LWChatBaseModel LoadSqliteDataWhere:where Offset:0 count:10];
    
    return array;
    
}
- (void)reloadTableViewCount:(NSInteger)count
{
    [LWChatBaseModel minuteOffSetArray:self.DataSource];
    [LWTool traverseChatMessage:self.DataSource];
    
//    NSInteger nowCount = self.DataSource.count + count;
    CGFloat oldHeight = self.tableView.contentHeight;

    if (self.DataSource.count > 0) {
        [self.tableView reloadData];
        if (self.DataSource.count > 0 && self.DataSource.count > count && count != 0) {
//            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:oldCount inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:NO];
            
            [self.tableView scrollRectToVisible:CGRectMake(0,self.tableView.contentHeight-oldHeight-60, self.tableView.width, self.tableView.height) animated:false];
        }else
        {
            if (self.DataSource.count > 0) {
                [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.DataSource.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:NO];
            }
        }
    }

}

- (void)loadSQLData
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSString *where;
        if ([self refDate]) {
            where = [NSString stringWithFormat:@"insertDt < '%@' and memberId = %@",[self refDate],self.patient.memberId];
        }else
        {
            where = [NSString stringWithFormat:@"memberId = %@",self.patient.memberId];
        }
        
        NSMutableArray *array = [LWChatBaseModel LoadSqliteDataWhere:where Offset:0 count:10];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSInteger count = self.DataSource.count;
            [self.DataSource addObjectsFromArray:array];
            [self  reloadTableViewCount:count];
            [self.tableView.mj_header endRefreshing];

        });
    });
    

}

- (NSString *)refDate
{
    if (self.refreshType == RefreshTypeNew)
    {
        NSString *where = [NSString stringWithFormat:@"insertDt < '%@' and memberId = %@",[NSDate stringWithDate:[NSDate date] format:[NSDate ymdHmsFormat]],self.patient.memberId];
        NSMutableArray *array = [LWChatBaseModel LoadSqliteDataWhere:where Offset:0 count:10];
        UUMessageFrame *modelFram = [array firstObject];
        self.refTimer = modelFram.model.refreshDate;
        return modelFram.model.refreshDate;
    }else
    {
        UUMessageFrame *messageFram = [self.DataSource firstObject];
        return messageFram.model.insertDt;
    }
}

- (void)loadHttpChatList
{
    [LWHttpRequestManager httpChatPatientListWithPatientId:self.patient.memberId Page:self.page type:self.refreshType size:10 refreshDate: [self refDate] success:^(NSMutableArray *chats, LWChatBaseModel *baseModel) {
        [self.tableView.mj_header endRefreshing];
        
        if (chats.count <= 0) {
            return ;
        }
        NSInteger count = self.DataSource.count;
        if (self.refreshType == RefreshTypeNew) {
            [self.DataSource removeAllObjects];
        }
        [self.DataSource addObjectsFromArray:chats];
        [self reloadTableViewCount:count];
    } failure:^(NSString *errorMes) {
        [self.tableView.mj_header endRefreshing];
        [LWProgressHUD showALAlertBannerWithView:self.view Style:SALAlertBannerStyleWarning  Position:SALAlertBannerPositionTop Subtitle:errorMes ];
    }];
}
#pragma mark - UIResponder actions
-(void)routerEventWithType:(EventChatCellType)eventType userInfo:(NSDictionary *)userInfo
{
    LWChatModel *model = [userInfo objectForKey:kModelKey];
    
    switch (eventType)
    {
        case EventChatCellTypeSendMsgEvent:
            
//            [self.view endEditing:YES];
            [self SendMessage:userInfo];
            
            break;
        case EventChatCellRemoveEvent:
            
//            [self RemoveModel:model];
            
            break;
        case EventChatCellImageTapedEvent:
            NSLog(@"点击了图片了。。");
            [self showImage:[userInfo objectForKey:@"self"]];
            break;
        case EventChatCellHeadTapedEvent:
            NSLog(@"头像被点击了。。。");
            break;
        case EventChatCellHeadLongPressEvent:
            NSLog(@"头像被长按了。。。。");
            break;
        case EventChatCellTypeVoicePlayEvent:
            NSLog(@"播放。。。。");
            [[LWVoiceManager shareInstance] playVoiceWithModel:model withCell:[userInfo objectForKey:@"self"]];
            break;
        case EventChatCellTypeSenderBiaoDan:
            
            [self senderJsAliYunType:21 WithDic:nil withContent:nil withVocMain:0];

            break;
        case EventChatCellTypeSenderGoods:
        {
            KLGoodsDetailedViewController *vc = [[KLGoodsDetailedViewController alloc] initWithGoodsId:model.productId theFootButtonHidden:YES];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
    
}


-(void)SendMessage:(NSDictionary*)userInfo
{
    
    WSChatCellType type = [userInfo[@"type"]integerValue];
    NSString *content = nil;
    switch (type)
    {
        case WSChatCellType_Text:
        {
            content = userInfo[@"text"];
        }
            break;
        case WSChatCellType_Image:
        {
        }
            break;
        case WSChatCellType_Audio:
        {
        }
            break;
        default:
            break;
    }
    
    [self senderJsAliYunType:1 WithDic:nil withContent:content withVocMain:0];
    
}


/**
 *  @brief  删除模型
 *
 *  @param model 模型
 */
-(void)RemoveModel:(LWChatRows *)model
{
//    NSIndexPath *index = [NSIndexPath indexPathForRow:[self.DataSource indexOfObject:model] inSection:0];
//    
//    NSMutableArray *indexs = @[index].mutableCopy;
//    
//    NSMutableIndexSet *indexSets = [NSMutableIndexSet indexSetWithIndex:index.row];
//    
//    
//    if ((index.row > 0) && ((WSChatModel*)(self.DataSource[index.row-1])).chatCellType == WSChatCellType_Time)
//    {
//        if((index.row == self.DataSource.count-1) || (((WSChatModel*)(self.DataSource[index.row+1])).chatCellType == WSChatCellType_Time))
//        {//删除上一个
//            
//            [indexSets addIndex:index.row-1];
//            [indexs addObject:[NSIndexPath indexPathForRow:index.row-1 inSection:0]];
//        }
//    }
//    
//    [self.DataSource removeObjectsAtIndexes:indexSets];
//    
//    [self.tableView beginUpdates];
//    [self.tableView deleteRowsAtIndexPaths:indexs withRowAnimation:UITableViewRowAnimationFade];
//    [self.tableView endUpdates];
    
}


#pragma mark - Getter Method
- (LWChatViewControllerDataSource *)chatViewControllerDataSource
{
    if (!_chatViewControllerDataSource) {
        _chatViewControllerDataSource = [[LWChatViewControllerDataSource alloc] init];
        _chatViewControllerDataSource.delegate = self;
        _chatViewControllerDataSource.dataSource = self.DataSource;
        _chatViewControllerDataSource.vc = self;
    }
    return _chatViewControllerDataSource;
}

-(LWChatMessageInputBar *)inputBar
{
    if (_inputBar) {
        return _inputBar;
    }
    
    _inputBar = [[LWChatMessageInputBar alloc]init];
    _inputBar.delegate = self;
    _inputBar.translatesAutoresizingMaskIntoConstraints = NO;
    
    return _inputBar;
}

-(UITableView *)tableView
{
    if (_tableView) {
        return _tableView;
    }
    
    _tableView                      =   [UITableView newAutoLayoutView];
    _tableView.separatorStyle       =   UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor      =   RGBA(245, 245, 245, 1);
    _tableView.keyboardDismissMode  =   UIScrollViewKeyboardDismissModeOnDrag;
    
    [_tableView registerClass:[UUMessageCell class] forCellReuseIdentifier:@"UUMessageCell"];
    
    return _tableView;
}

- (NSMutableArray *)DataSource
{
    if (!_DataSource) {
        _DataSource = [NSMutableArray array];
    }
    return _DataSource;
}

- (void)backLoadMessage{

    if (self.DataSource.count > 0) {
        UUMessageFrame *modelFram = self.DataSource.lastObject;
        LWChatModel *model = modelFram.model;
        NSString *message ;
        if (model.chatCellType == WSChatCellType_Audio) {
            message = @"[语音]";
        }else if (model.chatCellType == WSChatCellType_Image)
        {
            message = @"[图片]";
        }else if (model.chatCellType == WSChatCellType_Card)
        {
            message = model.doctorText;
        }else if (model.chatCellType == WSChatCellType_Text)
        {
            message = model.content;
        }else if (model.chatCellType == WSChatCellType_Goods)
        {
            message = @"[商品]";
        }
        else
        {
            message = model.msgContent;
        }
        _backBlock?_backBlock(model.insertDt,message):nil;
    }else
    {
        _backBlock?_backBlock(nil,nil):nil;
        
    }
}
#pragma mark - nav
- (void)navLeftButtonAction
{
    [self backLoadMessage];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)navRightButtonAction
{
    KLPatientListModel *pat = [self listPatient];
    WEAKSELF
    if (!pat) {
        [LWHttpRequestManager httpPatientListWithPage:1 size:100000 refreshDate:nil success:^(NSMutableArray *list) {
            [KL_weakSelf pushPatientCententCtr:[KL_weakSelf listPatient]];
        } failure:^(NSString *errorMes) {
            [LWProgressHUD showALAlertBannerWithView:KL_weakSelf.view Style:SALAlertBannerStyleWarning  Position:SALAlertBannerPositionTop Subtitle:errorMes ];
        }];
    }else{
        [self pushPatientCententCtr:pat];
    }
}

- (KLPatientListModel *)listPatient
{
    KLPatientListModel *model = [[LKDBHelper getUsingLKDBHelper] searchSingle:[KLPatientListModel class] where:[NSString stringWithFormat:@"patientId = %@",self.patient.memberId] orderBy:nil];
    
    return model;
}
- (void)pushPatientCententCtr:(KLPatientListModel *)row
{
    LWPatientCententCtr *patientCentent = (LWPatientCententCtr *)[UIViewController CreateControllerWithTag:CtrlTag_PatientCenter];
    patientCentent.patient = row;
    [self.navigationController pushViewController:patientCentent animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - void

- (void)addSenderModel:(LWSenderResBaseModel *)model
{
    LWChatModel *chatModel = [[LWChatModel alloc] init];
    chatModel.joinId = model.joinId;
    chatModel.insertDt = model.body.insertDt;
    chatModel.isCount = model.body.isCount;
    chatModel.msgType = model.body.msgType;

    chatModel.msgContent = model.body.doctorMsg;
    chatModel.patientName = model.body.patientName;
    chatModel.isDispose = model.body.isDispose;
    chatModel.modifyDt = model.body.modifyDt;
    chatModel.isValid = model.body.isValid;
    chatModel.doctorId = model.body.doctorId;
    chatModel.sid = model.body.sid;
    chatModel.ownerType = model.body.ownerType;
    chatModel.memberId = model.body.memberId;
    chatModel.headImgUrl = model.body.headImageUrl;;
    chatModel.remark = model.body.remark;
    chatModel.foreignId = model.body.foreignId;
    chatModel.currentPage = 1;
    
    NSDictionary *obj = [model.body.dataStr objectFromJSONString];
    NSInteger  cType = [obj[@"contentType"] integerValue];
    NSString *cont = obj[@"content"];
    NSString *voiceMin = obj[@"voiceMin"];
    chatModel.voiceMin = [voiceMin doubleValue];
    
    chatModel.contentType = cType;
    chatModel.content = cont;
    chatModel.chatMessageType = model.body.msgType;
    
    if (model.body.ownerType == 1) {
        chatModel.ownerType = NO;
    }else
    {
        chatModel.ownerType = YES;
    }
    
    if (chatModel.contentType == 1) { //文本
        chatModel.chatCellType = WSChatCellType_Text;
    }else if (chatModel.contentType == 2)//图片
    {
        chatModel.chatCellType = WSChatCellType_Image;
    }else if (chatModel.contentType == 21)
    {
        chatModel.chatCellType = WSChatCellType_Card;
    }
    else//语音
    {
        chatModel.chatCellType = WSChatCellType_Audio;
    }

    UUMessageFrame *modelfram = [[UUMessageFrame alloc] init];
    modelfram.model = chatModel;
    [LWChatBaseModel minuteOffSetStart:modelfram end:[self.DataSource lastObject]];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.DataSource.count inSection:0];
    [self.DataSource addObject:modelfram];
    
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
    
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        
    [[LKDBHelper getUsingLKDBHelper] insertToDB:chatModel];

}

- (void)senderJsAliYunType:(NSInteger)type WithDic:(NSDictionary *)dic withContent:(NSString *)cont withVocMain:(NSInteger )count
{
    NSInteger vocMain = count;
    NSString *content;
    
    if (type == 1) { //文字
        content = cont;
    }else if (type == 21)
    {
        
    }
    else
    {
        content = [LWUpLoadingManager getUploadSuccessString:dic];
    }
    WEAKSELF
    [LWHttpRequestManager httpDoctorReply:self.patient.memberId content:content contentType:type voiceMin:vocMain foreignId:nil success:^(LWSenderResBaseModel *senderResBaseModel) {
  
        [KL_weakSelf addSenderModel:senderResBaseModel];
    } failure:^(NSString *errorMes) {
        [LWProgressHUD showALAlertBannerWithView:KL_weakSelf.view Style:SALAlertBannerStyleWarning  Position:SALAlertBannerPositionTop Subtitle:errorMes ];
    }];
    
}
- (void)httpUpLoadData:(NSData *)data withType:(NSInteger)type withVocMain:(NSInteger )count
{
    [LWHttpRequestManager httpUpLoadData:data WithType:type success:^(NSDictionary *dic) {
    } failure:^(NSString *errorMes) {
        [LWProgressHUD showALAlertBannerWithView:nil Style:SALAlertBannerStyleWarning  Position:SALAlertBannerPositionTop Subtitle:errorMes ];
    }];

}

#pragma mark -LWChatMessageInputBarDelegate

- (void)uploadData:(NSData *)data
           theType:(NSInteger)type
             count:(NSInteger)count{
WEAKSELF
    [LWUpLoadingManager httpUpLoadData:data withType:type withVocMain:count success:^(NSDictionary *dic) {
        [KL_weakSelf senderJsAliYunType:type WithDic:dic withContent:nil withVocMain:count];

    } failure:nil];
}
- (void)voicEndRecord:(NSData *)voiceData count:(NSInteger)cout
{
    [self uploadData:voiceData theType:3 count:cout];
}
- (void)moreButtonEventClick:(NSInteger)tag
{
    WEAKSELF
    switch (tag) {
        case 0: //照片
        {
            [[KLImagePickerManager shareInstance] photoLibraryTheNav:self.navigationController succBlock:^(NSData *imageData) {
                
                [KL_weakSelf uploadData:imageData theType:2 count:0];
            }];
        }
            break;
        case 1://相机
        {
            [[KLImagePickerManager shareInstance] cameraTheNav:self.navigationController succBlock:^(NSData *imageData) {
                
                [KL_weakSelf uploadData:imageData theType:2 count:0];
            }];
        }
            break;
        case 2://快捷回复
        {
            
            FastReplyVC *vc = (FastReplyVC *)[UIViewController CreateControllerWithTag:CtrlTag_FastReply];
            [vc setChooseFastRepBlock:^(NSString *content) {
                
                [KL_weakSelf.inputBar fastReplyContent:content];
            }];
            [self.navigationController pushViewController:vc animated:YES];
            
            [MobClick event:@"FastReply" label:@"快捷回复按钮的点击量"];
            
        }
            break;
        case 3://biaodan
        {
            
            LWTheFormTypeViewController *vc = (LWTheFormTypeViewController *)[UIViewController CreateControllerWithTag:CtrlTag_TheFormType];
            vc.patientId = self.patient.memberId;
            vc.showType = showTheFormTypeMouKuai;
            [self.navigationController pushViewController:vc animated:YES];

            [MobClick event:@"TheForm" label:@"表单按钮的点击量"];
        }
            break;
        case 4:
        {
            KLGoodsViewController *vc = [KLGoodsViewController new];
            [self.navigationController pushViewController:vc animated:YES];
            
            WEAKSELF
            /**
             *  发送商品给患者
             */
            [[vc rac_signalForSelector:@selector(senderGoods:theSenderVc:)] subscribeNext:^(id x) {
                RACTuple *Tuple = x;
                NSLog(@"%@",Tuple.first);

                UIViewController *senderVc = Tuple.second;
                
                [[KLIndicatorViewManager standardIndicatorViewManager] showLoadingWithContent:@"正在发送" theView:senderVc.view];
                [LWHttpRequestManager httpDoctorReply:KL_weakSelf.patient.memberId content:@"" contentType:13 voiceMin:0 foreignId:Tuple.first success:^(LWSenderResBaseModel *senderResBaseModel) {
                    
                    [[KLIndicatorViewManager standardIndicatorViewManager] showErrorWith:@"发送成功" theView:senderVc.view theImage:nil showSucc:^{
                        
                        [MobClick event:@"goodssender" label:@"商品发送"];
                        [weakSelf appNotificationss:nil];
                        [weakSelf.navigationController popToViewController:weakSelf animated:YES];
                    }];
                } failure:^(NSString *errorMes) {
                    
                    [[KLPromptViewManager shareInstance] kl_showPromptViewWithTitle:@"温馨提示" theContent:errorMes];
                }];

            }];
            
        }
            break;
        default:
            break;
    }
}

#pragma mark - Private methods

- (void)showImage :(UUMessageCell *)cell{

    MJPhotoBrowser *photoBrowser = [[MJPhotoBrowser alloc] init];
    MJPhoto *photo = [[MJPhoto alloc] init];
    photo.image = cell.btnContent.backImageView.image;
    photoBrowser.photos = @[photo];
    [photoBrowser show];
}
#pragma mark - LWChatViewControllerDataSourceDelegate
- (void)didSelectRowAtIndexPath:(LWChatModel *)model
{
    [self.inputBar removeFromMoreView];
    
    switch (model.chatMessageType) {
        case WSChatMessageType_ACAassessment: //完成ACT评估
        {
            LWACTAssessmentViewController *vc = (LWACTAssessmentViewController *)[UIViewController CreateControllerWithTag:CtrlTag_ACTAssessment];
            vc.bayId = model.foreignId;
            vc.patientName = self.patient.patientName;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case WSChatMessageType_AsthmaAassessment: //完成哮喘评估
        {
            LWAsthmaAssessmentViewController *vc = (LWAsthmaAssessmentViewController *)[UIViewController CreateControllerWithTag:CtrlTag_AsthmaAssessment];
            vc.searchLoadId = model.foreignId;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case WSChatMessageType_PEFRecord: //PEF记录通知
        {
            LWHistoricalRecordVC *patientLog = (LWHistoricalRecordVC *)[UIViewController CreateControllerWithTag:CtrlTag_PatientLog];
            patientLog.pid = self.patient.memberId;
            [self.navigationController pushViewController:patientLog animated:YES];
        }
            break;
        case WSChatMessageType_BiaoDan: //表单
        {
            LWTheFormViewController *vc = (LWTheFormViewController *)[UIViewController CreateControllerWithTag:CtrlTag_TheForm];
            vc.foreignId = model.foreignId;
            vc.showType = model.isDispose == 0?showTheFormTypeMouKuaiNoSucc:showTheFormTypeMouKuaiSucc;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case WSChatMessageType_conventionDan:
        {
            LWReservationDetailedViewController *vc = (LWReservationDetailedViewController *)[UIViewController CreateControllerWithTag:CtrlTag_ReservationDetailed];
            vc.requestId = model.foreignId;
            vc.isDispose = model.isDispose;
            [self.navigationController pushViewController:vc animated:YES];
        
        }
            break;
        case WSChatMessageType_goods:
        {
            KLGoodsDetailedViewController *vc = [[KLGoodsDetailedViewController alloc] initWithGoodsId:model.productId theFootButtonHidden:YES];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}

@end
