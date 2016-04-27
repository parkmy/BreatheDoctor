//
//  KLMessgaeDataSource.h
//  BreatheDoctor
//
//  Created by comv on 16/4/25.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KLMessgaeDataSource : NSObject<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)   NSMutableArray *messageArray;

@property (nonatomic, copy)  void(^deleteRowsAtIndexPathsBlock)(NSIndexPath *indexPath,LWMainRows *model);

@property (nonatomic, copy)  void(^didSelectRowAtIndexPathBlock)(NSIndexPath *indexPath,LWMainRows *model);

@end
