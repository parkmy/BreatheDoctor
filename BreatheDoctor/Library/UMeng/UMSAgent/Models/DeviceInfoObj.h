//
//  DeviceInfoObj.h
//  DiabetesPatient
//
//  Created by 郑建武 on 15-2-13.
//  Copyright (c) 2015年 com.comvee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceInfoObj : NSObject<NSCoding>

@property (nonatomic,retain) NSString *platform;            //操作系统名称
@property (nonatomic,retain) NSString *os_version;          //操作系统版本
@property (nonatomic,retain) NSString *language;            //语言
@property (nonatomic,retain) NSString *resolution;          //分
@property (nonatomic,retain) NSString *deviceid;            //设备ID
@property (nonatomic,retain) NSString *mccmnc;              //所属国家代码及网络识别码
@property (nonatomic,retain) NSString *version;             //软件版本号
@property (nonatomic,retain) NSString *network;             //网络标识，WIFI或者是2G/3G
@property (nonatomic,retain) NSString *devicename;          //设备名称
@property (nonatomic,retain) NSString *modulename;          //模块名称
@property (nonatomic,retain) NSString *time;                //yyyy-MM-dd HH:mm:ss
@property (nonatomic,retain) NSString *isjailbroken;        //是否越狱
@property (nonatomic,retain) NSString *loadfrom;            //渠道来源
@property (nonatomic,retain) NSString *userid;              //用户ID

@end
