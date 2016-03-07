//
//  LWBuyOrderDetailedViewController.m
//  BreatheDoctor
//
//  Created by comv on 16/2/25.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWReservationDetailedViewController.h"
#import "NSDate+Extension.h"

@interface LWReservationDetailedViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton    *stateButton;
@property (nonatomic, strong) LWReservationDetailedModel *model;

@end

@implementation LWReservationDetailedViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [super addNavBar:@"预约详情"];
    [super addBackButton:@"nav_btnBack.png"];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadUI];
    [self loadData];
}
- (void)loadUI
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    _stateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_stateButton setTitle:@"已取消" forState:UIControlStateNormal];
    _stateButton.backgroundColor = RGBA(0, 0, 0, .2);
    _stateButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_stateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_stateButton setCornerRadius:3.0F];
    [self.view addSubview:_stateButton];
    _stateButton.sd_layout.bottomSpaceToView(self.view,25).leftSpaceToView(self.view,10).rightSpaceToView(self.view,10).heightIs(45);
    _tableView.sd_layout.topSpaceToView(self.view,64).leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).bottomSpaceToView(_stateButton,0);
    if (_isDispose != 3)
    {
        _stateButton.hidden = YES;
    }
    
}
- (void)loadData
{
    [LWProgressHUD displayProgressHUD:self.view displayText:@""];
    [LWHttpRequestManager httpLoadOrderAppointmentInfoWithOrdAppid:self.requestId Success:^(LWReservationDetailedModel *model) {
        [self hiddenNonetWork];
        [LWProgressHUD closeProgressHUD:self.view];
        self.model = model;
        [self.tableView reloadData];
    } failure:^(NSString *errorMes) {
        [LWProgressHUD closeProgressHUD:self.view];
        [self showErrorMessage:errorMes isShowButton:NO type:showErrorTypeHttp];
    }];
    
}
- (void)reloadRequestWithSender:(UIButton *)sender
{
    [self loadData];
}
- (void)navLeftButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

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

#pragma mark - table delegate datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section == 0?1:3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    if (indexPath.section == 0)
    {
        
        UITableViewCell *heardCell = [tableView dequeueReusableCellWithIdentifier:@"heardCell"];
        if (!heardCell) {
            heardCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"heardCell"];
            heardCell.textLabel.font = kNSPXFONT(33);
            heardCell.textLabel.textColor = [UIColor colorWithHexString:@"#666666"];
            heardCell.detailTextLabel.font = [UIFont systemFontOfSize:15];
            heardCell.detailTextLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        }
        
        heardCell.imageView.image = kImage(@"dianhuazixun");
        heardCell.textLabel.text = @"电话咨询";
        heardCell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@",stringJudgeNull(self.model.doctorName),stringJudgeNull(self.model.hospitalName)];
        
        cell = heardCell;
        
    }else if (indexPath.section == 1)
    {
        UITableViewCell *footCell = [tableView dequeueReusableCellWithIdentifier:@"footCell"];
        if (!footCell) {
            footCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"footCell"];
            
            footCell.textLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:kNSPXFONTFLOAT(33)];
            footCell.textLabel.textColor = [UIColor colorWithHexString:@"#333333"];
            footCell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:kNSPXFONTFLOAT(32)];
            footCell.detailTextLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        }
        
        
        if (indexPath.row == 0) {
            footCell.textLabel.text = @"接听电话";
            footCell.detailTextLabel.text = stringJudgeNull(self.model.phone);
        }else if (indexPath.row == 1)
        {
            footCell.textLabel.text = @"预约时长";
            NSDate *starDate = [NSDate dateWithString:stringJudgeNull(self.model.startTime) format:[NSDate hmFormat]];
            NSDate *endDate = [NSDate dateWithString:stringJudgeNull(self.model.endTime) format:[NSDate hmFormat]];
            double h = [endDate timeIntervalSinceReferenceDate] - [starDate timeIntervalSinceReferenceDate];
            footCell.detailTextLabel.text = [NSString stringWithFormat:@"%.0f分钟",h/60];
        }else if (indexPath.row == 2)
        {
            footCell.textLabel.text = @"预约时间";
            NSDate *starDate = [NSDate dateWithString:stringJudgeNull(self.model.startTime) format:[NSDate hmFormat]];
            NSDate *endDate = [NSDate dateWithString:stringJudgeNull(self.model.endTime) format:[NSDate hmFormat]];
            NSDate *date = [NSDate dateWithString:stringJudgeNull(self.model.date) format:[NSDate ymdFormat]];
            NSString *endDateString = [NSDate stringWithDate:endDate format:[NSDate hmFormat]];
            NSString *starDateString = [NSDate stringWithDate:starDate format:[NSDate hmFormat]];
            NSString *dateString = [NSDate stringWithDate:date format:@"MM月-dd日"];
            footCell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@ - %@",stringJudgeNull(dateString),stringJudgeNull(starDateString),stringJudgeNull(endDateString)];
        }
        
        cell = footCell;
        
    }
    
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return section == 0?15:.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return .1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.section == 0?80:50;
}
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    if (section != 1) {
//        return nil;
//    }
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 35)];
//    label.textColor = [UIColor colorWithHexString:@"#999999"];
//    label.font = [UIFont systemFontOfSize:14];
//    label.text = @"   * 距离最早咨询时间至少半小时，方可进行时间更改";
//    label.backgroundColor = [UIColor clearColor];
//    if (screenWidth < 330) {
//        label.adjustsFontSizeToFitWidth = YES;
//    }
//    return label;
//}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
