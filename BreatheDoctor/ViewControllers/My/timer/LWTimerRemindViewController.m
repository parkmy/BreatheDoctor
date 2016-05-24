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
#import "LWPopAlatView.h"
#import "NSDate+Extension.h"
#import "KLDatePickViewController.h"
#import "KLTimerWeeksViewController.h"
#import "KLTimerRemindViewOperation.h"
#import "ZZPhotoHud.h"
#import "KLSetInstructionsViewController.h"

@interface LWTimerRemindViewController ()<LWTimerRemindIndexViewDeleagte,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (nonatomic, strong) LWTimerRemindIndexView *indexView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *models;
@property (nonatomic, assign) BOOL isChange;
@property (nonatomic, strong) KLDatePickViewController *datePickViewController;
@end

@implementation LWTimerRemindViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [super addNavBar:@"回复时间"];
    [super addBackButton:@"nav_btnBack.png"];
    self.navRightContent = self.isChange?@"完成":@"";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.navRightButton.hidden = YES;
    
    [self setUI];
    [self loadData];
}

- (void)setUI
{
    self.tableView.rowHeight = 120*MULTIPLE;
}

- (void)loadData
{
    [ZZPhotoHud showActiveHudWithTitle:@"正在获取..."];
    WEAKSELF
    [LWHttpRequestManager httploadDoctorServerTimeSuccess:^(NSMutableArray *models) {
        [ZZPhotoHud hideActiveHud];
        if (![[NSUserDefaults standardUserDefaults] objectForKey:@"LWPopAlatView"]) {
            [[NSUserDefaults standardUserDefaults] setObject:@"11111" forKey:@"LWPopAlatView"];
            [LWPopAlatView showView:nil];
        }
        [KL_weakSelf.models removeAllObjects];
        [KL_weakSelf.models addObjectsFromArray:models];
        int a = 3 - (int)KL_weakSelf.models.count;
        for (int i = 0; i < a; i++) {
            LWDoctorTimerModel *model = [LWDoctorTimerModel getInitModel];
            [KL_weakSelf.models addObject:model];
        }
        [KL_weakSelf.tableView reloadData];
    } failure:^(NSString *errorMes) {
        [ZZPhotoHud hideActiveHud];
        [LWProgressHUD showALAlertBannerWithView:nil Style:0 Position:0 Subtitle:errorMes];
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
    WEAKSELF
    [KLTimerRemindViewOperation saveTimerRemindSetingWithArray:self.models success:^(BOOL isSuccess) {
        [KL_weakSelf.navigationController popViewControllerAnimated:YES];
    }];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }else
    {
        WEAKSELF
        [KLTimerRemindViewOperation saveTimerRemindSetingWithArray:self.models success:^(BOOL isSuccess) {
            [KL_weakSelf.navigationController popViewControllerAnimated:YES];
        }];
    }
}
- (void)setInstructions{
    
    KLSetInstructionsViewController *vc = [KLSetInstructionsViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.models.count > 3) {
        return 3;
    }
    return self.models.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section == 0?.1:10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return section == 2?30:.1;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (section != 2) {
        return nil;
    }
    UIView *view = [UIView new];
    
    UIImageView *icon = [[UIImageView alloc] initWithImage:kImage(@"timer_warning")];
    icon.frame = CGRectMake(10, 5, 15, 15);
    
    UILabel     *label = [UILabel new];
    label.text = @"设置说明";
    label.font = kNSPXFONT(30);
    label.frame = CGRectMake(30, 5, 80, 15);
    label.textColor = [LWThemeManager shareInstance].navBackgroundColor;
    [view addSubview:icon];
    [view addSubview:label];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 2.5, 120, 25);
    button.backgroundColor =[UIColor clearColor];
    [view addSubview:button];
    [button addTarget:self action:@selector(setInstructions) forControlEvents:UIControlEventTouchUpInside];
    return view;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LWTimerButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LWTimerButtonCell" forIndexPath:indexPath];
    switch (indexPath.section) {
        case 0:
        {
            cell.indexLabel.text = @"时段段一";
        }
            break;
        case 1:
        {
            cell.indexLabel.text = @"时段段二";
        }
            break;
        case 2:
        {
            cell.indexLabel.text = @"时段段三";
        }
            break;
        default:
            break;
    }
    LWDoctorTimerModel *model = self.models[indexPath.section];
    cell.starLabel.text = model.startTime;
    cell.endLabel.text = model.endTime;
    [KLTimerRemindViewOperation setWeekLabelWithLabel:cell.weekslabel data:model.repeatWeek];
    WEAKSELF
    [cell setTapStarButtonBlock:^(UILabel *label) {
        [KL_weakSelf showPickView:label withIndexPath:indexPath withModel:model isStar:YES];
    }];
    
    [cell setTapEndButtonBlock:^(UILabel *label) {
        [KL_weakSelf showPickView:label withIndexPath:indexPath withModel:model isStar:NO];
    }];
    
    [cell setTapMoreButtonBlock:^(UILabel *label) {
            
        KLTimerWeeksViewController *weeksViewController = [KLTimerWeeksViewController new];
        weeksViewController.weeks = [NSMutableArray arrayWithArray:[KLTimerRemindViewOperation weekArray:model.repeatWeek]];
        [KL_weakSelf addChildViewController:weeksViewController];
        [KL_weakSelf.view addSubview:weeksViewController.view];
        
        
        [KL_weakSelf.tableView setContentOffset:CGPointMake(0, indexPath.section*(90+15)) animated:YES];

        [weeksViewController setBackBlock:^(NSMutableArray *weeks) {
            
            if (weeks.count != [[KLTimerRemindViewOperation weekArray:model.repeatWeek] count]) {
                KL_weakSelf.isChange = YES;
                weakSelf.navRightContent = @"完成";
            }else
            {
                NSMutableString *string = [[NSMutableString alloc] initWithString:@""];
                for (NSString *mstr in weeks)
                {
                    [string appendString:mstr];
                }
                for (NSString *astr in [KLTimerRemindViewOperation weekArray:model.repeatWeek])
                {
                    if (![string containsaString:astr])
                    {
                        if (![astr isEqualToString:@""]) {
                            KL_weakSelf.isChange = YES;
                            weakSelf.navRightContent = @"完成";
                        }
                        
                    }
                }
                
            }
            if (weeks) {
                weeks = (NSMutableArray *)[weeks sortedArrayUsingSelector:@selector(compare:)];
            }
            
            NSMutableString *weekString = [[NSMutableString alloc] initWithString:@""];
            for (NSString *str in weeks)
            {
                [weekString appendString:[NSString stringWithFormat:@"%@|",str]];
            }
            model.repeatWeek = weekString;
            [KL_weakSelf.tableView reloadData];
        }];
        
      
        [weeksViewController setCompleteDismiss:^{
            
            [KL_weakSelf.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
        }];

    }];
    
    
    return cell;
    
}

- (void)showPickView:(UILabel *)label withIndexPath:(NSIndexPath *)indexPath withModel:(LWDoctorTimerModel *)model isStar:(BOOL)isStar
{
    NSString *left = @"";
    NSString *right = @"";
    
    NSArray *array = [stringJudgeNull(label.text) componentsSeparatedByString:@":"];
    if (array.count > 1) {
        left = [array objectAtIndex:0];
        right = [array objectAtIndex:1];
    }
    if (_datePickViewController) {
        _datePickViewController.view.hidden = NO;

    }else{
        _datePickViewController = [[KLDatePickViewController alloc] init];
    }
    [_datePickViewController setleftButtonTitleInfo:@"取消"];
    [_datePickViewController setcenterTitleLabelStringInfo:isStar?@"开始时间":@"结束时间"];
    [_datePickViewController setrightButtonTitleInfo:@"保存"];
    
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:0 animated:YES];
    [self.tableView setContentOffset:CGPointMake(0, indexPath.section*(90+15)) animated:YES];

    __weak typeof(self)weakSelf = self;
    [_datePickViewController setCompleteChooseBlock:^(NSString *string) {
        if (![label.text isEqualToString:string]) {
            weakSelf.isChange = YES;
            weakSelf.navRightContent = @"完成";
        }
        if (isStar) {
            
            NSDate *starDate = [NSDate dateWithString:stringJudgeNull(string) format:[NSDate hmFormat]];
            
            NSDate *endDate  = [NSDate dateWithString:stringJudgeNull(model.endTime) format:[NSDate hmFormat]];
            NSInteger endCount = [model.endTime integerValue];

            double cha = [endDate timeIntervalSinceReferenceDate] - [starDate timeIntervalSinceReferenceDate];
            if (cha < 30*60 && endCount > 0) {
                SHOWAlertView(@"提示", @"您选择的时间段不符合，请重新选择！")
                return ;
            }
            model.startTime = string;
        }else
        {
            NSDate *starDate = [NSDate dateWithString:stringJudgeNull(model.startTime) format:[NSDate hmFormat]];
            NSDate *endDate  = [NSDate dateWithString:stringJudgeNull(string) format:[NSDate hmFormat]];
            NSInteger starCount = [model.startTime integerValue];

            double cha = [endDate timeIntervalSinceReferenceDate] - [starDate timeIntervalSinceReferenceDate];
            if (cha < 30*60 && starCount > 0) {
                SHOWAlertView(@"提示", @"您选择的时间段不符合，请重新选择！")
                return ;
            }
            model.endTime = string;
        }
        label.text = string;
        
        weakSelf.datePickViewController.view.hidden = YES;
        [weakSelf.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
    }];
    [_datePickViewController setCompleteDismiss:^{
        [weakSelf.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
    }];
    [self addChildViewController:_datePickViewController];
    [self.view addSubview:_datePickViewController.view];
    
    [_datePickViewController setleftPickViewCountIndex:[left intValue]];
    [_datePickViewController setRightPickViewCountIndex:[right intValue]];
}

@end
