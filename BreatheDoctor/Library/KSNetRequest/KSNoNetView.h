//
//  KSNoNetView.h
//  Test
//
//  Created by KS on 15/11/25.
//  Copyright © 2015年 xianhe. All rights reserved.
//

/**
 *  这个View是无网络状态下的视图,可以实现自定义
 *
 *  
 */

#import <UIKit/UIKit.h>

@protocol KSNoNetViewDelegate  <NSObject>

- (void)reloadNetworkDataSource:(UIButton *)sender;

@end

@interface KSNoNetView : UIView

@property (nonatomic, strong) id<KSNoNetViewDelegate>delegate;

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UIButton *ErrorButton;

/**
 *  初始化方法,可以自定义,
 *
 *  @return KSNotNetView
 */
+ (instancetype) instanceNoNetView;


@end
