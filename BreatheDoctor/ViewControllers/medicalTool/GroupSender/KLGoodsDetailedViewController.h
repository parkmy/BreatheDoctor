//
//  KLGoodsDetailedViewController.h
//  BreatheDoctor
//
//  Created by comv on 16/4/29.
//  Copyright © 2016年 lwh. All rights reserved.
// 商品详细

#import "BaseViewController.h"

@interface KLGoodsDetailedViewController : BaseViewController
- (id)initWithGoodsId:(NSString *)goodsId theFootButtonHidden:(BOOL)isHidden;
- (void)footButtonClick:(UIButton *)sender theSenderVC:(UIViewController *)vc;
@end
