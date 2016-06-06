//
//  KLGroupSenderChatCell.h
//  BreatheDoctor
//
//  Created by comv on 16/4/27.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KLGroupSenderChatView;

@interface KLGroupSenderChatCell : UITableViewCell
/**
 *  数据模型
 */
@property (nonatomic, strong) id model;
/**
 *  再发一条
 */
@property (nonatomic, copy) void(^againSenderEventBlock)();
/**
 *  删除一条
 */
@property (nonatomic, copy) void(^removeEventBlock)(id model);
/**
 *  点击商品
 */
@property (nonatomic, copy) void(^tapGoodsBlock)(NSString *goodsId);
/**
 *  点击语音
 */
@property (nonatomic, copy) void(^voiceTapBlock)(id model,id view);
@end
