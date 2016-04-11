//
//  LWPEFView.m
//  BreatheDoctor
//
//  Created by comv on 16/3/16.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWPEFView.h"
#import "LWPEFListView.h"
#import "KLHistoricalOperation.h"

@interface LWPEFView ()
{
    NSString *_dateString;
    KLPatientLogBodyModel *_model;
    NSInteger _dateCount;
}
@end

@implementation LWPEFView

- (id)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        self.mTableView.delegate = self;
        self.mTableView.dataSource = self;
    }
    return self;
}
- (void)setLogDateText:(NSString *)string
{
    _dateString = string;
    [self.mTableView reloadData];
}
- (void)reloadPEFViewData:(KLPatientLogBodyModel *)model
{
    _model = model;
    [self.mTableView reloadData];
}
- (void)setPefDateList:(NSInteger)dateCount{
    _dateCount = dateCount;
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
            historicalHeardView.baseHistoricalView = self;
            [cell.contentView addSubview:historicalHeardView];
            historicalHeardView.tag = 888;
            historicalHeardView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
        }
        
        LWHistoricalHeardView *historicalHeardView = (LWHistoricalHeardView *)[cell viewWithTag:888];
        [historicalHeardView setFootLabelTitle:@"PEF值控制在绿区，可降低哮喘发作风险"];
        [historicalHeardView setHistoricalType:showHistoricalTypePEF];
        [historicalHeardView setScaleCircleWithObjc:_model];
        [historicalHeardView setScaleCircleDateText:_dateString];
        return cell;
    }else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pefListView"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"pefListView"];
            cell.selectionStyle = 0;
            LWPEFListView *listView = [LWPEFListView new];
            listView.tag = 999;
            [cell.contentView addSubview:listView];
            listView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
        }
        LWPEFListView *listView = (LWPEFListView *)[cell viewWithTag:999];
        [listView setPefHistorical:[KLHistoricalOperation mergeHistoricalListInfo:_model.recordList]];
        [listView changePefDateList:_dateCount];
        [listView setLineViewYnumber:_model.pefPredictedValue];
        listView.pefPredictedValue = _model.pefPredictedValue;
        [listView setItmLineView:_model];
        
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.section==0?180*MULTIPLEVIEW:235*MULTIPLEVIEW;
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
