//
//  LWVoiceManager.h
//  BreatheDoctor
//
//  Created by comv on 15/11/16.
//  Copyright © 2015年 lwh. All rights reserved.
//  语音下载播放管理者

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "LWChatModel.h"
#import "UUMessageCell.h"

@interface LWVoiceManager : NSObject

+ (LWVoiceManager *)shareInstance;

- (void)playVoiceWithModel:(LWChatModel *)model withCell:(UUMessageCell *)cell;

- (void)stopVoice;

@end
