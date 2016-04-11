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

/**
 *  获取缓存数据
 *
 *  @param requestArray 请求消息数组
 *
 *  @return 缓存数据
 */
+ (NSMutableArray *)sqlCacheMessagesInfoRequestArray:(NSMutableArray *)requestArray;

/**
 *  改变角标数量
 *
 *  @param barItem
 *  @param array 消息数组
 */
+ (void)changeBadgeValueInfo:(UITabBarItem *)barItem
             andMessgaeArray:(NSMutableArray *)array;


/**
 *  刷新消息
 *
 *  @param successBlock 返回结果
 */

+ (void)refreshHomeMsgSuccess:(void(^)(NSMutableArray *messageArray))successBlock;


@end
