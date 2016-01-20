//
//  LWNewFriendsViewController.h
//  BreatheDoctor
//
//  Created by comv on 16/1/6.
//  Copyright © 2016年 lwh. All rights reserved.
//  新朋友界面

#import "BaseViewController.h"

@interface LWNewFriendsViewController : BaseViewController
@property (nonatomic, copy) NSString *patientId;
@property (nonatomic, strong) NSMutableArray *requsetArray;
@property (nonatomic, copy) void(^backBlock)();
@property (nonatomic, copy) void(^addSuccBlock)();
@end
