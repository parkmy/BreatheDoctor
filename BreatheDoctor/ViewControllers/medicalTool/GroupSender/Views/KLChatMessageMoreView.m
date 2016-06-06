//
//  KLChatMessageMoreView.m
//  BreatheDoctor
//
//  Created by comv on 16/4/26.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLChatMessageMoreView.h"
#import "LWChatMessageMoreCollectionCell.h"

//自己的高度
#define kHeightMoreView      (80)

@interface KLChatMessageMoreView ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UICollectionView *mCollectionView;
    
    UIPageControl    *mPageControl;
}

/**
 *  @brief  数据源
 */
@property(nonatomic,strong)NSMutableArray *DataSource;
@end

@implementation KLChatMessageMoreView

- (id)initWithFrame:(CGRect)frame{

    if ([super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        
        [layout setItemSize:CGSizeMake([UIScreen mainScreen].bounds.size.width/4-20, kHeightMoreView)];
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        layout.sectionInset = UIEdgeInsetsMake(20,10,0,10);
        layout.minimumLineSpacing = 20;
        
        mCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        mCollectionView.pagingEnabled = YES;
        mCollectionView.showsHorizontalScrollIndicator = NO;
        mCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
        mCollectionView.backgroundColor = [UIColor clearColor];
        mCollectionView.dataSource = self;
        mCollectionView.delegate   = self;
        [mCollectionView registerClass:[LWChatMessageMoreCollectionCell class] forCellWithReuseIdentifier:@"LWChatMessageMoreCollectionCell"];
        
        [self addSubview:mCollectionView];
        
        mCollectionView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    }
    return self;
}

#pragma mark - Collection Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.DataSource.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LWChatMessageMoreCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LWChatMessageMoreCollectionCell" forIndexPath:indexPath];
//        cell.backgroundColor = RGBA(arc4random_uniform(250), arc4random_uniform(35), arc4random_uniform(222), 1);

    cell.model = self.DataSource[indexPath.row];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"选中了：%ld",(long)indexPath.row);
//    if (_delegate && [_delegate respondsToSelector:@selector(seleMoreButtonClick:)]) {
//        [_delegate seleMoreButtonClick:indexPath.row];
//    }
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    mPageControl.currentPage = (scrollView.contentOffset.x)/scrollView.bounds.size.width;
}

-(NSMutableArray *)DataSource
{
    if (_DataSource) {
        return _DataSource;
    }
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"LWMoreImageTitles" ofType:@"plist"];;
    
    _DataSource = [NSMutableArray arrayWithArray:[NSArray arrayWithContentsOfFile:filePath]];
    [_DataSource removeObjectAtIndex:_DataSource.count-2];
    return _DataSource;
}
@end
