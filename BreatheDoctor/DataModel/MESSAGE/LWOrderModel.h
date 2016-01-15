//
//  LWOrderModel.h
//
//  Created by   on 16/1/6
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LWOrderModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double quantity;
@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, strong) NSString *fullName;
@property (nonatomic, strong) NSString *createDt;
@property (nonatomic, strong) NSString *patientName;

@property (nonatomic, assign) long long buyPeopleNum;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
