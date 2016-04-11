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

+ (NSMutableArray *)sqlCacheMessagesInfoRequestArray:(NSMutableArray *)requestArray{

    NSString *wheres = [NSString stringWithFormat:@"memberId = %@",@"requestmessage"];
    
    NSMutableArray *array = [[LKDBHelper getUsingLKDBHelper] search:[LWMainRows class] where:nil orderBy:@"insertDt DESC" offset:0 count:100000];
    
    [requestArray removeAllObjects];
    NSMutableArray *cacheMessageArray = [NSMutableArray array];
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
    if (requestArray.count > 0) { //当请求消息
        
        if (requestModel) {//如果有新朋友对象直接修改
            requestModel.insertDt = [(LWMainRows *)[requestArray firstObject] insertDt];
            requestModel.count = requestArray.count;;
        }else//没有救进行插入
        {
            LWMainRows *model = [[LWMainRows alloc] init];
            model.insertDt = [(LWMainRows *)[requestArray firstObject] insertDt];
            model.msgContent = @"您有新的患者申请";
            model.patientName = @"新朋友";
            model.count = requestArray.count;
            model.memberId = @"requestmessage";
            model.msgType = NEWTYPE;
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
            [[LKDBHelper getUsingLKDBHelper] deleteWithClass:[LWMainRows class] where:wheres];
            [cacheMessageArray removeObject:requestModel];
        }
    }
    
    [cacheMessageArray sortUsingComparator:^NSComparisonResult(LWMainRows * obj1, LWMainRows * obj2) { //时间排序
        NSDate *time1 = [NSDate dateWithString:obj1.insertDt format:[NSDate ymdHmsFormat]];
        NSDate *time2 = [NSDate dateWithString:obj2.insertDt format:[NSDate ymdHmsFormat]];
        NSComparisonResult result = [time2 compare:time1];
        return result;
    }];


    return cacheMessageArray;
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

+ (void)refreshHomeMsgSuccess:(void(^)(NSMutableArray *messageArray))successBlock{

    
    

}
@end
