//
//  CDMacro.h
//  ComveeDoctor
//
//  Created by zhengjw on 14-7-27.
//  Copyright (c) 2014年 zhengjw. All rights reserved.
//

#ifndef ComveeDoctor_CDMacro_h
#define ComveeDoctor_CDMacro_h

#import "AppDelegate.h"

#define appDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)
#define currentNavigationController  appDelegate.rootViewConttroller.selectedViewController.navigationController

#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

//#define VersionNum 210            //v1.3.1 ver就传 131
////渠道
////#define ChannelId @"QQ3群"
////#define ChannelId @"本地服务器"
////#define ChannelId @"App Store"
// #define ChannelId @"91助手"
////#define ChannelId @"同步推"
////#define ChannelId @"PP助手"
////渠道数字
////#define ChannelNum @"q103"
////#define ChannelNum @"k800"
////#define ChannelNum @"k801"
////#define ChannelNum @"k802"
////#define ChannelNum @"k803"
//
////xxx-xx(02ios)-xxx(01:正式 03:企业 99:测试)
//#define ChannelNum @"1010203"
//
//#define Join_Id @"comveeiPhone"
//
//#define FILEPATH @"FilePath" 
//
#define DBDIR   @"comveeDB"
//
//#define ImageFilePath @"/ChatCaches/ThumbNail"
//
//#define SoundFilePath @"/ChatCaches/chatSound"
//
//
////字体
#define FONT @"HelveticaNeue"
#define FONT_BOLD @"HelveticaNeue-Bold"

//友盟APPKEY
//53e0407dfd98c5be120251e9
//
#define UMENG_KEY @"53e0407dfd98c5be120251e9"

#define QQAppId @"1104806175"
#define QQAppKey @"daxo97rvcjpAtAq6"
//微博、微信注册ID
#define wxID @"wx1fd9031080e2ebc4"
#define wxSecret @"7a07c2b8f1f3d8ec4ca00c31a2d37c67"
#define sinaKey @"2221450207"
#define sinaSecret @"336134a80fe2bbd7e7715e5765ccd142"

#define ShareSDKKey @"b462825a82f0"

//#define iPhone6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828,1472), [[UIScreen mainScreen] currentMode].size) : NO)
//{1125, 2001}
//暂时已320作为6与6+的区别条件
#define iPad         (screenWidth > 750 ? YES : NO)
#define iPhone6Add   (screenWidth > 375 ? YES : NO)
#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242,2208), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(828,1472), [[UIScreen mainScreen] currentMode].size)|| CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size): NO)

#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size)) : NO)

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define screenWidth [[UIScreen mainScreen] bounds].size.width
#define screenHeight [[UIScreen mainScreen] bounds].size.height

#define sizeScaleX ((screenHeight<=480)?1.0f:screenWidth/320)
#define sizeScaleY ((screenHeight<=480)?1.0f:screenHeight/568)
#define FontScale iPhone6Plus?1.5:1

CG_INLINE CGRect CGRectMakeFit(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    CGRect rect;
    rect.origin.x = x * sizeScaleX;
    rect.origin.y = y * sizeScaleY;
    rect.size.width = width * sizeScaleX;
    rect.size.height = height * sizeScaleY;
    return rect;
}

#define systemVersion [[[UIDevice currentDevice] systemVersion] floatValue]    //系统版本号
#define XcodeAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define ios7Height ([[[UIDevice currentDevice] systemVersion] floatValue]>=7?20:0)

//系统导航设置高度
#define systemNavHeight 44
#define systemTabbarHeight 50

#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]


#define systemColor [LWThemeManager shareInstance].navBackgroundColor//系统配色
//#define BackgroundColor [UIColor colorWithRed:242.0f/255.0f green:240.0f/255.0f blue:235.0f/255.0f alpha:1.0f]//背景配色

#define viewBackgroundColor [UIColor colorWithRed:244/255.0f green:244/255.0f blue:244/255.0f alpha:1.0f]
//线条颜色
#define LineColor [UIColor colorWithRed:0xd9/255.0 green:0xd9/255.0 blue:0xd9/255.0 alpha:1.0]

#define LINEWIDTH 0.5
#define CORNERRADIUS 5.0
#define BORDERWIDTH 0.5
//表数据颜色
#define maxDataColor [UIColor colorWithRed:0xff/255.0f green:0x33/255.0f blue:0x00/255.0f alpha:1.0f]
#define mixDataColor CUSTOM_COLOR(0x3d, 0x86, 0xff, 1.0)

#define normalDataColor [UIColor colorWithRed:0x6b/255.0f green:0xcd/255.0f blue:0x14/255.0f alpha:1.0f]

#define CUSTOM_COLOR(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]



//消息横条类型
#define  SALAlertBannerStyleSuccess  0
#define  SALAlertBannerStyleFailure 1
#define  SALAlertBannerStyleNotify 2
#define  SALAlertBannerStyleWarning 3
//消息横条弹出方式
#define  SALAlertBannerPositionTop 0
#define  SALAlertBannerPositionBottom 1
#define  SALAlertBannerPositionUnderNavBar 2


//超时
#define CONNECT_TIMEOUT 8//超时时间


#define CommentConvenient   [CDCommontConvenient shareCDcomment]

///请求创建医患关系
static NSString * APP_PUSH_TYPE_REQUEST_RELATION = @"APP_PUSH_TYPE_REQUEST_RELATION";
///PEF记录
static NSString * APP_PUSH_TYPE_PEF_RECORD = @"APP_PUSH_TYPE_PEF_RECORD";
/// ACT评估
static NSString * APP_PUSH_TYPE_ASSESS_ACT = @"APP_PUSH_TYPE_ASSESS_ACT";
///哮喘症状评估
static NSString * APP_PUSH_TYPE_ASSESS_ASTHMA = @"APP_PUSH_TYPE_ASSESS_ASTHMA";
///首诊
static NSString * APP_PUSH_TYPE_FIRST_DIAGNOSE = @"APP_PUSH_TYPE_FIRST_DIAGNOSE";
///复诊通知
static NSString * APP_PUSH_TYPE_REPEAT_TREATMENT_INFORM = @"APP_PUSH_TYPE_REPEAT_TREATMENT_INFORM";
///患者添加对话通知
static NSString * APP_PUSH_TYPE_PATIENT_ADD_DIALOGUE = @"APP_PUSH_TYPE_PATIENT_ADD_DIALOGUE";
///发送诊断模块成
static NSString * APP_PUSH_TYPE_SENDERZHENGDUANMOKUAISUCC = @"APP_PUSH_TYPE_SENDERZHENGDUANMOKUAISUCC";

///点击消息
static NSString * APP_TABBAR_ITM_MESSAGE = @"APP_TABBAR_ITM_MESSAGE";

///登陆成功
static NSString * APP_LOGIN_SUCC         = @"APP_LOGIN_SUCC";

///添加成功
static NSString * APP_ADDPATIENT_SUCC    = @"APP_ADDPATIENT_SUCC";

///PEFSHOW
static NSString * APP_LOG_PEFSHOW         = @"APP_LOG_PEFSHOW";

///修改成功
static NSString * APP_UPDATEPATIENT_SUCC    = @"APP_UPDATEPATIENT_SUCC";

/**
 *  认证通过certification
 */
static NSString * APP_PUSH_TYPE_CERTIFICATION_SUCC    = @"APP_CERTIFICATION_SUCC";

typedef NS_ENUM(NSInteger ,showTheFormType) {
    showTheFormTypeBiaoDan = 0, //表单
    showTheFormTypeMouKuai , //模块
    showTheFormTypeMouKuaiNoSucc ,//未完成
    showTheFormTypeMouKuaiSucc ,//完成

};



#endif

