//
//  KLMessgaeDataSource.m
//  BreatheDoctor
//
//  Created by comv on 16/4/25.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLMessgaeDataSource.h"
#import "KLMessageCell.h"
#import "KLMessageOperation.h"

@implementation KLMessgaeDataSource

- (NSMutableArray *)messageArray{
    
    if (!_messageArray) {
        _messageArray = [NSMutableArray array];
    }
    return _messageArray;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.messageArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    KLMessageCell *messageCell = [tableView dequeueReusableCellWithIdentifier:@"KLMessageCell" forIndexPath:indexPath];
    [messageCell setMessageModel:self.messageArray[indexPath.row]];
    return messageCell;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    LWMainRows *message = self.messageArray[indexPath.row];
    
    _deleteRowsAtIndexPathsBlock?_deleteRowsAtIndexPathsBlock(indexPath,message):nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LWMainRows *message = self.messageArray[indexPath.row];
    _didSelectRowAtIndexPathBlock?_didSelectRowAtIndexPathBlock(indexPath,message):nil;
}

@end
