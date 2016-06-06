//
//  LWPersonalSetingCtr.m
//  BreatheDoctor
//
//  Created by comv on 15/11/11.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWPersonalSetingCtr.h"
#import "LWLoginManager.h"
#import "LWWEBViewController.h"
#import "LWHttpDefine.h"
#import "KLOutLoginCell.h"

@interface LWPersonalSetingCtr ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation LWPersonalSetingCtr
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [super addNavBar:@"更多设置"];
    [super addBackButton:@"nav_btnBack.png"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addSubViews];
}
- (void)addSubViews{

    self.tableView.rowHeight = 44*MULTIPLE;
    self.tableView.sectionFooterHeight = .1;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"stcell"];
}
- (void)navLeftButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
 
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"stcell" forIndexPath:indexPath];
        cell.textLabel.font = kNSPXFONT(28);
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        cell.textLabel.text = @"修改密码";
        return cell;

    }else if (indexPath.section == 1){
    
        KLOutLoginCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KLOutLoginCell" forIndexPath:indexPath];
        
        return cell;
    }
    return nil;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 20;
    }
    return 15;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1) {
        
        [[LWLoginManager shareInstance] exitLoginViewVc:self];
    }else if (indexPath.section == 0)
    {
        UIViewController *vc = [UIViewController CreateControllerWithTag:CtrlTag_PassModify];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section == 0)
    {
        if (indexPath.row == 0) {
            UIViewController *vc = [UIViewController CreateControllerWithTag:CtrlTag_AboutUser];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 1)
        {
            LWWEBViewController *vc = (LWWEBViewController *)[UIViewController CreateControllerWithTag:CtrlTag_WEB];
            vc.titleString = @"声明";
            vc.url = @"http://zkys.zhangkong.me/mobile/statement/statement.html";
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }
}

@end
