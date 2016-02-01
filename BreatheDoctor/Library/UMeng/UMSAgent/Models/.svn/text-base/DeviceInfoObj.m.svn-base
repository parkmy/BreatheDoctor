//
//  DeviceInfoObj.m
//  DiabetesPatient
//
//  Created by 郑建武 on 15-2-13.
//  Copyright (c) 2015年 com.comvee. All rights reserved.
//

#import "DeviceInfoObj.h"

@implementation DeviceInfoObj

@synthesize deviceid;
@synthesize devicename;
@synthesize isjailbroken;
@synthesize language;
@synthesize mccmnc;
@synthesize modulename;
@synthesize network;
@synthesize os_version;
@synthesize platform;
@synthesize resolution;
@synthesize time;
@synthesize version;
@synthesize userid;
@synthesize loadfrom;

- (void)dealloc
{
    deviceid = nil;
    devicename = nil;
    isjailbroken = nil;
    language = nil;
    mccmnc = nil;
    modulename = nil;
    network = nil;
    platform = nil;
    resolution = nil;
    time = nil;
    version = nil;
    userid = nil;
    loadfrom = nil;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self =[super init]) {
        self.deviceid = [aDecoder decodeObjectForKey:@"deviceid"];
        self.devicename = [aDecoder decodeObjectForKey:@"devicename"];
        self.isjailbroken = [aDecoder decodeObjectForKey:@"isjailbroken"];
        self.language = [aDecoder decodeObjectForKey:@"language"];
        self.mccmnc = [aDecoder decodeObjectForKey:@"mccmnc"];
        self.modulename = [aDecoder decodeObjectForKey:@"modulename"];
        self.network = [aDecoder decodeObjectForKey:@"network"];
        self.os_version = [aDecoder decodeObjectForKey:@"os_version"];
        self.platform = [aDecoder decodeObjectForKey:@"platform"];
        self.resolution = [aDecoder decodeObjectForKey:@"resolution"];
        self.time = [aDecoder decodeObjectForKey:@"time"];
        self.version = [aDecoder decodeObjectForKey:@"version"];
        self.userid = [aDecoder decodeObjectForKey:@"userid"];
        self.loadfrom = [aDecoder decodeObjectForKey:@"loadfrom"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:deviceid forKey:@"deviceid"];
    [aCoder encodeObject:devicename forKey:@"devicename"];
    [aCoder encodeObject:isjailbroken forKey:@"isjailbroken"];
    [aCoder encodeObject:language forKey:@"language"];
    [aCoder encodeObject:mccmnc forKey:@"mccmnc"];
    [aCoder encodeObject:modulename forKey:@"modulename"];
    [aCoder encodeObject:network forKey:@"network"];
    [aCoder encodeObject:os_version forKey:@"os_version"];
    [aCoder encodeObject:platform forKey:@"platform"];
    [aCoder encodeObject:resolution forKey:@"resolution"];
    [aCoder encodeObject:time forKey:@"time"];
    [aCoder encodeObject:version forKey:@"version"];
    [aCoder encodeObject:userid forKey:@"userid"];
    [aCoder encodeObject:loadfrom forKey:@"loadfrom"];
}


@end
