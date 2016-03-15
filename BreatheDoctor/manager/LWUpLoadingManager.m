//
//  LWUpLoadingManager.m
//  BreatheDoctor
//
//  Created by comv on 16/1/21.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWUpLoadingManager.h"
#import "NSDate+Extension.h"
#import "LWHttpRequestManager.h"
#import "LWHttpDefine.h"
#import "YRJSONAdapter.h"

@implementation LWUpLoadingManager
/*
#pragma mark 上传图片 语音
+ (void)httpUpLoadData:(NSData *)data
              WithType:(WSChatCellType )type
               success:(void (^)(NSDictionary *dic))success
               failure:(void (^)(NSString * errorMes))failure
{
    
    AFHTTPRequestOperationManager *httpManager = [LWHttpRequestManager httpRequestManager];
    
    NSMutableDictionary *requestParams = [LWHttpRequestManager dic];
    [LWHttpRequestManager addPublicHeaderPost:requestParams];
    //199 测试
    //105 正式
    [requestParams setObject:platCode forKey:@"platCode"];
    [requestParams setObject:[NSDate stringWithDate:[NSDate date] format:@"yyyy-MM-dd HH:mm:ss"] forKey:@"req_num"];
    [httpManager POST:comveeUpload_URL parameters:requestParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:data name:type==2?@"testimage.jpg":@"testaudio.mp3" fileName:type==2?@"testimage.jpg":@"testaudio.mp3" mimeType:type==2?@"image/jpg":@"audio/mp3"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *jsDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        if ([jsDic objectForKey:res_msg]) {
            if ([[[jsDic objectForKey:res_msg] objectForKey:res_code]integerValue] == 0) {
                if (success) {
                    success(jsDic);
                }
            }else
            {
                if (failure) {
                    failure([jsDic[res_msg] objectForKey:res_msg]);
                }
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(@"无法连接到服务器");
        }
    }];
    
}
 */

+(void)startMultiPartUploadTaskWithURL:(NSString *)url
                           imagesArray:(NSArray *)images
                              WithType:(WSChatCellType )type
                      compressionRatio:(float)ratio
                               success:(void (^)(NSMutableArray *models))success
                               failure:(void (^)(NSString * errorMes))failure
{
    if (images.count == 0) {
        failure?failure(@"上传内容没有包含图片"):nil;
        return;
    }    
    
    NSMutableDictionary *requestParams = [LWHttpRequestManager dic];
    [LWHttpRequestManager addPublicHeaderPost:requestParams];
    //199 测试
    //105 正式
    [requestParams setObject:platCode forKey:@"platCode"];
    [requestParams setObject:[NSDate stringWithDate:[NSDate date] format:@"yyyy-MM-dd HH:mm:ss"] forKey:@"req_num"];
    
    NSMutableArray *mutableOperations = [NSMutableArray array];
    for (UIImage *image in images) {
        NSData *imageData;
        if (ratio > 0.0f && ratio < 1.0f) {
            imageData = UIImageJPEGRepresentation(image, ratio);
        }else{
            imageData = UIImageJPEGRepresentation(image, 1.0f);
        }
        
        NSMutableURLRequest *request =  [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:comveeUpload_URL parameters:requestParams constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            [formData appendPartWithFileData:imageData name:type==2?@"testimage.jpg":@"testaudio.mp3" fileName:type==2?@"testimage.jpg":@"testaudio.mp3" mimeType:type==2?@"image/jpg":@"audio/mp3"];
        } error:nil];
        request.timeoutInterval = 15;
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        [mutableOperations addObject:operation];
    }
    NSArray *operations = [AFURLConnectionOperation batchOfRequestOperations:mutableOperations progressBlock:^(NSUInteger numberOfFinishedOperations, NSUInteger totalNumberOfOperations) {
        NSLog(@"%lu of %lu complete", numberOfFinishedOperations, totalNumberOfOperations);
    } completionBlock:^(NSArray *operations) {
        NSMutableArray *array = [NSMutableArray array];
        BOOL isFailur = NO;
        for (AFHTTPRequestOperation *operation in operations)
        {
            NSLog(@"%@",operation.error);
            if (operation.error) {
                isFailur = YES;
            }else{
                if (!operation.responseObject) {
                    isFailur = YES;
                    return ;
                }
                NSDictionary *jsDic = [NSJSONSerialization JSONObjectWithData:operation.responseObject options:NSJSONReadingAllowFragments error:nil];
                
                NSLog(@"%@",[jsDic JSONString]);

                if ([[[jsDic objectForKey:res_msg] objectForKey:res_code]integerValue] == 0) {
                    [array addObject:jsDic];
                }else
                {
                    if (failure) {
                        failure([jsDic[res_msg] objectForKey:res_msg]);
                    }
                    return ;
                }
            }
        }
        if (isFailur) {
            AFHTTPRequestOperation *oper = (AFHTTPRequestOperation *)operations[0];
            failure(oper.error.domain);
        }
        NSLog(@"All operations in batch complete");
        success?success(array):nil;
    }];
    [[NSOperationQueue mainQueue] addOperations:operations waitUntilFinished:NO];
 
    
}

@end
