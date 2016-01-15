//
//  LWPublicDataManager.m
//  BreatheDoctor
//
//  Created by comv on 15/11/12.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWPublicDataManager.h"

@implementation LWPublicDataManager

+ (LWPublicDataManager *)shareInstance
{
    static LWPublicDataManager *instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^ { instance = [[LWPublicDataManager alloc] init]; });
    return instance;
}

- (void)cloesCurrentPatientID
{
    if (self.currentPatientID) {
        self.currentPatientID = nil;
    }
}

NSString * stringJudgeNull(NSString *string)
{
    if(string == nil || string == NULL || [string isEqual:[NSNull null]]||[string isEqual:@"(null)"])
        return @"";
    
    else    return [NSString stringWithFormat:@"%@",string];
}

void setExtraCellLineHidden(UITableView *tableView)

{
    
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
}

@end