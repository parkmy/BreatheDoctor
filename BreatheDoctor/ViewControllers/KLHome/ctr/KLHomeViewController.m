//
//  KLHomeViewController.m
//  COButton
//
//  Created by liaowh on 16/6/2.
//  Copyright © 2016年 comv. All rights reserved.
//

#import "KLHomeViewController.h"
#import "KLNavigationBarView.h"
#import "KLHomeItmModel.h"
#import <UIButton+WebCache.h>
#import "KLHomeFlowLayout.h"
#import "LWLoginManager.h"
#import "KLIndicatorViewManager.h"
#import "KLRegistPublicOperation.h"
#import "KLMessageViewController.h"
#import "KLMessageOperation.h"
#import "KLPatientOperation.h"
#import "KLMedicalToolViewController.h"
#import "KLGuideViewController.h"
#import "KLHomeMenuCollectionViewCell.h"
#import "KLHomeInforMationCollectionViewCell.h"
#import "KLHomeBannerCollectionReusableView.h"
#import "KLHomeMoreConsultingCollectionReusableView.h"

@interface KLHomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *homeCollectionView;
@property (nonatomic, strong) NSMutableArray   *homeDataArray;
@property (nonatomic, strong) UIWebView        *phoneNumberSender;
@property (nonatomic, strong) UIButton         *userIconImageView;
@property (nonatomic, strong) UILabel          *userCheckStatus;
@end

@implementation KLHomeViewController
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    
    [self loginjudge];
    
    [self registHomeNotificationCenter];
    
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    /**
     *  刷新消息属性
     */
    [KLMessageOperation shareInstance].showVc = nil;
    [KLMessageOperation shareInstance].source = nil;
    [KLMessageOperation shareInstance].tableView = nil;
    
    [self changeBadgeLabel];

}

- (void)setup{
    
    [super addNavBar:@"首页"];
    
    self.homeDataArray = [KLHomeItmModel getInitHomeItms];
    [self.view addSubview:self.homeCollectionView];
    self.homeCollectionView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(64, 0, 0, 0));
    
    KLNavigationBarView *navBar = self.barView;
    [navBar addSubview:self.userIconImageView];
    [navBar addSubview:self.userCheckStatus];
    
    self.userIconImageView.frame = CGRectMake(12, 20+7, 30, 30);
    self.userCheckStatus.frame = CGRectMake(35, 25, 30, 14);
    [self.userIconImageView setCornerRadius:self.userIconImageView.width/2];
    [self.userCheckStatus setCornerRadius:4.0f];
}
- (void)registHomeNotificationCenter{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSucc:) name:APP_LOGIN_SUCC object:nil];
}
#pragma mark -  event
- (void)userIconTap:(UIButton *)sender{
   
//    if ([LBLoginBaseModel isCheckStatusTheIsShow:YES]) {
    
        [self.navigationController pushViewController:[UIViewController CreateControllerWithTag:CtrlTag_PersonalCenter] animated:YES];
//    }
}

#pragma mark - void
- (UILabel *)getbadgeLabel{

    KLHomeMenuCollectionViewCell *cell = (KLHomeMenuCollectionViewCell *)[self.homeCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    return cell.badgeLabel;
}
- (KLHomeMenuCollectionViewCell *)getPatientCountCell{

    return (KLHomeMenuCollectionViewCell *)[self.homeCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];;
}
- (void)changeUserCheckState{

    LBLoginBaseModel *user = [CODataCacheManager shareInstance].userModel;
    
    [self.userIconImageView sd_setImageWithURL:kNSURL(user.body.perRealPhoto) forState:UIControlStateNormal placeholderImage:kImage(@"personalcenter_14.png")];
    
    if (![LBLoginBaseModel isCheckStatusTheIsShow:NO]) {
        
//        ff684a  59b53a
        self.userCheckStatus.backgroundColor = [UIColor colorWithHexString:@"#ff684a"];
        self.userCheckStatus.text = @"未认证";
    }else{
        
        self.userCheckStatus.backgroundColor = [UIColor colorWithHexString:@"#59b53a"];
        self.userCheckStatus.text = @"已认证";
    }
    
}
/**
 * 登陆成功
 */
- (void)loginSucc:(NSNotificationCenter *)sender{
    
    [[KLPromptViewManager shareInstance] kl_showPromptViewWithTitle:@"温馨提示" theContent:@"登陆成功O(∩_∩)O~"];
    
    
    [[KLMessageOperation shareInstance] refreshHomeMsg];
    
    [[KLIndicatorViewManager standardIndicatorViewManager] showLoadingWithContent:@"初始化中" theView:self.view];
    [self changeBadgeLabel];
    
    [self changeUserCheckState];

}
- (void)changeBadgeLabel{

    WEAKSELF
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [KLMessageOperation shareInstance].badgeLabel = [KL_weakSelf getbadgeLabel];
        [[KLMessageOperation shareInstance] loadCacheMesg];
        [[KLMessageOperation shareInstance] refreshHomeMsg];
        
        [KL_weakSelf changePatientCountLabel];
    });
}
- (void)changePatientCountLabel{

    WEAKSELF
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [KLPatientOperation loadCachePatientListSucc:^(NSMutableArray *dataArray, NSString *refTimer) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                KLHomeMenuCollectionViewCell *cell = [KL_weakSelf getPatientCountCell];
                [cell setPatientCountWith:dataArray.count];
            });
         
            
            [KLPatientOperation httploadPatientListTheRefreshDate:refTimer Succ:^(NSArray *list) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    KLHomeMenuCollectionViewCell *newcell = [KL_weakSelf getPatientCountCell];
                    [newcell setPatientCountWith:dataArray.count + list.count];
                });
             
            } failure:^(NSString *errorMes) {
            }];
            
        }];
        
    });
    


}
/**
 *  判断登录
 */
- (void)loginjudge
{
    BOOL isLogin = [LWLoginManager isLogin];
    if (!isLogin)
    {
        [[LWLoginManager shareInstance] showLoginViewNav:self];
    }else
    {
        [self changeUserCheckState];
        
        [LBLoginBaseModel updateUserModel];
        /**
         *  延迟判断是否认证
         */
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [KLRegistPublicOperation notCertificationAgainIfCertificationSuccess:^(BOOL isCheck) {
                
            }];
        });
//        [self loadCacheMes];
    }
}
#pragma mark - init
- (UICollectionView *)homeCollectionView{
    
    if (!_homeCollectionView) {
        
        _homeCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[KLHomeFlowLayout alloc] init]];
        _homeCollectionView.showsHorizontalScrollIndicator = false;
        _homeCollectionView.showsVerticalScrollIndicator = false;
        _homeCollectionView.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
        _homeCollectionView.dataSource = self;
        _homeCollectionView.delegate = self;
        
        [_homeCollectionView registerClass:[KLHomeMenuCollectionViewCell class] forCellWithReuseIdentifier:@"KLHomeMenuCollectionViewCell"];
        [_homeCollectionView registerClass:[KLHomeInforMationCollectionViewCell class] forCellWithReuseIdentifier:@"KLHomeInforMationCollectionViewCell"];
        [_homeCollectionView registerClass:[KLHomeBannerCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"KLHomeBannerCollectionReusableView"];
        [_homeCollectionView registerClass:[KLHomeMoreConsultingCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"KLHomeMoreConsultingCollectionReusableView"];

    }
    return _homeCollectionView;
}
- (UIWebView *)phoneNumberSender{
    
    if (!_phoneNumberSender) {
        _phoneNumberSender = [UIWebView new];
        [self.view addSubview:_phoneNumberSender];
    }
    return _phoneNumberSender;
}
- (UIButton *)userIconImageView{

    if (!_userIconImageView) {
        
        _userIconImageView = [UIButton buttonWithType:UIButtonTypeCustom];
        [_userIconImageView addTarget:self action:@selector(userIconTap:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _userIconImageView;
}
- (UILabel *)userCheckStatus{

    if (!_userCheckStatus) {
        
        _userCheckStatus = [UILabel new];
        _userCheckStatus.textAlignment = 1;
        _userCheckStatus.textColor = [UIColor whiteColor];
        _userCheckStatus.font = kNSPXFONT(18);
    }
    return _userCheckStatus;
}

#pragma mark -UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return self.homeDataArray.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [(NSMutableArray *)self.homeDataArray[section] count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    
    if (indexPath.section == 0) {
        
        KLHomeMenuCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KLHomeMenuCollectionViewCell" forIndexPath:indexPath];
        //    cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
        NSMutableArray *array = (NSMutableArray *)self.homeDataArray[indexPath.section];
        KLHomeItmModel *model = [array objectAtIndex:indexPath.row];
        [cell setModel:model];
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
        
    }else{
        
        KLHomeInforMationCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KLHomeInforMationCollectionViewCell" forIndexPath:indexPath]; 
        return cell;
    }
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (0 == indexPath.section) {
        
        if (kind == UICollectionElementKindSectionHeader) {
            
            KLHomeBannerCollectionReusableView *homeBannerCollectionReusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"KLHomeBannerCollectionReusableView" forIndexPath:indexPath];
            
            WEAKSELF
            [[homeBannerCollectionReusableView rac_signalForSelector:@selector(cycleScrollView:didSelectItemAtIndex:)] subscribeNext:^(id x) {
                
                KLGuideViewController *vc = [KLGuideViewController new];
                vc.hidesBottomBarWhenPushed = YES;
                [KL_weakSelf.navigationController pushViewController:vc animated:YES];
            }];
            
            
            return homeBannerCollectionReusableView;
        }
        return nil;
    }else if (1 == indexPath.section){
        
        if (kind == UICollectionElementKindSectionHeader) {
            
            KLHomeMoreConsultingCollectionReusableView *homeMoreConsultingCollectionReusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"KLHomeMoreConsultingCollectionReusableView" forIndexPath:indexPath];
            return homeMoreConsultingCollectionReusableView;
        }
        return nil;
    }
    return nil;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    if (0 == indexPath.section) {
        
        switch (indexPath.row) {
            case 0:
            {
                KLMessageViewController *vc = [KLMessageViewController new];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 1:
            {
                if (![LBLoginBaseModel isCheckStatusTheIsShow:YES]) {
                    return;
                }
                UIViewController *vc = [UIViewController CreateControllerWithTag:CtrlTag_AddPatient];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 2:
            {
                if (![LBLoginBaseModel isCheckStatusTheIsShow:YES]) {
                    return;
                }
                UIViewController *vc = [UIViewController CreateControllerWithTag:CtrlTag_TimerRemind];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 3:
            {
                if (![LBLoginBaseModel isCheckStatusTheIsShow:YES]) {
                    return;
                }
                KLMedicalToolViewController *vc = [KLMedicalToolViewController new];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];

            }
                break;
            case 4:
            {
                NSString *allString = [NSString stringWithFormat:@"tel:4007-038-039"];
                NSURL *telURL =[NSURL URLWithString:allString];
                [self.phoneNumberSender loadRequest:[NSURLRequest requestWithURL:telURL]];
                
                
            }
                break;
            default:
                break;
        }
    }
}


@end
