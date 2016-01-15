//
//  LWDoctorTimerModel.h
//
//  Created by   on 16/1/14
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LWDoctorTimerModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, strong) NSString *sid;
@property (nonatomic, strong) NSString *repeatWeek;
@property (nonatomic, strong) NSString *endTime;
@property (nonatomic, strong) NSString *doctorId;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;
+ (instancetype)getInitModel;

@end
