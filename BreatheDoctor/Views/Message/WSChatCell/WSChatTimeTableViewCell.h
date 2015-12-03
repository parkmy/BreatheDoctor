//
//  WSChatTimeTableViewCell.h
//  QQ
//
//  Created by weida on 15/8/16.
//  Copyright (c) 2015年 weida. All rights reserved.


#import <UIKit/UIKit.h>


#define kTimeCellReusedID    (@"time")


@interface WSChatTimeTableViewCell : UITableViewCell
/**
 *  @brief  聊天消息中单条消息模型
 */
@property(nonatomic,strong) LWChatRows *model;

@end
