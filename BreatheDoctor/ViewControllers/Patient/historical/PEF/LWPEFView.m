//
//  LWPEFView.m
//  BreatheDoctor
//
//  Created by comv on 16/3/16.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWPEFView.h"
#import "LWPEFListView.h"

@interface LWPEFView ()

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
            [cell.contentView addSubview:historicalHeardView];
            historicalHeardView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
        }
        return cell;
    }else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pefListView"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"pefListView"];
            cell.selectionStyle = 0;
            LWPEFListView *listView = [LWPEFListView new];
            [cell.contentView addSubview:listView];
            listView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
        }
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
    return section==0?.1:5;
}

@end
