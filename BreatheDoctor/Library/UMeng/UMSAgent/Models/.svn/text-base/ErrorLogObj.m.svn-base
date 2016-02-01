//
//  ErrorLogObj.m
//  DiabetesPatient
//
//  Created by 郑建武 on 15-2-27.
//  Copyright (c) 2015年 com.comvee. All rights reserved.
//

#import "ErrorLogObj.h"

@implementation ErrorLogObj


@synthesize time;
@synthesize stackTrace;
@synthesize version;


- (void)dealloc
{
    time = nil;
    stackTrace = nil;
    version = nil;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self =[super init]) {
        self.time = [aDecoder decodeObjectForKey:@"time"];
        self.stackTrace = [aDecoder decodeObjectForKey:@"stackTrace"];
        self.version = [aDecoder decodeObjectForKey:@"version"];
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:time forKey:@"time"];
    [aCoder encodeObject:stackTrace forKey:@"stackTrace"];
    [aCoder encodeObject:version forKey:@"version"];
}


@end
