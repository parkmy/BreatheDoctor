//
//  LWSymptomsFootView.m
//  BreatheDoctor
//
//  Created by comv on 16/3/17.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWSymptomsFootView.h"
#import "LWSymptomsCell.h"

@interface LWSymptomsFootView ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation LWSymptomsFootView

- (id)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame])
    {
        
        [self addSubview:self.collectionView];
        self.collectionView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(3, 7, 3, 7));
        
    }
    return self;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat w = (screenWidth-50)/4;
        layout.itemSize = CGSizeMake(w, w);
//        layout.minimumLineSpacing = 3.0f;
        layout.sectionInset = UIEdgeInsetsMake(3, 3, 3, 3);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[LWSymptomsCell class] forCellWithReuseIdentifier:@"LWSymptomsCell"];
    }
    return _collectionView;
}
#pragma mark -UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 12;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
 
    LWSymptomsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LWSymptomsCell" forIndexPath:indexPath];
    
    return cell;
}

@end
