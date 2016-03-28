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
#import "KLPEFItmLineView.h"

@interface LWPEFListView ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *mTableView;
    KLPEFItmLineView *pefLineView;
    LWHistoricalItmView *itmView;
    NSMutableArray *dataArray;
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
        
        itmView = ({
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
            
            
            table.hidden = YES;
            table.alpha = 0;
            table;
        });
        
        [contentView addSubview:mTableView];
        
        pefLineView = [[KLPEFItmLineView alloc] initWithDataSource:nil withFram:CGRectZero];
        [contentView addSubview:pefLineView];
        
        
        itmView.sd_layout.rightSpaceToView(self,10).topSpaceToView(self,5).widthIs(100).heightIs(30*MULTIPLEVIEW);
        titleLabel.sd_layout.rightSpaceToView(itmView,5).topSpaceToView(self,5).leftSpaceToView(self,10).heightIs(30*MULTIPLEVIEW);
        contentView.sd_layout.leftSpaceToView(self,10).rightSpaceToView(self,10).topSpaceToView(itmView,5).bottomSpaceToView(self,5);
        mTableView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
        pefLineView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
        
        [self setBlock];
    }
    return self;
}

- (void)setBlock
{
    __weak typeof(self)weakSelf = self;
    
    [itmView setLeftButtonBlock:^{
        [weakSelf showLeft];
    }];
    
    [itmView setRightButtonBlock:^{
        [weakSelf showRight];
    }];
}

- (void)showLeft
{
    [UIView animateWithDuration:.5 animations:^{
        pefLineView.hidden = NO;
        mTableView.alpha = 0;
        pefLineView.alpha = 1;
    } completion:^(BOOL finished) {
        mTableView.hidden = YES;
    }];
}
- (void)showRight
{
    [UIView animateWithDuration:.5 animations:^{
        mTableView.hidden = NO;
        pefLineView.alpha = 0;
        mTableView.alpha = 1;
    } completion:^(BOOL finished) {
        pefLineView.hidden = YES;
    }];
    
}
- (void)setPefHistorical:(NSMutableArray *)array{
    dataArray = array;
    [mTableView reloadData];
}
- (void)setLineViewYnumber:(double)pefPredictedValue{
    [pefLineView changeYnumber:pefPredictedValue];
}
- (void)changePefDateList:(NSInteger)dateCount{
    [pefLineView changeDateList:dateCount];
}
- (void)setItmLineView:(KLPatientLogBodyModel *)body{
    pefLineView.dataSource = [pefLineView getItms:body];
    [pefLineView setNeedsDisplay];
}
#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LWPEFHistorListCell *listCell = [tableView dequeueReusableCellWithIdentifier:@"LWPEFHistorListCell" forIndexPath:indexPath];
    [listCell setBackgroundColorWithTag:(indexPath.row)%2];
    listCell.pefPredictedValue = self.pefPredictedValue;
    [listCell setModel:dataArray[indexPath.row]];
    return listCell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    LWPEFHistorListTitleCell *view = [LWPEFHistorListTitleCell new];
    view.frame = CGRectMake(0, 0, screenWidth, (72/2)*MULTIPLEVIEW);
    return view;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return (72/2)*MULTIPLEVIEW;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 22*MULTIPLEVIEW;
}

@end
