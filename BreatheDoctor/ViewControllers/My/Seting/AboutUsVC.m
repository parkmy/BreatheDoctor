//
//  AboutUsVC.m
//  ComveeDoctor
//
//  Created by SX on 14-11-3.
//  Copyright (c) 2014年 zhengjw. All rights reserved.
//

#import "AboutUsVC.h"
#import "CDMacro.h"
#import "CDCommontConvenient.h"
#define Distance 216

@interface AboutUsVC ()

@end

@implementation AboutUsVC
#define Blank 25

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        content = @"    “掌控呼吸医生助手”    定位是医生对慢性患者进行健康管理服务的工具。  为医生提供患者的咨询、预约、提醒及随访管理等一系列专业、连续、个性化的患者管理服务,帮助医生更好的管理患者健康及安排自身行程。";
        titleAry = [[NSArray alloc]initWithObjects:@"体征数据",@"的处理和分析",@"全国",@"跟踪支持",@"记录和服务", nil];
        btnAry = [[NSArray alloc]initWithObjects:@"采集和统计",@"智能化",@"知名专家",@"专业随访", nil];
        version = @"";
        
}
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [super addNavBar:NSLocalizedString(@"Personal_AboutUs", @"关于我们")];
    [super addBackButton:@"nav_btnBack"];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addMainView];
}

#pragma mark- 添加主视图

-(void)navLeftButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)addMainView
{
    m_view = [[UIView alloc]initWithFrame:CGRectMake(0, systemNavHeight, self.view.frame.size.width, self.view.frame.size.height-systemNavHeight)];
    if (systemVersion >= 7)
    {
        m_view.frame = CGRectMake(0, systemNavHeight+20, self.view.frame.size.width, self.view.frame.size.height-systemNavHeight-20);
    }
    [self.view addSubview:m_view];
    
    UIImageView *labView = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width-128)/2,75, 128, 118)];
    
    labView.frame = CGRectMake(self.view.frame.size.width/2-90/2, 75,90, 132);

    int distanceH = 132-118;

    
    if (!iPhone6Plus)
    {        labView.image = [UIImage imageNamed:@"4.5.6-切图.png"];
        
    }
    else
    {//270,396
        labView.image = [UIImage imageNamed:@"6P-切图.png"];
    }
    
    [m_view addSubview:labView];
    
    
    [CommentConvenient creatLable:CGRectMake(0, labView.frame.origin.y+labView.frame.size.height-5, m_view.frame.size.width, 14) text:[NSString stringWithFormat:@"V%@",XcodeAppVersion] Color:[UIColor grayColor]  Font:[UIFont systemFontOfSize:14] textAliment:1 Sv:m_view];
    
    CGSize constraint = CGSizeMake(self.view.frame.size.width-2*Blank, 1000.f);
    CGSize size= [content sizeWithFont:[UIFont systemFontOfSize:10] constrainedToWidth:constraint.width];
    UILabel *contentLb = [[UILabel alloc]initWithFrame:CGRectMake(Blank, Distance+distanceH, self.view.frame.size.width-2*Blank, size.height)];
    contentLb.numberOfLines = 0;
    contentLb.backgroundColor = [UIColor clearColor];
    contentLb.text = content;
    contentLb.font = [UIFont fontWithName:FONT size:10];
    contentLb.textColor = [UIColor grayColor];
    [m_view addSubview:contentLb];
    //   titleAry = [[NSArray alloc]initWithObjects:@"体征数据",@"的处理和分析",@"全国",@"跟踪支持",@"记录和服务", nil];
    [CommentConvenient
  creatLable:CGRectMake(Blank,Distance+size.height+31+distanceH,70, 15) text:titleAry[0] Color:[UIColor grayColor] Font:[UIFont fontWithName:FONT size:11]textAliment:0 Sv:m_view];
    
    [CommentConvenient
 creatLable:CGRectMake(self.view.frame.size.width-Blank-80, Distance+size.height+31+distanceH, 90, 15) text:titleAry[1] Color:[UIColor grayColor] Font:[UIFont fontWithName:FONT size:11]textAliment:0 Sv:m_view];
    
    [CommentConvenient
 creatLable:CGRectMake(Blank,Distance+size.height+31*2+15+distanceH, 50, 15) text:titleAry[2] Color:[UIColor grayColor] Font:[UIFont fontWithName:FONT size:11]textAliment:0 Sv:m_view];
    
    [CommentConvenient
 creatLable:CGRectMake(Blank+80,Distance+size.height+31*2+15+distanceH, 70, 15) text:titleAry[3] Color:[UIColor grayColor] Font:[UIFont fontWithName:FONT size:11]textAliment:0 Sv:m_view];
    
    [CommentConvenient
 creatLable:CGRectMake(self.view.frame.size.width-Blank-80,Distance+size.height+31*2+15+distanceH, 78, 15) text:titleAry[4] Color:[UIColor grayColor] Font:[UIFont fontWithName:FONT size:11]textAliment:1 Sv:m_view];
    
    //按钮
    btn1 = [CommentConvenient
 creatButton:CGRectMake(Blank+40, Distance+size.height+29+distanceH, 80,17) Title:btnAry[0] textColor:systemColor NormalBackImage:nil SelectlBackImage:nil Ation:@selector(url:) SubView:m_view AtionTarget:self];
    btn1.tag = 1;
    btn1.titleLabel.font = [UIFont fontWithName:FONT size:14];
    btn1.titleLabel.textAlignment = NSTextAlignmentLeft;
    
    btn2 = [CommentConvenient
 creatButton:CGRectMake(self.view.frame.size.width-154, Distance+size.height+29+distanceH, 55, 17) Title:btnAry[1] textColor:systemColor NormalBackImage:nil SelectlBackImage:nil Ation:@selector(url:) SubView:m_view AtionTarget:self];
    btn2.tag = 2;
    btn2.titleLabel.font = [UIFont fontWithName:FONT size:14];
    btn2.titleLabel.textAlignment = NSTextAlignmentRight;
    
    btn3 = [CommentConvenient
 creatButton:CGRectMake(Blank+19, Distance+size.height+29*2+17+distanceH, 65, 17) Title:btnAry[2] textColor:systemColor NormalBackImage:nil SelectlBackImage:nil Ation:@selector(url:) SubView:m_view AtionTarget:self];
    btn3.tag = 3;
    btn3.titleLabel.font = [UIFont fontWithName:FONT size:14];
    btn3.titleLabel.textAlignment = NSTextAlignmentLeft;
    
    btn4 = [CommentConvenient
 creatButton:CGRectMake(self.view.frame.size.width-154, Distance+size.height+29*2+17+distanceH, 65, 17) Title:btnAry[3] textColor:systemColor NormalBackImage:nil SelectlBackImage:nil Ation:@selector(url:) SubView:m_view AtionTarget:self];
    btn4.tag = 4;
    btn4.titleLabel.font = [UIFont fontWithName:FONT size:14];
    btn4.titleLabel.textAlignment = NSTextAlignmentRight;
    
    //版本号
    [CommentConvenient
 creatLable:CGRectMake(0, 160+distanceH, self.view.frame.size.width, 20) text:version Color:[UIColor grayColor] Font:[UIFont fontWithName:FONT size:15] textAliment:1 Sv:m_view];
    
}

#pragma mark- ButtonAction
-(void)url:(UIButton *)sender
{
    int i = (int)sender.tag;
    switch (i)
    {
        case 1:
            break;
        case 2:
            break;
        case 3:
            break;
        case 4:
            break;
        default:
            break;
    }
}

@end
