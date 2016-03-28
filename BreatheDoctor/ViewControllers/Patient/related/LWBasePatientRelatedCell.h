//
//  LWBasePatientRelatedCell.h
//  BreatheDoctor
//
//  Created by comv on 16/3/23.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KLPatientRelatedModel.h"

@interface LWBasePatientRelatedCell : UITableViewCell

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *mContentView;
@property (nonatomic, strong) UITextView *mContentTextView;
@property (nonatomic, strong) KLPatientRelatedModel *model;

@property (nonatomic, copy) void(^changeContentBlock)();

- (void)setContentTextViewText:(NSString *)text;


@end
