//
//  KLGroupSenderChatBaseView.h
//  BreatheDoctor
//
//  Created by comv on 16/4/27.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KLGroupSenderContentView;

@interface KLGroupSenderChatView : UIView

@property (nonatomic, strong) UIButton                    *againSenderButton;
@property (nonatomic, strong) KLGroupSenderContentView    *contentView;
@property (nonatomic, strong) id model;

- (void)removeItemClicked:(id)sender;

@end
