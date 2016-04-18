//
//  LWLogStateView.m
//  BreatheDoctor
//
//  Created by comv on 16/3/18.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWLogStateView.h"
#import "KLStateView.h"
#import "KLStateCell.h"
#import "KLStateModel.h"

@interface LWLogStateView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIView  *contentView;
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation LWLogStateView

- (id)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame])
    {
//        self.backgroundColor = RGBA(arc4random_uniform(233), arc4random_uniform(222), arc4random_uniform(111), 1);

        self.backgroundColor = [UIColor whiteColor];

        [self addSubview:self.titleLabel];
        [self addSubview:self.iconImageView];
        
//        self.titleLabel.text = @"记症状";
        UIImage *image = kImage(@"jiyongyao");
        self.iconImageView.image = image;
        self.iconImageView.sd_layout.leftSpaceToView(self,15).topSpaceToView(self,25).widthIs(image.size.width).heightIs(image.size.height);
        self.titleLabel.sd_layout.leftSpaceToView(self.iconImageView,12).topSpaceToView(self,17).rightSpaceToView(self,5).heightIs(20*MULTIPLEVIEW);
        
        _contentView = [UIView new];
//        view.backgroundColor = [UIColor greenColor];
        [self addSubview:_contentView];
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_contentView addSubview:_collectionView];
        [_collectionView registerClass:[KLStateCell class] forCellWithReuseIdentifier:@"KLStateCell"];
//        UIImageView *line = [UIImageView new];
//        line.image = [UIImage new];
//        [view addSubview:line];
        
        _contentView.sd_layout.leftSpaceToView(self.iconImageView,12).bottomSpaceToView(self,0).topSpaceToView(self.titleLabel,0).rightSpaceToView(self,0);
        _collectionView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
        
//        line.sd_layout.leftSpaceToView(view,10).bottomSpaceToView(view,0).rightSpaceToView(view,0).heightIs(1);
        
    }
    return self;
}


- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = kNSPXFONT(30);
        _titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    }
    return _titleLabel;
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
    }
    return _iconImageView;
}

- (void)setStateIconImageName:(NSString *)image{
    self.iconImageView.image = kImage(image);
}
- (void)setStateTitleName:(NSString *)name{
    self.titleLabel.text = stringJudgeNull(name);
}
- (void)setDataArray:(NSMutableArray *)dataArray{
    
    _dataArray = dataArray;
    [self.collectionView reloadData];
}
- (CGFloat)collectionViewContentHeight{
    return _collectionView.contentHeight;
}
//- (void)setSymptoms:(NSMutableArray *)symptoms{
//    
//    _symptoms = symptoms;
//    for (UIView *view in _contentView.subviews) {
//        [view removeFromSuperview];
//    }
//    
//    for (int i = 0; i < symptoms.count; i++) {
//        KLStateView *stateView = [KLStateView new];
//        [_contentView addSubview:stateView];
//    }
//    
//}
//
//- (void)setMedication:(NSMutableArray *)medication{
//    
//    _medication = medication;
//    
//}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    KLStateCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KLStateCell" forIndexPath:indexPath];    
    KLStateModel *model = self.dataArray[indexPath.row];
    [cell.stateView stateLabelText:model.title];
    cell.stateView.stateColor = model.stateColor;
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    KLStateModel *model = self.dataArray[indexPath.row];
    return model.itmSize;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return  UIEdgeInsetsMake(5, 0, 5, 0);

}

@end
