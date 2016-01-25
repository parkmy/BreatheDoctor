//
//  LWTimerRemindViewController.m
//  BreatheDoctor
//
//  Created by comv on 15/12/30.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWTimerRemindViewController.h"
#import "LWTimerRemindIndexView.h"
#import "LWTimerButtonCell.h"
#import "LWPickerViewController.h"
#import "LWTimerWeeksViewController.h"
#import "NSString+Contains.h"
#import "YRJSONAdapter.h"
#import "SVProgressHUD.h"
#import "LWPopAlatView.h"

@interface LWTimerRemindViewController ()<LWTimerRemindIndexViewDeleagte,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (nonatomic, strong) LWTimerRemindIndexView *indexView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *models;
@property (nonatomic, assign) BOOL isChange;

@end

@implementation LWTimerRemindViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [super addNavBar:@"回复时间"];
    [super addBackButton:@"nav_btnBack.png"];
    [super addRightButton:@"完成"];
    self.navRightButton.hidden = !self.isChange;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navRightButton.hidden = YES;

    [self setUI];
    [self loadData];
    
}

- (void)setUI
{
    self.tableView.rowHeight = 90*(iPhone6Plus?1.15:1);
}

- (void)loadData
{
    [SVProgressHUD showProgress:60 status:@"正在获取..." maskType:SVProgressHUDMaskTypeBlack];

    [LWHttpRequestManager httploadDoctorServerTimeSuccess:^(NSMutableArray *models) {
        [SVProgressHUD dismiss];
        if (models.count <= 0) {
            [LWPopAlatView showView:nil];
        }
        [self.models removeAllObjects];
        [self.models addObjectsFromArray:models];
        
        for (int i = 0; i < (3 -self.models.count); i++) {
            LWDoctorTimerModel *model = [LWDoctorTimerModel getInitModel];
            [self.models addObject:model];
        }
        [self.tableView reloadData];
    } failure:^(NSString *errorMes) {
        [SVProgressHUD showErrorWithStatus:errorMes];
    }];
}
- (void)saveSeting
{

    NSMutableString *requestString = [[NSMutableString alloc] initWithString:@""];
    for (int i = 0; i < self.models.count; i++)
    {
        LWDoctorTimerModel *model = self.models[i];
        NSDictionary *dic = model.dictionaryRepresentation;
        NSString *string = dic.JSONString;
        if (i == 0) {
            [requestString appendFormat:@"[%@",string];
        }else if (i == 1)
        {
            [requestString appendFormat:@",%@",string];
        }else if (i == 2)
        {
            [requestString appendFormat:@",%@]",string];
        }
        
    }
    
    NSLog(@"%@",requestString);

    requestString = [requestString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
    requestString = [requestString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    requestString = [requestString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//    NSLog(@"%@",self.models.JSONString);
    
    [SVProgressHUD showProgress:60 status:@"正在保存..." maskType:SVProgressHUDMaskTypeBlack];
    [LWHttpRequestManager httpsubmitDoctorServerTimeWithJsonString:requestString Success:^() {
        [SVProgressHUD showSuccessWithStatus:@"设置成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    } failure:^(NSString *errorMes) {
        [SVProgressHUD showErrorWithStatus:errorMes];
    }];
    
    
    
}

- (NSMutableArray *)models
{
    if (!_models) {
        _models = [NSMutableArray array];
    }
    return _models;
}



- (void)navLeftButtonAction
{
    if (self.isChange) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您没有保存设置，是否保存设置？" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
        [alert show];
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)navRightButtonAction
{
    [self saveSeting];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];

    }else
    {
        [self saveSeting];
    }
}
#pragma mark - tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.models.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section == 0?.1:15;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LWTimerButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LWTimerButtonCell" forIndexPath:indexPath];

    LWDoctorTimerModel *model = self.models[indexPath.section];
    cell.starLabel.text = model.startTime;
    cell.endLabel.text = model.endTime;
    [self setWeekLabelWithLabel:cell.weekslabel data:model.repeatWeek];
    
    [cell setTapStarButtonBlock:^(UILabel *label) {
        [self showPickView:label withIndexPath:indexPath withModel:model isStar:YES];
    }];
    
    [cell setTapEndButtonBlock:^(UILabel *label) {
        [self showPickView:label withIndexPath:indexPath withModel:model isStar:NO];
    }];
    
    [cell setTapMoreButtonBlock:^(UILabel *label) {
        LWTimerWeeksViewController *vc = [[LWTimerWeeksViewController alloc] init];
        vc.weeks = [NSMutableArray arrayWithArray:[self weekArray:model.repeatWeek]];
        [self.navigationController pushViewController:vc animated:YES];
        
        [vc setBackBlock:^(NSMutableArray *weeks) {
            
            if (weeks.count != [[self weekArray:model.repeatWeek] count]) {
                self.isChange = YES;
                self.navRightButton.hidden = NO;
            }else
            {
                NSMutableString *string = [[NSMutableString alloc] initWithString:@""];
                for (NSString *mstr in weeks)
                {
                    [string appendString:mstr];
                }
                for (NSString *astr in [self weekArray:model.repeatWeek])
                {
                    if (![string containsaString:astr])
                    {
                        if (![astr isEqualToString:@""]) {
                            self.isChange = YES;
                            self.navRightButton.hidden = NO;
                        }
                        
                    }
                }
            
            }

            
            NSMutableString *weekString = [[NSMutableString alloc] initWithString:@""];
            for (NSString *str in weeks)
            {
                [weekString appendString:[NSString stringWithFormat:@"%@|",str]];
            }
            model.repeatWeek = weekString;
            [self.tableView reloadData];
        }];
    }];
    
    
    return cell;
    
}

#pragma mark - void
- (NSArray *)weekArray:(NSString *)string
{
    if (string.length <= 0) {
        return [NSArray array];
    }
    return  [string componentsSeparatedByString:@"|"];
}
- (NSString *)getWeekString:(NSArray *)array
{
    NSMutableString *weekString = [[NSMutableString alloc] initWithString:@""];
    for (NSString *str in array)
    {
        if (str.integerValue == 1)
        {
            [weekString appendString:@" 周一 "];
        }else if (str.integerValue == 2)
        {
            [weekString appendString:@" 周二 "];
        }else if (str.integerValue == 3)
        {
            [weekString appendString:@" 周三 "];
        }else if (str.integerValue == 4)
        {
            [weekString appendString:@" 周四 "];
        }else if (str.integerValue == 5)
        {
            [weekString appendString:@" 周五 "];
        }else if (str.integerValue == 6)
        {
            [weekString appendString:@" 周六 "];
        }else if (str.integerValue == 7)
        {
            [weekString appendString:@" 周日 "];
        }
        
    }
    return weekString.length == 0?@"未选择":weekString;
}

- (void)setWeekLabelWithLabel:(UILabel *)label data:(NSString *)string
{
    label.text = [self getWeekString:[self weekArray:string]];
    
}

- (void)showPickView:(UILabel *)label withIndexPath:(NSIndexPath *)indexPath withModel:(LWDoctorTimerModel *)model isStar:(BOOL)isStar
{
    __weak LWPickerViewController *vc = (LWPickerViewController *)StoryboardCtr(@"LWPickerViewController");
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:0 animated:YES];
    [self.tableView setContentOffset:CGPointMake(0, indexPath.section*(90+15)) animated:YES];
    
    [vc setCompleteChooseBlock:^(NSString *string) {
        if (![label.text isEqualToString:string]) {
            self.isChange = YES;
            self.navRightButton.hidden = NO;
        }
        if (isStar) {
            model.startTime = string;
        }else
        {
            model.endTime = string;
        }
        label.text = string;
        [vc dismissPickerView];
    }];
    [vc setCompleteDismiss:^{
        [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
    }];
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    
    
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
