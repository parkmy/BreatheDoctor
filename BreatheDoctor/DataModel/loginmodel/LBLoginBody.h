//
//  LBLoginBody.h
//
//  Created by   on 15/11/6
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LBLoginBody : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *qrcodePath;
@property (nonatomic, strong) NSString *perName;
@property (nonatomic, strong) NSString *position;
@property (nonatomic, strong) NSString *qrcodeId;
@property (nonatomic, strong) NSString *perRealPhotoS;
@property (nonatomic, strong) NSString *perRealPhoto;
@property (nonatomic, strong) NSString *hospitalNameText;
@property (nonatomic, strong) NSString *doctorId;
@property (nonatomic, strong) NSString *hospitalName;
@property (nonatomic, strong) NSString *departmentNameText;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *birthday;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *positionText;
@property (nonatomic, strong) NSString *signature;
@property (nonatomic, strong) NSString *perSpacil;
@property (nonatomic, assign) double perSex;
@property (nonatomic, strong) NSString *departmentName;
@property (nonatomic, copy) NSString *CheckStatus;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
