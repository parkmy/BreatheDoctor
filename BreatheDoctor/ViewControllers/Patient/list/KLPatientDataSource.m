//
//  KLPatientDataSource.m
//  BreatheDoctor
//
//  Created by comv on 16/4/21.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLPatientDataSource.h"
#import "KLPatientLisetCell.h"
#import "KLPatientListModel.h"

@implementation KLPatientDataSource

- (NSMutableArray *)searchArray
{
    if (!_searchArray) {
        _searchArray = [NSMutableArray array];
    }
    return _searchArray;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!self.isSearch) {
        NSString *key = self.keys[section];
        
        return [(NSMutableArray *)[self.patientDics objectForKey:key] count];
    }
    return self.searchArray.count;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.isSearch?1:self.keys.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KLPatientLisetCell *listcell = [tableView dequeueReusableCellWithIdentifier:@"KLPatientLisetCell" forIndexPath:indexPath];
    [listcell setType:self.listType];
    
    KLPatientListModel *model;
    if (self.isSearch) {
        model = self.searchArray[indexPath.row];
    }else{
        NSString *key = self.keys[indexPath.section];
        NSMutableArray *arr = (NSMutableArray *)[self.patientDics objectForKey:key];
        model = arr[indexPath.row];
    }
    [listcell setModel:model];
    return listcell;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.isSearch) {
        return nil;
    }
    NSString *key = self.keys[section];
    NSMutableArray *arr = (NSMutableArray *)[self.patientDics objectForKey:key];
    
    if (self.patientDics.count>0&&[arr count]>0)
    {
        UIView * view = [[UIView alloc]init];
        view.backgroundColor =viewBackgroundColor;
        
        UILabel * lable = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 22)];
        lable.text = key;
        lable.font =[UIFont systemFontOfSize:16];
        lable.backgroundColor =[UIColor clearColor];
        lable.textColor =[UIColor colorWithRed:152.0/255.0 green:152.0/255.0 blue:152.0/255.0 alpha:1.0];
        [view addSubview:lable];
        
        return view;
    }
    else
    {
        return nil;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 22;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    KLPatientListModel *model;
    if (self.isSearch) {
        model = self.searchArray[indexPath.row];
    }else{
        NSString *key = self.keys[indexPath.section];
        NSMutableArray *arr = (NSMutableArray *)[self.patientDics objectForKey:key];
        model = arr[indexPath.row];
    }
    _didSelectTableCellBlock?_didSelectTableCellBlock(indexPath,model):nil;
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.isSearch) {
        if (self.searchArray.count > 0) {
            [self.searchBar resignFirstResponder];
        }
    }else{
        //        [self hiddenPullView];
    }
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)aTableView
{
    if (!self.isSearch)  // regular table
    {
        NSMutableArray *toBeReturned = [NSMutableArray arrayWithObject:UITableViewIndexSearch];
        
        [toBeReturned addObjectsFromArray:self.keys];
        //        char c= '#';
        //        [toBeReturned addObject:[NSString stringWithFormat:@"%c",c]];
        return toBeReturned;
    }
    else return nil; // search table
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if (title == UITableViewIndexSearch)
    {
        [self.tableView scrollRectToVisible:self.searchBar.frame animated:NO];
        return -1;
    }
    return [self.keys indexOfObject:title];
}

@end
