//
//  KLGoodsDetailedImageView.m
//  BreatheDoctor
//
//  Created by comv on 16/5/3.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLGoodsDetailedImageView.h"
#import "KLGoodsDetailedImageUrlList.h"
#import "KLGoodsDetailedModel.h"
#import "KLGoodsImageCollectionViewCell.h"
#import <UIImageView+WebCache.h>
#import <SDImageCache.h>

@interface KLGoodsDetailedImageView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *imagesCollectionView;
@property (nonatomic, strong) NSMutableArray   *imageUrls;
@property (nonatomic, strong) NSMutableArray   *sizeArray;
@end

@implementation KLGoodsDetailedImageView

- (id)initWithFrame:(CGRect)frame{
    
    if ([super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.imagesCollectionView];
        
        self.imagesCollectionView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
        
//        [self setupAutoHeightWithBottomView:self.imagesCollectionView bottomMargin:0];
        self.sd_layout.heightIs(300);
    }
    return self;
}
- (CGFloat)cellHeight{
    
    return self.imagesCollectionView.contentHeight;
}
- (UICollectionView *)imagesCollectionView{
    
    if (!_imagesCollectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _imagesCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _imagesCollectionView.dataSource = self;
        _imagesCollectionView.delegate = self;
        _imagesCollectionView.backgroundColor = [UIColor whiteColor];
        
        [_imagesCollectionView registerClass:[KLGoodsImageCollectionViewCell class] forCellWithReuseIdentifier:@"KLGoodsImageCollectionViewCell"];
    }
    return _imagesCollectionView;
}
- (void)setModel:(KLGoodsDetailedModel *)model{
    
    _model = model;
    self.imageUrls = [self goodsImageUrlListWithList:self.model.imageUrlList];
    self.sizeArray = [self goodsSDimageCacheSizesWith:self.imageUrls];
    [self.imagesCollectionView reloadData];
}
- (NSMutableArray *)goodsImageUrlListWithList:(NSArray *)list{
    
    NSMutableArray *array = [NSMutableArray array];
    for (KLGoodsDetailedImageUrlList *listModel in list) {
        if (listModel.type == 2) {
            [array addObject:listModel.imageUrl];
        }
    }
    return array;
}
- (NSMutableArray *)goodsSDimageCacheSizesWith:(NSMutableArray *)array{
    
    NSMutableArray *sizeArray = [NSMutableArray array];
    for (NSString *imageUrl in array) {
        
        SDImageCache *manager = [SDImageCache sharedImageCache];
        UIImage *image = [manager imageFromDiskCacheForKey:imageUrl];
        if (image) {
            
            [sizeArray addObject:NSStringFromCGSize([self imageCFsizeWithSize:image.size])];
        }else{
            
            [sizeArray addObject:NSStringFromCGSize([kImage(@"defaultIconImage") size])];
        }
    }
    return sizeArray;
}
- (CGSize)imageCFsizeWithSize:(CGSize)size{
    
    CGSize cfSzie ;
    if (size.width > screenWidth) {
        cfSzie.width = screenWidth;
        CGFloat sp = (size.width/size.height);
        cfSzie.height =  cfSzie.width/sp;
    }else{
        cfSzie.width = size.width;
        cfSzie.height = size.height;
    }
    return cfSzie;
}

#pragma mark -UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [self.imageUrls count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    KLGoodsImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KLGoodsImageCollectionViewCell" forIndexPath:indexPath];
    WEAKSELF
    [cell.goodsImageView sd_setImageWithURL:kNSURL([self.imageUrls rewriteObjectAtIndex:indexPath.row]) placeholderImage:kImage(@"defaultIconImage") completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [KL_weakSelf.sizeArray replaceObjectAtIndex:indexPath.row withObject:NSStringFromCGSize([KL_weakSelf imageCFsizeWithSize:image.size])];
        [KL_weakSelf.imagesCollectionView reloadItemsAtIndexPaths:@[indexPath]];
    }];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",[self.sizeArray rewriteObjectAtIndex:indexPath.row]);
    return CGSizeFromString([self.sizeArray rewriteObjectAtIndex:indexPath.row]);
}


@end
