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

@property (nonatomic, strong) id model;
@property (nonatomic, copy) void(^againSenderEventBlock)();
@property (nonatomic, copy) void(^removeEventBlock)(id model);
@property (nonatomic, copy) void(^tapGoodsBlock)(NSString *goodsId);
@property (nonatomic, copy) void(^voiceTapBlock)(id model,id view);
@end
