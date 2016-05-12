//
//  KLGoodsCell.h
//  BreatheDoctor
//
//  Created by comv on 16/4/26.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KLGoodsCell : UITableViewCell
@property (nonatomic, strong) id goods;

/**
 *  添加tags外接使用后期调整
 *
 *  @param view view description
 *  @param tags 
 */
+ (void)addTagsLabelWithSuperView:(UIView *)view andTages:(NSArray *)tags;
+ (NSArray *)getTages:(NSString *)tag;

@end
