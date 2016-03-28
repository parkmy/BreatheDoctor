//
//  KLSymptomsLogModel.m
//  BreatheDoctor
//
//  Created by comv on 16/3/25.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLSymptomsLogModel.h"

@implementation KLSymptomsLogModel

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if([super init]){
        self.iconName = dict[@"imageName"];
        self.titleName = dict[@"titleName"];
        self.count = [[dict objectForKey:@"count"] integerValue];
    }
    return self;
}

@end
