//
//  LWPatientMedicationLogVC.m
//  BreatheDoctor
//
//  Created by comv on 15/11/22.
//  Copyright © 2015年 lwh. All rights reserved.
// 用药日志

#import "LWPatientMedicationLogVC.h"
#import "LWMedicationLogCountCell.h"
#import "LWMedicationLogHeadCell.h"
#import "LWMedicationLogTimerCell.h"
#import "LWMedicationLogTimerOneCell.h"
#import "LWMedicationModel.h"

@interface LWPatientMedicationLogVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datas;
@end

@implementation LWPatientMedicationLogVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)refreshMedicationLog
{
    self.datas = [LWMedicationModel MedicationModels];
    [self.tableView reloadData];
}
#pragma mark -UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 2+self.datas.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 160;
    }else if (indexPath.row == 1)
    {
        return 44;
    }else
    {
        LWMedicationModel *model = self.datas[indexPath.row-2];
        return model.isOne?45:90;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    if (indexPath.row == 0) {
        
        LWMedicationLogCountCell *MedicationLogCountCell = [tableView dequeueReusableCellWithIdentifier:@"LWMedicationLogCountCell" forIndexPath:indexPath];
        [MedicationLogCountCell reloadData];
        cell = MedicationLogCountCell;
    }else if (indexPath.row == 1)
    {
        LWMedicationLogHeadCell *MedicationLogHeadCell = [tableView dequeueReusableCellWithIdentifier:@"LWMedicationLogHeadCell" forIndexPath:indexPath];
        cell = MedicationLogHeadCell;
    }else
    {
        LWMedicationModel *model = self.datas[indexPath.row-2];
        
        if (model.isOne)
        {
            LWMedicationLogTimerOneCell *MedicationLogTimerOneCell = [tableView dequeueReusableCellWithIdentifier:@"LWMedicationLogTimerOneCell" forIndexPath:indexPath];
            [MedicationLogTimerOneCell setModel:model];
            cell = MedicationLogTimerOneCell;
            
        }else
        {
            LWMedicationLogTimerCell *MedicationLogTimerCell = [tableView dequeueReusableCellWithIdentifier:@"LWMedicationLogTimerCell" forIndexPath:indexPath];
            [MedicationLogTimerCell setModel:model];
            cell = MedicationLogTimerCell;
        
        }
        
        

    }
    return cell;
}


@end
