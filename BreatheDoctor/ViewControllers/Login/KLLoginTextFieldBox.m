//
//  KLLoginTextFieldBox.m
//  BreatheDoctor
//
//  Created by comv on 16/5/17.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLLoginTextFieldBox.h"

@implementation KLLoginTextFieldBox

- (id)initWithType:(FIELDTYPE)type{
    
    if ([super init]) {
        
        _icon = ({
            
            UIImageView *imageView = [UIImageView new];
            
            imageView;
        });
        
        _titleLabel = ({
            
            UILabel *label = [UILabel new];
            
            label;
        });
        
        _timeButton = ({
            
            KLTimeButton *btn = [[KLTimeButton alloc] initWithFrame:CGRectZero AndBeforeTitle:@"获取验证码" AndWorkingMarkStr:@"" AndTimeSum:60 AndTimeButtonStar:^{
                
            } AndTimeButtonStop:^{
                
            }];
            
            btn;
        });
        
        _boxField = ({
            
            UITextField *field = [UITextField new];
            
            field;
        });
        
        [self sd_addSubviews:@[_icon,_titleLabel,_boxField,_timeButton]];
        
        if (type == FIELDTYPEIMAGE) {
            
            _icon.sd_layout
            .leftSpaceToView(self,5)
            .centerXEqualToView(self);
        }else{
            
            _titleLabel.sd_layout
            .leftSpaceToView(self,5)
            .centerXEqualToView(self);
        }
        
        if (type == 2) {
            
            _timeButton.sd_layout
            .rightSpaceToView(self,5)
            .widthIs(80)
            .heightIs(35)
            .centerXEqualToView(self);
        }
        
        _boxField.sd_layout
        .leftSpaceToView(type==0?_icon:_titleLabel,5)
        .rightSpaceToView(type==2?_timeButton:self,5)
        .topSpaceToView(self,0)
        .bottomSpaceToView(self,0);
        
        
    }
    return self;
}

@end
