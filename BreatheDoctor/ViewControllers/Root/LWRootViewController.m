//
//  LWRootViewController.m
//  BreatheDoctor
//
//  Created by comv on 15/11/27.
//  Copyright © 2015年 lwh. All rights reserved.
//

// 写字楼里写字间，写字间里程序员；
// 程序人员写程序，又拿程序换酒钱。
// 酒醒只在网上坐，酒醉还来网下眠；
// 酒醉酒醒日复日，网上网下年复年。
// 但愿老死电脑间，不愿鞠躬老板前；
// 奔驰宝马贵者趣，公交自行程序员。
// 别人笑我忒疯癫，我笑自己命太贱；
// 不见满街漂亮妹，哪个归得程序员？

#import "LWRootViewController.h"
#import "CDMacro.h"
#import "LWPatientListCtr.h"
#import "KLNavigationController.h"
#import "KLHomeViewController.h"

#define kTitleKey   @"kTitleKey"
#define kImgKey     @"kImgKey"
#define kSelImgKey  @"kSelImgKey"

@interface LWRootViewController ()

@end

@implementation LWRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addChildViewControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addChildViewControllers
{

    self.tabBar.backgroundColor = [UIColor whiteColor];

    NSArray *childItemsArray = @[
                                 @{
                                   kTitleKey  : @"工作站",
                                   kImgKey    : @"tab_down_1",
                                   kSelImgKey : @"tab_up_1"},
                                 
                                 @{
                                   kTitleKey  : @"患者",
                                   kImgKey    : @"tab_down_2",
                                   kSelImgKey : @"tab_up_2"},
                                 
                                 @{
                                   kTitleKey  : @"我",
                                   kImgKey    : @"tab_down_3",
                                   kSelImgKey : @"tab_up_3"} ];
    
    [childItemsArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL *stop) {
        
        UIViewController *vc = nil;
        
        if (idx == 0) {
            
            vc = [[KLHomeViewController alloc] init];
        }else if (idx == 1){
        
            vc = [[LWPatientListCtr alloc] initWithListType:LISTTYPEDEFT];
        }else{
        
            vc = StoryboardCtr(@"LWPersonalCtr");
        }
        
        vc.title = dict[kTitleKey];
        KLNavigationController *nav = [[KLNavigationController alloc]initWithRootViewController:vc];
        UITabBarItem *item = nav.tabBarItem;
        item.title = dict[kTitleKey];
        item.image = [UIImage imageNamed:dict[kImgKey]];
        item.selectedImage = [[UIImage imageNamed:dict[kSelImgKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName : systemColor} forState:UIControlStateSelected];
        [self addChildViewController:nav];
    }];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if ([item.title isEqualToString:@"工作站"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:APP_TABBAR_ITM_MESSAGE object:nil];
    }

}

@end
