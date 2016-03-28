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
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation LWSymptomsFootView

- (id)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame])
    {
//        
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"LWSymptomsList" ofType:@"plist"];
//        NSArray *array = [[NSArray alloc] initWithContentsOfFile:path];
//        [self.dataArray removeAllObjects];
//        [self.dataArray addObjectsFromArray:array];
        
        [self addSubview:self.collectionView];
        self.collectionView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(3, 7, 3, 7));
    }
    return self;
}
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)setFootSymptoms:(NSMutableArray *)array
{
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:array];
    [self.collectionView reloadData];
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
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
 
    LWSymptomsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LWSymptomsCell" forIndexPath:indexPath];
    [cell setObjc:self.dataArray[indexPath.row]];
    return cell;
}

@end
