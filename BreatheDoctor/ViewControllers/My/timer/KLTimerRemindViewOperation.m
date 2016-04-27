//
//  KLTimerRemindViewOperation.m
//  BreatheDoctor
//
//  Created by comv on 16/4/8.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLTimerRemindViewOperation.h"
#import "ZZPhotoHud.h"
#import "YRJSONAdapter.h"

@implementation KLTimerRemindViewOperation

+ (void)saveTimerRemindSetingWithArray:(NSMutableArray *)array
                               success:(void(^)(BOOL isSuccess))successBlock{
    
    if (array.count <= 0) {
        return;
    }
    NSMutableString *requestString = [[NSMutableString alloc] initWithString:@""];
    for (int i = 0; i < array.count; i++)
    {
        LWDoctorTimerModel *model = array[i];
        NSDictionary *dic = model.dictionaryRepresentation;
        NSString *string = dic.JSONString;
        if (i == 0) {
            [requestString appendFormat:@"[%@",string];
        }else if (i == 1)
        {
            [requestString appendFormat:@",%@",string];
        }else if (i == 2)
        {
            [requestString appendFormat:@",%@]",string];
        }
        
    }
    
    NSLog(@"%@",requestString);
    
    requestString = [[requestString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] mutableCopy];  //去除掉首尾的空白字符和换行字符
    requestString = [[requestString stringByReplacingOccurrencesOfString:@"\r" withString:@""] mutableCopy];
    requestString = [[requestString stringByReplacingOccurrencesOfString:@"\n" withString:@""] mutableCopy];
    //    NSLog(@"%@",self.models.JSONString);
    
    [ZZPhotoHud showActiveHudWithTitle:@"正在保存..."];
    
    [LWHttpRequestManager httpsubmitDoctorServerTimeWithJsonString:requestString Success:^() {
        [ZZPhotoHud hideActiveHud];
        [[KLPromptViewManager shareInstance] kl_showPromptViewWithTitle:@"温馨提示" theContent:@"设置成功" theHiddenBlock:^{
            successBlock?successBlock(YES):nil;
        }];
//        [LCCoolHUD showSuccess:@"设置成功" zoom:YES shadow:NO];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        });
    } failure:^(NSString *errorMes) {
        [ZZPhotoHud hideActiveHud];
        [LCCoolHUD showFailure:errorMes zoom:YES shadow:NO];
        //        successBlock?successBlock(NO):nil;
    }];
    
}

+ (NSArray *)weekArray:(NSString *)string
{
    if (string.length <= 0) {
        return [NSArray array];
    }
    NSMutableArray *array = [NSMutableArray arrayWithArray:[string componentsSeparatedByString:@"|"]];
    for (NSInteger i = array.count-1; i > 0; i--)
    {
        NSString *objc = [array objectAtIndex:i];
        
        if ([objc isEqualToString:@""]) {
            [array removeObject:objc];
        }
    }
    return  array;
}

+ (NSString *)getWeekString:(NSArray *)array
{
    NSArray *sArray = [array sortedArrayUsingSelector:@selector(compare:)];
    
    NSMutableString *weekString = [[NSMutableString alloc] initWithString:@""];
    for (NSString *str in sArray)
    {
        if (str.integerValue == 1)
        {
            [weekString appendString:@" 周一 "];
        }else if (str.integerValue == 2)
        {
            [weekString appendString:@" 周二 "];
        }else if (str.integerValue == 3)
        {
            [weekString appendString:@" 周三 "];
        }else if (str.integerValue == 4)
        {
            [weekString appendString:@" 周四 "];
        }else if (str.integerValue == 5)
        {
            [weekString appendString:@" 周五 "];
        }else if (str.integerValue == 6)
        {
            [weekString appendString:@" 周六 "];
        }else if (str.integerValue == 7)
        {
            [weekString appendString:@" 周日 "];
        }
        
    }
    return weekString.length == 0?@"未选择":weekString;
}

+ (void)setWeekLabelWithLabel:(UILabel *)label data:(NSString *)string
{
    label.text = [[self class] getWeekString:[[self class] weekArray:string]];
    
}
@end
