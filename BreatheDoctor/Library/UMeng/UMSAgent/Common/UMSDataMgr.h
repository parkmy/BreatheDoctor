//
//  UMSDataMgr.h
//  DiabetesPatient
//
//  Created by 郑建武 on 15-2-27.
//  Copyright (c) 2015年 com.comvee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActivityLogObj.h"
#import "EventInfoObj.h"

@interface UMSDataMgr : NSObject

+(NSString *)getKeyInfo;

//////////////////Start 页面时长信息及路径跟踪//////////////////////

+(NSString*)generalActivityKey;
+(NSString*)generalNewActivityKey;

+(int)saveActivityLogInfo:(ActivityLogObj *)acLog;
+(int)deleteActivityByKey:(NSString*)strActivityKeyName;

//////////////////END  页面时长信息及路径跟踪//////////////////////


//////////////////Start 事件信息统计//////////////////////

+(NSString*)generalEventKey;
+(NSString*)generalNewEventKey;
+(int)saveEventInfo:(EventInfoObj *)eventInfoObj;
+(int)deleteEventByKey:(NSString*)strEventKeyName;

//////////////////END 事件信息统计//////////////////////

@end
