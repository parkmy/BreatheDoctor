//
//  KLImagePickerManager.h
//  BreatheDoctor
//
//  Created by comv on 16/4/28.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^DidSeleImageBlock)(NSData *imageData);

@interface KLImagePickerManager : NSObject<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

+ (KLImagePickerManager *)shareInstance;

- (void)photoLibraryTheNav:(UINavigationController *)nav
                succBlock:(DidSeleImageBlock)imageBlock;


- (void)cameraTheNav:(UINavigationController *)nav
                succBlock:(DidSeleImageBlock)imageBlock;
@end
