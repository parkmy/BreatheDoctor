//
//  LWPatientRelatedPhotoView.m
//  BreatheDoctor
//
//  Created by comv on 16/1/12.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWPatientRelatedPhotoView.h"
#import "LWPatientRelatedPhotoCollectionViewCell.h"
#import <UIImageView+WebCache.h>

@interface LWPatientRelatedPhotoView ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation LWPatientRelatedPhotoView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        
        CGFloat w = (Screen_SIZE.width - 30)/3 - 10;
        
        [layout setItemSize:CGSizeMake(w,w)];
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        layout.sectionInset = UIEdgeInsetsMake(15, 5,4, 5);
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.dataSource = self;
        _collectionView.delegate   = self;
        [_collectionView registerClass:[LWPatientRelatedPhotoCollectionViewCell class] forCellWithReuseIdentifier:@"LWPatientRelatedPhotoCollectionViewCell"];
        
        [self addSubview:_collectionView];

        _collectionView.sd_layout.topSpaceToView(self,0).leftSpaceToView(self,0).rightSpaceToView(self,0).bottomSpaceToView(self,0);
        
    }
    return self;
}

- (void)setImages:(NSMutableArray *)images
{
    _images = images;
    if (_delegate && [_delegate respondsToSelector:@selector(imagesChangeHeight:)]) {
        [_delegate imagesChangeHeight:images];
    }
    [self.collectionView reloadData];
}
#pragma mark - Collection Delegate


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.images.count+1;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LWPatientRelatedPhotoCollectionViewCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LWPatientRelatedPhotoCollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    if (indexPath.row == self.images.count) {
        cell.cancelButton.hidden = YES;
        cell.object = kImage(@"tianjia");
    }else
    {
        cell.cancelButton.hidden = NO;
        id objc = self.images[indexPath.row];
        cell.object = objc;
    }
    
    [cell setDeleButtonimageTapBlock:^(id object) {
        if (_delegate && [_delegate respondsToSelector:@selector(deleteimage: withCollectionView:)]) {
            [_delegate deleteimage:object withCollectionView:self.collectionView];
        }

    }];

    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"选中了：%ld",(long)indexPath.row);
    
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectItemAtIndexPath:)]) {
        [_delegate didSelectItemAtIndexPath:indexPath];
    }
    

}


@end
