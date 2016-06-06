//
//  KLDoctorPatientBindingViewController.m
//  BreatheDoctor
//
//  Created by liaowh on 16/6/6.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLDoctorPatientBindingViewController.h"
#import "KLGuideModel.h"
#import "KLGuideTextCell.h"
#import "KLGuideImageTextCell.h"

@interface KLDoctorPatientBindingViewController ()

@end

@implementation KLDoctorPatientBindingViewController

- (void)setupWithTableStyle:(UITableViewStyle)style{

    [super setupWithTableStyle:UITableViewStyleGrouped];
    
    [super addNavBar:@"呼吸平台操作指南"];
    [super addBackButton:@"nav_btnBack"];
    
    self.dataArray = [KLGuideModel getInitGuideDoctorPatientModels];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = 0;
}
- (void)registerTbaleViewCell{
    
    [self.tableView registerClass:[KLGuideTextCell class] forCellReuseIdentifier:@"KLGuideTextCell"];
    [self.tableView registerClass:[KLGuideImageTextCell class] forCellReuseIdentifier:@"KLGuideImageTextCell"];
}
- (KLGuideModel *)getIndexPath:(NSIndexPath *)indexPath{

    if (!indexPath) {
        return nil;
    }
    NSDictionary *dic = self.dataArray[indexPath.section];
    
    NSString *key = [dic.allKeys firstObject];
    
    NSMutableArray *rowArray = [dic objectForKey:key];
    KLGuideModel *model = [rowArray objectAtIndex:indexPath.row];
    
    return model;
}
#pragma mark - nav
- (void)navLeftButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - delegate
- (NSInteger)KL_tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSMutableDictionary *dic = self.dataArray[section];
    
    NSString *key = [dic.allKeys firstObject];
    
    NSMutableArray *rowArray = [dic objectForKey:key];
    
    return rowArray.count;
}
- (NSInteger)KL_numberOfSectionsInTableView:(UITableView *)tableView{

    return self.dataArray.count;
}

- (UITableViewCell *)KL_tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    KLGuideModel *model = [self getIndexPath:indexPath];
    
    if (model.type == GuideCellTypeText) {
        
        KLGuideTextCell *textCell = [tableView dequeueReusableCellWithIdentifier:@"KLGuideTextCell" forIndexPath:indexPath];
        [textCell setModel:model];
        return textCell;
    }else{
    
        KLGuideImageTextCell *imageTextCell = [tableView dequeueReusableCellWithIdentifier:@"KLGuideImageTextCell" forIndexPath:indexPath];
        [imageTextCell setModel:model];
        return imageTextCell;
    
    }
}

- (void)KL_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
  
}
- (UIView *)KL_tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    NSDictionary *dic = self.dataArray[section];
    
    NSString *key = [dic.allKeys firstObject];
    
    UILabel *headerLabel = [UILabel new];
    headerLabel.font = kNSPXFONT(32);
    headerLabel.textColor = [UIColor colorWithHexString:@"#d6d6d6d"];
    headerLabel.frame = CGRectMake(0, 0, 40*MULTIPLE, 40*MULTIPLE);
    headerLabel.text = [NSString stringWithFormat:@"   %@",key];
    
    return headerLabel;
}
- (CGFloat)KL_tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    KLGuideModel *model = [self getIndexPath:indexPath];
    
    if (model.type == GuideCellTypeText) {
        
        CGFloat height = [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[KLGuideTextCell class] contentViewWidth:[self cellContentViewWith]];
        
        return height;
    }else{
        
        CGFloat height = [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[KLGuideImageTextCell class] contentViewWidth:[self cellContentViewWith]];
        return height;
        
    }
}
- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && systemVersion < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}
- (CGFloat)KL_tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return .1;
}

- (CGFloat)KL_tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40*MULTIPLE;
}


@end
