//
//  EventInfoObj.m
//  DiabetesPatient
//
//  Created by 郑建武 on 15-2-27.
//  Copyright (c) 2015年 com.comvee. All rights reserved.
//

#import "EventInfoObj.h"

@implementation EventInfoObj

@synthesize event_id;
@synthesize time;
@synthesize acc;
@synthesize label;
@synthesize version;
@synthesize startMils;
@synthesize duration;

- (void)dealloc
{
    event_id = nil;
    time = nil;
    label = nil;
    version = nil;
    startMils = nil;
    duration = nil;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self =[super init]) {
        self.event_id = [aDecoder decodeObjectForKey:@"event_id"];
        self.label = [aDecoder decodeObjectForKey:@"label"];
        self.time = [aDecoder decodeObjectForKey:@"time"];
        self.acc = [aDecoder decodeInt32ForKey:@"acc"];
        self.version = [aDecoder decodeObjectForKey:@"version"];
        
        self.startMils = [aDecoder decodeObjectForKey:@"startMils"];
        self.duration = [aDecoder decodeObjectForKey:@"duration"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:event_id forKey:@"event_id"];
    [aCoder encodeObject:label forKey:@"label"];
    [aCoder encodeObject:time forKey:@"time"];
    [aCoder encodeObject:version forKey:@"version"];
    [aCoder encodeInt:acc forKey:@"acc"];
    [aCoder encodeObject:startMils forKey:@"startMils"];
    [aCoder encodeInt:duration forKey:@"duration"];
}

@end
