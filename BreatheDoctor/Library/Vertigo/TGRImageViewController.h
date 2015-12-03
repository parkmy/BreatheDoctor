// TGRImageViewController.h
//  base
// Copyright (c) 2015 Guillermo Gonzalez
//


#import <UIKit/UIKit.h>


@interface TGRImageViewController : UIViewController

// The scroll view used for zooming.
@property (strong, nonatomic) UIScrollView *scrollView;

// The image view that displays the image.
@property (strong, nonatomic) UIImageView *imageView;

// The image that will be shown.
@property (strong, nonatomic, readonly) UIImage *image;

// Initializes the receiver with the specified image.
- (id)initWithImage:(UIImage *)image;

@end
