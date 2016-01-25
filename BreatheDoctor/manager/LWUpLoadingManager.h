//
//  LWUpLoadingManager.h
//  BreatheDoctor
//
//  Created by comv on 16/1/21.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LWUpLoadingManager : NSObject

/**
 *  上传带图片的内容，允许多张图片上传（URL）POST
 *
 *  @param url                 网络请求地址
 *  @param images              要上传的图片数组（注意数组内容需是图片）
 *  @param ratio               图片的压缩比例（0.0~1.0之间）
 *  @param succeedBlock        成功的回调
 *  @param failedBlock         失败的回调
 *  @param uploadProgressBlock 上传进度的回调
 */
+(void)startMultiPartUploadTaskWithURL:(NSString *)url
                           imagesArray:(NSArray *)images
                              WithType:(WSChatCellType )type
                      compressionRatio:(float)ratio
                               success:(void (^)(NSMutableArray *models))success
                               failure:(void (^)(NSString * errorMes))failure;

@end
