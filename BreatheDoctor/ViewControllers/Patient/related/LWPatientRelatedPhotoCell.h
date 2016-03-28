//
//  LWPatientRelatedPhotoCell.h
//  BreatheDoctor
//
//  Created by comv on 16/3/23.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWBasePatientRelatedCell.h"

@protocol LWPatientRelatedPhotoCellDelegate <NSObject>

@optional
- (void)selectItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)deleteItemWithImage:(id )objc withCollectionView:(UICollectionView *)collectionView;

@end

@interface LWPatientRelatedPhotoCell : LWBasePatientRelatedCell
@property (nonatomic, weak) id<LWPatientRelatedPhotoCellDelegate>delegate;
- (void)setImages:(NSMutableArray *)array;
@end
