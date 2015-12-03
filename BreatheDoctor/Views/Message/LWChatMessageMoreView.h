//
//  LWChatMessageMoreView.h
//  BreatheDoctor
//
//  Created by comv on 15/11/14.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol LWChatMessageMoreViewDelegate <NSObject>
@optional
- (void)seleMoreButtonClick:(NSInteger)tag;
@end

/**
 *  @brief  更多、图片、段视频、文件等
 */

@interface LWChatMessageMoreView : UIView
@property (nonatomic, weak) id<LWChatMessageMoreViewDelegate>delegate;
@end
