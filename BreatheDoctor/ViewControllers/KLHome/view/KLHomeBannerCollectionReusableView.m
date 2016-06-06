//
//  KLHomeBannerCollectionReusableView.m
//  COButton
//
//  Created by liaowh on 16/6/2.
//  Copyright © 2016年 comv. All rights reserved.
//

#import "KLHomeBannerCollectionReusableView.h"
#import "SDCycleScrollView.h"

@interface KLHomeBannerCollectionReusableView ()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView  *bannerScrollView;

@end

@implementation KLHomeBannerCollectionReusableView

- (void)setup{

    [super setup];
    
    self.backgroundColor = [UIColor whiteColor];
    
    
    _bannerScrollView = ({
        
        SDCycleScrollView *view = [SDCycleScrollView new];
        view.delegate = self;
        view.autoScroll = NO;
        view.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
        view.currentPageDotColor = [UIColor colorWithHexString:@"#ff9402"];
        view.placeholderImage = kImage(@"defaultIconImage");
        view.autoScrollTimeInterval = 4.0f;
        view.pageControlDotSize = CGSizeMake(5, 5);
        view;
    });
    [self addSubview:_bannerScrollView];
    
    _bannerScrollView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    
    _bannerScrollView.localizationImageNamesGroup = @[@"banner"];

}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{};


@end
