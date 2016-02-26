//
//  LWOrderRecordViewController.m
//  BreatheDoctor
//
//  Created by comv on 15/12/31.
//  Copyright © 2015年 lwh. All rights reserved.
//


#import "LWOrderRecordViewController.h"
#import "LWYerChangIndexView.h"
#import "LWOrderCollectionViewCell.h"
#import "LWOrderDetailsCell.h"
#import "NSDate+Extension.h"
#import "RFLayout.h"
#import "PickerDateViewController.h"
#import "LWOrderListModel.h"

@interface LWOrderRecordViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,LWOrderCollectionViewCellDelegate
>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) RFLayout *collectionLayout;
@property (nonatomic, assign) CGPoint lwContentOffset;

@property (nonatomic, strong) PickerDateViewController *pickView;

@property (nonatomic, strong) NSMutableArray *orderArray;

@property (nonatomic, assign) BOOL isMove;

@end

@implementation LWOrderRecordViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [super addNavBar:@"购买记录"];
    [super addBackButton:@"nav_btnBack.png"];
    [super addRightButton:@"rili.png"];
    
}

- (RFLayout *)collectionLayout
{
    if (!_collectionLayout) {
        _collectionLayout = [[RFLayout alloc] initWithItmSize:CGSizeMake(self.view.width-80, self.view.height-64-80)];
    }
    return _collectionLayout;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height-64) collectionViewLayout:self.collectionLayout];
    }
    return _collectionView;
}

- (void)initData
{
    _orderArray = [NSMutableArray array];
    
    for (int i = 0; i < 12; i++)
    {
        NSDate *date = [[NSDate date] offsetMonths:-i];
        
        LWOrderListModel *model = [[LWOrderListModel alloc] init];
        model.year = [date year];
        model.month = [date month];
        model.orderDate = [NSString stringWithFormat:@"%ld月/%ld年",model.month,model.year];
        
        [_orderArray addObject:model];
        
    }
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initData];
    
    __weak typeof(self) weakSelf = self;
    
    [self.collectionLayout setChangeOfsetBlock:^(CGPoint point) {
        weakSelf.lwContentOffset = point;
    }];
    
    [self.view addSubview:self.collectionView];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    //    self.collectionView.bounces = NO;
    //    self.collectionView.pagingEnabled = YES;
    [self.collectionView registerClass:[LWOrderCollectionViewCell class] forCellWithReuseIdentifier:@"LWOrderCollectionViewCell"];
    self.collectionView.backgroundColor =  [UIColor groupTableViewBackgroundColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.orderArray.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LWOrderCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LWOrderCollectionViewCell" forIndexPath:indexPath];
    cell.delegate = self;
    LWOrderListModel *model = self.orderArray[indexPath.row];
    [cell.orderCell setLW_DateLabelText:model.orderDate];
    return cell;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self.collectionView setContentOffset:self.lwContentOffset animated:YES];
    
}

#pragma mark - nav

- (void)navLeftButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)navRightButtonAction
{
    [self showDateChooseView];
}

- (void)showDateChooseView
{
    if (self.pickView) {
        return;
    }
    __weak typeof(self) weakSelf = self;
    
    self.pickView = [PickerDateViewController new];
    [self addChildViewController:self.pickView];
    [self.view addSubview:self.pickView.view];
    
    [self.pickView setSelectedBlock:^(NSString *date) {
        [weakSelf moveDate:[NSDate dateWithString:date format:@"yyyy年MM月"]];
    }];
    
    [self.pickView setDismissBlock:^{
        weakSelf.pickView = nil;
    }];
}
- (void)moveDate:(NSDate *)date
{
    self.isMove = NO;
    
    [self.orderArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LWOrderListModel *model = obj;
        if (model.month == [date month] && model.year == [date year])
        {
            [self.collectionView scrollRectToVisible:CGRectMake((self.collectionView.contentWidth/12)*idx- 5*idx, 0, self.collectionView.width, self.collectionView.height) animated:YES];
            
            self.isMove = YES;
        }
        
    }];
    

    if (!self.isMove) {
        SHOWAlertView(@"提示", @"选择日期不在范围内！")
    }else
    {
        [self.pickView cancelButtonClick];
    }

    
//    for (LWOrderListModel *model in self.orderArray)
//    {
//        if (model.month == [date month] && model.year == [date year])
//        {
//            
//            
//        }
//        
//    }
}
#pragma mark -LWOrderCollectionViewCellDelegate
- (void)didSelectRowIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [self.navigationController pushViewController:[UIViewController CreateControllerWithTag:CtrlTag_ReservationDetailed] animated:YES];
    }else
    {
        [self.navigationController pushViewController:[UIViewController CreateControllerWithTag:CtrlTag_orderListDetailed] animated:YES];
    }
}


@end
