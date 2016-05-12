//
//  FastReplyVC.m
//  ComveeDoctor
//
//  Created by JYL on 14-10-10.
//  Copyright (c) 2014年 zhengjw. All rights reserved.
//

#import "FastReplyVC.h"
#import "CDMacro.h"
#import "FastReplyVCCell.h"
#import "PatientTaskDescribeVC.h"

@interface FastReplyVC ()

@end

@implementation FastReplyVC
@synthesize m_tableView;
@synthesize msgArray;
@synthesize body;
@synthesize isDelete;
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self setNavControl];
    msgArray = [NSMutableArray arrayWithArray:[CODataCacheManager shareInstance].fastReplys];
    [m_tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initialize];

}

- (void)setNavControl
{
    [super addNavBar:isDelete?@"编辑":@"快捷回复"];
    [super addBackButton:@"nav_btnBack.png"];
    [super addRightButton:isDelete?@"完成":@"编辑"];
}

- (void)initialize
{
    m_view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)] ;
    [self.view addSubview:m_view];
    
	m_tableView = [[UITableView alloc] initWithFrame:m_view.bounds];
	m_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	m_tableView.backgroundColor=[UIColor clearColor];
	m_tableView.autoresizesSubviews = NO;
	m_tableView.showsHorizontalScrollIndicator = NO;
	m_tableView.showsVerticalScrollIndicator = YES;
    m_tableView.delegate = self;
	m_tableView.dataSource = self;
    [m_view addSubview:m_tableView];
	
    
    UIView * view = [[UIView alloc]init];
    view.userInteractionEnabled = YES;
    view.frame = CGRectMake(0, 0, self.view.frame.size.width, 70);
    
    m_addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [m_addBtn setBackgroundImage:[UIImage imageNamed:@"personalcenter_42.png"] forState:UIControlStateNormal];
    m_addBtn.frame = CGRectMake(15, 15, self.view.frame.size.width-30, 40);
    [m_addBtn addTarget:self action:@selector(addBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:m_addBtn];
    m_tableView.tableFooterView = view;
    
}
- (void)navLeftButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)navRightButtonAction
{
    isDelete=!isDelete;
   
    if (isDelete)
    {
        [super.navRightButton setTitle:@"完成" forState:UIControlStateNormal];
         super.navTitle.text = @"编辑";
        [m_tableView setEditing:YES animated:YES];
         m_tableView.allowsSelectionDuringEditing = YES;
    }
    else
    {
        [super.navRightButton setTitle:@"编辑" forState:UIControlStateNormal];
         super.navTitle.text = NSLocalizedString(@"Fast Reply", "快捷回复");
         [m_tableView setEditing:NO animated:YES];
    }
    
    [m_tableView reloadData];
   
    
}

#pragma mark- TableView代理
#pragma mark- TableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [msgArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    FastReplyVCCell *cell = (FastReplyVCCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell)
    {
        cell = [[FastReplyVCCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    [cell setDetailTetil:[msgArray objectAtIndex:indexPath.row]];
    
    if (isDelete)
    {
       cell.detailLable.frame = CGRectMake(15,0,m_view.frame.size.width-55,cell.detailLable.frame.size.height);
    }
    else
    {
        cell.detailLable.frame = CGRectMake(15,0,m_view.frame.size.width-30,cell.detailLable.frame.size.height);
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isDelete)
    {//医生添加的才可以修改
        PatientTaskDescribeVC * taskVc = (PatientTaskDescribeVC *)[UIViewController CreateControllerWithTag:CtrlTag_PatientTaskDescribe];
        taskVc.view.tag=indexPath.row+1;
        taskVc.fastVc =self;
        taskVc.editView.text =[msgArray objectAtIndex:indexPath.row];
        taskVc.placeLabel.text = nil;
        [self.navigationController pushViewController:taskVc animated:YES];

    }
    else
    {
        if (_chooseFastRepBlock) {
            _chooseFastRepBlock([msgArray objectAtIndex:indexPath.row]);
        }
        [self.navigationController popViewControllerAnimated:YES];
        
    }
   
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row<3)
    {
        [LWProgressHUD showALAlertBannerWithView:self.view Style:SALAlertBannerStyleWarning  Position:SALAlertBannerPositionTop Subtitle:@"系统模板，无法删除"];
        [self navRightButtonAction];
    }
    else
    {
        alerView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"确认删除该条快捷回复" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alerView.tag=indexPath.row;
        
        [alerView show];
        alerView.delegate = self;
    }

}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1)
    {
        [msgArray removeObjectAtIndex:alerView.tag];
        [CODataCacheManager shareInstance].fastReplys = msgArray;
        [[CODataCacheManager shareInstance] updateReply:msgArray];
        [m_tableView reloadData];
    }
    else
    {
        [self navRightButtonAction];
    }
  
}

#pragma mark-
-(void)changAddBtnFrame{
    
    if (isDelete)
    {
        [super.navRightButton setTitle:@"完成" forState:UIControlStateNormal];
        
        return;
    }
    else
    {
        [super.navRightButton setTitle:@"编辑" forState:UIControlStateNormal];
    }
   
}

-(void)delAtionIndext:(NSIndexPath*)path
{
   
}

-(void)addBtnAction
{
    PatientTaskDescribeVC * taskVc = (PatientTaskDescribeVC *)[UIViewController CreateControllerWithTag:CtrlTag_PatientTaskDescribe];
    taskVc.view.tag=-1;
    taskVc.fastVc =self;
    [self.navigationController pushViewController:taskVc animated:YES];
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
