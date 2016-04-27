//
//  LWChatViewControllerDataSource.h
//  BreatheDoctor
//
//  Created by comv on 15/11/16.
//  Copyright © 2015年 lwh. All rights reserved.
// 对话表单代理

#import <Foundation/Foundation.h>
#import "LWChatViewController.h"
@class LWChatModel;

@protocol LWChatViewControllerDataSourceDelegate <NSObject>

@optional
- (void)didSelectRowAtIndexPath:(LWChatModel *)model;

@end


@interface LWChatViewControllerDataSource : NSObject<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, weak) LWChatViewController *vc;
@property (nonatomic, weak)  id<LWChatViewControllerDataSourceDelegate>delegate;
@end
