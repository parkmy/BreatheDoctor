
//
//  KLGoodsImageModel.m
//  BreatheDoctor
//
//  Created by comv on 16/5/6.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLGoodsImageModel.h"
#import <SDImageCache.h>

@implementation KLGoodsImageModel

- (void)setImageUrl:(NSString *)imageUrl{
    
    _imageUrl = imageUrl;
    
    UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:_imageUrl];
    if (image) {
        self.imageSize = [self imageCFsizeWithSize:image.size];
    }else{
        self.imageSize = CGSizeMake(screenWidth, 100);
    }

}
- (CGSize)imageCFsizeWithSize:(CGSize)size{
    
    CGSize cfSzie ;
    cfSzie.width = screenWidth;
    CGFloat sp = (size.width/size.height);
    cfSzie.height =  cfSzie.width/sp;
    return cfSzie;
}
@end
