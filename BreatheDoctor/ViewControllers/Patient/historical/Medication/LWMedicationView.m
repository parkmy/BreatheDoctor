//
//  LWMedicationView.m
//  BreatheDoctor
//
//  Created by comv on 16/3/16.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWMedicationView.h"
#import "LWMedicationContentCell.h"
#import "LWMedicationTitleTypeView.h"

@implementation LWMedicationView

- (id)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.mTableView.delegate = self;
        self.mTableView.dataSource = self;
        
        self.mTableView.separatorStyle = 0;
        
        [self.mTableView registerClass:[LWMedicationContentCell class] forCellReuseIdentifier:@"LWMedicationContentCell"];
        
    }
    return self;
}

#pragma mark - tableDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section == 0?1:10;
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
        LWMedicationContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LWMedicationContentCell"];

        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.section==0?180*MULTIPLEVIEW:60*MULTIPLEVIEW;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return section == 0?5:.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section==0?.1:50*MULTIPLEVIEW;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        LWMedicationTitleTypeView *view = [LWMedicationTitleTypeView new];
        view.bounds = CGRectMake(0, 0, screenWidth, 50*MULTIPLEVIEW);
        return view;
    }
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        
        UIView *bg = [UIView new];
        UIView *line1 = [UIView allocAppLineView];
        UIView *line2 = [UIView allocAppLineView];
        [bg addSubview:line1];
        [bg addSubview:line2];
        bg.bounds = CGRectMake(0, 0, screenWidth, 5);
        bg.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        line1.frame = CGRectMake(0, 0, screenWidth, .5);
        line2.frame = CGRectMake(0, bg.height-.5, screenWidth, .5);
    }
    return nil;
}

@end
