//
//  LWChatViewControllerDataSource.m
//  BreatheDoctor
//
//  Created by comv on 15/11/16.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWChatViewControllerDataSource.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "WSChatTextTableViewCell.h"
#import "WSChatImageTableViewCell.h"
#import "WSChatVoiceTableViewCell.h"
#import "WSChatTimeTableViewCell.h"
#import "LWChatCardCell.h"
#import "LWChatRows.h"
#import "LWChatCardCell.h"
#import "LWChatModel.h"
#import "UUMessageCell.h"
#import "UUMessageFrame.h"

@interface LWChatViewControllerDataSource ()<UUMessageCellDelegate>

@end

@implementation LWChatViewControllerDataSource

#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self tableView:tableView heightForRowAtIndexPath:indexPath];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UUMessageFrame *model = self.dataSource[indexPath.row];
    
//    NSInteger height = model.rowHeight;
    
//    if (!height)
//    {
//        height = [tableView fd_heightForCellWithIdentifier:kCellReuseID(model) configuration:^(WSChatBaseTableViewCell* cell)
//                  {
//                      [cell setModel:model];
//                  }];
//        
//    }
    
    return model.cellHeight;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    LWChatModel *model = self.dataSource[indexPath.row];
//    
//
//    WSChatBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellReuseID(model) forIndexPath:indexPath];
//    
//    [cell setModel:model];
    UUMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UUMessageCell" forIndexPath:indexPath];
    cell.delegate = self;
    [cell setMessageFrame:self.dataSource[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.vc.view endEditing:YES];
    
    UUMessageFrame *modelFram = self.dataSource[indexPath.row];

    if (_delegate && [_delegate respondsToSelector:@selector(didSelectRowAtIndexPath:)]) {
        [_delegate didSelectRowAtIndexPath:modelFram.model];
    }
    
}

#pragma mark -UUMessageCellDelegate

- (void)headImageDidClick:(UUMessageCell *)cell userId:(NSString *)userId
{


}

@end
