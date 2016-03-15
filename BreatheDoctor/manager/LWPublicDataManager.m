//
//  LWPublicDataManager.m
//  BreatheDoctor
//
//  Created by comv on 15/11/12.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWPublicDataManager.h"
#import "NSDate+Extension.h"

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

+ (BOOL)IntoTheBackGroundtimeIsMoreThan:(NSInteger)time WithKey:(NSString *)key
{
    NSDate *oldDate = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if(!oldDate)
    {
        return YES;
    }
    NSDate *newDate = [NSDate date];
    
    double xc = ([newDate timeIntervalSinceReferenceDate] - [oldDate timeIntervalSinceReferenceDate]);
    
    if (xc >= time){
        return YES;
    }
    return NO;
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


+ (void)AcceptButtonEventClick:(LWMainRows *)row
                       success:(void(^)())success
                       failure:(void(^)(NSString *errorMes))failure
{
    [LWProgressHUD displayProgressHUD:nil displayText:@"请稍后..."];
    [LWHttpRequestManager httpagreeAttentionWithPatientId:row.memberId sid:row.sid Success:^{
        [LWProgressHUD closeProgressHUD:nil];
        
        [[LKDBHelper getUsingLKDBHelper] deleteToDB:row];
        success?success():nil;
        [[NSNotificationCenter defaultCenter] postNotificationName:APP_ADDPATIENT_SUCC object:nil];
    } failure:^(NSString *errorMes) {
        [LWProgressHUD closeProgressHUD:nil];
        failure?failure(errorMes):nil;
    }];
}

@end
