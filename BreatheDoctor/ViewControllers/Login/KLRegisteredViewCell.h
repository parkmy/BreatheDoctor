//
//  KLRegisteredViewCell.h
//  BreatheDoctor
//
//  Created by comv on 16/5/18.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KLTimeButton.h"
@class KLRegistModel;

@interface KLRegisteredViewCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic, strong) UILabel     *registTitleLabel;
@property (nonatomic, strong) UITextField *registField;

@property (nonatomic, strong) KLTimeButton *timeVcodeButton;

@property (nonatomic, strong) KLRegistModel  *model;

@property (nonatomic, copy) void(^timerVcodeButtonStarBlock)(KLTimeButton *sender);

@end
