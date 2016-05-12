//
//  LWChatMessageInputBar.h
//  BreatheDoctor
//
//  Created by comv on 15/11/14.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LWChatMessageInputBarDelegate <NSObject>
@optional
- (void)voicEndRecord:(NSData *)voiceData count:(NSInteger)cout;
- (void)moreButtonEventClick:(NSInteger)tag;
@end

/**
 *  @brief  聊天界面底部输入界面
 */
@interface LWChatMessageInputBar : UIView
/**
 *  @brief  输入TextView
 */
@property(nonatomic,strong)UITextView *mInputTextView;

@property (nonatomic, strong) UITableView *baseTbaleView;
@property (nonatomic, weak) id<LWChatMessageInputBarDelegate>delegate;
- (void)fastReplyContent:(NSString *)content;
- (void)removeFromMoreView;
@end
