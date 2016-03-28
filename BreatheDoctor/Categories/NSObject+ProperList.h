//
//  NSObject+ProperList.h
//  BreatheDoctor
//
//  Created by comv on 16/3/26.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ProperList)

/* 获取对象的所有属性，不包括属性值 */
- (NSArray *)getAllProperties;
/* 获取对象的所有属性 以及属性值 */
- (NSDictionary *)properties_aps;

@end
