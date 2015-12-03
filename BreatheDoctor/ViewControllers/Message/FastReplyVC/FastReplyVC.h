//
//  FastReplyVC.h
//  ComveeDoctor
//
//  Created by JYL on 14-10-10.
//  Copyright (c) 2014年 zhengjw. All rights reserved.
//

#import "BaseViewController.h"

@class QuestionlistVC;

@interface FastReplyVC : BaseViewController<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
    
    UILabel *navLabel;
    UIButton *rightBtn;
    UIButton *m_addBtn;
   
    UIView *m_view;
    NSIndexPath * paths;
    UITableViewCell *currentCell;
    UIAlertView * alerView;
    
    BOOL slide;
    
}

@property (nonatomic, strong) UITableView *m_tableView;
@property (nonatomic, strong) NSMutableArray *msgArray;
@property (nonatomic, strong) QuestionlistVC * body;
@property (nonatomic, assign) BOOL isDelete;

@property (nonatomic, copy) void(^chooseFastRepBlock)(NSString *content);


@end
