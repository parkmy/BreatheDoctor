//
//  KLMessageCell.h
//  BreatheDoctor
//
//  Created by comv on 16/4/25.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KLMessageCell : UITableViewCell
/**
 *  用户名
 */
@property (nonatomic, strong) UILabel       *userNameLabel;
/**
 *  消息
 */
@property (nonatomic, strong) UILabel       *messageLabel;
/**
 *  时间
 */
@property (nonatomic, strong) UILabel       *dateLabel;
/**
 *  消息数量
 */
@property (nonatomic, strong) UILabel       *messageCountLabel;
/**
 *  用户图标
 */
@property (nonatomic, strong) UIImageView   *userIcon;


@property (nonatomic, strong) LWMainRows    *messageModel;

@end
