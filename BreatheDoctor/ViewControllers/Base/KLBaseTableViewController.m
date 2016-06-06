//
//  KLBaseTableViewController.m
//  BreatheDoctor
//
//  Created by liaowh on 16/6/3.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLBaseTableViewController.h"

@interface KLBaseTableViewController ()

@end

@implementation KLBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupWithTableStyle:UITableViewStylePlain];
    [self registerTbaleViewCell];
}

- (void)setupWithTableStyle:(UITableViewStyle)style{

    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:style];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    [self.view addSubview:_tableView];
    
    _tableView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(64, 0, 0, 0));
    
    setExtraCellLineHidden(_tableView);

    
}

- (void)registerTbaleViewCell{};

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if ([self respondsToSelector:@selector(KL_numberOfSectionsInTableView:)]) {
        
        return [self KL_numberOfSectionsInTableView:tableView];
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self KL_tableView:tableView numberOfRowsInSection:section];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [self KL_tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self respondsToSelector:@selector(KL_tableView:heightForHeaderInSection:)]) {
        
        return [self KL_tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if ([self respondsToSelector:@selector(KL_tableView:heightForRowAtIndexPath:)]) {
        
        return [self KL_tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    return self.tableView.rowHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if ([self respondsToSelector:@selector(KL_tableView:heightForHeaderInSection:)]) {
        
        return [self KL_tableView:tableView heightForFooterInSection:section];
    }
    return .1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if ([self respondsToSelector:@selector(KL_tableView:heightForHeaderInSection:)]) {
        
        return [self KL_tableView:tableView heightForHeaderInSection:section];
    }
    return .1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if ([self respondsToSelector:@selector(KL_tableView:viewForHeaderInSection:)]) {
        
        return [self KL_tableView:tableView viewForHeaderInSection:section];
    }
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
