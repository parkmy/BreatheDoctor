//
//  KLChatMessageInputBar.h
//  BreatheDoctor
//
//  Created by comv on 16/4/26.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#define defHeight (98/2)
@class KLChatMessageMoreView;

@interface KLChatMessageInputBar : UIView
@property (nonatomic, strong)   KLChatMessageMoreView  *mMoreView;
- (void)kl_fastReplyContent:(NSString *)content;
- (void)kl_voiceSenderWithVoiceData:(NSData *)data theVoiceCount:(NSInteger)count;
- (void)kl_textSenderWithText:(NSString *)text;
- (void)starRecord;
- (void)endRecord;
@end
