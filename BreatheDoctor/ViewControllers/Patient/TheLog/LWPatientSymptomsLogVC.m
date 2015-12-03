//
//  LWPatientSymptomsLogVC.m
//  BreatheDoctor
//
//  Created by comv on 15/11/22.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWPatientSymptomsLogVC.h"
#import "LWPatientLogSymptomsCountCell.h"
#import "LWPatientLogSymptomsDescribeCell.h"
#import "LWTool.h"

@interface LWPatientSymptomsLogVC ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation LWPatientSymptomsLogVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (void)refreshSymptomsLog
{
    self.dataArray = [LWTool LogrowsCount];
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section == 0?1:self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        LWPEFRecordList *model = (LWPEFRecordList *)self.dataArray[indexPath.row];
        return model.rowHight;
    }else
    {
        return 200;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return .1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    if (indexPath.section == 0) {
        
        LWPatientLogSymptomsCountCell *patientLogSymptomsCountCell = [tableView dequeueReusableCellWithIdentifier:@"LWPatientLogSymptomsCountCell" forIndexPath:indexPath];
        [patientLogSymptomsCountCell loadData];
        cell = patientLogSymptomsCountCell;
    }else
    {
        LWPatientLogSymptomsDescribeCell *patientLogSymptomsDescribeCell = [tableView dequeueReusableCellWithIdentifier:@"LWPatientLogSymptomsDescribeCell" forIndexPath:indexPath];
        [patientLogSymptomsDescribeCell setModel:self.dataArray[indexPath.row]];
        cell = patientLogSymptomsDescribeCell;
    }
    
    return cell;
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
