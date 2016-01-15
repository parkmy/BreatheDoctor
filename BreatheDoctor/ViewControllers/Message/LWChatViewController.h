//
//  LWChatViewController.h
//  BreatheDoctor
//
//  Created by comv on 15/11/14.
//  Copyright © 2015年 lwh. All rights reserved.
// 对话界面

#import "BaseViewController.h"
/**
 *  @brief  聊天窗口
 */
@interface LWChatViewController : BaseViewController

@property (nonatomic, strong) LWMainRows *patient;
@property (nonatomic, copy) void(^backBlock)(NSString *date,NSString *content);

@end
