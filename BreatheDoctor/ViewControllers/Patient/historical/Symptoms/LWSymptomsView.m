//
//  LWSymptomsView.m
//  BreatheDoctor
//
//  Created by comv on 16/3/16.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWSymptomsView.h"
#import "LWSymptomsFootView.h"
#import "KLSymptomsLogModel.h"
#import "KLHistoricalOperation.h"

@interface LWSymptomsView ()
{
    NSString *_dateString;
    KLPatientLogBodyModel *_model;
}
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation LWSymptomsView

- (id)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.mTableView.delegate = self;
        self.mTableView.dataSource = self;
        NSString *path = [[NSBundle mainBundle] pathForResource:@"LWSymptomsList" ofType:@"plist"];
        NSArray *array = [[NSArray alloc] initWithContentsOfFile:path];
        [self.dataArray removeAllObjects];
        for (NSDictionary *dic in array) {
            [self.dataArray addObject:[[KLSymptomsLogModel alloc] initWithDictionary:dic]];
        }
    }
    return self;
}
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)setLogDateText:(NSString *)string
{
    _dateString = string;
    [self.mTableView reloadData];
}
- (void)reloadSymptomsViewData:(KLPatientLogBodyModel *)model
{
    _model = model;
    [KLHistoricalOperation historicalSymptomsRecordCountInfo:model.recordList theSymptomsLogArray:self.dataArray thehistoricalDataArray:nil];
    [self.mTableView reloadData];
}
#pragma mark - tableDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"historicalHeardView"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"historicalHeardView"];
            cell.selectionStyle = 0;
            LWHistoricalHeardView *historicalHeardView = [LWBaseHistoricalView historicalHeardView];
            historicalHeardView.tag = 888;
            [cell.contentView addSubview:historicalHeardView];
            historicalHeardView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
        }
        LWHistoricalHeardView *historicalHeardView = (LWHistoricalHeardView *)[cell viewWithTag:888];
        [historicalHeardView setFootLabelTitle:@"保持身体正常，无不适，可改善哮喘风险"];
        [historicalHeardView setHistoricalType:showHistoricalTypeSymptoms];
        [historicalHeardView setScaleCircleWithObjc:_model];
        [historicalHeardView setScaleCircleDateText:_dateString];

        return cell;
    }else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"symptomsFootView"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"symptomsFootView"];
            cell.selectionStyle = 0;
            LWSymptomsFootView *symptomsFootView = [LWSymptomsFootView new];
            symptomsFootView.tag = 999;
            [cell.contentView addSubview:symptomsFootView];
            symptomsFootView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
        }
        LWSymptomsFootView *symptomsFootView = (LWSymptomsFootView *)[cell viewWithTag:999];
        [symptomsFootView setFootSymptoms:self.dataArray];
        
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.section==0?180*MULTIPLEVIEW:245*MULTIPLEVIEW;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section==0?.1:5*MULTIPLEVIEW;
}


@end
