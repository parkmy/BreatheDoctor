//
//  LWCardView.h
//  UUChatTableView
//
//  Created by comv on 15/12/2.
//  Copyright © 2015年 uyiuyao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+TKGeometry.h"
#import "UIView+SDAutoLayout.h"
@class UUMessageFrame;
@interface LWCardView : UIView

@property (nonatomic, strong) UIView *mBubbleView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextView *contentTexView;

@property (nonatomic, strong) UUMessageFrame *modelFram;
@end
