//
//  PatientTaskDescribeVC.m
//  ComveeDoctor
//
//  Created by Comvee on 14-9-11.
//  Copyright (c) 2014年 zhengjw. All rights reserved.
//

#import "PatientTaskDescribeVC.h"
#import "CDMacro.h"
//#import "PatientNewAddTaskVC.h"
#import "FastReplyVC.h"
//#import "ShareFun.h"

@interface PatientTaskDescribeVC ()

@end

@implementation PatientTaskDescribeVC
@synthesize textFiled;
@synthesize NavTitle;
@synthesize TaskDescribe;
@synthesize editView;
@synthesize placeLabel;
@synthesize numberLabel;
@synthesize number;
@synthesize currentPath;
@synthesize fastVc;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    if (self.view.tag>=1)
    {
        [super addNavBar:@"编辑"];
    }
    else if (self.view.tag==-1)
    {
        [super addNavBar:@"添加"];
         placeLabel.text =@"请输入您想添加的快捷回复内容。。。";
    }
    
    [super addBackButton:@"nav_btnBack.png"];
    [super addRightButton:NSLocalizedString(@"NAV_SAVE_PATIENT", "保存")];
    
    if (self.view.tag<=0||self.view.tag>14)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardHild) name:UIKeyboardWillHideNotification object:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [editView becomeFirstResponder];
        });
    }

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self initialize];
}

- (void)initialize
{
        
    m_view=[[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)] ;
    [self.view addSubview:m_view];
    
    editView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, m_view.frame.size.width, 220)];
    editView.delegate = self;
    editView.font = [UIFont fontWithName:FONT size:15];
    editView.backgroundColor = [UIColor whiteColor];
    [m_view addSubview:editView];
    
    placeLabel = [[UILabel alloc]initWithFrame:CGRectMake(7, 7,200, 20)];
    placeLabel.text =@"请输入...";
    placeLabel.enabled = NO;
    placeLabel.backgroundColor = [UIColor clearColor];
    placeLabel.font = [UIFont fontWithName:FONT size:15];
    [editView addSubview:placeLabel];
    
    
    [self setLineViewWidth:0 height:0];
    
    backView = [[UIView alloc]initWithFrame:CGRectMake(0, 220, m_view.frame.size.width, 20)];
    backView.backgroundColor = [UIColor whiteColor];
    [m_view addSubview:backView];
    
    
    UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(0, backView.frame.size.height-1, backView.frame.size.width, 1)];
    lab.backgroundColor = LineColor;
    [backView addSubview:lab];


    number = 0;
    numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0,screenWidth-30, 20)];
    numberLabel.text = [NSString stringWithFormat:@"%d/500",number];
    numberLabel.font = [UIFont fontWithName:FONT size:13];
    numberLabel.textColor = [UIColor blueColor];
    numberLabel.textAlignment = NSTextAlignmentRight;
    [backView addSubview:numberLabel];
    
    
}

- (void)setLineViewWidth:(int)x height:(int)y
{
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, y, self.view.frame.size.width, 1)];
    lineView.backgroundColor = LineColor;
    [editView addSubview:lineView];
}

- (void)navRightButtonAction
{
    if (editView.text.length < 1)
    {
        [LWProgressHUD showALAlertBannerWithView:self.view Style:SALAlertBannerStyleWarning  Position:SALAlertBannerPositionTop Subtitle:@"内容不能未空"];
    }else
    {//添加快捷回复
        if (self.view.tag==-1)
        {
            [fastVc.msgArray addObject:editView.text];
            fastVc.isDelete = YES;
            [fastVc navRightButtonAction];
            [CODataCacheManager shareInstance].fastReplys = fastVc.msgArray;
            [[CODataCacheManager shareInstance] updateReply:fastVc.msgArray];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        else if (self.view.tag>0)
        {
            [fastVc.msgArray replaceObjectAtIndex:self.view.tag-1 withObject:editView.text];
            [CODataCacheManager shareInstance].fastReplys = fastVc.msgArray;
            [[CODataCacheManager shareInstance] updateReply:fastVc.msgArray];
            NSIndexPath * path = [NSIndexPath indexPathForItem:self.view.tag-1 inSection:0];
            [fastVc.m_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:path,nil] withRowAnimation:  UITableViewRowAnimationNone];
            fastVc.isDelete = YES;
            [fastVc navRightButtonAction];
            [self.navigationController popViewControllerAnimated:YES];
        }
       else
       {
//           [_newAdd.detailData replaceObjectAtIndex:1 withObject:editView.text];
//           
//           [self.navigationController popViewControllerAnimated:YES];
//           [_newAdd.tableViews reloadRowsAtIndexPaths:[NSArray arrayWithObjects:currentPath,nil] withRowAnimation:UITableViewRowAnimationNone];
       }
        
      
    }

}

#pragma mark - 导航控件
- (void)navLeftButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark- 代理方法
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (self.view.tag<15&&self.view.tag>0)
    {
        [textView resignFirstResponder];
        [LWProgressHUD showALAlertBannerWithView:self.view Style:SALAlertBannerStyleWarning  Position:SALAlertBannerPositionTop Subtitle:@"系统模板，无法修改" ];
    }
    else
    {
        if(!previousTextViewContentHeight)
            previousTextViewContentHeight = textView.contentSize.height;
    }
   
}

//设置最大编辑字数
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    BOOL ifCandEdit=YES;
    
    if (textView.text.length > 499)
    {
        if (text.length<1)
        {
            ifCandEdit=YES;
        }
        else
        {
             ifCandEdit=NO;
        }
       
    }
    
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    
    return ifCandEdit;
}

-(void)textViewDidChange:(UITextView *)textView
{
//    placeLabel.text =  textView.text;
    if (textView.text.length == 0)
    {
        placeLabel.text = @"请输入...";
    }else
    {
        placeLabel.text = @"";
    }
    number = (int)[editView.text length];
    numberLabel.text = [NSString stringWithFormat:@"%d/500",number];
    
    CGFloat maxHeight = textView.frame.size.height;
    CGSize size = [textView sizeThatFits:CGSizeMake(textView.frame.size.width, maxHeight)];
    CGFloat textViewContentHeight = size.height;
    BOOL isShrinking = textViewContentHeight < previousTextViewContentHeight;
    CGFloat changeInHeight = textViewContentHeight - previousTextViewContentHeight;
    
    if(!isShrinking && previousTextViewContentHeight == maxHeight) {
        changeInHeight = 0;
    }
    else {
        changeInHeight = MIN(changeInHeight, maxHeight - previousTextViewContentHeight);
    }
    
    if(changeInHeight != 0.0f)
    {
        [UIView animateWithDuration:0.25f
                         animations:^{
                             UIEdgeInsets insets = UIEdgeInsetsMake(0.0f,
                                                                    0.0f,
                                                                   textView.contentInset.bottom + changeInHeight,
                                                                    0.0f);
                             
                             editView.contentInset = insets;
                             
                             editView.scrollIndicatorInsets = insets;
                             
                             
                         }
                         completion:^(BOOL finished) {
                         }];
        
        
        previousTextViewContentHeight = MIN(textViewContentHeight, maxHeight);
    }
    
}

- (void)adjustTextViewHeightBy:(CGFloat)changeInHeight
{

//    CGRect prevFrame = editView.frame;
//    
//    float height = MIN(prevFrame.size.height + changeInHeight, editView.frame.size.height-10);
//
//    height = MAX(height, prevFrame.size.height);
//    editView.frame = CGRectMake(0,
//                                 0,
//                                 prevFrame.size.width,
//                                 height);

    
}

#pragma mark 输入框限定设置
-(void)keyBoardShow:(NSNotification*)notication
{
    NSDictionary *userInfo = [notication userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    editView.frame = CGRectMake(0, 0, m_view.frame.size.width, m_view.frame.size.height-keyboardRect.size.height-64);
    backView.frame =CGRectMake(0, editView.frame.size.height, m_view.frame.size.width, 20);
//    numberLabel.frame = CGRectMake(200, editView.frame.size.height+editView.frame.origin.y+5,105, 20);
}

- (void)keyBoardHild
{
    
    CGSize size = [editView.text sizeWithFont:[UIFont systemFontOfSize:15] constrainedToWidth:self.view.width];
    float height =size.height+20;
    height= MAX(size.height, 220);
    height = MIN(height, m_view.frame.size.height-20);
    editView.frame = CGRectMake(0, 0, m_view.frame.size.width, height);
    
    backView.frame =CGRectMake(0, editView.frame.size.height, m_view.frame.size.width, 20);

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
