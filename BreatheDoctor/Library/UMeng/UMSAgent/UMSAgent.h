//
//  UMSAgent.h
//  DiabetesPatient
//
//  Created by 郑建武 on 15-2-13.
//  Copyright (c) 2015年 com.comvee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    REALTIME = 0,       //RealTime Send Policy
    BATCH = 1,          //Send Data When Start
}ReportPolicy;

@interface UMSAgent : NSObject<UIAlertViewDelegate>
{
    
}

+ (void)startWithAppkey:(NSString *)appKey;
+ (void)startWithAppkey:(NSString *)appKey reportPolicy:(ReportPolicy)rp channelId:(NSString *)cid;

+(void)bindUserIdentifier:(NSString *)userid;

+(void)startTracPage:(NSString*)page_name;
+(void)endTracPage:(NSString*)page_name;

//等同于 event:eventId label:eventId;
+ (void)event:(NSString *)eventId;
+ (void)event:(NSString *)eventId label:(NSString *)label;
+ (void)event:(NSString *)eventId acc:(NSInteger)accumulation;
+ (void)event:(NSString *)eventId label:(NSString *)label acc:(NSInteger)accumulation;

+(void)checkUpdate;



+ (void)setIsLogEnabled:(BOOL)isLogEnabled;
+ (void)setCrashReportEnabled:(BOOL)value;

+ (BOOL)isJailbroken;
+ (NSString*)getUMSUDID;

@end