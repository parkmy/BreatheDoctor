//
//  RYMSettingHelper.m
//  RYM
//
//  Created by 廖维海 on 15/4/24.
//  Copyright (c)2015年 www.cheweiguanjia.com. All rights reserved.
//

#import "GJMFileHelper.h"

@implementation GJMFileHelper

#pragma mark - 通用读取保存函数

/**
 *  将字典或者数组写入到指定文件中
 *
 *  @param fileName 文件名称（不包含路径，有默认路径）
 *  @param data     数据，字典或者数组
 *
 *  @return 成功标志
 */
+ (BOOL)writeToFile:(NSString *)fileName data:(id)data
{

    NSString * documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * path = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", fileName]];
    
    return [data writeToFile:path atomically:YES];
}


+ (BOOL)existsFileWithFileName:(NSString *)fileName
{
    NSString * documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * path = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", fileName]];
    
    return [[NSFileManager defaultManager] fileExistsAtPath:path];

}

/**
 *  从文件中读取一个可变数组
 *
 *  @param fileName 文件名
 *
 *  @return 可变数组
 */
+ (NSMutableArray *)mutableArrayFromFile:(NSString *)fileName
{
    NSString * documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * path = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", fileName]];
    NSMutableArray * d = [NSMutableArray arrayWithContentsOfFile:path];
    return d ? d : [NSMutableArray array];
}

+ (NSData *)dataWithFileName:(NSString *)fileName
{
    NSString * documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * path = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", fileName]];
    return [NSData dataWithContentsOfFile:path];
    
}

/**
 *  从文件中读取一个可变字典
 *
 *  @param fileName 文件名
 *
 *  @return 可变字典
 */
+ (NSMutableDictionary *)mutableDictionaryFromFile:(NSString *)fileName
{
    NSString * documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * path = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", fileName]];
    return [NSMutableDictionary dictionaryWithContentsOfFile:path];
}

+ (BOOL)createFile:(NSString *)fileName
{
    NSString * documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * path = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", fileName]];
    return [@"hello world" writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

+ (BOOL)removeFile:(NSString *)fileName
{
    NSString * documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * path = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", fileName]];
    return [[NSFileManager defaultManager]removeItemAtPath:path error:nil];
}


@end
