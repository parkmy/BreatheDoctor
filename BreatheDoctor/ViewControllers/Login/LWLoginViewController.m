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
#import "KLRegisteredViewController.h"
#import "KLRetrievePasswordViewController.h"

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
    [self setUI];
}
- (void)dealloc{
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;

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
        _titleArray = @[@"登录中·",@"登录中··",@"登录中···"];
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
        [[KLPromptViewManager shareInstance] kl_showPromptViewWithTitle:@"温馨提示" theContent:NSLocalizedString(@"LOGIN_ALERT_NOUSERNAME",nil)];
        return;
    }
    
    
    if (self.accountTF.text.length <= 0||![self.accountTF.text isPhoneNumber]) {
        [[KLPromptViewManager shareInstance] kl_showPromptViewWithTitle:@"温馨提示" theContent:NSLocalizedString(@"LOGIN_ALERT_IncorrectUsername",nil)];
        return;
    }
    if (self.passwordTF.text == nil || [self.passwordTF.text isEqualToString:@""]) {
        [[KLPromptViewManager shareInstance] kl_showPromptViewWithTitle:@"温馨提示" theContent:NSLocalizedString(@"LOGIN_ALERT_NOPASSWORD",nil)];
        return;
    }
    
    [self starTimerLoding];
    WEAKSELF
    [LWHttpRequestManager httpLoginWithPhoneNumber:self.accountTF.text password:self.passwordTF.text success:^(LBLoginBaseModel *userModel) {
        
        [KL_weakSelf endHidenTimer];
        if (_delegate && [_delegate respondsToSelector:@selector(loginSucc)]) {
            [_delegate loginSucc];
        }
    } failure:^(NSString *errorMes) {
        
        [KL_weakSelf endHidenTimer];
        [[KLPromptViewManager shareInstance] kl_showPromptViewWithTitle:@"温馨提示" theContent:errorMes];
    }];
    
}
- (IBAction)rigistEvent:(id)sender {
    
    KLRegisteredViewController *vc = [KLRegisteredViewController new];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)RetrievePassword:(id)sender {
    
    KLRetrievePasswordViewController *vc = [KLRetrievePasswordViewController new];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
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
