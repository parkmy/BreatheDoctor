//
//  KLNavigationBarView.h
//  COButton
//
//  Created by comv on 16/5/13.
//  Copyright © 2016年 comv. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  图片文字边距
 */
#define margin 0
#define BARFONT  34

/**
 *  图片位置
 */
typedef NS_ENUM(NSInteger,IMAGELOCATIONTYPE) {
    /**
     *  默认左边
     */
    IMAGELOCATIONTYPELEFT  = 0,
    /**
     *  右边
     */
    IMAGELOCATIONTYPERIGHT = 1,
};

@interface KLNavItm : UIButton

@property (nonatomic, assign) IMAGELOCATIONTYPE imageLocationType;

@end

@interface KLNavigationBarView : UIView

@property (nonatomic, copy) void(^leftNavBarClickBlock)(id sender);
@property (nonatomic, copy) void(^rightNavBarClickBlock)(id sender);

/**
 *  中心标题
 */
@property (nonatomic, copy) NSString *navTitle;
/**
 *  左边标题
 */
@property (nonatomic, copy) NSString *leftTitle;
/**
 *  右边标题
 */
@property (nonatomic, copy) NSString *rightTitle;
/**
 *  左边图标
 */
@property (nonatomic, strong) UIImage *leftImage;
/**
 *  右边图标
 */
@property (nonatomic, strong) UIImage *rightImage;
/**
 *
 */
@property (nonatomic, strong) UIView *customNavCenterView;
#pragma mark -event
- (void)nav_leftButtonClick:(id)sender;
- (void)nav_rightButtonClick:(id)sender;
@end
