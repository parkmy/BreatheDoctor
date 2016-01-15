//
//  PersonalPassModifyViewController.m
//  ComveeDoctor
//
//  Created by zhengjw on 14-7-29.
//  Copyright (c) 2014年 zhengjw. All rights reserved.
//

#import "PersonalPassModifyVC.h"
#import "CDMacro.h"
#import "CDCommontConvenient.h"
#import "LWLoginManager.h"

@interface PersonalPassModifyVC ()

@end

@implementation PersonalPassModifyVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [super addNavBar:@"密码修改"];
    [super addBackButton:@"nav_btnBack"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    
}

- (void)navLeftButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    m_view=[[UIView alloc]initWithFrame:CGRectMake(0, systemNavHeight, self.view.frame.size.width, self.view.frame.size.height-systemNavHeight)] ;
    if(systemVersion>=7)
    {
        m_view.frame = CGRectMake(0, 20+systemNavHeight, self.view.frame.size.width, self.view.frame.size.height-systemNavHeight-20);
    }
    [self.view addSubview:m_view];
    ;
    
    UIView *labelView=[[UIView alloc]initWithFrame:CGRectMake(20*sizeScaleX, 20*sizeScaleY, m_view.frame.size.width-20*2*sizeScaleX, 45*3*sizeScaleY)];
    labelView.backgroundColor=[UIColor whiteColor];
    [m_view addSubview:labelView];
    
    for (int i=0; i<3; i++)
    {
        if (i!=2)
        {
            UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(20*sizeScaleX, (20+(i+1)*45)*sizeScaleY, m_view.frame.size.width-20*2*sizeScaleX, 0.5f)];
            lineView.backgroundColor=[UIColor blackColor];
            lineView.alpha=0.4f;
            [m_view addSubview:lineView];

        }
        
        UIImageView *iconImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"yishengzhushou_58.png"]];
        iconImageView.frame=CGRectMake(30*sizeScaleX, (20+45*i+15)*sizeScaleY+2*sizeScaleY, 15, 15);
        [m_view addSubview:iconImageView];
        
    }
    
    //圆角设置
    labelView.layer.cornerRadius = CORNERRADIUS;
    labelView.layer.masksToBounds = YES;
    //设置圆角
    CALayer *layer=[labelView layer];
    //是否设置边框以及是否可见
    [layer setMasksToBounds:YES];
    //设置边框线的宽
    [layer setBorderWidth:0.5f];
    //设置边框线的颜色
    [layer setBorderColor:[UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.4f].CGColor];
    
    old_password =  [CommentConvenient creatTextField:CGRectMakeFit(54,20+45*0,280-45,45) Place:@"请输入您的原密码" TextColor:nil TextAliment:NSTextAlignmentLeft Sv:m_view delegate:self];
    old_password.tag=0;
    old_password.clearButtonMode = UITextFieldViewModeWhileEditing;
    old_password.font=[UIFont fontWithName:FONT size:15];
    old_password.borderStyle = UITextBorderStyleNone;
    old_password.returnKeyType = UIReturnKeyGo;
    old_password.secureTextEntry = YES;
    
    m_password1  =  [CommentConvenient creatTextField:CGRectMakeFit(54,20+45*1,280-45,45) Place:@"请输入您的新密码(6~16个字符)" TextColor:nil TextAliment:NSTextAlignmentLeft Sv:m_view delegate:self];
    m_password1.tag=1;
	m_password1.font=[UIFont fontWithName:FONT size:15];
    m_password1.clearButtonMode = UITextFieldViewModeWhileEditing;
    [m_password1 setBackgroundColor:[UIColor clearColor]];
    m_password1.borderStyle = UITextBorderStyleNone;
    m_password1.returnKeyType = UIReturnKeyGo;
    m_password1.secureTextEntry = YES;
    
    m_password2  = [CommentConvenient creatTextField:CGRectMakeFit(54,20+45*2,280-45,45) Place:@"请再次输入您的新密码" TextColor:nil TextAliment:NSTextAlignmentLeft Sv:m_view delegate:self];
    m_password2.clearButtonMode = UITextFieldViewModeWhileEditing;
    m_password2.tag=2;
    m_password2.font=[UIFont fontWithName:FONT size:15];
    [m_password2 setBackgroundColor:[UIColor clearColor]];
    m_password2.borderStyle = UITextBorderStyleNone;
    m_password2.returnKeyType = UIReturnKeyGo;
    m_password2.secureTextEntry = YES;
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setBackgroundColor:systemColor];
    [sureBtn setCornerRadius:5.0f];
    [sureBtn setTitle:@"确 定" forState:UIControlStateNormal];
    sureBtn.titleLabel.font=[UIFont fontWithName:FONT size:20];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureBtn.frame = CGRectMake(21*sizeScaleX, (20+45*3+20)*sizeScaleY, m_view.frame.size.width-40*sizeScaleX, 45);
    [sureBtn addTarget:self action:@selector(loadPassModify:) forControlEvents:UIControlEventTouchUpInside];
    [m_view addSubview:sureBtn];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    currentField = textField;
}

-(void)takeFirstResponder
{
    [currentField becomeFirstResponder];
}

-(BOOL)checkNull:(NSString *)text
{
	NSString *str = [text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
	if([str length] == 0)
	{
		return YES;
	}
	return NO;
}

- (void)sureAction
{
    [currentField resignFirstResponder];
}

//解除锁定
-(void)setLockNO
{
    self.view.userInteractionEnabled = YES;
    
}
- (void) loadPassModify:(UIButton*)sender
{
    NSString *alertStr=nil;
    BOOL isNull = NO;
	NSArray *array = [m_view subviews];
	for (id obj in array)
	{
		if([obj isMemberOfClass:[UITextField class]])
		{
			UITextField *textField = (UITextField *)obj;
            [textField resignFirstResponder];
			isNull = [self checkNull:textField.text];
			if(isNull == YES)
			{
				int tag = (int)[textField tag];
				if(TextFieldTag_oldPasswd == tag)
				{
					alertStr=@"原密码不能为空";
					break;
				}
				else if(TextFieldTag_newPasswd == tag)
				{
					alertStr=@"新密码不能为空";
					break;
				}
				else if(TextFieldTag_newPasswdConfirm == tag)
				{
					alertStr=@"确认密码不能为空";
					break;
				}
				
			}
		}
	}
	
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^[a-z0-9A-Z]{6,12}$"];
    if([pred evaluateWithObject:old_password.text]==NO)
        //if([old_password.text isMatchedByRegex:@"^[a-z0-9A-Z]{6,12}$"] == NO)
    {
        alertStr=@"对不起，密码不正确";
    }
    
    pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^[a-z0-9A-Z]{6,12}$"];
    if([pred evaluateWithObject:m_password1.text]==NO)
        //if([m_password1.text isMatchedByRegex:@"^[a-z0-9A-Z]{6,12}$"] == NO)
    {
        alertStr=@"对不起，新密码不符合要求";
    }
    
    NSString *password1 = [m_password1 text];
    NSString *password2 = [m_password2 text];
    if(![password1 isEqualToString:password2])
    {
        alertStr=@"两次输入的密码不一致，请重新输入";
    }
	
    if (alertStr!=nil)
    {

        [LWProgressHUD showALAlertBannerWithView:self.view Style:SALAlertBannerStyleWarning  Position:SALAlertBannerPositionTop Subtitle:alertStr ];
        return;
    }
    
    [LWProgressHUD displayProgressHUD:self.view.window displayText:@"请稍后..."];
    [LWHttpRequestManager httpChangeThePasswordWitholdPwd:old_password.text newPwd:password1 success:^(NSDictionary *dic) {
        [LWProgressHUD closeProgressHUD:self.view.window];
        [[LWLoginManager shareInstance] exitLoginViewVc:self];
    } failure:^(NSString *errorMes) {
        [LWProgressHUD closeProgressHUD:self.view.window];
        [LWProgressHUD showALAlertBannerWithView:self.view Style:SALAlertBannerStyleWarning  Position:SALAlertBannerPositionTop Subtitle:errorMes ];
    }];
    
    
}


@end
