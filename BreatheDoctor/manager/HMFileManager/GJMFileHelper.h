//
//  RYMSettingHelper.h
//  RYM
//
//  Created by 廖维海 on 15/4/24.
//  Copyright (c)2015年 www.cheweiguanjia.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@interface GJMFileHelper : NSObject

#pragma mark - 通用读取和保存函Anywhere数
+ (NSMutableDictionary *)mutableDictionaryFromFile:(NSString *)fileName;
+ (NSMutableArray *)mutableArrayFromFile:(NSString *)fileName;
+ (NSData *)dataWithFileName:(NSString *)fileName;
+ (BOOL)writeToFile:(NSString *)fileName data:(id)data;
+ (BOOL)existsFileWithFileName:(NSString *)fileName;
+ (BOOL)createFile:(NSString *)filePath;
+ (BOOL)removeFile:(NSString *)fileName;
@end
