//
//  KLBaseTableViewController.h
//  BreatheDoctor
//
//  Created by liaowh on 16/6/3.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "BaseViewController.h"

@interface KLBaseTableViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

- (void)setupWithTableStyle:(UITableViewStyle)style;
- (void)registerTbaleViewCell;

- (NSInteger)KL_numberOfSectionsInTableView:(UITableView *)tableView;

- (NSInteger)KL_tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

- (UITableViewCell *)KL_tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)KL_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (CGFloat)KL_tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

- (CGFloat)KL_tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;

- (CGFloat)KL_tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;

- (UIView *)KL_tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;

@end
