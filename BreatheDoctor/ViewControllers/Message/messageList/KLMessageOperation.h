//
//  KLMessageOperation.h
//  BreatheDoctor
//
//  Created by comv on 16/4/6.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <Foundation/Foundation.h>
#define NEWTYPE 110
@class KLMessgaeDataSource;

@interface KLMessageOperation : NSObject

@property (nonatomic, strong) UILabel *badgeLabel;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) KLMessgaeDataSource *source;
@property (nonatomic, strong) UIViewController   *showVc;

+ (KLMessageOperation *)shareInstance;
/**
 *  退出登录的时候需要清除
 */
- (void)removeMessageRequest;
/**
 *  注册通知
 */
- (void)registHomeMessgaeNotificationCenter;
/**
 *  加载缓存消息
 */
- (void)loadCacheMesg;
/**
 *  刷新新消息
 *
 */
- (void)refreshHomeMsg;


+ (NSMutableArray *)sqlCacheMessages;

/**
 *  改变角标数量
 *
 *  @param barItem
 *  @param array 消息数组
 */
- (void)changeBadgeValueTheMessgaeArray:(NSMutableArray *)array;



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
