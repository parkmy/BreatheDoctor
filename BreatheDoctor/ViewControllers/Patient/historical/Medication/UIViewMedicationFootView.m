//
//  UIViewMedicationFootView.m
//  BreatheDoctor
//
//  Created by comv on 16/3/17.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "UIViewMedicationFootView.h"
#import "LWMedicationContentCell.h"
#import "LWMedicationTitleCell.h"

@interface UIViewMedicationFootView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation UIViewMedicationFootView

- (id)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame])
    {
        
        UIView *bgview = ({
            UIView *view = [UIView new];
            [self addSubview:view];
            view;
        });
        
        _tableView = ({
            UITableView *table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
            [bgview addSubview:table];
            table.delegate = self;
            table.dataSource = self;
            table;
        });
        
        bgview.sd_layout.spaceToSuperView(UIEdgeInsetsMake(10, 10, 10, 10));
        _tableView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
        
    }
    return self;
}

#pragma mark -UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (indexPath.row == 0) {
        LWMedicationTitleCell *titleCell = [tableView dequeueReusableCellWithIdentifier:@"LWMedicationTitleCell" forIndexPath:indexPath];
        cell = titleCell;
    }else
    {
        LWMedicationContentCell *contentCell = [tableView dequeueReusableCellWithIdentifier:@"LWMedicationContentCell" forIndexPath:indexPath];
        cell = contentCell;
    }
    return cell;

}

@end
