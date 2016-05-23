//
//  KLLoginTextFieldBox.h
//  BreatheDoctor
//
//  Created by comv on 16/5/17.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KLTimeButton.h"
/**
 *  输入框类型
 */
typedef NS_ENUM(NSUInteger,FIELDTYPE) {
    /**
     *  图标
     */
    FIELDTYPEIMAGE = 0,
    /**
     *  文字
     */
    FIELDTYPETEXT  = 1,
    /**
     *  验证码
     */
    FIELDTYPEVCODE = 2,
};
@interface KLLoginTextFieldBox : UIView

@property (nonatomic, strong) UILabel      *titleLabel;
@property (nonatomic, strong) UIImageView  *icon;
@property (nonatomic, strong) UITextField  *boxField;
@property (nonatomic, strong) KLTimeButton *timeButton;


- (id)initWithType:(FIELDTYPE)type;

@end
