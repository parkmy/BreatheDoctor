//
//  LWPEFListView.m
//  BreatheDoctor
//
//  Created by comv on 16/3/15.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWPEFListView.h"
#import "LWHistoricalItmView.h"
#import "LWPEFHistorListCell.h"
#import "LWPEFHistorListTitleCell.h"

@interface LWPEFListView ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *mTableView;

}
@end

@implementation LWPEFListView

- (id)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        UILabel *titleLabel = ({
            UILabel *label = [UILabel new];
            [self addSubview:label];
            label.text = @"峰流速(PEF)表";
            label.font = kNSPXFONT(30);
            label.textColor = [UIColor colorWithHexString:@"#333333"];
            [self addSubview:label];
            label;
        });
   
        LWHistoricalItmView *itmView = ({
            LWHistoricalItmView *view = [[LWHistoricalItmView alloc] initWithSize:CGSizeMake(70*MULTIPLEVIEW, 20*MULTIPLEVIEW) leftTitle:@"曲线" rightTitle:@"列表"];
            [self addSubview:view];
            view;
        });
        
        UIView *contentView = ({
            UIView *view = [UIView new];
            view.layer.borderWidth = .5;
            view.layer.borderColor = appLineColor.CGColor;
            [self addSubview:view];
            view;
        });
        
        mTableView = ({
        
            UITableView *table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
            table.dataSource = self;
            table.delegate = self;
            table.separatorStyle = 0;
            [table registerClass:[LWPEFHistorListCell class] forCellReuseIdentifier:@"LWPEFHistorListCell"];
            [table registerClass:[LWPEFHistorListTitleCell class] forCellReuseIdentifier:@"LWPEFHistorListTitleCell"];
            table;
        });
        
        [contentView addSubview:mTableView];
        
        
        itmView.sd_layout.rightSpaceToView(self,10).topSpaceToView(self,5).widthIs(100).heightIs(30*MULTIPLEVIEW);
        titleLabel.sd_layout.rightSpaceToView(itmView,5).topSpaceToView(self,5).leftSpaceToView(self,10).heightIs(30*MULTIPLEVIEW);
        contentView.sd_layout.leftSpaceToView(self,10).rightSpaceToView(self,10).topSpaceToView(itmView,5).bottomSpaceToView(self,5);
        mTableView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
        
        
    }
    return self;
}

#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    if (indexPath.row == 0)
    {
        LWPEFHistorListTitleCell *titleCell = [tableView dequeueReusableCellWithIdentifier:@"LWPEFHistorListTitleCell" forIndexPath:indexPath];
        cell = titleCell;
    }else
    {
        LWPEFHistorListCell *listCell = [tableView dequeueReusableCellWithIdentifier:@"LWPEFHistorListCell" forIndexPath:indexPath];
        [listCell setBackgroundColorWithTag:(indexPath.row+1)%2];
        cell = listCell;
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return (72/2)*MULTIPLEVIEW;
    }else
    {
        return 22*MULTIPLEVIEW;
    }
}

@end
