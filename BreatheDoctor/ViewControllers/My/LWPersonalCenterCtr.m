//
//  LWPersonalCenterCtr.m
//  BreatheDoctor
//
//  Created by comv on 15/11/11.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWPersonalCenterCtr.h"
#import "LWPersonCenterIconCell.h"
#import "LWPersonalMessageCell.h"
#import "CODataCacheManager.h"
#import <UIImageView+WebCache.h>

@interface LWPersonalCenterCtr ()

@end

@implementation LWPersonalCenterCtr
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [super addNavBar:@"个人中心"];
    [super addBackButton:@"nav_btnBack.png"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.sectionFooterHeight = .1;

}
- (void)navLeftButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - tableviewdelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section == 0?3:5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    LBLoginBaseModel *user = [CODataCacheManager shareInstance].userModel;
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        LWPersonCenterIconCell *personCenterIconCell = [tableView dequeueReusableCellWithIdentifier:@"LWPersonCenterIconCell" forIndexPath:indexPath];
        [personCenterIconCell.userIcon sd_setImageWithURL:kNSURL(user.body.perRealPhoto) placeholderImage:kImage(@"personalcenter_14.png")];
        cell = personCenterIconCell;
        
    }else if (indexPath.section == 1 && indexPath.row == 3) //专长
    {
        LWPersonalMessageCell *personalMessageCell = [tableView dequeueReusableCellWithIdentifier:@"LWPersonalMessageCell" forIndexPath:indexPath];
        [personalMessageCell setMessage:user.body.perSpacil];
        cell = personalMessageCell;
        
    }else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"CELL"];
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
            cell.selectionStyle = 0;
            cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"#333333"];
            cell.textLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        }
        
        NSString *textLabelTitle = nil;
        NSString *detailTextLabelTitle = nil;
        
        if (indexPath.section == 1) {
            if (indexPath.row == 0) { //医院
                textLabelTitle = @"医院";
                detailTextLabelTitle = stringJudgeNull(user.body.hospitalName);
            }else if (indexPath.row == 1) //科室
            {
                textLabelTitle = @"科室";
                detailTextLabelTitle = stringJudgeNull(user.body.departmentName);
            }else if (indexPath.row == 2) //职称
            {
                textLabelTitle = @"职称";
                detailTextLabelTitle = stringJudgeNull(user.body.positionText);
            }else if (indexPath.row == 4)
            {
                textLabelTitle = @"签名";
                detailTextLabelTitle = [stringJudgeNull(user.body.signature) stringByReplacingOccurrencesOfString:@"^$%" withString:@"，"];

            }
        }else
        {
            if (indexPath.row == 1) { //姓名
                textLabelTitle = @"姓名";
                detailTextLabelTitle = stringJudgeNull(user.body.perName);
            }else if (indexPath.row == 2) //性别
            {
                textLabelTitle = @"性别";
                detailTextLabelTitle = user.body.perSex == 1?@"男":@"女";
            }
        
        }
        
        cell.textLabel.text = textLabelTitle;
        cell.detailTextLabel.text = detailTextLabelTitle;

    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 80*MULTIPLE;
    }else if (indexPath.section == 1 && indexPath.row == 3)//专长
    {
        LBLoginBaseModel *user = [CODataCacheManager shareInstance].userModel;
        NSString *perSpacil = user.body.perSpacil;
        CGFloat h = [perSpacil sizeWithFont:[UIFont systemFontOfSize:14] constrainedToWidth:160].height + 10;
        return MAX(h, 44)*MULTIPLE;
    }
    return 44*MULTIPLE;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return .1;
    }
    return 15;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
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
