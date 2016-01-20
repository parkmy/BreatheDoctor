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

@interface LWRootViewController ()

@end

@implementation LWRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loginTabbar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loginTabbar
{
    self.tabBar.hidden=NO;
    //5个视图控制器--对应5个模块
    UIViewController *vc1  = StoryboardCtr(@"LWMessageCtr");
    UIViewController *vc2  = StoryboardCtr(@"LWPatientListCtr");
    UIViewController *vc3  = StoryboardCtr(@"LWPersonalCtr");
    
    //5个导航控制器--对应上述5个视图
    UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:vc1];
    UINavigationController *nav2 =[[UINavigationController alloc]initWithRootViewController:vc2];
    UINavigationController *nav3 =[[UINavigationController alloc]initWithRootViewController:vc3];
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    //nav_third
    NSArray *NavConnections=[[NSArray alloc] initWithObjects:nav1,nav2,nav3, nil];
    self.viewControllers=NavConnections;
    
    if (systemVersion>=7.0) {
        [self.tabBar setTintAdjustmentMode:UIViewTintAdjustmentModeNormal];
    }
    self.tabBar.itemPositioning = UITabBarItemPositioningAutomatic;
    //self.tabBar.delegate = self;
    
    [self.tabBar setTintColor:CUSTOM_COLOR(73, 146, 59, 1.0)];
    [self.tabBar setSelectedImageTintColor:systemColor];
    
    UIOffset sets = UIOffsetMake(0, -2);
    nav1.tabBarItem.titlePositionAdjustment = sets;
    [nav1.tabBarItem setTitle:@"消息"];
    
    nav2.tabBarItem.titlePositionAdjustment = sets;
    [nav2.tabBarItem setTitle:@"患者"];
    
    
    nav3.tabBarItem.titlePositionAdjustment = sets;
    [nav3.tabBarItem setTitle:@"我"];
    
    UIImage *selectedImg=nil;
    
    selectedImg=[UIImage imageNamed:@"tab_up_1"];
    if (systemVersion>=7) {
        selectedImg=[selectedImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    [nav1.tabBarItem setFinishedSelectedImage:selectedImg withFinishedUnselectedImage:[UIImage imageNamed:@"tab_down_1"]];
    
    selectedImg=[UIImage imageNamed:@"tab_up_2"];
    if (systemVersion>=7) {
        selectedImg=[selectedImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    [nav2.tabBarItem setFinishedSelectedImage:selectedImg withFinishedUnselectedImage:[UIImage imageNamed:@"tab_down_2"]];
    
    selectedImg=[UIImage imageNamed:@"tab_up_3"];
    if (systemVersion>=7) {
        selectedImg=[selectedImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
    [nav3.tabBarItem setFinishedSelectedImage:selectedImg withFinishedUnselectedImage:[UIImage imageNamed:@"tab_down_3"]];
    
    selectedImg=[UIImage imageNamed:@"tab_up_5"];
    if (systemVersion>=7) {
        selectedImg=[selectedImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    self.selectedIndex=0;
    
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if ([item.title isEqualToString:@"消息"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:APP_TABBAR_ITM_MESSAGE object:nil];
    }

}

@end
