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
#import "LWOrderDetailedListViewController.h"

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
        NSString *monthString = nil;
        if (model.month < 10) {
            monthString = [NSString stringWithFormat:@"0%@",kNSNumInteger(model.month)];
        }else
        {
            monthString = [NSString stringWithFormat:@"%@",kNSNumInteger(model.month)];
        }
        model.orderDate = [NSString stringWithFormat:@"%@月/%ld年",monthString,model.year];
        
        [_orderArray addObject:model];
        
    }
    _orderArray = (NSMutableArray *)[[_orderArray reverseObjectEnumerator] allObjects];
}
- (void)httpRequestData
{
    [LWProgressHUD displayProgressHUD:self.view displayText:@""];
    WEAKSELF
    [LWHttpRequestManager httpLoadDoctorRelateOrderIndexWithDate:[NSDate stringWithDate:[NSDate date] format:[NSDate ymdHmsFormat]] Success:^(NSMutableArray *models) {
        [LWProgressHUD closeProgressHUD:self.view];
        for (LWOrderListModel *model2 in KL_weakSelf.orderArray)
        {
            for (LWOrderListModel *model1 in models)
            {
                if (model1.year == model2.year && model1.month == model2.month)
                {
                    model2.phoneOrderNum = model1.phoneOrderNum;
                    model2.productOrderNum = model1.productOrderNum;
                    model2.graphicOrderNum = model1.graphicOrderNum;
                    model2.orderSum = model1.orderSum;
                    model2.date = model1.date;
                }
            }
            
        }
        [KL_weakSelf.collectionView reloadData];
        [KL_weakSelf moveDate:[NSDate date] animated:NO];
    } failure:^(NSString *errorMes) {
        [LWProgressHUD closeProgressHUD:self.view];
        [KL_weakSelf moveDate:[NSDate date] animated:NO];
    }];
    
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
    
    [self httpRequestData];
    
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
    [cell.orderCell setOrderCellData:model];
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
        [weakSelf moveDate:[NSDate dateWithString:date format:@"yyyy年MM月"] animated:YES];
    }];
    
    [self.pickView setDismissBlock:^{
        weakSelf.pickView = nil;
    }];
}
- (void)moveDate:(NSDate *)date animated:(BOOL)animated
{
    self.isMove = NO;
    WEAKSELF
    
    [self.orderArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LWOrderListModel *model = obj;
        if (model.month == [date month] && model.year == [date year])
        {
            [KL_weakSelf.collectionView scrollRectToVisible:CGRectMake((KL_weakSelf.collectionView.contentWidth/12)*idx- 5*idx, 0, KL_weakSelf.collectionView.width, KL_weakSelf.collectionView.height) animated:animated];
            
            KL_weakSelf.isMove = YES;
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
- (void)didSelectRowIndexPath:(NSIndexPath *)indexPath andOrderModel:(LWOrderListModel *)model
{
    LWOrderDetailedListViewController *vc = (LWOrderDetailedListViewController *)[UIViewController CreateControllerWithTag:CtrlTag_orderListDetailed];
    if (indexPath.row == 0) { //商品
        vc.productType = ProductTypeProductOrder;
        [MobClick beginEvent:@"ProductTypeProductOrder" label:@"商品"];

    }else if (indexPath.row == 1)//图文
    {
        vc.productType = ProductTypeGraphicOrder;
        [MobClick beginEvent:@"ProductTypeGraphicOrder" label:@"图文"];

    }else if (indexPath.row == 2)//电话
    {
        vc.productType = ProductTypePhoneOrder;
        [MobClick beginEvent:@"ProductTypePhoneOrder" label:@"电话"];

    }
    
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];

}


@end
