//
//  PatientAddViewController.m
//  ComveeDoctor
//
//  Created by JYL on 14-8-1.
//  Copyright (c) 2014年 zhengjw. All rights reserved.
//

#import "PatientAddVC.h"
#import "CDMacro.h"
#import "UIImageView+AFNetworking.h"
#import "CDCommontConvenient.h"
#import "CODataCacheManager.h"

#define LeftLableTextColor [UIColor colorWithRed:self.view.frame.size.width/2-1502.0/255.0f green:self.view.frame.size.width/2-1502.0/255.0f blue:self.view.frame.size.width/2-1502.0/255.0f alpha:1.0f]
#define RightLableTextColor [UIColor colorWithRed:51.0/255.0f green:51.0/255.0f blue:51.0/255.0f alpha:1.0f]


@interface PatientAddVC ()

@end

@implementation PatientAddVC
@synthesize fatherControl,imgName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dealloc
{
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initialize];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [super addNavBar:@"添加患者"];
    [super addBackButton:@"nav_btnBack.png"];
}


- (void)initialize
{
    
    self.view.backgroundColor = [UIColor blackColor];
    
    m_view=[[UIView alloc]initWithFrame:CGRectMake(0,systemNavHeight, self.view.frame.size.width, self.view.frame.size.height-systemNavHeight)] ;
    if(systemVersion>=7)
    {
        m_view.frame = CGRectMake(0, 20+systemNavHeight, self.view.frame.size.width, self.view.frame.size.height-systemNavHeight-20);
    }
    
    m_view.backgroundColor = [UIColor colorWithHexString:@"#999999"];
    
    [self.view addSubview:m_view];
  
    int height = 392+70;
    
    UIImage * image  = [UIImage imageNamed:@"yisheng_06"];
    int Distance = 0;
    //{1125, 2001}
    NSLog(@"%@",NSStringFromCGSize([[UIScreen mainScreen] currentMode].size));
    if (iPhone4)
    {
        Distance = 15;
        image =[UIImage imageNamed:@"yisheng_4s"];
        height =337+60;
    }
    else if (iPhone6)
    {
        if ( CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size))
        {
            height+=70;
        }
        else
        {
            height+=80;
        }
        
        
        image =[UIImage imageNamed:@"yisheng_@3x"];
    }
    else if (iPhone6Plus)
    {
        if (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size))
        {
            height+=100;
        }
        else
        {
            height+=120;
        }
        
        
        image =[UIImage imageNamed:@"yisheng_@3x"];
    }
    // 左端盖宽度
    NSInteger leftCapWidth = image.size.width * 0.1f;
    // 顶端盖高度
    NSInteger topCapHeight = image.size.width * 0.9f;
    // 重新赋值
    image = [image stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
    
    scanView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 20-Distance, self.view.frame.size.width-20, height)];
    scanView.image = image;
    [m_view addSubview:scanView];
    
    [CommentConvenient creatLable:CGRectMake(0, 20, scanView.frame.size.width, 17) text:@"用微信扫一扫加我" Color:[UIColor colorWithRed:0x00/255.0 green:0x00/255.0 blue:0x00/255.0 alpha:1.0] Font:[UIFont systemFontOfSize:17] textAliment:NSTextAlignmentCenter Sv:scanView];
    
    UILabel * lable = [CommentConvenient creatLable:CGRectMake(15, 65,scanView.frame.size.width-30, 40) text:@"患者用微信扫一扫加我，即可和我建立联系" Color:[UIColor colorWithRed:0x99/255.0 green:0x99/255.0 blue:0x99/255.0 alpha:1.0] Font:[UIFont systemFontOfSize:14] textAliment:NSTextAlignmentLeft Sv:scanView];
    lable.numberOfLines = 0;
    
//    NSMutableArray * arry0 =[[CDGloablVar sharedGloablVar].doctorData objectAtIndex:0];
//    NSMutableArray * arry =[[CDGloablVar sharedGloablVar].doctorData objectAtIndex:1];
    
    image  = [UIImage imageNamed:@"yisheng_03"];
    
    // 左端盖宽度
    leftCapWidth = image.size.width * 0.5f;
    // 顶端盖高度
    topCapHeight = image.size.width * 0.5f;
    // 重新赋值
    image = [image stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
    CGRect frame =CGRectMake(47, 125, scanView.frame.size.width-94, scanView.frame.size.width-94);
    UIImage * scanimgs =[UIImage imageNamed:@"ysiheng_03"];
    if (iPhone4)
    {
        frame =CGRectMake(scanView.frame.size.width/2-180/2, 110, 180, 180);
        scanimgs = [UIImage imageNamed:@"yisheng_4s"];
    }
    UIImageView * scanImg = [[UIImageView alloc]initWithFrame:frame];
    scanImg.image = [UIImage imageNamed:@"ysiheng_03"];
    [scanView addSubview:scanImg];

    
     codeImg = [[ UIImageView alloc]initWithFrame:CGRectMake(8, 8, scanImg.frame.size.width-16,scanImg.frame.size.height-16)];
    
    
    LBLoginBaseModel *user = [CODataCacheManager shareInstance].userModel;
    
    [codeImg setImageWithURL:[NSURL URLWithString:user.body.qrcodePath] placeholderImage:nil];
    
   // imgName = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[arry objectAtIndex:[arry count]-2]]]];
    
    [scanImg addSubview:codeImg];
    
    
    NSString * name = user.body.perName;
    NSString * professional =user.body.positionText;
    NSString * num = @"";
    
    
    CGSize size = [name sizeWithFont:[UIFont systemFontOfSize:16] constrainedToHeight:20.0f];
    [CommentConvenient creatLable:CGRectMake(15, scanView.frame.size.height -26,size.width, 16) text:name  Color:[UIColor colorWithRed:0x33/255.0 green:0x33/255.0 blue:0x33/255.0 alpha:1.0] Font:[UIFont systemFontOfSize:16] textAliment:NSTextAlignmentLeft Sv:scanView];
    
    CGSize sizes = [professional sizeWithFont:[UIFont systemFontOfSize:12] constrainedToHeight:20.0f];
    
    [CommentConvenient creatLable:CGRectMake(15+size.width+5, scanView.frame.size.height -24,sizes.width, 12) text:professional  Color:[UIColor colorWithRed:0x33/255.0 green:0x33/255.0 blue:0x33/255.0 alpha:1.0] Font:[UIFont systemFontOfSize:12] textAliment:NSTextAlignmentLeft Sv:scanView];
    
    CGSize sizes1 = [num sizeWithFont:[UIFont systemFontOfSize:12] constrainedToHeight:20.0f];
    
    [CommentConvenient creatLable:CGRectMake(scanView.frame.size.width-sizes1.width-15, scanView.frame.size.height -24,sizes1.width, 12) text:num  Color:[UIColor colorWithRed:0x33/255.0 green:0x33/255.0 blue:0x33/255.0 alpha:1.0] Font:[UIFont systemFontOfSize:12] textAliment:NSTextAlignmentCenter Sv:scanView];
    
    [CommentConvenient creatLable:CGRectMake(scanView.frame.size.width-sizes1.width-15-38, scanView.frame.size.height -26,35,16) text:@"编号"  Color:[UIColor colorWithRed:0x00/255.0 green:0x33/255.0 blue:0x33/255.0 alpha:1.0] Font:[UIFont systemFontOfSize:16] textAliment:NSTextAlignmentCenter Sv:scanView];
     
}

- (void)navLeftButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
