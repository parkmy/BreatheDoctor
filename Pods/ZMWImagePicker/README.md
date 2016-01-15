# ZMWImagePicker
类似微信选照片（根据需要修改了些）

用法：
在用的时候添加 #import "DNImagePickerController.h"

#pragma mark - 选图片的方法
- (void)buttonAction:(id)sender
{
DNImagePickerController *imagePicker = [[DNImagePickerController alloc] init];
imagePicker.imagePickerDelegate = self;
[self presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark - DNImagePickerControllerDelegate----返回的代理。

- (void)dnImagePickerController:(DNImagePickerController *)imagePickerController sendImages:(NSArray *)imageAssets isFullImage:(BOOL)fullImage imageArray:(NSArray *)imageArray
{
    NSLog(@"imageArray======%@  /n    fullImage===%d",imageArray,fullImage);
}

- (void)dnImagePickerControllerDidCancel:(DNImagePickerController *)imagePicker
{
    [imagePicker dismissViewControllerAnimated:YES completion:^{

    }];
}

