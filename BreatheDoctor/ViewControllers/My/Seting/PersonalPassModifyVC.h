//
//  PersonalPassModifyViewController.h
//  ComveeDoctor
//
//  Created by zhengjw on 14-7-29.
//  Copyright (c) 2014年 zhengjw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"


typedef enum
{
	TextFieldTag_oldPasswd = 0,
	TextFieldTag_newPasswd,
	TextFieldTag_newPasswdConfirm,
} TextFieldTag;

@interface PersonalPassModifyVC : BaseViewController<UITextFieldDelegate>
{
    UITextField *old_password;
    UITextField *m_password1;
    UITextField *m_password2;
    UITextField * currentField;
    UIView *m_view;
    
}

@end
