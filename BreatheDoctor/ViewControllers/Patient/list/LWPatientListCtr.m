//
//  LWPatientListCtr.m
//  BreatheDoctor
//
//  Created by comv on 15/11/10.
//  Copyright © 2015年 lwh. All rights reserved.
//
#define ALPHA	@"ABCDEFGHIJKLMNOPQRSTUVWXYZ"

#import "LWPatientListCtr.h"
#import "NSString+Size.h"
#import "LWPatientCell.h"
#import "LWPatientCententCtr.h"
#import "UIImage+color.h"
#import <IQKeyboardManager.h>
#import "LWCustomMenu.h"
#import "LWPatientListModel.h"
#import "NSString+Pinyin.h"
#import "NSString+Contains.h"

typedef NS_ENUM(NSInteger , ShowGroupingType) {
    ShowGroupingTypeAll = 0, //所有
    ShowGroupingTypeNoDetermined ,//未确定
    ShowGroupingTypeCompleteControl ,//完全控制
    ShowGroupingTypePartControl ,//部分控制
    ShowGroupingTypeNoControl ,//为控制
};
@interface LWPatientListCtr ()<UISearchBarDelegate,LWCustomMenuDelegate>

@property (nonatomic, assign) ShowGroupingType showGroupingType;
@property (strong, nonatomic) UISearchBar *searchBar;
@property (nonatomic, strong) NSMutableArray *patients;
@property (nonatomic, assign) BOOL isShowPullDowView;
@property (nonatomic, assign) BOOL isSearch;
@property (nonatomic, strong) UIImageView * pullImg;
@property (nonatomic, strong) UIButton * pullBtn;

@property (nonatomic, strong) LWCustomMenu *pullDownView;
@property (nonatomic, strong) NSArray *keys;
@property (nonatomic, strong) NSMutableDictionary *patientDics;

@property (nonatomic, strong) NSMutableArray *searchArray;

@property (nonatomic, copy) NSString *refreshTime;


@end

@implementation LWPatientListCtr
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setNavControl];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_pullBtn removeFromSuperview];
    [_pullImg removeFromSuperview];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initProperty];
    [self setUI];
    [self loadCacheMes];
    [self httploadPatientList];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appLoginSucc:) name:APP_LOGIN_SUCC object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appNotification:) name:APP_ADDPATIENT_SUCC object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appNotification:) name:APP_UPDATEPATIENT_SUCC object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appNotification:)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];

}
- (void)appLoginSucc:(NSNotification *)sender
{
    [self.patientDics removeAllObjects];
    [self.patients removeAllObjects];
    self.keys = nil;
    [self.tableView reloadData];
    [self httploadPatientList];
}
- (void)appNotification:(NSNotificationCenter *)sender
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self httploadPatientList];
    });
}
- (void)setUI
{
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.rowHeight  = 60*(iPhone6Plus?1.15:1);
    self.tableView.tableHeaderView = self.searchBar;
    setExtraCellLineHidden(self.tableView);
    
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    self.tableView.sectionIndexColor = [UIColor colorWithRed:85.0/255.0 green:85.0/255.0 blue:85.0/255.0 alpha:1];
    
}

- (void)initProperty
{
    self.showGroupingType = ShowGroupingTypeAll;
    self.isSearch = NO;
    self.isShowPullDowView = NO;
    self.tableView.sectionHeaderHeight = 20;
}

- (void)setNavControl
{
    [super addNavBar:@"患者"];
    
    [super addRightButton:@"添加患者"];
    
    _pullImg = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width-13)/2+30,19.5,13, 7)];
    _pullImg.image = [UIImage imageNamed:@"V-1_.png"];
    [super.navBar addSubview:_pullImg];
    
    _pullBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _pullBtn.frame = CGRectMake((self.view.frame.size.width-50)/2,0,50, 50);
    
    [_pullBtn addTarget:self action:@selector(getGroupData) forControlEvents:UIControlEventTouchUpInside];
    [super.navBar addSubview:_pullBtn];
    
}

- (void)ToDealWithPatientList
{
    [self.patientDics removeAllObjects];
    self.keys = nil;
    
    NSMutableArray *array = [NSMutableArray array];
    
    if (self.showGroupingType == ShowGroupingTypeAll) {
        array = self.patients;
    }else
    {
        @autoreleasepool {
            for (LWPatientRows *pat in self.patients) {
                if (pat.controlLevel == self.showGroupingType) {
                    [array addObject:pat];
                }
            }
        }
    }
    
    @autoreleasepool {
        
        for (LWPatientRows *pat in array)
        {
            
            if (!pat.PinYin || ![ALPHA containsaString:stringJudgeNull(pat.PinYin)]) {
                if ([self.patientDics objectForKey:@"#"]) {
                    NSMutableArray *arr = [self.patientDics objectForKey:@"#"];
                    [arr addObject:pat];
                }else
                {
                    NSMutableArray *arr = [NSMutableArray array];
                    [arr addObject:pat];
                    [self.patientDics setObject:arr forKey:@"#"];
                }
            }else
            {
                if ([self.patientDics objectForKey:pat.PinYin]) {
                    NSMutableArray *arr = [self.patientDics objectForKey:pat.PinYin];
                    [arr addObject:pat];
                }else
                {
                    NSMutableArray *arr = [NSMutableArray array];
                    [arr addObject:pat];
                    [self.patientDics setObject:arr forKey:pat.PinYin];
                }
            }
            
        }
        
        
    }
    
    
    SEL sel = @selector(localizedCompare:);
    //对拼音排序
    self.keys = (NSMutableArray*)[self.patientDics.allKeys sortedArrayUsingSelector:sel];
    [self.tableView reloadData];
}

- (void)getGroupData
{
    if(self.isSearch)return;
    
    self.isShowPullDowView = !self.isShowPullDowView;
    if (self.isShowPullDowView) {
        [self pullDownViewShowOrHide];
    }else
    {
        [self hiddenPullView];
    }
}

- (void)showSchoolList:(UIBarButtonItem *)barButtonItem
{
    
}

#pragma mark - init
- (NSMutableArray *)patients
{
    if (!_patients) {
        _patients = [NSMutableArray array];
    }
    return _patients;
}
- (NSMutableArray *)searchArray
{
    if (!_searchArray) {
        _searchArray = [NSMutableArray array];
    }
    return _searchArray;
}
- (NSMutableDictionary *)patientDics
{
    if (!_patientDics) {
        _patientDics = [NSMutableDictionary dictionary];
    }
    return _patientDics;
}
- (UISearchBar*)searchBar{
    
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] init];
        _searchBar.delegate = self;
        [_searchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        [_searchBar sizeToFit];
        _searchBar.backgroundColor = systemColor;
        _searchBar.backgroundImage = [UIImage imageWithColor:[UIColor clearColor] size:_searchBar.bounds.size];
        _searchBar.placeholder = @"搜索";
    }
    return _searchBar;
}

#pragma mark -UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [self isSearchShow];
    self.searchBar.showsCancelButton = YES;
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    [self isSearchShow];
    self.searchBar.showsCancelButton = NO;
    return YES;
}
- (void)isSearchShow
{
    if (self.searchArray.count <= 0) {
        self.isSearch = NO;
    }else
    {
        self.isSearch = YES;
    }
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self searchDissmiss];
}
- (void)searchDissmiss
{
    [self.searchArray removeAllObjects];
    self.isSearch = NO;
    self.searchBar.text = @"";
    self.searchBar.showsCancelButton = NO;
    [self.searchBar resignFirstResponder];
    [self.tableView reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self.searchArray removeAllObjects];
    for (LWPatientRows *pat in self.patients) {
        NSString *patientNmae = [NSString stringWithFormat:@"%@(%@)",pat.patientName,pat.remark];
        NSString *pinying = [patientNmae pinyinWithoutBlank];
        if ([patientNmae containsaString:searchText]||[pinying containsaString:searchText]) {
            [self.searchArray addObject:pat];
        }
    }
    [self isSearchShow];
    [self.tableView reloadData];

}

#pragma mark - tableviewdelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!self.isSearch) {
        NSString *key = self.keys[section];
        
        return [(NSMutableArray *)[self.patientDics objectForKey:key] count];
    }
    return self.searchArray.count;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.isSearch?1:self.keys.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LWPatientCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LWPatientCell" forIndexPath:indexPath];
    LWPatientRows *model;
    if (self.isSearch) {
        model = self.searchArray[indexPath.row];
    }else{
        NSString *key = self.keys[indexPath.section];
        NSMutableArray *arr = (NSMutableArray *)[self.patientDics objectForKey:key];
        model = arr[indexPath.row];
    }
    [cell setPatient:model];
    return cell;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.isSearch) {
        return nil;
    }
    NSString *key = self.keys[section];
    NSMutableArray *arr = (NSMutableArray *)[self.patientDics objectForKey:key];
    
    if (self.patientDics.count>0&&[arr count]>0)
    {
        UIView * view = [[UIView alloc]init];
        view.backgroundColor =viewBackgroundColor;
        
        UILabel * lable = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 22)];
        lable.text = key;
        lable.font =[UIFont systemFontOfSize:16];
        lable.backgroundColor =[UIColor clearColor];
        lable.textColor =[UIColor colorWithRed:152.0/255.0 green:152.0/255.0 blue:152.0/255.0 alpha:1.0];
        [view addSubview:lable];
        
        return view;
    }
    else
    {
        return nil;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LWPatientCententCtr *patientCentent = (LWPatientCententCtr *)[UIViewController CreateControllerWithTag:CtrlTag_PatientCenter];
    LWPatientRows *model;
    if (self.isSearch) {
        model = self.searchArray[indexPath.row];
    }else{
        NSString *key = self.keys[indexPath.section];
        NSMutableArray *arr = (NSMutableArray *)[self.patientDics objectForKey:key];
        model = arr[indexPath.row];
    }
    patientCentent.patient = model;
    [self.navigationController pushViewController:patientCentent animated:YES];
    
    
    NSIndexPath *seleIndexPath = indexPath;
    
    //返回的时候刷新这行
    [patientCentent setBackBlock:^{
        [self loadCacheMes];
        if (indexPath.row > 0) {
            [NSIndexPath indexPathForRow:seleIndexPath.row-1 inSection:seleIndexPath.section];
            [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
        }
    }];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.isSearch) {
        if (self.searchArray.count > 0) {
            [self.searchBar resignFirstResponder];
        }
    }else{
        //        [self hiddenPullView];
    }
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)aTableView
{
    if (!self.isSearch)  // regular table
    {
        NSMutableArray *toBeReturned = [NSMutableArray arrayWithObject:UITableViewIndexSearch];
        
        [toBeReturned addObjectsFromArray:self.keys];
//        char c= '#';
//        [toBeReturned addObject:[NSString stringWithFormat:@"%c",c]];
        return toBeReturned;
    }
    else return nil; // search table
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if (title == UITableViewIndexSearch)
    {
        [self.tableView scrollRectToVisible:self.searchBar.frame animated:NO];
        return -1;
    }
    return [self.keys indexOfObject:title];
}

- (void)pullDownViewShowOrHide
{
    
    
    __weak __typeof(self) weakSelf = self;
    if (!self.pullDownView) {
        
//        if (self.patients.count > 0) {
//            [self.tableView scrollRectToVisible:self.searchBar.frame animated:NO];
//        }
        _pullDownView.delegate = self;
        
        self.pullDownView = [[LWCustomMenu alloc] initWithDataArr:[LWTool forGrouping:self.patients] origin:CGPointMake(0, 0) width:125 rowHeight:44];
        _pullDownView.delegate = self;
        _pullDownView.dismiss = ^() {
            weakSelf.tableView.scrollEnabled = YES;
            weakSelf.isShowPullDowView = NO;
            weakSelf.pullImg.image = [UIImage imageNamed:@"V-1_.png"];
            weakSelf.pullDownView = nil;
        };
        _pullDownView.arrImgName = @[@"item_school.png", @"item_battle.png", @"item_list.png", @"item_chat.png", @"item_share.png"];
        
        [self.view.window addSubview:_pullDownView];
        self.tableView.scrollEnabled = NO;
    } else {
        self.pullDownView = nil;
        [self pullDownViewShowOrHide];
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    self.pullDownView.transform = CGAffineTransformMakeTranslation(0,6);
    _pullImg.image = [UIImage imageNamed:@"V-7_.png"];
    
    [UIView commitAnimations];
    
}

- (void)hiddenPullView
{
    if (!self.pullDownView) {
        return;
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.pullDownView.transform = CGAffineTransformMakeTranslation(0, 0);
        _pullImg.image = [UIImage imageNamed:@"V-1_.png"];
        
    }
                     completion:^(BOOL finished)
     {
         [self.pullDownView dismissWithCompletion:^(LWCustomMenu *object) {
             self.tableView.scrollEnabled = YES;
             self.isShowPullDowView = NO;
             self.pullImg.image = [UIImage imageNamed:@"V-1_.png"];
             self.pullDownView = nil;
         }];
         self.isShowPullDowView = NO;
     }];
}
#pragma mark 分组列表

- (void)loadCacheMes
{

    NSMutableArray *array = [[LKDBHelper getUsingLKDBHelper] search:[LWPatientRows class] where:nil orderBy:nil offset:0 count:10000];
    if (array.count <= 0) {
        [self showErrorMessage:@"您还没有患者，去添加吧~" isShowButton:NO type:showErrorTypeMore];
        return;
    }
    LWPatientRows *model = array[0];
    self.refreshTime = model.refTimer;
    [self.patients removeAllObjects];
    [self.patients addObjectsFromArray:array];

    [self hiddenNonetWork];
    [self ToDealWithPatientList];
}

- (void)httploadPatientList
{
    [LWHttpRequestManager httpPatientListWithPage:1 size:100000 refreshDate:self.refreshTime success:^(LWPatientBaseModel *patientBaseModel) {
        [LWProgressHUD closeProgressHUD:self.view];
        [self loadCacheMes];
    } failure:^(NSString *errorMes) {
        [LWProgressHUD closeProgressHUD:self.view];
        if (self.patients.count <= 0) {
            [self showErrorMessage:@"网络连接失败，点击重试~" isShowButton:NO type:showErrorTypeHttp];
        }
    }];
    
}
- (void)reloadRequestWithSender:(UIButton *)sender //错误页面按钮点击事件
{
    if (sender.tag == showErrorTypeHttp) {
        [LWProgressHUD displayProgressHUD:self.view displayText:@"正在加载..."];
        [self httploadPatientList];
    }else{
        [self showAddPatinentView];
    }
}
- (void)showAddPatinentView
{
    UIViewController *vc = [UIViewController CreateControllerWithTag:CtrlTag_AddPatient];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - nav
- (void)navRightButtonAction
{
    if (self.pullDownView) {
        [self hiddenPullView];
        return;
    }
    [self showAddPatinentView];
}

#pragma mark -LWPullDownViewDelegate
- (void)jhCustomMenu:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.showGroupingType = indexPath.row;
    [self ToDealWithPatientList];

    if (!self.isSearch && self.patientDics.count <= 0) {
        [self showErrorMessage:@"该分组暂无患者~" isShowButton:YES type:showErrorTypeMore];
    }else
    {
        [self hiddenNonetWork];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
