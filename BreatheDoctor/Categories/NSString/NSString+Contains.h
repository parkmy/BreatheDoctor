//
//  NSString+Contains.h
//  iOS-Categories (https://github.com/shaojiankui/iOS-Categories)
//
//  Created by 符现超 on 15/5/9.
//  Copyright (c) 2015年 http://weibo.com/u/1655766025 All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Contains)

/**
 *  处理空字符串
 *
 *  @param string 判断的字段
 *
 *  @return 返回新的字符串
 */
+ (NSString *)stringJudgeNullInfoString:(NSString *)string;

/**
 *  @brief  判断URL中是否包含中文
 *
 *  @return 是否包含中文
 */
- (BOOL)isContainChinese;
/**
 *  @brief  是否包含空格
 *
 *  @return 是否包含空格
 */
- (BOOL)isContainBlank;

/**
 *  @brief  Unicode编码的字符串转成NSString
 *
 *  @return Unicode编码的字符串转成NSString
 */
- (NSString *)makeUnicodeToString;

- (BOOL)containsCharacterSet:(NSCharacterSet *)set;
/**
 *  @brief 是否包含字符串
 *
 *  @param string 字符串
 *
 *  @return YES, 包含;
 */
- (BOOL)containsaString:(NSString *)string;
/**
 *  @brief 获取字符数量
 */
- (int)wordsCount;

+ (NSString *)appVersion;

+ (NSString*)getSendMessageReqNum;//6位随机数

@end
