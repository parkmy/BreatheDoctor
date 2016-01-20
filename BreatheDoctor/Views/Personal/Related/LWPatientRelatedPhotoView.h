//
//  LWPatientRelatedPhotoView.h
//  BreatheDoctor
//
//  Created by comv on 16/1/12.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LWPatientRelatedPhotoViewDelegate <NSObject>

@optional
- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)deleteimage:(UIImage *)image withCollectionView:(UICollectionView *)collectionView;

@end

@interface LWPatientRelatedPhotoView : UIView
@property (nonatomic, strong) NSMutableArray *images;

@property (nonatomic, weak) id<LWPatientRelatedPhotoViewDelegate>delegate;
@end
