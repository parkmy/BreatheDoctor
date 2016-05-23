//
//  KLRegistModel.h
//  BreatheDoctor
//
//  Created by comv on 16/5/18.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  注册输入框类型
 */
typedef NS_ENUM(NSInteger,FieldType) {
    /**
     *  默认没验证码
     */
    FieldTypeDef = 0,
    /**
     *  有验证码
     */
    FieldTypeVCode = 1,
};
@interface KLRegistModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *fieldText;
@property (nonatomic, copy) NSString *placeholderString;

@property (nonatomic, assign) FieldType type;
@property (nonatomic, assign) BOOL isSecureTextEntry;
@property (nonatomic, assign) UIKeyboardType keyType;

@property (nonatomic, assign) NSInteger maxCount;

/**
 *  得到初始化模型数据
 */
+ (NSMutableArray *)initializeRegistModels;


+ (NSString *)fieldTextTheIndex:(NSInteger)index withArray:(NSMutableArray *)array;


@end
