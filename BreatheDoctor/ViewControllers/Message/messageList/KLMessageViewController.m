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
//@property (nonatomic, strong)   UIView *headerGroupSenderView;
@end

@implementation KLMessageViewController

- (void)dealloc{


}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super addNavBar:@"消息"];
    [super addBackButton:@"nav_btnBack"];

    [self addSubViews];
    
    [KLMessageOperation shareInstance].showVc = self;
    [KLMessageOperation shareInstance].source = self.messageDataSource;
    [KLMessageOperation shareInstance].tableView = self.tableView;
    [[KLMessageOperation shareInstance] loadCacheMesg];
    
    [[KLMessageOperation shareInstance] refreshHomeMsg];

    [self setBlock];
        
    [self httpReachabilityStatusChange];
    
}
- (void)addSubViews{
    
    [self.view addSubview:self.tableView];
    self.tableView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(BARHIGHT, 0, 0, 0));
    setExtraCellLineHidden(self.tableView);
}
- (void)httpReachabilityStatusChange
{
    WEAKSELF
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status <= 0) {
            KL_weakSelf.tableView.tableHeaderView = KL_weakSelf.headerErrorView;
        }else
        {
            [[KLMessageOperation shareInstance] refreshHomeMsg];
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
        [[KLMessageOperation shareInstance] changeBadgeValueTheMessgaeArray:KL_weakSelf.messageDataSource.messageArray];
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
        
        [[KLMessageOperation shareInstance] changeBadgeValueTheMessgaeArray:KL_weakSelf.messageDataSource.messageArray];
        
    }];
    
    [newFirends setAddSuccBlock:^{
        
        [[KLMessageOperation shareInstance] refreshHomeMsg];
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
        
        [[KLMessageOperation shareInstance] changeBadgeValueTheMessgaeArray:KL_weakSelf.messageDataSource.messageArray];
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
//#pragma mark -添加患者
- (void)navLeftButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
