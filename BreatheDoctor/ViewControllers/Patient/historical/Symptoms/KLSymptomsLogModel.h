//
//  KLSymptomsLogModel.h
//  BreatheDoctor
//
//  Created by comv on 16/3/25.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KLSymptomsLogModel : NSObject

@property (nonatomic, copy) NSString *iconName;
@property (nonatomic, copy) NSString *titleName;
@property (nonatomic, assign) NSInteger count;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
