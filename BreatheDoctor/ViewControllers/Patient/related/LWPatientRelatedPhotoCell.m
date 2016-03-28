//
//  LWPatientRelatedPhotoCell.m
//  BreatheDoctor
//
//  Created by comv on 16/3/23.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWPatientRelatedPhotoCell.h"
#import "LWPatientRelatedPhotoView.h"

@interface LWPatientRelatedPhotoCell ()<LWPatientRelatedPhotoViewDelegate>
@property (nonatomic, strong) LWPatientRelatedPhotoView *patientRelatedPhotoView;
@end

@implementation LWPatientRelatedPhotoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.mContentTextView.hidden = YES;
        [self.mContentView addSubview:self.patientRelatedPhotoView];
        self.patientRelatedPhotoView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    }
    return self;
}
- (void)setImages:(NSMutableArray *)array
{
    //    [self imagesChangeHeight:array];
    self.patientRelatedPhotoView.images = array;
}
- (LWPatientRelatedPhotoView *)patientRelatedPhotoView
{
    if (!_patientRelatedPhotoView) {
        _patientRelatedPhotoView = [[LWPatientRelatedPhotoView alloc] initWithFrame:CGRectZero];
        _patientRelatedPhotoView.delegate = self;
    }
    return _patientRelatedPhotoView;
}
#pragma mark -LWPatientRelatedPhotoViewDelegate
- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_delegate && [_delegate respondsToSelector:@selector(selectItemAtIndexPath:)]) {
        [_delegate selectItemAtIndexPath:indexPath];
    }
}
- (void)deleteimage:(id )object withCollectionView:(UICollectionView *)collectionView
{
    if (_delegate && [_delegate respondsToSelector:@selector(deleteItemWithImage:withCollectionView:)]) {
        [_delegate deleteItemWithImage:object withCollectionView:collectionView];
    }
}
- (void)imagesChangeHeight:(NSMutableArray *)images
{
    
}
@end
