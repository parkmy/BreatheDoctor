//
//  KLRegisteredViewController.m
//  BreatheDoctor
//
//  Created by comv on 16/5/17.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLRegisteredViewController.h"
#import "KLRegisteredViewCell.h"
#import "KLRegistModel.h"
#import "KLRegistPublicFootView.h"
#import "KLServiceAgreementViewController.h"
#import "NSString+RegexCategory.h"
#import "KLRegistPublicOperation.h"
#import "KLIndicatorViewManager.h"
#import "LWLoginManager.h"

@interface KLRegisteredViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *registModels;
@end

@implementation KLRegisteredViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [super addNavBar:@"注册"];
    [super addBackButton:@"nav_btnBack"];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.registModels = [[KLRegistModel initializeRegistModels] mutableCopy];
    
    [self addSubViews];
}
- (void)addSubViews{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate   = self;
    [self.view addSubview:_tableView];
    _tableView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    
    _tableView.rowHeight = 45*MULTIPLEVIEW;
    setExtraCellLineHidden(_tableView);
    
    [_tableView registerClass:[KLRegisteredViewCell class] forCellReuseIdentifier:@"KLRegisteredViewCell"];
}

- (void)navLeftButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.registModels.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KLRegisteredViewCell *registeredViewCell = [tableView dequeueReusableCellWithIdentifier:@"KLRegisteredViewCell"];

    KLRegistModel *model = self.registModels[indexPath.row];
    
    [registeredViewCell setModel:model];
    
    /**
     *  有验证码注册
     */
    if (model.type == FieldTypeVCode) {
        /**
         *  开始发送验证码
         */
        WEAKSELF
        [registeredViewCell setTimerVcodeButtonStarBlock:^(KLTimeButton *sender){
            
            [KLRegistPublicOperation senderMessageVcodeTheTimeButton:sender thePhone:[KLRegistModel fieldTextTheIndex:0 withArray:KL_weakSelf.registModels] verifyType:1];
        }];
    }
    
    return registeredViewCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 100.f;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    KLRegistPublicFootView *foot = [KLRegistPublicFootView new];
    foot.registPublicType = RegistPublicTypeDef;
    WEAKSELF
    /**
     *  注册
     */
    [foot setNextButtonClickBlock:^{
        
        NSString *phone = [KLRegistModel fieldTextTheIndex:0 withArray:KL_weakSelf.registModels];
        NSString *vCode = [KLRegistModel fieldTextTheIndex:1 withArray:KL_weakSelf.registModels];
        NSString *pswd =  [KLRegistModel fieldTextTheIndex:2 withArray:KL_weakSelf.registModels];
        NSString *invitationCode = [KLRegistModel fieldTextTheIndex:3 withArray:KL_weakSelf.registModels];
        
        if (phone.length <= 0||![phone isPhoneNumber]) {
            
            [[KLPromptViewManager shareInstance] kl_showPromptViewWithTitle:@"温馨提示" theContent:@"请输入正确的手机号码"];
            return ;
        }
        
        if (vCode.length <= 0) {
            
            [[KLPromptViewManager shareInstance] kl_showPromptViewWithTitle:@"温馨提示" theContent:@"请输入正确的验证码"];
            return ;
        }
        
        if (pswd.length <= 0) {
            
            [[KLPromptViewManager shareInstance] kl_showPromptViewWithTitle:@"温馨提示" theContent:@"请输入正确的密码"];
            return ;
        }
        
        if (invitationCode.length <= 0) {
            
            [[KLPromptViewManager shareInstance] kl_showPromptViewWithTitle:@"温馨提示" theContent:@"请输入正确的邀请码"];
            return ;
        }
        
        [[KLIndicatorViewManager standardIndicatorViewManager] showLoadingWithContent:@"正在注册" theView:KL_weakSelf.view];
        /**
         *  注册请求
         */
        [LWHttpRequestManager httpRegistDoctorWithMobilePhone:phone theUserPsw:pswd theVerifyCode:vCode theInvitationCode:invitationCode Success:^{
            /**
             *  显示注册成功
             */
            [[KLIndicatorViewManager standardIndicatorViewManager] showErrorWith:@"注册成功" theView:KL_weakSelf.view theImage:nil showSucc:^{
                
                /**
                 *  注册成功进行登录
                 */
                [[KLIndicatorViewManager standardIndicatorViewManager] showLoadingWithContent:@"正在登录" theView:KL_weakSelf.view];
             
                [KLRegistPublicOperation loginWithPhoneNumber:phone thePsw:pswd success:^(id userModel) {
                    /**
                     *  登陆完成返回主页发送通知
                     */
                    [[KLIndicatorViewManager standardIndicatorViewManager] hiddenIndicatorView];
                    /**
                     *  登陆成功进入主页
                     */
                    [[LWLoginManager shareInstance] loginSucc];
                } failure:^(NSString *errorMes) {
                    
                    [[KLIndicatorViewManager standardIndicatorViewManager] hiddenIndicatorView];
                }];
                
            }];

        } failure:^(NSString *errorMes) {
            
            [[KLIndicatorViewManager standardIndicatorViewManager] hiddenIndicatorView];
            [[KLPromptViewManager shareInstance] kl_showPromptViewWithTitle:@"温馨提示" theContent:errorMes];
        }];

    }];
    
    /**
     *  协议
     */
    [foot setPushAgreementClickBlock:^{
        
        KLServiceAgreementViewController *vc = [KLServiceAgreementViewController new];
        [KL_weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    return foot;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
