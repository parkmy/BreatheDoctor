// TGRImageZoomTransition.m
//
// Copyright (c) 2015 Guillermo Gonzalez
//


#import "TGRImageViewController.h"

@interface TGRImageViewController ()<UIScrollViewDelegate>

@property (strong, nonatomic) UITapGestureRecognizer *singleTapGestureRecognizer;
@property (strong, nonatomic) UITapGestureRecognizer *doubleTapGestureRecognizer;

@end

@implementation TGRImageViewController

- (id)initWithImage:(UIImage *)image {
    if (self = [super init]) {
        _image = image;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_scrollView];
    _scrollView.delegate = self;
    _scrollView.userInteractionEnabled = YES;
    _scrollView.minimumZoomScale = 1;
    _scrollView.maximumZoomScale = 2;
//    _scrollView.showsVerticalScrollIndicator = NO;
//    _scrollView.showsHorizontalScrollIndicator = NO;
    //设置UIScrollView的滚动范围和图片的真实尺寸一致
//    _scrollView.contentSize=self.image.size;
    _imageView = [[UIImageView alloc] initWithFrame:self.scrollView.bounds];
//    _imageView.center = CGPointMake(_scrollView.contentSize.width/2, _scrollView.contentSize.height/2);
    _imageView.userInteractionEnabled = YES;
    [_scrollView addSubview:_imageView];
    
    _singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        _doubleTapGestureRecognizer.numberOfTapsRequired = 1;
    [_imageView addGestureRecognizer:_singleTapGestureRecognizer];
    _doubleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    _doubleTapGestureRecognizer.numberOfTapsRequired = 2;
    [_imageView addGestureRecognizer:_doubleTapGestureRecognizer];
    
    [self.singleTapGestureRecognizer requireGestureRecognizerToFail:self.doubleTapGestureRecognizer];
    self.imageView.image = self.image;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - UIScrollViewDelegate methods

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

#pragma mark - Private methods

- (void)handleSingleTap:(UITapGestureRecognizer *)tapGestureRecognizer {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)handleDoubleTap:(UITapGestureRecognizer *)tapGestureRecognizer {
    if (self.scrollView.zoomScale == self.scrollView.minimumZoomScale) {
        // Zoom in
        CGPoint center = [tapGestureRecognizer locationInView:self.scrollView];
        CGSize size = CGSizeMake(self.scrollView.bounds.size.width / self.scrollView.maximumZoomScale,
                                 self.scrollView.bounds.size.height / self.scrollView.maximumZoomScale);
        CGRect rect = CGRectMake(center.x - (size.width / 2.0), center.y - (size.height / 2.0), size.width, size.height);
        [self.scrollView zoomToRect:rect animated:YES];
    }
    else {
        // Zoom out
        [self.scrollView zoomToRect:self.scrollView.bounds animated:YES];
    }
}

@end
