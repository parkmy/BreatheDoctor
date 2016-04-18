//
//  KLMessageOperation.m
//  BreatheDoctor
//
//  Created by comv on 16/4/6.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLMessageOperation.h"
#import "NSDate+Extension.h"

@implementation KLMessageOperation
+ (KLMessageOperation *)shareInstance{
    
    static dispatch_once_t onceToken;
    static KLMessageOperation *_op;
    dispatch_once(&onceToken, ^{
        _op = [KLMessageOperation new];
    });
    return _op;
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
+ (void)changeBadgeValueInfo:(UITabBarItem *)barItem
             andMessgaeArray:(NSMutableArray *)array{
    
    NSInteger value = 0;
    
    for (LWMainRows *model in array) {
        value += model.count;
    }
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = value;
    
    if (value <= 0)
    {
        barItem.badgeValue = nil;
    }
    else if (value > 99)
    {
        barItem.badgeValue = @"99+";
    }
    else
    {
        barItem.badgeValue = [NSString stringWithFormat:@"%@",kNSNumInteger(value)];
    }
}

+ (void)reloadTableViewInfoObjcs:(NSArray *)array
                 theMessageArray:(NSMutableArray *)messageArray
                    theTableView:(UITableView *)tableView{
    
    NSMutableArray *indexPaths = [NSMutableArray array];
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
                [messageArray replaceObjectAtIndex:j withObject:objc];
//                searchObjc = objc;
                [indexPaths addObject:[NSIndexPath indexPathForRow:j inSection:0]];
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
    if (indexPaths.count > 0) {
        [tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
    }
    /**
     *  是否有新数据
     */
    newArray = [[self class] nowMessageDataInfo:newArray andOldRequestModel:requestModel];
    /**
     *  老数据没数据 新数据有直接刷新 否则按条数插入
     */
    if (messageArray.count <= 0) {
        [messageArray addObjectsFromArray:newArray];
        [tableView reloadData];
    }else{
        for (int j = 0; j < newArray.count; j++) {
            
            LWMainRows *objc = newArray[j];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:j inSection:0];
            /**
             *  请求的新朋友判断是插入还是刷新 其余插入
             */
            if (objc.msgType == NEWTYPE) {
                if (requestModel) {
                    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                }else{
                    [messageArray insertObject:objc atIndex:j];
                    [tableView beginUpdates];
                    [tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                    [tableView endUpdates];
                }
            }else{
                [messageArray insertObject:objc atIndex:j];
                [tableView beginUpdates];
                [tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                [tableView endUpdates];
                
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
