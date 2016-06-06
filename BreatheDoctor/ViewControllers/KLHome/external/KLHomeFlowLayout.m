//
//  KLHomeFlowLayout.m
//  COButton
//
//  Created by liaowh on 16/6/2.
//  Copyright © 2016年 comv. All rights reserved.
//

#import "KLHomeFlowLayout.h"
#define itm1Width (120*MULTIPLEVIEW-rowMargin*2)
#define itm1Height (190*MULTIPLE)
#define section0HeaderHeight (160*MULTIPLE)
#define section1HeaderHeight (40*MULTIPLE)
#define sectionMargin 10
#define rowMargin 1

@interface KLHomeFlowLayout ()

@property (nonatomic, strong) NSMutableArray *attributesArray;
@property (nonatomic, assign) CGFloat  maxHeight;
@end

@implementation KLHomeFlowLayout

- (NSMutableArray *)attributesArray{
    
    if (!_attributesArray) {
        
        _attributesArray = [NSMutableArray array];
    }
    return _attributesArray;
}

- (void)prepareLayout{
    
    [super prepareLayout];
    
    [self.attributesArray removeAllObjects];
    
    [self addattributesTheSectionRowsCount:[self.collectionView numberOfItemsInSection:0] theSectionCount:0];
    [self addattributesTheSectionRowsCount:[self.collectionView numberOfItemsInSection:1] theSectionCount:1];
    
    [self addHeaderWithIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [self addHeaderWithIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
}
- (void)addHeaderWithIndexPath:(NSIndexPath *)indexPath
{

    CGFloat contentWidth = self.collectionView.width;
    
    CGFloat sectionHeaderWidth = 0;
    CGFloat sectionHeaderHeight = 0;
    
    CGFloat sectionHeaderX = 0;
    CGFloat sectionHeaderY = 0;
    
    if (indexPath.section == 0) {
        
        sectionHeaderWidth = contentWidth;
        sectionHeaderHeight = section0HeaderHeight;
    }else if (indexPath.section == 1){
        
        sectionHeaderWidth = contentWidth;
        sectionHeaderHeight = section1HeaderHeight;
        sectionHeaderY = itm1Height+section0HeaderHeight+sectionMargin;

    }
    
    //添加底部视图frame
//    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:indexPath];
    attrs.frame = CGRectMake(sectionHeaderX, sectionHeaderY, sectionHeaderWidth, sectionHeaderHeight);

    [self.attributesArray addObject:attrs];

}

- (void)addattributesTheSectionRowsCount:(NSInteger)count theSectionCount:(NSInteger)section{
    
    for (int sectionrow = 0; sectionrow < count; sectionrow++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:sectionrow inSection:section];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attributesArray addObject:attributes];
    }
}
- (CGSize)collectionViewContentSize{
    // return [super collectionViewContentSize];
    //返回字典中最大Y值
    // return CGSizeMake(0, [self.maxYDict[maxKey] floatValue]);
    return CGSizeMake(0, self.maxHeight);
}
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    return self.attributesArray;
}




- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat contentWidth = self.collectionView.width;
    
    CGFloat cellWidth = 0;
    CGFloat cellHeight = 0;
    
    CGFloat cellX = 0;
    CGFloat cellY = 0;
    
    if (indexPath.section == 0) {
        
        cellWidth = itm1Width;
        cellHeight = itm1Height;
        
        cellX = 0;
        cellY = 0;
        
        if (indexPath.row != 0) {
            
            cellWidth  = (contentWidth-cellWidth)/2;
            cellHeight = cellHeight/2;
            //            int a = ((int)indexPath.row/2);
            //            int b = (indexPath.row%2);
            if (indexPath.row == 1) {
                cellX = itm1Width+rowMargin;
            }else if (indexPath.row == 2){
                cellX = itm1Width + cellWidth+rowMargin*2;
            }else if (indexPath.row == 3){
                cellX = itm1Width+rowMargin;
                cellY = cellHeight+rowMargin;
            }else if (indexPath.row == 4){
                cellX = itm1Width + cellWidth+rowMargin*2;
                cellY = cellHeight+rowMargin;
            }
            
            
            //            cellX      = itm1Width + cellWidth*a;
            //            cellY      = cellHeight*b;
        }else{
            cellHeight +=rowMargin;
        }
    }else if (indexPath.section == 1){
        
        cellWidth = contentWidth;
        cellHeight = self.collectionView.height-self.maxHeight;
        cellHeight = MAX(90*MULTIPLE, cellHeight);
        
        cellX      = 0;
        cellY      = itm1Height + cellHeight*indexPath.row + sectionMargin + section1HeaderHeight;
    }
    
    
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attrs.frame = CGRectMake(cellX, cellY+section0HeaderHeight, cellWidth, cellHeight);
    
    self.maxHeight = attrs.frame.origin.y+cellHeight;

    return attrs;
}

@end
