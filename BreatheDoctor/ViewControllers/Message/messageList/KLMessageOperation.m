//
//  KLMessageOperation.m
//  BreatheDoctor
//
//  Created by comv on 16/4/6.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLMessageOperation.h"
#import "NSDate+Extension.h"
#import "KLMessgaeDataSource.h"
#import "KLIndicatorViewManager.h"

@interface KLMessageOperation ()
@property (nonatomic, strong)   LWMainMessageBaseModel *mainMessageModel;
@property (nonatomic, copy)  NSString *refreshTime;

@property (nonatomic, strong) NSMutableArray *msgArray;

@end

@implementation KLMessageOperation

+ (KLMessageOperation *)shareInstance{
    
    static dispatch_once_t onceToken;
    static KLMessageOperation *_op;
    dispatch_once(&onceToken, ^{
        _op = [KLMessageOperation new];
    });
    return _op;
}
- (void)removeMessageRequest{

    [self.msgArray removeAllObjects];
    self.mainMessageModel = nil;
    self.refreshTime = nil;
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (NSMutableArray *)msgArray{
    
    if (!_msgArray) {
        _msgArray = [NSMutableArray array];
    }
    return _msgArray;
}
- (void)registHomeMessgaeNotificationCenter{

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newMessage:) name:APP_PUSH_TYPE_NEWMESSAGE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(newMessage:)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];
}
/**
 *  新消息通知
 */
- (void)newMessage:(NSNotificationCenter *)sender{
    
    [self refreshHomeMsg];
}
#pragma mark - 获取缓存数据
- (void)loadCacheMesg
{
    [self.msgArray removeAllObjects];
    [self.msgArray addObjectsFromArray:[KLMessageOperation sqlCacheMessages]];
    
    if (self.source) {
        
        [self.source.messageArray removeAllObjects];
        [self.source.messageArray addObjectsFromArray:self.msgArray];
    }

    if (self.msgArray.count <= 0) {
        
        if (self.showVc) {
            [self.showVc showErrorMessage:@"暂时没有新消息~" isShowButton:YES type:showErrorTypeMore];
        }
        [self refreshHomeMsg];
        
    }else{
        if (self.showVc && self.tableView) {
            
            [self.showVc hiddenNonetWork];
            [self.tableView reloadData];
        }
        [self changeBadgeValueTheMessgaeArray:self.msgArray];
    }
}

#pragma mark - 获取刷新数据

- (void)refreshHomeMsg
{
    
    self.refreshTime = nil;
    if (self.mainMessageModel)//内存对象
    {
        self.refreshTime = self.mainMessageModel.body.refreshDate;
    }else
    {
        LWMainRows *model = [self.msgArray firstObject];
        if (model) {//内存数组
            self.refreshTime = model.refreshTime;;
        }
    }
    WEAKSELF
    [LWHttpRequestManager httpMaiMesggaeWithPage:1 size:100000 refreshDate:self.refreshTime  success:^(LWMainMessageBaseModel *mainMessageBaseModel) {
        
        KL_weakSelf.mainMessageModel = mainMessageBaseModel;
        
        if (KL_weakSelf.mainMessageModel.body.rows.count <= 0) {
            
            [KL_weakSelf changeBadgeValueTheMessgaeArray:KL_weakSelf.msgArray];
            return ;
        }
        if (KL_weakSelf.showVc) {
            [KL_weakSelf.showVc hiddenNonetWork];
        }
        
        if (KL_weakSelf.source) {
            
            [KLMessageOperation reloadTableViewInfoObjcs:KL_weakSelf.mainMessageModel.body.rows theMessageArray:KL_weakSelf.source.messageArray theTableView:KL_weakSelf.tableView];
            [KL_weakSelf.msgArray removeAllObjects];
            [KL_weakSelf.msgArray addObjectsFromArray:KL_weakSelf.source.messageArray];

        }else{
            [KLMessageOperation reloadTableViewInfoObjcs:KL_weakSelf.mainMessageModel.body.rows theMessageArray:KL_weakSelf.msgArray theTableView:KL_weakSelf.tableView];
        }

        [KL_weakSelf changeBadgeValueTheMessgaeArray:KL_weakSelf.msgArray];
        
        [[KLIndicatorViewManager standardIndicatorViewManager] hiddenIndicatorView];
    } failure:^(NSString *errorMes) {
        
        [KL_weakSelf changeBadgeValueTheMessgaeArray:KL_weakSelf.msgArray];
        [[KLIndicatorViewManager standardIndicatorViewManager] hiddenIndicatorView];
    }];
}
/**
 *  得到新朋友对象
 *
 *  @param array 消息数组
 *
 *  @return 返回对象
 */
+ (LWMainRows *)requestModelInfoMessageArray:(NSMutableArray *)array{
    
    LWMainRows *requestModel = nil;
    
    for (LWMainRows *row in array) //遍历得到请求消息和对话消息以及新朋友
    {
        if (row.msgType == NEWTYPE) //新朋友
        {
            requestModel = row;
        }
    }
    
    return requestModel;
}
/**
 *  刷新新消息
 *
 *  @param newarray     新消息数组
 *  @param requestModel 请求对象
 *
 *  @return 返回新消息数组
 */
+ (NSMutableArray *)nowMessageDataInfo:(NSMutableArray *)newarray
                    andOldRequestModel:(LWMainRows *)requestModel{
    
    NSMutableArray *requestArray = [NSMutableArray array];
    NSMutableArray *cacheMessageArray = [NSMutableArray array];
    
    NSString *wheres = [NSString stringWithFormat:@"memberId = %@",@"requestmessage"];
    
    //    LWMainRows *requestModel = [[self class] requestModelInfoMessageArray:oldmessageArray];
    
    for (LWMainRows *row in newarray) //遍历得到请求消息和对话消息以及新朋友
    {
        if (row.msgType == 2)
        { //请求消息
            if (row.isDispose == 0)
            { //拒绝的患者不添加
                [requestArray addObject:row];
            }
        }else//对话消息
        {
            [cacheMessageArray addObject:row];
        }
    }
    
    if(requestModel){
        for (LWMainRows *model in requestModel.requestArray) {
            
            for (LWMainRows *nowModel in requestArray) {
                if (![nowModel.memberId isEqualToString:model.memberId]){
                    [requestArray addObject:model];
                }
            }
            
        }
    }
    
    [[self class] dealRequestMessageInfo:requestArray theRequestModel:requestModel theSQLwheres:wheres theCacheMessageArray:cacheMessageArray];
    
    return cacheMessageArray;
}


/**
 *  得到缓存数据
 *
 *  @param array 数据库数据
 *
 *  @return 缓存数据
 */
+ (NSMutableArray *)getMessageArrayInfoCacheMessage:(NSMutableArray *)array{
    
    NSMutableArray *requestArray = [NSMutableArray array];
    
    NSMutableArray *cacheMessageArray = [NSMutableArray array];
    
    NSString *wheres = [NSString stringWithFormat:@"memberId = %@",@"requestmessage"];
    
    
    LWMainRows *requestModel = nil;
    
    for (LWMainRows *row in array) //遍历得到请求消息和对话消息以及新朋友
    {
        if (row.msgType == 2)
        { //请求消息
            if (row.isDispose == 0)
            { //拒绝的患者不添加
                [requestArray addObject:row];
            }
        }else if (row.msgType == NEWTYPE) //新朋友
        {
            requestModel = row;
            [cacheMessageArray addObject:row];
        }
        else//对话消息
        {
            [cacheMessageArray addObject:row];
        }
    }
    
    [[self class] dealRequestMessageInfo:requestArray theRequestModel:requestModel theSQLwheres:wheres theCacheMessageArray:cacheMessageArray];
    
    return cacheMessageArray;
}
/**
 *  数据库数据
 *
 *  @return 数据
 */
+ (NSMutableArray *)sqlCacheMessages{
    
    NSMutableArray *array = [[LKDBHelper getUsingLKDBHelper] search:[LWMainRows class] where:nil orderBy:@"insertDt DESC" offset:0 count:100000];
    
    return [[self class] getMessageArrayInfoCacheMessage:array];
}
+ (void)dealRequestMessageInfo:(NSMutableArray *)requestArray
               theRequestModel:(LWMainRows *)requestModel
                  theSQLwheres:(NSString *)wheres
          theCacheMessageArray:(NSMutableArray *)cacheMessageArray{
    
    if (requestArray.count > 0) { //当请求消息
        
        if (requestModel) {//如果有新朋友对象直接修改
            requestModel.insertDt = [(LWMainRows *)[requestArray firstObject] insertDt];
            requestModel.count = requestArray.count;;
            requestModel.requestArray = requestArray;
        }else//没有救进行插入
        {
            LWMainRows *model = [[LWMainRows alloc] init];
            model.insertDt = [(LWMainRows *)[requestArray firstObject] insertDt];
            model.msgContent = @"您有新的患者申请";
            model.patientName = @"新朋友";
            model.count = requestArray.count;
            model.memberId = @"requestmessage";
            model.msgType = NEWTYPE;
            model.requestArray = requestArray;
            [cacheMessageArray addObject:model];
            
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
            [[LKDBHelper getUsingLKDBHelper] deleteToDB:requestModel];
            //            [[LKDBHelper getUsingLKDBHelper] deleteWithClass:[LWMainRows class] where:wheres];
            [cacheMessageArray removeObject:requestModel];
        }
    }
    
    [cacheMessageArray sortUsingComparator:^NSComparisonResult(LWMainRows * obj1, LWMainRows * obj2) { //时间排序
        NSDate *time1 = [NSDate dateWithString:obj1.insertDt format:[NSDate ymdHmsFormat]];
        NSDate *time2 = [NSDate dateWithString:obj2.insertDt format:[NSDate ymdHmsFormat]];
        NSComparisonResult result = [time2 compare:time1];
        return result;
    }];
    
    
}
- (void)changeBadgeValueTheMessgaeArray:(NSMutableArray *)array{
    
    NSInteger value = 0;
    
    for (LWMainRows *model in array) {
        value += model.count;
    }
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = value;
    
    self.badgeLabel.text = @"";
    self.badgeLabel.hidden = false;
    
    if (value <= 0)
    {
        self.badgeLabel.text = @"";
        self.badgeLabel.hidden = YES;
    }
    else if (value > 99)
    {
        self.badgeLabel.text = @"99+";
    }
    else
    {
        self.badgeLabel.text = [NSString stringWithFormat:@"%@",kNSNumInteger(value)];
    }
}
/**
 *  刷新数据
 *
 *  @param array        新数据
 *  @param messageArray 老数据
 *  @param tableView    表
 */
+ (void)reloadTableViewInfoObjcs:(NSArray *)array
                 theMessageArray:(NSMutableArray *)messageArray
                    theTableView:(UITableView *)tableView{
    
    //    NSMutableArray *indexPaths = [NSMutableArray array];
    NSMutableArray *newArray = [NSMutableArray array];
    
    /**
     *  请求模型
     */
    LWMainRows *requestModel = [[self class] requestModelInfoMessageArray:messageArray];
    
    /**
     *  遍历要刷新的数据得到刷新的indexs
     */
    for (LWMainRows *objc in array)
    {
        LWMainRows *oldObjc = nil;
        
        for (int j = 0; j < messageArray.count; j++)
        {
            LWMainRows *searchObjc = messageArray[j];
            if ([searchObjc.memberId isEqualToString:objc.memberId])
            {
                oldObjc = searchObjc;
                /**
                 *  消息相同第一条 直接替换更新
                 */
                if (j == 0) {
                    [messageArray replaceObjectAtIndex:j withObject:objc];
                    if (tableView) {
                        [tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:j inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                    }
                    continue;
                }
                /**
                 *  不是第一条跟第一条对比
                 */
                LWMainRows *oneObjc = messageArray[0];
                
                NSDate *date1 = [NSDate dateWithString:objc.insertDt format:[NSDate ymdHmsFormat]];
                NSDate *date2 = [NSDate dateWithString:oneObjc.insertDt format:[NSDate ymdHmsFormat]];
                /**
                 *  比第一条
                 */
                if ([date1 compare:date2] == NSOrderedAscending){
                    if (tableView) {
                        [tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:j inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                    }
                }else{
                    
                    [messageArray removeObjectAtIndex:j];
                    if (tableView) {
                        [tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:j inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                    }
                    [messageArray insertObject:objc atIndex:0];
                    if (tableView) {
                        [tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                    }
                }
                continue;
            }
        }
        if (!oldObjc) {
            [newArray addObject:objc];
        }
    }
    /**
     *  有刷新刷新
     */
    //    if (indexPaths.count > 0) {
    //        [tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
    //    }
    /**
     *  是否有新数据
     */
    newArray = [[self class] nowMessageDataInfo:newArray andOldRequestModel:requestModel];
    /**
     *  老数据没数据 新数据有直接刷新 否则按条数插入
     */
    if (messageArray.count <= 0) {
        [messageArray addObjectsFromArray:newArray];
        if (tableView) {
            [tableView reloadData];
        }
    }else{
        for (int j = 0; j < newArray.count; j++) {
            
            LWMainRows *objc = newArray[j];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:j inSection:0];
            /**
             *  请求的新朋友判断是插入还是刷新 其余插入
             */
            if (objc.msgType == NEWTYPE) {
                if (requestModel) {
                    if (tableView) {
                        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                    }
                }else{
                    [messageArray insertObject:objc atIndex:j];
                    if (tableView) {
                        
                        [tableView beginUpdates];
                        [tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                        [tableView endUpdates];
                    }
                }
            }else{
                [messageArray insertObject:objc atIndex:j];
                if (tableView) {
                    [tableView beginUpdates];
                    [tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                    [tableView endUpdates];
                }
            }
        }
    }
}
//+ (void)insertObjectData:(id)objc
//            theTableView:(UITableView *)table
//           theIndexPaths:(NSArray *)array{
//
//
//
//}


@end
