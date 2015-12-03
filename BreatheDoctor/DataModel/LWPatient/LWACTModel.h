//
//  LWACTModel.h
//
//  Created by   on 15/11/24
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LWACTModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *insertDt;
@property (nonatomic, assign) double act5;
@property (nonatomic, assign) NSInteger actResult;
@property (nonatomic, assign) double act3;
@property (nonatomic, strong) NSString *actId;
@property (nonatomic, assign) double act1;
@property (nonatomic, strong) NSString *assessDt;
@property (nonatomic, assign) double actType;
@property (nonatomic, assign) double act4;
@property (nonatomic, assign) double grade;
@property (nonatomic, strong) NSString *patientId;
@property (nonatomic, assign) double act2;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
