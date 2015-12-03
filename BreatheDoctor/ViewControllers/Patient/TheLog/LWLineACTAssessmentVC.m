//
//  LWLineACTAssessmentVC.m
//  BreatheDoctor
//
//  Created by comv on 15/12/1.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWLineACTAssessmentVC.h"
#import "LWAsthmaAssessmentCell.h"
#import "LWACTStateAssessmentCell.h"

@interface LWLineACTAssessmentVC ()
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation LWLineACTAssessmentVC
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [super addNavBar:@"ACT评估"];
    [super addBackButton:@"nav_btnBack.png"];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.rowHeight = 180;
    [self loadData];
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
    [LWProgressHUD displayProgressHUD:self.view displayText:@"请稍后..."];
    [LWHttpRequestManager httpLoadAsthmaAssessLogWithPatientId:self.patientID starDate:self.starDate EndDate:self.endDate success:^(NSMutableArray *models) {
        [LWProgressHUD closeProgressHUD:self.view];
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:models];
        [self.tableView reloadData];
    } failure:^(NSString *errorMes) {
        [LWProgressHUD closeProgressHUD:self.view];
        [LWProgressHUD showALAlertBannerWithView:self.view.window Style:SALAlertBannerStyleWarning  Position:SALAlertBannerPositionTop Subtitle:errorMes ];
    }];
}

#pragma mark - tableviewdelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count+1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (indexPath.row == 0) {
        LWACTStateAssessmentCell *ACTStateAssessmentCell = [tableView dequeueReusableCellWithIdentifier:@"LWACTStateAssessmentCell" forIndexPath:indexPath];
        [ACTStateAssessmentCell initACTStateAssessmentCelWith:self.patientName actResult:self.type date:[NSString stringWithFormat:@"%@ - %@",self.starDate,self.endDate]];
        cell = ACTStateAssessmentCell;
    }else
    {
        LWAsthmaAssessmentCell *AsthmaAssessmentCell = [tableView dequeueReusableCellWithIdentifier:@"LWAsthmaAssessmentCell" forIndexPath:indexPath];
        [AsthmaAssessmentCell setModel:self.dataArray[indexPath.row-1]];
        cell = AsthmaAssessmentCell;
    }
    return cell;
}


#pragma mark -nav
- (void)navLeftButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
