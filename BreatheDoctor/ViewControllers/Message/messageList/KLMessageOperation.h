//
//  KLMessageOperation.h
//  BreatheDoctor
//
//  Created by comv on 16/4/6.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <Foundation/Foundation.h>
#define NEWTYPE 110

@interface KLMessageOperation : NSObject

+ (KLMessageOperation *)shareInstance;

+ (NSMutableArray *)sqlCacheMessages;

/**
 *  改变角标数量
 *
 *  @param barItem
 *  @param array 消息数组
 */
+ (void)changeBadgeValueInfo:(UITabBarItem *)barItem
             andMessgaeArray:(NSMutableArray *)array;



//
//+ (void)refreshHomeMsgInfo:(UITableView *)tableView
//        theOldMessageArray:(NSMutableArray *)oldArray
//        theNewMessageArray:(NSMutableArray *)newArray;

/**
 *  刷新表
 *
 *  @param array        要刷新的数据
 *  @param messageArray 旧数据
 *  @param tableView    表
 */
+ (void)reloadTableViewInfoObjcs:(NSArray *)array
                 theMessageArray:(NSMutableArray *)messageArray
                    theTableView:(UITableView *)tableView;

@end
