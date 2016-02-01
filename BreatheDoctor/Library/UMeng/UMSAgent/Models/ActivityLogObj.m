//
//  ActivityLogObj.m
//  DiabetesPatient
//
//  Created by 郑建武 on 15-2-13.
//  Copyright (c) 2015年 com.comvee. All rights reserved.
//

#import "ActivityLogObj.h"

@implementation ActivityLogObj

@synthesize sessionId;
@synthesize startMils;
@synthesize endMils;
@synthesize duration;
@synthesize activity;
@synthesize version;

- (void)dealloc
{
    sessionId = nil;
    startMils = nil;
    endMils = nil;
    duration = nil;
    activity = nil;
    version = nil;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self =[super init]) {
        self.sessionId = [aDecoder decodeObjectForKey:@"sessionId"];
        self.startMils = [aDecoder decodeObjectForKey:@"startMils"];
        self.endMils = [aDecoder decodeObjectForKey:@"endMils"];
        self.duration = [aDecoder decodeObjectForKey:@"duration"];
        self.activity = [aDecoder decodeObjectForKey:@"activity"];
        self.version = [aDecoder decodeObjectForKey:@"version"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:sessionId forKey:@"sessionId"];
    [aCoder encodeObject:startMils forKey:@"startMils"];
    [aCoder encodeObject:endMils forKey:@"endMils"];
    [aCoder encodeObject:duration forKey:@"duration"];
    [aCoder encodeObject:activity forKey:@"activity"];
    [aCoder encodeObject:version forKey:@"version"];
}


@end
