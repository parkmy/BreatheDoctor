//
//  KLImagePickerManager.m
//  BreatheDoctor
//
//  Created by comv on 16/4/28.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLImagePickerManager.h"

@interface KLImagePickerManager ()

@property (nonatomic ,copy) DidSeleImageBlock  didSeleImageBlock;

@end

@implementation KLImagePickerManager

+ (KLImagePickerManager *)shareInstance{

    static dispatch_once_t onceToken;
    static KLImagePickerManager *manager = nil;
    dispatch_once(&onceToken, ^{
        manager = [[KLImagePickerManager alloc] init];
    });
    return manager;
}

#pragma mark-------------------相册
- (void)photoLibraryTheNav:(UINavigationController *)nav
                 succBlock:(DidSeleImageBlock)imageBlock
{
    self.didSeleImageBlock = nil;
    self.didSeleImageBlock = imageBlock;
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.navigationBar.barTintColor = [LWThemeManager shareInstance].navBackgroundColor;
        [picker.navigationBar setTintColor:[UIColor whiteColor]];
//        picker.view.backgroundColor = [LWThemeManager shareInstance].navBackgroundColor;
        //        [controls.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        //        [controls.navigationBar  setShadowImage:[UIImage new]];
        picker.edgesForExtendedLayout = UIRectEdgeNone;
        
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate = self;
        
        [nav presentViewController:picker animated:YES completion:^
         {
             [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
             
         }];
    }
    
}
#pragma mark------------------拍照
- (void)cameraTheNav:(UINavigationController *)nav
           succBlock:(DidSeleImageBlock)imageBlock
{
    self.didSeleImageBlock = nil;
    self.didSeleImageBlock = imageBlock;
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        
        UIImagePickerController *controls = [[UIImagePickerController alloc]init];
        controls.sourceType = UIImagePickerControllerSourceTypeCamera;
        controls.delegate = self;
        
        [nav presentViewController:controls animated:YES completion:^{
            
        }];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"很抱歉，您的设备不支持摄像头,是否设置？" delegate:self cancelButtonTitle:@"是" otherButtonTitles:@"否", nil];
        [alert show];   
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        NSURL *url = [NSURL URLWithString:@"prefs:root=General"];
        if ([[UIApplication sharedApplication] canOpenURL:url])
        {
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}

//相册、拍照取消
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:NO completion:
     ^{
         [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
         
     }];
}
//图片缩放
- (UIImage *)resetSizeOfImage:(UIImage*)source_image
{
    CGSize newSize;
    newSize = CGSizeMake(source_image.size.width, source_image.size.height);
    if (source_image.size.width>960) {
        newSize = CGSizeMake(source_image.size.width*0.5, source_image.size.height*0.5);
    }
    UIGraphicsBeginImageContext(newSize);
    [source_image drawInRect : CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
    if ([navigationController isKindOfClass:[UIImagePickerController class]])
    {
        viewController.navigationController.navigationBar.translucent = NO;
        viewController.edgesForExtendedLayout = UIRectEdgeNone;
    }
}
//图片转换数据data上传
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    
    
    UIImage *scale_image=[self resetSizeOfImage:image];
    NSData *imageData=nil;
    imageData = UIImageJPEGRepresentation(scale_image, 0.5);
    
    self.didSeleImageBlock?self.didSeleImageBlock(imageData):nil;
    
    [picker dismissViewControllerAnimated:NO completion:
     ^{
         [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
     }];
}


@end
