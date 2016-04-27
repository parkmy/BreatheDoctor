//
//  KLGoodsViewController.m
//  BreatheDoctor
//
//  Created by comv on 16/4/26.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLGoodsViewController.h"
#import "KLGoodsCell.h"
#import "ALActionSheetView.h"

@interface KLGoodsViewController ()

@end

@implementation KLGoodsViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [super addNavBar:@"商品"];
    [super addBackButton:@"nav_btnBack"];
}
- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self registerCell];
//    [self racEvent];
}

- (void)registerCell{

    [self.tableView registerClass:[KLGoodsCell class] forCellReuseIdentifier:@"KLGoodsCell"];
}
- (void)navLeftButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 90*MULTIPLEVIEW;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    KLGoodsCell *goodsCell = [tableView dequeueReusableCellWithIdentifier:@"KLGoodsCell" forIndexPath:indexPath];
    return goodsCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    ALActionSheetView *view = [[ALActionSheetView alloc] initWithTitle:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@[@"预览此商品",@"发送给患者"] handler:^(ALActionSheetView *actionSheetView, NSInteger buttonIndex) {
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        if (buttonIndex == 0) {
            

        }else if (buttonIndex == 1)
        {

        }
    }];
    [view show];
}
@end
