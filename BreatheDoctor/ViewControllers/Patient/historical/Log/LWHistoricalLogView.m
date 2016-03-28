//
//  LWLogView.m
//  BreatheDoctor
//
//  Created by comv on 16/3/18.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWHistoricalLogView.h"
#import "LWHistoricalLogCell.h"
#import "LWHistoricalLogModel.h"
#import "KLHistoricalOperation.h"

@interface LWHistoricalLogView ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *mtableView;
}
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation LWHistoricalLogView

- (id)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame])
    {
        mtableView = ({
            UITableView *table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
            [self addSubview:table];
            table.dataSource = self;
            table.delegate = self;
            [table registerClass:[LWHistoricalLogCell class] forCellReuseIdentifier:@"LWHistoricalLogCell"];
            table;
        });
        
        mtableView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));        
    }
    return self;
}
- (void)reloadDataArrayInfo:(KLPatientLogBodyModel *)bodyModel
{
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:[LWHistoricalLogModel historicalLogModelArrayInfo:bodyModel]];
    [mtableView reloadData];
}
//- (NSMutableArray *)getMissArrayInfo:(NSMutableArray *)array
//{
//    NSMutableArray *Hisarray = [NSMutableArray array];
//    for (int i = 0; i < array.count; i++)
//    {
//        LWHistoricalLogModel *model = [LWHistoricalLogModel new];
//        model.historicalLogType = i%3;
//        [Hisarray addObject:model];
//    }
//    return array;
//}
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark - delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LWHistoricalLogCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LWHistoricalLogCell" forIndexPath:indexPath];
    [cell setObjc:self.dataArray[indexPath.section]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LWHistoricalLogModel *model = self.dataArray[indexPath.section];
    return model.rowHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section == 0?.1:10;
}

@end
