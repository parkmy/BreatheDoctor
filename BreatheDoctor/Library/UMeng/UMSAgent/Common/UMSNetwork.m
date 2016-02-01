//
//  UMSNetwork.m
//  DiabetesPatient
//
//  Created by 郑建武 on 15-2-27.
//  Copyright (c) 2015年 com.comvee. All rights reserved.
//

#import "UMSNetwork.h"

@implementation UMSNetwork

+(NSDictionary* )SendData:(NSString*)URLString data:(NSString*)requestStr
{
    NSURL *url = [NSURL URLWithString:URLString];
    NSData *requestData = [requestStr dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody:requestData];

    
    NSError        *responseError = nil;
    NSURLResponse  *response = nil;
    
    NSData *returnData = [ NSURLConnection sendSynchronousRequest: request returningResponse: &response error: &responseError ];
    if (response == nil) {
        if (responseError != nil)
        {
            NSLog(@"Connection to server failed.");
            
        }
        return nil;
    }
    else
    {
        NSError* error =nil;
        NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData:returnData options:NSJSONReadingMutableLeaves error:&error];
        if(error!=nil)
        {
            return nil;
        }
        
        return resultDict;
        
        /*
        NSString *jsonString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        NSLog(@"RET JSON STR = %@",jsonString);
        jsonString = [jsonString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        return jsonString;
        */
    }
}

//IOS
+(CommonReturn *) postDeviceInfo:(NSString *) appkey deviceId:(NSString *)deviceId deviceInfo:(NSMutableArray *)deviceArrayInfo
{
    NSString* url = [NSString stringWithFormat:@"%@%@",URL_AGENT,URL_DEVICEINFO];
    
    NSError *error = nil;
    NSData *requestData = [NSJSONSerialization dataWithJSONObject:deviceArrayInfo options:NSJSONWritingPrettyPrinted error:&error];//[deviceArrayInfo JSONData];
    
    NSString *requestStr = [[NSString alloc] initWithData:requestData encoding:NSUTF8StringEncoding];
    requestStr = [NSString stringWithFormat:@"appkey=%@&deviceid=%@&data=%@",appkey,deviceId,requestStr];
    
    //NSLog(@"requestStr:%@",requestStr);
    
    CommonReturn *ret = [[CommonReturn alloc] init];
    NSDictionary *retDictionary = [UMSNetwork SendData:url data:requestStr];
    if(retDictionary!=nil)
    {
        ret.res_code = [[retDictionary objectForKey:@"res_code" ] intValue];
        ret.res_msg = [retDictionary objectForKey:@"res_msg"];
    }
    else
    {
        ret.res_code = -9;
        NSString *strMsg = [[NSString alloc] initWithFormat:@"返回数据异常"];
        ret.res_msg = strMsg;
    }
    return ret;
}

+(CommonReturn *) postActivityInfo:(NSString *)appkey deviceId:(NSString *)deviceId activityLogInfo:(NSMutableArray *)activityLogInfo
{
    
    NSString* url = [NSString stringWithFormat:@"%@%@",URL_AGENT,URL_ACTIVITYLOGINFO];
    
    NSError *error = nil;
    NSData *requestData = [NSJSONSerialization dataWithJSONObject:activityLogInfo options:NSJSONWritingPrettyPrinted error:&error];//[deviceArrayInfo JSONData];
    
    NSString *requestStr = [[NSString alloc] initWithData:requestData encoding:NSUTF8StringEncoding];
    requestStr = [NSString stringWithFormat:@"appkey=%@&deviceid=%@&data=%@",appkey,deviceId,requestStr];
    
    NSLog(@"requestStr:%@",requestStr);
    
    CommonReturn *ret = [[CommonReturn alloc] init];
    NSDictionary *retDictionary = [UMSNetwork SendData:url data:requestStr];
    if(retDictionary!=nil)
    {
        ret.res_code = [[retDictionary objectForKey:@"res_code" ] intValue];
        ret.res_msg = [retDictionary objectForKey:@"res_msg"];
    }
    else
    {
        ret.res_code = -9;
        NSString *strMsg = [[NSString alloc] initWithFormat:@"返回数据异常"];
        ret.res_msg = strMsg;
    }
    return ret;
}

+(CommonReturn *) postEventInfo:(NSString *)appkey deviceId:(NSString *)deviceId eventInfo:(NSMutableArray *)eventInfo
{
    NSString* url = [NSString stringWithFormat:@"%@%@",URL_AGENT,URL_EVENTINFO];
    
    //NSData *requestData = [eventInfo JSONData];
    NSError *error = nil;
    NSData *requestData = [NSJSONSerialization dataWithJSONObject:eventInfo options:NSJSONWritingPrettyPrinted error:&error];//[deviceArrayInfo JSONData];
    NSString *requestStr = [[NSString alloc] initWithData:requestData encoding:NSUTF8StringEncoding];
    requestStr = [NSString stringWithFormat:@"appkey=%@&deviceid=%@&data=%@",appkey,deviceId,requestStr];
    
    NSLog(@"requestStr:%@",requestStr);
    
    CommonReturn *ret = [[CommonReturn alloc] init];
    NSDictionary *retDictionary = [UMSNetwork SendData:url data:requestStr];
    if(retDictionary!=nil)
    {
        ret.res_code = [[retDictionary objectForKey:@"res_code" ] intValue];
        ret.res_msg = [retDictionary objectForKey:@"res_msg"];
        NSLog(@"提交信息：%@",ret.res_msg);
    }
    else
    {
        ret.res_code = -9;
        NSString *strMsg = [[NSString alloc] initWithFormat:@"返回数据异常"];
        ret.res_msg = strMsg;
    }
    return ret;
}

+(CommonReturn *) postErrorLogInfo:(NSString *)appkey deviceId:(NSString *)deviceId errorInfo:(NSMutableArray *)errorInfo
{
    NSString* url = [NSString stringWithFormat:@"%@%@",URL_AGENT,URL_ERRORINFO];
    
    //NSData *requestData = [errorInfo JSONData];
    NSError *error = nil;
    NSData *requestData = [NSJSONSerialization dataWithJSONObject:errorInfo options:NSJSONWritingPrettyPrinted error:&error];//[deviceArrayInfo JSONData];
    NSString *requestStr = [[NSString alloc] initWithData:requestData encoding:NSUTF8StringEncoding];
    requestStr = [NSString stringWithFormat:@"appkey=%@&deviceid=%@&data=%@",appkey,deviceId,requestStr];
    
    
    NSLog(@"requestStr:%@",requestStr);
    
    CommonReturn *ret = [[CommonReturn alloc] init];
    NSDictionary *retDictionary = [UMSNetwork SendData:url data:requestStr];
    if(retDictionary!=nil)
    {
        ret.res_code = [[retDictionary objectForKey:@"res_code" ] intValue];
        ret.res_msg = [retDictionary objectForKey:@"res_msg"];
        NSLog(@"提交信息：%@",ret.res_msg);

    }
    else
    {
        ret.res_code = -9;
        NSString *strMsg = [[NSString alloc] initWithFormat:@"返回数据异常"];
        ret.res_msg = strMsg;
    }
    return ret;
}

+(CheckUpdateReturn*) postCheckUpdate:(NSString *)appkey version:(NSString *)version_code channelId:(NSString *)cid
{
    NSString* url = [NSString stringWithFormat:@"%@%@",URL_AGENT,URL_ACTIVITYLOGINFO];
    
    NSString *requestStr = [NSString stringWithFormat:@"appkey=%@&version=%@&channelId=%@",appkey,version_code,cid];
    
    NSLog(@"requestStr:%@",requestStr);
    
    CheckUpdateReturn *ret = [[CheckUpdateReturn alloc] init];
    
    NSDictionary *retDictionary = [UMSNetwork SendData:url data:requestStr];
    if(retDictionary!=nil)
    {
        ret.res_code = [[retDictionary objectForKey:@"res_code" ] intValue];
        ret.res_msg = [retDictionary objectForKey:@"res_msg"];
        NSLog(@"提交信息：%@",ret.res_msg);

        ret.hasNewVer = [[retDictionary objectForKey:@"hasNewVer"] intValue];
        ret.description = [retDictionary objectForKey:@"description"];
        ret.version = [retDictionary objectForKey:@"version"];
        ret.fileurl = [retDictionary objectForKey:@"fileurl"];
        ret.forceUpdate = [retDictionary objectForKey:@"forceupdate"];
    }
    else
    {
        ret.res_code = -9;
        NSString *strMsg = [[NSString alloc] initWithFormat:@"返回数据异常"];
        ret.res_msg = strMsg;
    }
    return ret;
}

@end
