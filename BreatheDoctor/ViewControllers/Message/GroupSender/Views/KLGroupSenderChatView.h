//
//  KLGroupSenderChatBaseView.h
//  BreatheDoctor
//
//  Created by comv on 16/4/27.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  群发类型
 */
typedef NS_ENUM(NSInteger, GroupSenderChatType) {
    /**
     *  文字
     */
    GroupSenderChatTypeText =  0,
    /**
     *  语音
     */
    GroupSenderChatTypeVoice,
    /**
     *  图片
     */
    GroupSenderChatTypeImage,
    /**
     *  商品
     */
    GroupSenderChatTypeGoods,
};

@interface KLGroupSenderChatView : UIView



@end
