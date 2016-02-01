//
//  LWOrderRecordViewController.m
//  BreatheDoctor
//
//  Created by comv on 15/12/31.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWOrderRecordViewController.h"
#import "LWYerChangIndexView.h"
#import "LWOrderCountCell.h"
#import "LWOrderDetailsCell.h"
#import "NSDate+Extension.h"

@interface LWOrderRecordViewController ()
@property (nonatomic, strong) LWYerChangIndexView *yerIndexView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSString *loadDate;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation LWOrderRecordViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [super addNavBar:@"购买记录"];
    [super addBackButton:@"nav_btnBack.png"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self initDateView];
    [self initProperty];
    [self loadData];
}
- (void)initProperty
{
    self.loadDate = [NSDate stringWithDate:[NSDate date] format:[NSDate ymdHmsFormat]];
}
- (void)initDateView
{
    self.yerIndexView = [[LWYerChangIndexView alloc] initWithFrame:CGRectZero WithDelegate:self];
    self.yerIndexView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.yerIndexView];
    self.yerIndexView.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).topSpaceToView(self.view,64).heightIs(40);
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)loadData
{
    [self hiddenNonetWork];

    [LWProgressHUD displayProgressHUD:self.view displayText:@"请稍后..."];
    [LWHttpRequestManager httpLoadShopOrderLogWithDate:self.loadDate success:^(NSMutableArray *models) {
        [LWProgressHUD closeProgressHUD:self.view];
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:models];
        [self.tableView reloadData];
        if (self.dataArray.count <= 0) {
            [self showErrorMessage:@"本月无购买记录哦~" isShowButton:YES type:showErrorType64Hight];
        }else{
            [self hiddenNonetWork];
        }
    } failure:^(NSString *errorMes) {
        [self showErrorMessage:@"请求失败，点击刷新~" isShowButton:NO type:showErrorType64Hight];
        [LWProgressHUD closeProgressHUD:self.view];
    }];
}
- (void)reloadRequestWithSender:(UIButton *)sender
{
    [self hiddenNonetWork];
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

#pragma mark - tableviewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}             // Default is 1 if not implemented
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataArray.count > 0) {
        return section == 0?1:self.dataArray.count+1;
    }
    return section == 0?0:0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    if (indexPath.section == 0) {
        LWOrderModel *model = self.dataArray[0];
        LWOrderCountCell *OrderCountCell = [tableView dequeueReusableCellWithIdentifier:@"LWOrderCountCell" forIndexPath:indexPath];
        OrderCountCell.buyCountLabel.text = [NSString stringWithFormat:@"%lld",model.buyPeopleNum];
        OrderCountCell.orederCountLabel.text = [NSString stringWithFormat:@"%ld",self.dataArray.count];
        cell = OrderCountCell;
    }else
    {
       
        
        LWOrderDetailsCell *OrderDetailsCell = [tableView dequeueReusableCellWithIdentifier:@"LWOrderDetailsCell" forIndexPath:indexPath];

        if (indexPath.row != 0) {
            
             LWOrderModel *model = self.dataArray[indexPath.row - 1];
            
            for (UILabel *lin in OrderDetailsCell.lins) {
                lin.backgroundColor = RGBA(170, 170, 170, 1);
            }
            
            for (int i = 0; i < OrderDetailsCell.Labels.count; i++) {
                UILabel *label = OrderDetailsCell.Labels[i];
                label.textColor = RGBA(0, 0, 0, .5);
                label.backgroundColor = [UIColor whiteColor];

                if (i == 0) {
                    label.text = [NSString stringWithFormat:@"%ld",indexPath.row];
                }else if (i == 1)
                {
                    label.text = stringJudgeNull(model.patientName);

                }else if (i == 2)
                {
                    label.text = stringJudgeNull(model.createDt);

                }else if (i == 3)
                {
                    label.text = stringJudgeNull(model.fullName);

                }else if (i == 4)
                {
                    label.text = [NSString stringWithFormat:@"%@",kNSNumDouble(model.quantity)];
                }
                
            }
        }else
        {
            
            for (UILabel *label in OrderDetailsCell.Labels) {
                label.textColor = RGBA(0, 0, 0, .5);
                label.backgroundColor = [LWThemeManager shareInstance].navBackgroundColor;
            }
            
            for (UILabel *lin in OrderDetailsCell.lins) {
                lin.backgroundColor = [LWThemeManager shareInstance].navBackgroundColor;
            }
        
        }

    
        
        
        cell = OrderDetailsCell;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 150*MULTIPLE;
    }else
    {
        if (indexPath.row == 0) {
            return 44;
        }
        return 64*MULTIPLE;
    }
}

#pragma mark - LWYerChangIndexViewDeleagte
- (void)indexDateChnagecenterLabelDate:(NSDate *)date
{
    self.loadDate = [NSDate stringWithDate:date format:[NSDate ymdHmsFormat]];
    [self loadData];
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
