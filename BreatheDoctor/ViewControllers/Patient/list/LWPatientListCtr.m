//
//  LWPatientListCtr.m
//  BreatheDoctor
//
//  Created by comv on 15/11/10.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWPatientListCtr.h"

#import <IQKeyboardManager.h>
#import <ReactiveCocoa.h>

#import "NSString+Pinyin.h"
#import "NSString+Contains.h"

#import "KLPatientLisetCell.h"
#import "LWPatientCententCtr.h"
#import "LWPatientListModel.h"
#import "KLPatientListModel.h"
#import "KLPatientDataSource.h"
#import "LWCustomMenu.h"
#import "LWTool.h"
#import "KLGroupSenderViewCtr.h"
#import "KLGroupSenderPatientListModel.h"

@interface LWPatientListCtr ()<UISearchBarDelegate,LWCustomMenuDelegate>

@property (nonatomic, assign) LISTTYPE         listType;

@property (nonatomic, assign) ShowGroupingType showGroupingType;
@property (nonatomic, assign) BOOL             isShowPullDowView;

@property (nonatomic, strong) UIImageView      *pullImg;
@property (nonatomic, strong) UIButton         *pullBtn;
@property (nonatomic, strong) LWCustomMenu     *pullDownView;

@property (nonatomic, strong) NSMutableArray      *patients;

@property (nonatomic, copy)   NSString            *refreshTime;
@property (nonatomic, strong) UITableView         *tableView;
@property (nonatomic, strong) UISearchBar         *searchBar;

@property (nonatomic, strong) KLPatientDataSource *patientDataSource;

@property (nonatomic, strong) UIButton            *footNextButton;

@property (nonatomic, strong) NSMutableArray      *editorArray;

@property (nonatomic, strong) UILabel             *notPatientLabel;

@end

@implementation LWPatientListCtr
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (instancetype)initWithListType:(LISTTYPE)type{
    if ([super init]) {
        self.listType = type;
    }
    return self;
}
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
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    [self initSubViews];
    
    [self loadCacheMes];
    
    [self httploadPatientList];
    
    [self registeredNotificationCenter];
    
    [self setBlock];
}
- (void)registeredNotificationCenter{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appLoginSucc:) name:APP_LOGIN_SUCC object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appNotification:) name:APP_ADDPATIENT_SUCC object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appNotification:) name:APP_UPDATEPATIENT_SUCC object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appNotification:)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];
}
- (void)appLoginSucc:(NSNotification *)sender
{
    [self.patientDataSource.patientDics removeAllObjects];
    [self.patients removeAllObjects];
    self.refreshTime = nil;
    self.patientDataSource.keys = nil;
    [self.tableView reloadData];
    [self httploadPatientList];
}
- (void)appNotification:(NSNotificationCenter *)sender
{
    [self httploadPatientList];
}
- (void)initSubViews
{
    
    self.showGroupingType = ShowGroupingTypeAll;
    self.isShowPullDowView  = NO;
    
    self.patientDataSource.tableView   = self.tableView;
    self.patientDataSource.searchBar   = self.searchBar;
    self.patientDataSource.listType    = self.listType;
    
    [self.view addSubview:self.tableView];
    setExtraCellLineHidden(self.tableView);
    
    if (self.listType == LISTTYPEDEFT)
    {
        self.tableView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    }else
    {
        [self.view addSubview:self.footNextButton];
        
        self.footNextButton.sd_layout
        .leftSpaceToView(self.view,10)
        .rightSpaceToView(self.view,10)
        .bottomSpaceToView(self.view,10)
        .heightIs(45);
        
        self.tableView.sd_layout
        .leftSpaceToView(self.view,0)
        .rightSpaceToView(self.view,0)
        .topSpaceToView(self.view,0)
        .bottomSpaceToView(self.footNextButton,10);
    }
    
    _notPatientLabel = [UILabel new];
    _notPatientLabel.textAlignment = 1;
    _notPatientLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    _notPatientLabel.font = kNSPXFONT(30);
    _notPatientLabel.text = @"无结果";
    [self.view addSubview:_notPatientLabel];
    
    _notPatientLabel.sd_layout
    .widthIs(100)
    .heightIs(20)
    .centerYEqualToView(self.view)
    .centerXEqualToView(self.view);
    
    _notPatientLabel.hidden = YES;
}

- (void)setNavControl
{
    [super addNavBar:@"患者"];
    
    if (self.listType == LISTTYPEDEFT) {
        [super addRightButton:@"添加患者"];
    }else{
        [super addBackButton:@"nav_btnBack"];
        [super addRightButton:@"全选"];
    }
    
    _pullImg = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width-13)/2+30,19.5,13, 7)];
    _pullImg.image = [UIImage imageNamed:@"V-1_.png"];
    [super.navBar addSubview:_pullImg];
    
    _pullBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _pullBtn.frame = CGRectMake((self.view.frame.size.width-50)/2,0,50, 50);
    
    [_pullBtn addTarget:self action:@selector(showGroupClick) forControlEvents:UIControlEventTouchUpInside];
    [super.navBar addSubview:_pullBtn];
    
}
#pragma mark -void
- (void)pushPatientCenter:(KLPatientListModel *)model theIndex:(NSIndexPath *)index{
    
    WEAKSELF
    LWPatientCententCtr *patientCentent = (LWPatientCententCtr *)[UIViewController CreateControllerWithTag:CtrlTag_PatientCenter];
    patientCentent.patient = model;
    [KL_weakSelf.navigationController pushViewController:patientCentent animated:YES];
    
    NSIndexPath *seleIndexPath = index;
    //返回的时候刷新这行
    [patientCentent setBackBlock:^{
        
        [KL_weakSelf loadCacheMes];
        if (index.row > 0) {
            [NSIndexPath indexPathForRow:seleIndexPath.row-1 inSection:seleIndexPath.section];
            [KL_weakSelf.tableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
        }
    }];
}
- (void)changeFootNetxButton{
    
    if (self.editorArray.count > 0) {
        self.footNextButton.enabled = YES;
        [self.footNextButton setTitle:[NSString stringWithFormat:@"下一步（%@）",kNSNumInteger(self.editorArray.count)] forState:UIControlStateNormal];
    }else{
        self.footNextButton.enabled = NO;
        [self.footNextButton setTitle:@"下一步" forState:UIControlStateNormal];
    }
}

#pragma mark - click
- (void)setBlock{
    
    WEAKSELF
    [self.patientDataSource setDidSelectTableCellBlock:^(NSIndexPath *index, KLPatientListModel *model) {
        if (KL_weakSelf.listType == LISTTYPEDEFT) {
            
            [MobClick event:@"patientCenter" label:@"患者个人中心按钮的点击量"];
            [KL_weakSelf pushPatientCenter:model theIndex:index];
        }else{
            
            model.isSele = !model.isSele;
            if (model.isSele) {
                [KL_weakSelf.editorArray addObject:model];
            }else{
                [KL_weakSelf.editorArray removeObject:model];
            }
            
            KLPatientLisetCell *cell = [KL_weakSelf.tableView cellForRowAtIndexPath:index];
            [cell seteditorIconSele:model.isSele];
            
            [KL_weakSelf changeFootNetxButton];
        }
    }];
}


- (void)showGroupClick
{
    if(self.patientDataSource.isSearch)return;
    self.isShowPullDowView = !self.isShowPullDowView;
    if (self.isShowPullDowView) {
        
        [self pullDownViewShowOrHide];
    }else
    {
        [self hiddenPullView];
    }
}
- (void)navRightButtonAction
{
    if (self.pullDownView) {
        [self hiddenPullView];
        return;
    }
    /**
     *   全选或者添加患者
     */
    if (self.listType == LISTTYPEDEFT) {
     
        [self showAddPatinentView];
    }else{
        
//        [self.editorArray removeAllObjects];
//        [self.editorArray ];
        
        [self arrayWithMemberIsOnly:[self patientListDidSele]];
        
        [self.tableView reloadData];
        [self changeFootNetxButton];
    }
}
- (NSMutableArray *)patientListDidSele{
    
    NSMutableArray *patientSeleArray = [NSMutableArray array];
    
    WEAKSELF
    [self.patientDataSource.keys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        NSString *key = KL_weakSelf.patientDataSource.keys[idx];
        NSMutableArray *arr = (NSMutableArray *)[KL_weakSelf.patientDataSource.patientDics objectForKey:key];
        
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            KLPatientListModel *model = obj;
            [patientSeleArray addObject:model];
            if (!model.isSele) {
                model.isSele = YES;
            }
        }];
    }];
    
    return patientSeleArray;
}
- (void)arrayWithMemberIsOnly:(NSArray *)array
{
    for (unsigned i = 0; i < [array count]; i++)
    {
        @autoreleasepool
        {
            if (![self.editorArray containsObject:[array objectAtIndex:i]]) {
                
                [self.editorArray addObject:[array objectAtIndex:i]];
            }
        }
    }
}
- (void)navLeftButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)nextButtonClick:(UIButton *)sender{
    
    if (self.listType == LISTTYPEGROUPAGAINSENDER) {
        
        [self againSenderEdtiorSuccModel:[KLGroupSenderPatientListModel listVcGroupSenderPatientLisetModelWithList:self.editorArray]];
    }else{
        
        KLGroupSenderViewCtr *vc = [[KLGroupSenderViewCtr alloc] initWithGroupSenderPatientListModel:[KLGroupSenderPatientListModel listVcGroupSenderPatientLisetModelWithList:self.editorArray]];
        vc.pushType = PUSHTYPELIST;
        [self.navigationController pushViewController:vc animated:YES];
        WEAKSELF
        [[vc rac_signalForSelector:@selector(guoupSenderSuccess)] subscribeNext:^(id x) {
            
            [KL_weakSelf patientListGuoupSenderSuccess];
        }];
    }
}
/**
 *  群发成功
 */
- (void)patientListGuoupSenderSuccess{
    
}
/**
 *  再次发送成功
*/
- (void)againSenderEdtiorSuccModel:(KLGroupSenderPatientListModel *)model{

}
#pragma mark - init
- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.backgroundColor  = [UIColor whiteColor];
        _tableView.rowHeight        = 55*MULTIPLE;
        _tableView.tableHeaderView  = self.searchBar;
        _tableView.sectionIndexBackgroundColor = [UIColor clearColor];
        _tableView.sectionIndexColor = [UIColor colorWithRed:85.0/255.0 green:85.0/255.0 blue:85.0/255.0 alpha:1];
        _tableView.dataSource = self.patientDataSource;
        _tableView.delegate   = self.patientDataSource;
        [_tableView registerClass:[KLPatientLisetCell class] forCellReuseIdentifier:@"KLPatientLisetCell"];
    }
    return _tableView;
}
- (KLPatientDataSource *)patientDataSource{
    
    if (!_patientDataSource) {
        _patientDataSource = [KLPatientDataSource new];
    }
    return _patientDataSource;
}
- (NSMutableArray *)editorArray{
    if (!_editorArray) {
        _editorArray = [NSMutableArray array];
    }
    return _editorArray;
}
- (NSMutableArray *)patients
{
    if (!_patients) {
        _patients = [NSMutableArray array];
    }
    return _patients;
}

- (UISearchBar*)searchBar{
    
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] init];
        _searchBar.delegate = self;
        [_searchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        [_searchBar sizeToFit];
        _searchBar.backgroundColor = [UIColor colorWithHexString:@"#d7d7db"];
        _searchBar.placeholder = @"搜索";
    }
    return _searchBar;
}
- (UIButton *)footNextButton{
    
    if (!_footNextButton) {
        _footNextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _footNextButton.backgroundColor = [LWThemeManager shareInstance].navBackgroundColor;
        [_footNextButton setTitle:@"下一步" forState:UIControlStateNormal];
        [_footNextButton addTarget:self action:@selector(nextButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_footNextButton setCornerRadius:3.0f];
        _footNextButton.enabled = NO;
    }
    return _footNextButton;
}
#pragma mark - 分组展现
- (void)pullDownViewShowOrHide
{
    WEAKSELF
    if (!self.pullDownView) {
        
        _pullDownView.delegate = self;
        
        self.pullDownView = [[LWCustomMenu alloc] initWithDataArr:[LWTool forGrouping:self.patients] origin:CGPointMake(0, 0) width:125 rowHeight:44];
        _pullDownView.delegate = self;
        _pullDownView.dismiss = ^() {
            KL_weakSelf.tableView.scrollEnabled = YES;
            KL_weakSelf.isShowPullDowView = NO;
            KL_weakSelf.pullImg.image = [UIImage imageNamed:@"V-1_.png"];
            KL_weakSelf.pullDownView = nil;
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
    WEAKSELF
    [UIView animateWithDuration:0.5 animations:^{
        KL_weakSelf.pullDownView.transform = CGAffineTransformMakeTranslation(0, 0);
        KL_weakSelf.pullImg.image = [UIImage imageNamed:@"V-1_.png"];
        
    }
                     completion:^(BOOL finished)
     {
         [KL_weakSelf.pullDownView dismissWithCompletion:^(LWCustomMenu *object) {
             KL_weakSelf.tableView.scrollEnabled = YES;
             KL_weakSelf.isShowPullDowView = NO;
             KL_weakSelf.pullImg.image = [UIImage imageNamed:@"V-1_.png"];
             KL_weakSelf.pullDownView = nil;
         }];
         KL_weakSelf.isShowPullDowView = NO;
     }];
}
#pragma mark -加载缓存
- (void)loadCacheMes
{
    WEAKSELF
    [KLPatientOperation loadCachePatientListSucc:^(NSMutableArray *dataArray, NSString *refTimer) {
        
        [KL_weakSelf.patients removeAllObjects];
        [KL_weakSelf.patients addObjectsFromArray:dataArray];
         KL_weakSelf.refreshTime = refTimer;
        /**
         *  如果是再次发送的编辑进行遍历
         */
        [KL_weakSelf traversePushType];
        
        [KL_weakSelf loadData];
    }];
    
}
- (void)traversePushType{
    
    if (self.listType == LISTTYPEGROUPAGAINSENDER) {
        
        for (NSString *patientID in [self.ListModel patientIds]) {
            
            for (KLPatientListModel *model in self.patients) {
                
                if ([model.patientId isEqualToString:patientID]) {
                    
                    model.isSele = YES;
                    [self.editorArray addObject:model];
                }
            }
        }
        [self changeFootNetxButton];
    }
}
#pragma mark -刷新数据
- (void)loadData{
    
    WEAKSELF
    [KLPatientOperation patientsInfoShowGroupingType:self.showGroupingType theDataArray:self.patients theSucc:^(NSMutableArray *patients, NSMutableDictionary *listDic, NSArray *keys) {
        
        KL_weakSelf.patientDataSource.patientDics = nil;
        KL_weakSelf.patientDataSource.patientDics = listDic;
        
        KL_weakSelf.patientDataSource.keys = nil;
        KL_weakSelf.patientDataSource.keys = keys;
        
        
        [KL_weakSelf.tableView reloadData];
        
        if (!KL_weakSelf.patientDataSource.isSearch && KL_weakSelf.patientDataSource.patientDics.count <= 0) {
            if (KL_weakSelf.showGroupingType == ShowGroupingTypeAll) {
                [KL_weakSelf showErrorMessage:@"您还没有患者，去添加吧~" isShowButton:NO type:showErrorTypeMore];
            }else{
                [KL_weakSelf showErrorMessage:@"该分组暂无患者~" isShowButton:YES type:showErrorTypeMore];
            }
            KL_weakSelf.tableView.hidden = YES;
        }else
        {
            [KL_weakSelf hiddenNonetWork];
            KL_weakSelf.tableView.hidden = NO;
        }
    }];
    
}
#pragma mark -加载网络新数据
- (void)httploadPatientList
{
    WEAKSELF
    [LWHttpRequestManager httpPatientListWithPage:1 size:100000 refreshDate:self.refreshTime success:^(NSMutableArray *list) {
        [LWProgressHUD closeProgressHUD:KL_weakSelf.view];
        if (list.count <= 0) {
            return ;
        }
        [KL_weakSelf loadCacheMes];
    } failure:^(NSString *errorMes) {
        [LWProgressHUD closeProgressHUD:KL_weakSelf.view];
        if (self.patients.count <= 0) {
            
            if ([LBLoginBaseModel isCheckStatusTheIsShow:NO]) {
                
                [KL_weakSelf showErrorMessage:@"网络连接失败，点击重试~" isShowButton:NO type:showErrorTypeHttp];
            }else{
                [KL_weakSelf showErrorMessage:@"您还没有患者，去添加吧~" isShowButton:NO type:showErrorTypeMore];
            }
            KL_weakSelf.tableView.hidden = YES;

        }
    }];
    
}
#pragma mark -请求失败刷新
- (void)reloadRequestWithSender:(UIButton *)sender //错误页面按钮点击事件
{
    if (sender.tag == showErrorTypeHttp) {
        [LWProgressHUD displayProgressHUD:self.view displayText:@"正在加载..."];
        [self httploadPatientList];
    }else{
        
        [self showAddPatinentView];
    }
}
#pragma mark -添加患者
- (void)showAddPatinentView
{
    if (![LBLoginBaseModel isCheckStatusTheIsShow:YES]) {
        
        return;
    }
    UIViewController *vc = [UIViewController CreateControllerWithTag:CtrlTag_AddPatient];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    self.patientDataSource.searchBar.showsCancelButton = YES;
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    self.searchBar.showsCancelButton = NO;
    return YES;
}
- (void)isSearchShow
{
    if (!self.searchBar.showsCancelButton) {
        self.patientDataSource.isSearch = YES;
    }
    if (self.patientDataSource.searchArray.count <= 0) {
        
//        self.tableView.hidden = YES;
        self.notPatientLabel.hidden = NO;
        
    }else
    {
//        self.tableView.hidden = NO;
        self.notPatientLabel.hidden = YES;

    }
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self searchDissmiss];
}
- (void)searchDissmiss
{
    self.notPatientLabel.hidden = YES;
    [self.patientDataSource.searchArray removeAllObjects];
    self.patientDataSource.isSearch = NO;
    self.searchBar.text = @"";
    self.searchBar.showsCancelButton = NO;
    [self.searchBar resignFirstResponder];
    [self.tableView reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length <= 0) {
        
        self.patientDataSource.isSearch = NO;
        self.notPatientLabel.hidden = YES;
        [self.tableView reloadData];
        return;
    }
    self.patientDataSource.isSearch = YES;

    [self.patientDataSource.searchArray removeAllObjects];
    for (KLPatientListModel *pat in self.patients) {
        NSString *patientNmae = [NSString stringWithFormat:@"%@(%@)",pat.patientName,pat.remark];
        NSString *pinying = [patientNmae pinyinWithoutBlank];
        if ([patientNmae containsaString:searchText]||[pinying containsaString:searchText]) {
            [self.patientDataSource.searchArray addObject:pat];
        }
    }
    [self isSearchShow];
    [self.tableView reloadData];
}
#pragma mark -LWCustomMenuDelegate
- (void)jhCustomMenu:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.showGroupingType = indexPath.row;
    [self loadData];
}

@end
