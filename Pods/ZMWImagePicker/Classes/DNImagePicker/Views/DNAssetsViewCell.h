//
//  DNAssetsViewCell.h
//  ImagePicker
//
//  Created by DingXiao on 15/2/11.
//  Copyright (c) 2015年 Dennis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/ALAsset.h>

@class DNAssetsViewCell;

@protocol DNAssetsViewCellDelegate <NSObject>
@optional

- (void)didSelectItemAssetsViewCell:(DNAssetsViewCell *)assetsCell;
- (void)didDeselectItemAssetsViewCell:(DNAssetsViewCell *)assetsCell;
@end

@interface DNAssetsViewCell : UICollectionViewCell

@property (nonatomic, strong) ALAsset *asset;
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, weak) id<DNAssetsViewCellDelegate> delegate;

- (void)fillWithAsset:(ALAsset *)asset isSelected:(BOOL)seleted;
///自己添加的方法，为了第一个cell放拍照的按钮。
- (void)fillWithAsset:(ALAsset *)asset isSelected:(BOOL)seleted row:(int)row;
- (void)fillWithAsset:(ALAsset *)asset isSelected:(BOOL)seleted row:(int)row image:(UIImage *)image;
@end
