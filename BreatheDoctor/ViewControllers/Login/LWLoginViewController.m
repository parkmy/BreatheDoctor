//
//  LWLoginViewController.m
//  BreatheDoctor
//
//  Created by comv on 15/11/11.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWLoginViewController.h"
#import "CDMacro.h"
#import "NSString+RegexCategory.h"
#import "NSString+Hash.h"

@interface LWLoginViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineHight;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) int loginCount;
@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation LWLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.hidesBackButton = YES;
    [self setUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;

}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
}
- (void)setUI
{
    self.lineHight.constant = .5;
    [self.loginButton setCornerRadius:3.0f];
    self.bgView.layer.borderWidth = .5;
    self.bgView.layer.borderColor = [UIColor colorWithHexString:@"#cccccc"].CGColor;
    self.centerYh.constant = -35*MULTIPLE;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)starTimerLoding
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(showTimerLoding) userInfo:nil repeats:YES];
}
- (void)showTimerLoding
{
    self.loginButton.enabled = NO;
    self.accountTF.enabled = NO;
    self.passwordTF.enabled = NO;
    [self.loginButton setTitle:[self.titleArray objectAtIndex:self.loginCount%3]  forState:UIControlStateNormal];
    self.loginCount ++;
}
- (NSArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = @[@"登录中.",@"登录中..",@"登录中..."];
    }
    return _titleArray;
}
- (void)endHidenTimer
{
    if (self.timer && self.timer.isValid)
    {
        [self.timer invalidate];
        self.timer = nil;
    }
    self.loginButton.enabled = YES;
    self.accountTF.enabled = YES;
    self.passwordTF.enabled = YES;
    [self.loginButton setTitle:@"登 录"  forState:UIControlStateNormal];
}
- (IBAction)buttonClick:(UIButton *)sender
{
    
    if (self.timer && self.timer.isValid)
    {
        return;
    }
    
    if (self.accountTF.text.length <= 0) {
        [LWProgressHUD showALAlertBannerWithView:self.view Style:SALAlertBannerStyleWarning  Position:SALAlertBannerPositionTop Subtitle:NSLocalizedString(@"LOGIN_ALERT_NOUSERNAME", nil)];
        return;
    }
    
    if (![self.accountTF.text isMobileNumber]) {
        [LWProgressHUD showALAlertBannerWithView:self.view Style:SALAlertBannerStyleWarning  Position:SALAlertBannerPositionTop Subtitle:NSLocalizedString(@"LOGIN_ALERT_IncorrectUsername", nil)];
        return;
    }
    if (self.passwordTF.text == nil || [self.passwordTF.text isEqualToString:@""]) {
        [LWProgressHUD showALAlertBannerWithView:self.view Style:SALAlertBannerStyleWarning  Position:SALAlertBannerPositionTop Subtitle:NSLocalizedString(@"LOGIN_ALERT_NOPASSWORD", nil)];
        return;
    }
    
    [self starTimerLoding];
    
    [LWHttpRequestManager httpLoginWithPhoneNumber:self.accountTF.text password:[self.passwordTF.text md5String] success:^(LBLoginBaseModel *userModel) {

        if (_delegate && [_delegate respondsToSelector:@selector(loginSucc)]) {
            [_delegate loginSucc];
        }
            [self endHidenTimer];
    } failure:^(NSString *errorMes) {
            [self endHidenTimer];
            [LWProgressHUD showALAlertBannerWithView:self.view Style:SALAlertBannerStyleWarning  Position:SALAlertBannerPositionTop Subtitle:errorMes ];
    }];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.passwordTF) {
        return YES;
    }
    
    if (range.location > 10)
    {
        return  NO;
    }
    else
    {
        return YES;
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{

    if (textField == self.passwordTF && self.accountTF.text.length == 11) {
        [self buttonClick:nil];
    }
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
