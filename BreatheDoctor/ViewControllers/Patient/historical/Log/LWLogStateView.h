//
//  LWLogStateView.h
//  BreatheDoctor
//
//  Created by comv on 16/3/18.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWLogStateView : UIView

@property (nonatomic, strong) NSMutableArray *dataArray;
/**
 *  状态图标
 *
 *  @param image 图片名字
 */
- (void)setStateIconImageName:(NSString *)image;
/**
 *  状态标题
 *
 *  @param name 标题
 */
- (void)setStateTitleName:(NSString *)name;
/**
 *  返回内容高度
 *
 *  @return 高度
 */
- (CGFloat)collectionViewContentHeight;
@end
