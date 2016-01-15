//
//  DNImageFlowViewController.m
//  ImagePicker
//
//  Created by DingXiao on 15/2/11.
//  Copyright (c) 2015年 Dennis. All rights reserved.
//

#import "DNImageFlowViewController.h"
#import "DNImagePickerController.h"
#import "DNPhotoBrowser.h"
#import "UIViewController+DNImagePicker.h"
#import "UIView+DNImagePicker.h"
#import "UIColor+Hex.h"
#import "DNAssetsViewCell.h"
#import "DNSendButton.h"
#import "DNAsset.h"
#import "NSURL+DNIMagePickerUrlEqual.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "UIColor+Hex.h"


static NSUInteger const kDNImageFlowMaxSeletedNumber = 9;

@interface DNImageFlowViewController () <UICollectionViewDataSource, UICollectionViewDelegate, DNAssetsViewCellDelegate, DNPhotoBrowserDelegate>

@property (nonatomic, strong) NSURL *assetsGroupURL;
@property (nonatomic, strong) ALAssetsLibrary *assetsLibrary;
@property (nonatomic, strong) ALAssetsGroup *assetsGroup;

@property (nonatomic, strong) UICollectionView *imageFlowCollectionView;
@property (nonatomic, strong) DNSendButton *sendButton;


@property (nonatomic, strong) NSMutableArray *assetsArray;
@property (nonatomic, strong) NSMutableArray *selectedAssetsArray;

@property (nonatomic, assign) BOOL isFullImage;

@property (nonatomic, strong) UIImage *takePhoteImage;  ///拍照完的图片。
@property (nonatomic, strong) NSMutableArray    *imageArray;    ///拍照的和选取的图片的数组。

@end

static NSString* const dnAssetsViewCellReuseIdentifier = @"DNAssetsViewCell";

@implementation DNImageFlowViewController

- (instancetype)initWithGroupURL:(NSURL *)assetsGroupURL
{
    self = [super init];
    if (self) {
        _assetsArray = [NSMutableArray new];
        _selectedAssetsArray = [NSMutableArray new];
        _assetsGroupURL = assetsGroupURL;
        _assetsLibrary = [[ALAssetsLibrary alloc] init];
        _imageArray = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self setupData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.toolbarHidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.toolbarHidden = YES;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - setup view and data
- (void)setupData
{
    [_assetsLibrary groupForURL:self.assetsGroupURL resultBlock:^(ALAssetsGroup *assetsGroup){
        self.assetsGroup = assetsGroup;
        if (self.assetsGroup) {
            self.title =[self.assetsGroup valueForProperty:ALAssetsGroupPropertyName];
            [self loadData];
        }
        
    } failureBlock:^(NSError *error){
        //            NSLog(@"%@",error.description);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tips" message:error.description delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
}


- (void)setupView
{
    self.view.backgroundColor = [UIColor hexStringToColor:@"#9cc75e"];
    
//    self.navigationController.navigationBar.backgroundColor = [UIColor hexStringToColor:@"#9cc75e"];

    [self createBarButtonItemAtPosition:DNImagePickerNavigationBarPositionLeft
                      statusNormalImage:[UIImage imageNamed:@"nav_btnBack.png"]
                   statusHighlightImage:[UIImage imageNamed:@"nav_btnBack.png"]
                                 action:@selector(backButtonAction)];
    [self createBarButtonItemAtPosition:DNImagePickerNavigationBarPositionRight
                                   text:@"取消"
                                 action:@selector(cancelAction)];
    
    [self imageFlowCollectionView];
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"预览" style:UIBarButtonItemStylePlain target:self action:@selector(previewAction)];
    [item1 setTintColor:[UIColor blackColor]];
    item1.enabled = NO;
    
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *item3 = [[UIBarButtonItem alloc] initWithCustomView:self.sendButton];
    
    UIBarButtonItem *item4 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    item4.width = -10;
    
    [self setToolbarItems:@[item1,item2,item3,item4] animated:NO];
}

- (void)loadData
{
    [self.assetsGroup setAssetsFilter:ALAssetsFilterFromDNImagePickerControllerFilterType([[self dnImagePickerController] filterType])];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.assetsGroup enumerateAssetsWithOptions:NSEnumerationReverse usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            if (result) {
                [self.assetsArray insertObject:result atIndex:0];
            }
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.imageFlowCollectionView reloadData];
            [self scrollerToBottom:NO];
        });
    });
}

#pragma mark - helpmethods
- (void)scrollerToBottom:(BOOL)animated
{
    NSInteger rows = [self.imageFlowCollectionView numberOfItemsInSection:0] - 1;
    [self.imageFlowCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:rows inSection:0] atScrollPosition:UICollectionViewScrollPositionBottom animated:animated];
}

- (DNImagePickerController *)dnImagePickerController
{
    
    if (nil == self.navigationController
        ||
        NO == [self.navigationController isKindOfClass:[DNImagePickerController class]])
    {
        NSAssert(false, @"check the navigation controller");
    }
    return (DNImagePickerController *)self.navigationController;
}

- (BOOL)assetIsSelected:(ALAsset *)targetAsset
{
    for (ALAsset *asset in self.selectedAssetsArray) {
        NSURL *assetURL = [asset valueForProperty:ALAssetPropertyAssetURL];
        NSURL *targetAssetURL = [targetAsset valueForProperty:ALAssetPropertyAssetURL];
        if ([assetURL isEqualToOther:targetAssetURL]) {
            return YES;
        }
    }
    return NO;
}

- (void)removeAssetsObject:(ALAsset *)asset
{
    if ([self assetIsSelected:asset]) {
        [self.selectedAssetsArray removeObject:asset];
    }
}

- (void)addAssetsObject:(ALAsset *)asset
{
    [self.selectedAssetsArray addObject:asset];
}

- (DNAsset *)dnassetFromALAsset:(ALAsset *)ALAsset
{
    DNAsset *asset = [[DNAsset alloc] init];
    asset.url = [ALAsset valueForProperty:ALAssetPropertyAssetURL];
    return asset;
}

- (NSArray *)seletedDNAssetArray
{
    NSMutableArray *seletedArray = [NSMutableArray new];
    for (ALAsset *asset in self.selectedAssetsArray) {
        DNAsset *dnasset = [self dnassetFromALAsset:asset];
        dnasset.asset = asset;
        [seletedArray addObject:dnasset];
    }
    return seletedArray;
}

#pragma mark - priviate methods
- (void)sendImages
{
    NSString *properyID = [self.assetsGroup valueForProperty:ALAssetsGroupPropertyPersistentID];
    [[NSUserDefaults standardUserDefaults] setObject:properyID forKey:kDNImagePickerStoredGroupKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
//    NSMutableArray *imageArray = [NSMutableArray array];
    for (int i = 0; i < [[self selectedAssetsArray]count]; ++i) {
        ALAsset *asset = [[self selectedAssetsArray]objectAtIndex:i];
        UIImage *image = [UIImage imageWithCGImage:asset.thumbnail];
        [self.imageArray addObject:image];
    }
//    NSLog(@"选中的imagearray ====== %@",imageArray);

    DNImagePickerController *imagePicker = [self dnImagePickerController];
    if (imagePicker && [imagePicker.imagePickerDelegate respondsToSelector:@selector(dnImagePickerController:sendImages:isFullImage:imageArray:)]) {
        [imagePicker.imagePickerDelegate dnImagePickerController:imagePicker sendImages:[self seletedDNAssetArray] isFullImage:self.isFullImage imageArray:self.imageArray];
    }
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];}

- (void)browserPhotoAsstes:(NSArray *)assets pageIndex:(NSInteger)page
{
    DNPhotoBrowser *browser = [[DNPhotoBrowser alloc] initWithPhotos:assets
                                                        currentIndex:page
                                                           fullImage:self.isFullImage];
    browser.delegate = self;
    browser.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:browser animated:YES];
}

- (BOOL)seletedAssets:(ALAsset *)asset
{
    if ([self assetIsSelected:asset]) {
        return NO;
    }
    UIBarButtonItem *firstItem = self.toolbarItems.firstObject;
    firstItem.enabled = YES;
//    ／／@"请在iPhone的\"设置-隐私-照片\"选项中，\n允许访问你的手机相册"
    if (self.selectedAssetsArray.count >= kDNImageFlowMaxSeletedNumber) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"一次不能超过9张图片！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alert show];
        
        return NO;
    }else
    {
        [self addAssetsObject:asset];
        self.sendButton.badgeValue = [NSString stringWithFormat:@"%lu",(unsigned long)self.selectedAssetsArray.count];
        return YES;
    }
}

- (void)deseletedAssets:(ALAsset *)asset
{
    [self removeAssetsObject:asset];
    self.sendButton.badgeValue = [NSString stringWithFormat:@"%lu",(unsigned long)self.selectedAssetsArray.count];
    if (self.selectedAssetsArray.count < 1) {
        UIBarButtonItem *firstItem = self.toolbarItems.firstObject;
        firstItem.enabled = NO;
    }
}

#pragma mark - getter/setter
- (ALAssetsLibrary *)assetsLibrary
{
    if (nil == _assetsLibrary) {
        _assetsLibrary = [[ALAssetsLibrary alloc] init];
    }
    return _assetsLibrary;
}

- (UICollectionView *)imageFlowCollectionView
{
    if (nil == _imageFlowCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 2.0;
        layout.minimumInteritemSpacing = 2.0;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _imageFlowCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:layout];
        _imageFlowCollectionView.backgroundColor = [UIColor clearColor];
        [_imageFlowCollectionView registerClass:[DNAssetsViewCell class] forCellWithReuseIdentifier:dnAssetsViewCellReuseIdentifier];
        
        _imageFlowCollectionView.alwaysBounceVertical = YES;
        _imageFlowCollectionView.delegate = self;
        _imageFlowCollectionView.dataSource = self;
        _imageFlowCollectionView.showsHorizontalScrollIndicator = YES;
        [self.view addSubview:_imageFlowCollectionView];
    }
    
    return _imageFlowCollectionView;
}

- (DNSendButton *)sendButton
{
    if (nil == _sendButton) {
        _sendButton = [[DNSendButton alloc] initWithFrame:CGRectZero];
        [_sendButton addTaget:self action:@selector(sendButtonAction:)];
    }
    return  _sendButton;
}

#pragma mark - ui action
- (void)backButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)sendButtonAction:(id)sender
{
    if (self.selectedAssetsArray.count > 0) {
        [self sendImages];
    }
}

- (void)previewAction
{
    [self browserPhotoAsstes:self.selectedAssetsArray pageIndex:0];
}

- (void)cancelAction
{
    DNImagePickerController *navController = [self dnImagePickerController];
    if (navController && [navController.imagePickerDelegate respondsToSelector:@selector(dnImagePickerControllerDidCancel:)]) {
        [navController.imagePickerDelegate dnImagePickerControllerDidCancel:navController];
    }
}

#pragma mark - DNAssetsViewCellDelegate
- (void)didSelectItemAssetsViewCell:(DNAssetsViewCell *)assetsCell
{
    assetsCell.isSelected = [self seletedAssets:assetsCell.asset];
}

- (void)didDeselectItemAssetsViewCell:(DNAssetsViewCell *)assetsCell
{
    assetsCell.isSelected = NO;
    [self deseletedAssets:assetsCell.asset];
}

#pragma mark - UICollectionView delegate and Datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.assetsArray.count + 1; //增加了个拍照的。。。
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DNAssetsViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:dnAssetsViewCellReuseIdentifier forIndexPath:indexPath];
    if (indexPath.row == 0) {
//        [cell fillWithAsset:nil isSelected:NO row:(int)indexPath.row];
        [cell fillWithAsset:nil isSelected:nil row:(int)indexPath.row image:self.takePhoteImage];
    }else{
        ALAsset *asset = self.assetsArray[indexPath.row - 1];
        cell.delegate = self;
        //    [cell fillWithAsset:asset isSelected:[self assetIsSelected:asset]];
        [cell fillWithAsset:asset isSelected:[self assetIsSelected:asset] row:(int)indexPath.row];
    }


    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {///拍照。
        NSLog(@"拍照。。。");
        [self takePhotoAction];
        return;
    }
    //照片浏览器。
    [self browserPhotoAsstes:self.assetsArray pageIndex:indexPath.row - 1];
}

#define kSizeThumbnailCollectionView  ([UIScreen mainScreen].bounds.size.width-10)/4
#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeMake(kSizeThumbnailCollectionView, kSizeThumbnailCollectionView);
    return size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(2, 2, 2, 2);
}

#pragma mark - DNPhotoBrowserDelegate
- (void)sendImagesFromPhotobrowser:(DNPhotoBrowser *)photoBrowser currentAsset:(ALAsset *)asset
{
    if (self.selectedAssetsArray.count <= 0) {
        [self seletedAssets:asset];
        [self.imageFlowCollectionView reloadData];
    }
    [self sendImages];
}

- (NSUInteger)seletedPhotosNumberInPhotoBrowser:(DNPhotoBrowser *)photoBrowser
{
    return self.selectedAssetsArray.count;
}

- (BOOL)photoBrowser:(DNPhotoBrowser *)photoBrowser currentPhotoAssetIsSeleted:(ALAsset *)asset{
    return [self assetIsSelected:asset];
}

- (BOOL)photoBrowser:(DNPhotoBrowser *)photoBrowser seletedAsset:(ALAsset *)asset
{
    BOOL seleted = [self seletedAssets:asset];
    [self.imageFlowCollectionView reloadData];
    return seleted;
}

- (void)photoBrowser:(DNPhotoBrowser *)photoBrowser deseletedAsset:(ALAsset *)asset
{
    [self deseletedAssets:asset];
    [self.imageFlowCollectionView reloadData];
}

- (void)photoBrowser:(DNPhotoBrowser *)photoBrowser seleteFullImage:(BOOL)fullImage
{
    self.isFullImage = fullImage;
}

#pragma mark - 自己添加拍照的方法
-(void)takePhotoAction {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.delegate = self;
//    picker.navigationBar.barTintColor = self.fromController.navigationController.navigationBar.barTintColor;
    // 设置导航默认标题的颜色及字体大小
    picker.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                                                 NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
    [self.navigationController presentViewController:picker animated:YES completion:nil];

}

#pragma mark - UIImagePickerControllerDelegate
// 选择了图片或者拍照了
- (void)imagePickerController:(UIImagePickerController *)aPicker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [aPicker dismissViewControllerAnimated:YES completion:nil];
    __block UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    if (image) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        [self.navigationController setNeedsStatusBarAppearanceUpdate];
//        NSLog(@"拍照成功了。拍照的image===%@",image);
        [self.imageArray addObject:image];//拍照的先存起来。
        //拍照完才调取选取图片的。
        [self sendButtonAction:nil];
        
        self.takePhoteImage = image;
        [_imageFlowCollectionView reloadData];
    }
    return;
}

// 取消
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)aPicker {
    [aPicker dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"取消拍照了。。。。");
    return;
}  


@end