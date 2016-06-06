//
//  KLHomeBannerCollectionReusableView.h
//  COButton
//
//  Created by liaowh on 16/6/2.
//  Copyright © 2016年 comv. All rights reserved.
//  主页banner

#import "KLBaseCollectionReusableView.h"
@class SDCycleScrollView;

@interface KLHomeBannerCollectionReusableView : KLBaseCollectionReusableView
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index;
@end
