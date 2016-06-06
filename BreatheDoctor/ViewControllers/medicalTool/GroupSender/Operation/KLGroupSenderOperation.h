//
//  KLGroupSenderOperation.h
//  BreatheDoctor
//
//  Created by comv on 16/4/26.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KLGroupSenderOperation : NSObject
/**
 *  得到群发患者的列表名字
 */
+ (NSString *)getGroupSenderListStringWithPatientArray:(NSMutableArray *)array;

/**
 *  得到商品价格字符串
*/
+ (NSAttributedString *)getGoodsPriceLabeString:(NSString *)string;

+ (NSMutableArray *)goodsImageUrlListWithList:(NSArray *)list;

+ (NSString *)priceFloatEqlistThePrice:(NSString *)price;

+ (CGSize)imageCFsizeWithSize:(CGSize)size;

@end
