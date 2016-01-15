//
//  LWNewFriendsViewController.m
//  BreatheDoctor
//
//  Created by comv on 16/1/6.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWNewFriendsViewController.h"
#import "LWMessageTakeCell.h"

@interface LWNewFriendsViewController ()<LWMessageTakeCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation LWNewFriendsViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [super addNavBar:@"新朋友"];
    [super addBackButton:@"nav_btnBack"];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tableView.rowHeight = 65;
    self.tableView.backgroundColor = [UIColor whiteColor];
    setExtraCellLineHidden(self.tableView);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)navLeftButtonAction
{
    _backBlock?_backBlock():nil;
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - tableviewdelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.requsetArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LWMainRows *message = self.requsetArray[indexPath.row];
    
    LWMessageTakeCell *messageTakeCell = [tableView dequeueReusableCellWithIdentifier:@"LWMessageTakeCell" forIndexPath:indexPath];
    messageTakeCell.delegate = self;
    [messageTakeCell setMessage:message];
    
    return messageTakeCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
//    LWMainRows *message = self.requsetArray[indexPath.row];
    [self.navigationController pushViewController:[UIViewController CreateControllerWithTag:CtrlTag_PatientAgreed] animated:YES];
    
}
#pragma mark 滑动表格删除行


-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    LWMainRows *message = self.requsetArray[indexPath.row];
    [[LKDBHelper getUsingLKDBHelper] deleteToDB:message];
    [self.requsetArray removeObject:message];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
}


#pragma mark -LWMessageTakeCellDelegate
- (void)tapAcceptButtonEventWith:(LWMainRows *)row
{
    [LWProgressHUD displayProgressHUD:self.view displayText:@"请稍后..."];
    [LWHttpRequestManager httpagreeAttentionWithPatientId:row.memberId sid:row.sid Success:^{
        [LWProgressHUD closeProgressHUD:self.view];
        
        [[LKDBHelper getUsingLKDBHelper] deleteToDB:row];
        
        _addSuccBlock?_addSuccBlock():nil;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:APP_ADDPATIENT_SUCC object:nil];
    } failure:^(NSString *errorMes) {
        [LWProgressHUD closeProgressHUD:self.view];
        [LWProgressHUD showALAlertBannerWithView:self.view Style:SALAlertBannerStyleWarning  Position:SALAlertBannerPositionTop Subtitle:errorMes ];
    }];
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
