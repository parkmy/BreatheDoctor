//
//  KLGoodsDetailedImageCell.h
//  BreatheDoctor
//
//  Created by comv on 16/4/29.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KLGoodsDetailedModel;

@interface KLGoodsDetailedImageCell : UITableViewCell
@property (nonatomic, strong) KLGoodsDetailedModel *model;
@property (nonatomic, strong) UIImageView *goodsimageView;
@property (nonatomic, copy) NSString *imageUrl;
@end
