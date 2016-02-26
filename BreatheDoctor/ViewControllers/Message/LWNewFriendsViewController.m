//
//  LWNewFriendsViewController.m
//  BreatheDoctor
//
//  Created by comv on 16/1/6.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWNewFriendsViewController.h"
#import "LWMessageTakeCell.h"
#import "LWMessageAgreedViewController.h"

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
    LWMainRows *message = self.requsetArray[indexPath.row];
    LWMessageAgreedViewController *vc = (LWMessageAgreedViewController *)[UIViewController CreateControllerWithTag:CtrlTag_PatientAgreed];
    vc.patientModel = message;
    [self.navigationController pushViewController:vc animated:YES];
    
    [vc setAddPatientSuccBlock:^{
        _addSuccBlock?_addSuccBlock():nil;
        [self.requsetArray removeObject:message];
        [self.tableView reloadData];
    }];
    
    [vc setAddPatientFaileBlock:^{
        _backBlock?_backBlock():nil;
        [self.requsetArray removeObject:message];
        [self.tableView reloadData];
    }];
    
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
    [LWPublicDataManager AcceptButtonEventClick:row success:^{
        _addSuccBlock?_addSuccBlock():nil;
        [self.requsetArray removeObject:row];
        [self.tableView reloadData];
    } failure:^(NSString *errorMes) {
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
