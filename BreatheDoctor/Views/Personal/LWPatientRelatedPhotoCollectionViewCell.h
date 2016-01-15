//
//  LWPatientRelatedPhotoCollectionViewCell.h
//  BreatheDoctor
//
//  Created by comv on 16/1/12.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWPatientRelatedPhotoCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImage *contentImage;
@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, copy) void(^deleButtonTapBlock)(UIImage *image);
@end
