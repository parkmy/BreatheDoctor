//
//  LWChatCardCell.h
//  BreatheDoctor
//
//  Created by comv on 15/11/16.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWChatModel.h"

#define kCardCellReusedID    (@"Card")

@interface LWChatCardCell : UITableViewCell

@property (nonatomic, strong) UIView *mBubbleView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextView *contentTexView;
/**
 *  @brief  聊天消息中单条消息模型
 */
@property(nonatomic,strong) LWChatModel *model;

@end
