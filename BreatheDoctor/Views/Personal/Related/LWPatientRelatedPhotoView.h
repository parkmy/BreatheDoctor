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
- (void)deleteimage:(id )object withCollectionView:(UICollectionView *)collectionView;
- (void)imagesChangeHeight:(NSMutableArray *)images;
@end

@interface LWPatientRelatedPhotoView : UIView
@property (nonatomic, strong) NSMutableArray *images;

@property (nonatomic, weak) id<LWPatientRelatedPhotoViewDelegate>delegate;
@end
