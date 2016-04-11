//
//  LWPersonalCtr.m
//  BreatheDoctor
//
//  Created by comv on 15/11/10.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWPersonalCtr.h"
#import "LWPersonalCell.h"
#import "LWPersonalHeardCell.h"
#import "CODataCacheManager.h"
#import "LWPersonalMenuButton.h"

@interface LWPersonalCtr ()

@end

@implementation LWPersonalCtr
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [super addNavBar:@"个人中心"];
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (indexPath.row == 0) {
        LWPersonalHeardCell *personalHeardCell = [tableView dequeueReusableCellWithIdentifier:@"LWPersonalHeardCell" forIndexPath:indexPath];
        personalHeardCell.backgroundColor = [UIColor colorWithPatternImage:kImage(@"huanzhezhongxinbeijing")];
        LBLoginBaseModel *user = [CODataCacheManager shareInstance].userModel;
        [personalHeardCell setDoctorIconImage:user.body.perRealPhoto];
        [personalHeardCell setDoctordoctorName:user.body.perName];
        [personalHeardCell setDoctorType:user.body.positionText];
        
        cell = personalHeardCell;
        
    }else
    {
        LWPersonalCell *personalCell = [tableView dequeueReusableCellWithIdentifier:@"LWPersonalCell" forIndexPath:indexPath];
        [personalCell setPersonalMenuButtonTapBlock:^(tapType type) {
            switch (type) {
                case tapTypeRecoverytime:
                {
                    [self.navigationController pushViewController:[UIViewController CreateControllerWithTag:CtrlTag_TimerRemind] animated:YES];
                }
                    break;
                case tapTypePurchaseRecords:
                {
                    [self.navigationController pushViewController:[UIViewController CreateControllerWithTag:CtrlTag_OrderRecord] animated:YES];
                }
                    break;
                case tapTypeMoreSettings:
                {
                    [self.navigationController pushViewController:[UIViewController CreateControllerWithTag:CtrlTag_PersonalSeting] animated:YES];
                }
                    break;
                case tapTypeStayTunedFor:
                {
                    
                }
                    break;
                default:
                    break;
            }
            
        }];
        if (indexPath.row == 1) {
            personalCell.lefticon.image = kImage(@"huifu");
            personalCell.leftmenuTitleLabel.text = @"回复时间";
            personalCell.leftButton.tapType = tapTypeRecoverytime;
            personalCell.rightIcon.image = kImage(@"jilu");
            personalCell.rightMenuLabel.text = @"患者购买记录";
            personalCell.rightButton.tapType = tapTypePurchaseRecords;
        }else
        {
            personalCell.lefticon.image = kImage(@"shezhi");
            personalCell.leftmenuTitleLabel.text = @"更多设置";
            personalCell.leftButton.tapType = tapTypeMoreSettings;
            personalCell.rightIcon.image = kImage(@"gengduo");
            personalCell.rightMenuLabel.text = @"敬请期待";
            personalCell.rightButton.tapType = tapTypeStayTunedFor;
            
        }
//        personalCell.iconw.constant  = personalCell.lefticon.image.size.width;
//        personalCell.iconh.constant  = personalCell.lefticon.image.size.height;
//        personalCell.riconw.constant = personalCell.rightIcon.image.size.width;
//        personalCell.riconh.constant = personalCell.rightIcon.image.size.height;
        cell = personalCell;
        
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return (270/2)*MULTIPLE;
    }
    return (230/2)*MULTIPLE;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        [self.navigationController pushViewController:[UIViewController CreateControllerWithTag:CtrlTag_PersonalCenter] animated:YES];
    }
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
