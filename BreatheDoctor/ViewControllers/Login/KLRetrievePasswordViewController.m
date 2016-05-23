//
//  KLRetrievePasswordViewController.m
//  BreatheDoctor
//
//  Created by comv on 16/5/18.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLRetrievePasswordViewController.h"
#import "KLRegisteredViewCell.h"
#import "KLRegistModel.h"
#import "KLRegistPublicFootView.h"
#import "NSString+RegexCategory.h"
#import "KLIndicatorViewManager.h"
#import "KLRegistPublicOperation.h"

@interface KLRetrievePasswordViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *registModels;
@end

@implementation KLRetrievePasswordViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [super addNavBar:@"找回密码"];
    [super addBackButton:@"nav_btnBack"];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.registModels = [[KLRegistModel initializeRegistModels] mutableCopy];
    [self.registModels removeLastObject];
    
    KLRegistModel *model = self.registModels[2];
    model.title = @"新密码";
    
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
            
            [KLRegistPublicOperation senderMessageVcodeTheTimeButton:sender thePhone:[KLRegistModel fieldTextTheIndex:0 withArray:KL_weakSelf.registModels] verifyType:2];
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
    foot.registPublicType = RegistPublicTypeForget;
    
    WEAKSELF
    /**
     *  提交
     */
    [foot setNextButtonClickBlock:^{
        
        NSString *phone = [KLRegistModel fieldTextTheIndex:0 withArray:KL_weakSelf.registModels];
        NSString *vCode = [KLRegistModel fieldTextTheIndex:1 withArray:KL_weakSelf.registModels];
        NSString *pswd =  [KLRegistModel fieldTextTheIndex:2 withArray:KL_weakSelf.registModels];
        
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
        
        [[KLIndicatorViewManager standardIndicatorViewManager] showLoadingWithContent:@"正在找回" theView:KL_weakSelf.view];

        [LWHttpRequestManager httpFindPasswordWithMobilePhone:phone theVerifyCode:vCode theNewPwd:pswd Success:^{
            
            /**
             *  显示修改成功
             */
            [[KLIndicatorViewManager standardIndicatorViewManager] showErrorWith:@"找回成功" theView:KL_weakSelf.view theImage:nil showSucc:^{
                
                [KL_weakSelf.navigationController popViewControllerAnimated:true];
            }];
        } failure:^(NSString *errorMes) {
            
            [[KLIndicatorViewManager standardIndicatorViewManager] hiddenIndicatorView];
            [[KLPromptViewManager shareInstance] kl_showPromptViewWithTitle:@"温馨提示" theContent:errorMes];
        }];
        
    }];
    
    return foot;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
