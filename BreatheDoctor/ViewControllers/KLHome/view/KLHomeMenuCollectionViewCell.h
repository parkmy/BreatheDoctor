//
//  KLHomeMenuCollectionViewCell.h
//  COButton
//
//  Created by liaowh on 16/6/2.
//  Copyright © 2016年 comv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KLHomeMenuCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) id model;
@property (nonatomic, strong) UILabel *badgeLabel;

- (void)setPatientCountWith:(NSInteger)count;

@end
