//
//  KLGoodsImageModel.h
//  BreatheDoctor
//
//  Created by comv on 16/5/6.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KLGoodsImageModel : NSObject

@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, assign) CGSize    imageSize;

- (CGSize)imageCFsizeWithSize:(CGSize)size;

@end
