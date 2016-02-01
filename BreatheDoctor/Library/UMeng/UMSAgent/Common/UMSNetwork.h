//
//  UMSNetwork.h
//  DiabetesPatient
//
//  Created by 郑建武 on 15-2-27.
//  Copyright (c) 2015年 com.comvee. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CommonReturn.h"
#import "DeviceInfoObj.h"
#import "CheckUpdateReturn.h"
//#define URL_AGENT                   @"http://report.zhangkong.me/"
#define URL_AGENT                   @"http://192.168.20.75:8099/fetch/"
#define URL_DEVICEINFO              @"servlet/FetchDeviceServlet"
#define URL_ACTIVITYLOGINFO         @"servlet/FetchActivityServlet"
#define URL_ERRORINFO               @"servlet/FetchErrorServlet"
#define URL_EVENTINFO               @"servlet/FetchEventServlet"

@interface UMSNetwork : NSObject

+(NSDictionary*)SendData:(NSString*)URLString data:(NSString*)requestStr;

+(CommonReturn *) postDeviceInfo:(NSString *) appkey deviceId:(NSString *)deviceId deviceInfo:(NSMutableArray *)deviceArrayInfo;

+(CommonReturn *) postActivityInfo:(NSString *)appkey deviceId:(NSString *)deviceId activityLogInfo:(NSMutableArray *)activityLogInfo;

+(CommonReturn *) postEventInfo:(NSString *)appkey deviceId:(NSString *)deviceId eventInfo:(NSMutableArray *)eventInfo;

+(CommonReturn *) postErrorLogInfo:(NSString *)appkey deviceId:(NSString *)deviceId errorInfo:(NSMutableArray *)errorInfo;

+(CheckUpdateReturn*) postCheckUpdate:(NSString *)appkey version:(NSString *)version_code channelId:(NSString *)cid;

@end
