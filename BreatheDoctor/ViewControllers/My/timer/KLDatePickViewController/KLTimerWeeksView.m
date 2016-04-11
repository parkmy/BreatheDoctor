//
//  KLTimerWeeksView.m
//  BreatheDoctor
//
//  Created by comv on 16/3/31.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLTimerWeeksView.h"
#import "KLTimerWeeksCell.h"
#import <ReactiveCocoa.h>

@interface KLTimerWeeksView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIButton       *leftButton;
@property (nonatomic, strong) UIButton       *rightButton;
@end

@implementation KLTimerWeeksView

- (id)initWithFrame:(CGRect)frame{
    
    if ([super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *titleLabel = [UILabel new];
        titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        titleLabel.text = @"重复周期";
        [self addSubview:titleLabel];
        
        UIView *line = [UIView allocAppLineView];
        [self addSubview:line];
        
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake(screenWidth/3-4*5,30);
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_collectionView];
        [_collectionView registerClass:[KLTimerWeeksCell class] forCellWithReuseIdentifier:@"KLTimerWeeksCell"];
        [self addSubview:self.leftButton];
        [self addSubview:self.rightButton];
        
        titleLabel.sd_layout.leftSpaceToView(self,10).topSpaceToView(self,0).rightSpaceToView(self,0).heightIs(40);
        line.sd_layout.leftSpaceToView(self,0).rightSpaceToView(self,0).heightIs(.5).topSpaceToView(titleLabel,0);
        
        self.leftButton.sd_layout.leftSpaceToView(self,0).bottomSpaceToView(self,0).heightIs(40).widthRatioToView(self,.5);
        self.rightButton.sd_layout.leftSpaceToView(self.leftButton,0).bottomSpaceToView(self,0).rightSpaceToView(self,0).heightIs(40);
        
        _collectionView.sd_layout.leftSpaceToView(self,0).
        rightSpaceToView(self,0).topSpaceToView(line,10).bottomSpaceToView(self.leftButton,0);
        
        [[self.leftButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            _leftButtonClikBlock?_leftButtonClikBlock():nil;
        }];
        
        [[self.rightButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            _rightButtonClikBlock?_rightButtonClikBlock(self.weeks):nil;
        }];
        
    }
    return self;
}

- (UIButton *)leftButton{
    
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.titleLabel.font = kNSPXFONT(30);
        [_leftButton setTitle:@"取消" forState:UIControlStateNormal];
        [_leftButton setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    }
    return _leftButton;
}
- (UIButton *)rightButton{
    
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.titleLabel.font = kNSPXFONT(30);
        [_rightButton setTitle:@"完成" forState:UIControlStateNormal];
        [_rightButton setTitleColor:[[UIColor redColor] colorWithAlphaComponent:.5] forState:UIControlStateNormal];
    }
    return _rightButton;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 7;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    KLTimerWeeksCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KLTimerWeeksCell" forIndexPath:indexPath];
    [cell setItmInfo:@[@"每周一",@"每周二",@"每周三",@"每周四",@"每周五",@"每周六",@"每周日"][indexPath.row]];
    for (NSString *str in self.weeks) {
        if (indexPath.row == (str.integerValue -1)) {
            cell.contentButton.selected = YES;
            [cell.contentButton setImage:kImage(@"xuanze") forState:UIControlStateNormal];
        }
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    KLTimerWeeksCell *cell = (KLTimerWeeksCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    cell.contentButton.selected = !cell.contentButton.selected;
    
    if (cell.contentButton.selected) {
        [cell.contentButton setImage:kImage(@"xuanze") forState:UIControlStateNormal];
        [self.weeks addObject:[NSString stringWithFormat:@"%ld",indexPath.row+1]];
    }else
    {
        [cell.contentButton setImage:kImage(@"timer_gray") forState:UIControlStateNormal];
        [self.weeks removeObject:[NSString stringWithFormat:@"%ld",indexPath.row+1]];
    }
}
@end
