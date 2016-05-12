//
//  KLGoodsViewController.m
//  BreatheDoctor
//
//  Created by comv on 16/4/26.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLGoodsViewController.h"
#import "KLGoodsCell.h"
#import "ALActionSheetView.h"
#import <MJRefresh.h>
#import "KLGoodsDetailedViewController.h"
#import "KLGoodsModel.h"
#import "FDActionSheet.h"

@interface KLGoodsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, assign) NSInteger         page;
@property (nonatomic, strong) NSMutableArray    *dataArray;
@property (nonatomic, assign) BOOL              isPull;
@property (nonatomic, strong) NSIndexPath       *seleIndexPath;
@property (nonatomic, strong) UITableView       *tableView;
@end

@implementation KLGoodsViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [super addNavBar:@"商品"];
    [super addBackButton:@"nav_btnBack"];
}
- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = false;
    
    [self initProperty];
    
    [self registerCell];
    
    [self xialarefreshData];
    

//    [self.dataArray.rac_sequence flattenMap:^RACStream *(id value) {
//       
//        
//    }];
    
    
    //    [self racEvent];
}
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)initProperty
{
    self.page = 1;
    self.isPull = YES;
    
    _tableView = ({
        
        UITableView *table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        table.dataSource = self;
        table.delegate = self;
        
        table;
    });
    [self.view addSubview:_tableView];
    _tableView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(64, 0, 0, 0));
    self.tableView.separatorStyle = 0;
}
- (void)loadGoods{
    
    [LWHttpRequestManager httploadProductListPage:self.page theCount:7 Success:^(NSMutableArray *models) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self hiddenNonetWork];
        if (self.isPull) {
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:models];
        }else
        {
            if(models.count > 0){
                [self.dataArray addObjectsFromArray:models];
            }else
            {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }
        [self.tableView reloadData];
        if (self.dataArray.count <= 0) {
            [self showErrorMessage:@"暂无商品，尽请期待" isShowButton:YES type:showErrorTypeMore];
        }
        
    } failure:^(NSString *errorMes) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if (self.dataArray.count <= 0) {
            [self showErrorMessage:errorMes isShowButton:NO type:showErrorTypeHttp];
        }
        
    }];
}

- (void)reloadRequestWithSender:(UIButton *)sender{
    
    [self hiddenNonetWork];
    [self.tableView.mj_header beginRefreshing];
}

- (void)xialarefreshData
{
    __weak typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.isPull = YES;
        weakSelf.page = 1;
        [weakSelf loadGoods];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        
        weakSelf.isPull = NO;
        weakSelf.page ++;
        [weakSelf loadGoods];
        
    }];
    
    self.tableView.mj_footer.automaticallyHidden = YES;
    //    self.tableView.mj_footer.ignoredScrollViewContentInsetBottom = 6;
    [header beginRefreshing];
    
    // 设置文字
    //    [header setTitle:@"下拉加载数据" forState:MJRefreshStateIdle];
    //    [header setTitle:@"正在加载 ..." forState:MJRefreshStateRefreshing];
    // 隐藏时间
    //    header.lastUpdatedTimeLabel.hidden = YES;
    [self.tableView setMj_header:header];
}
- (void)registerCell{
    setExtraCellLineHidden(self.tableView);
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[KLGoodsCell class] forCellReuseIdentifier:@"KLGoodsCell"];
}
- (void)navLeftButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 90*MULTIPLEVIEW;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    KLGoodsCell *goodsCell = [tableView dequeueReusableCellWithIdentifier:@"KLGoodsCell" forIndexPath:indexPath];
    [goodsCell setGoods:self.dataArray[indexPath.row]];
    return goodsCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.seleIndexPath = indexPath;
    
    FDActionSheet *sheet = [[FDActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"预览此商品",@"发送给患者",nil];
    [sheet show];
}
- (void)actionSheetCancel:(FDActionSheet *)actionSheet{
    
    [self.tableView deselectRowAtIndexPath:self.seleIndexPath animated:YES];
}
- (void)hideSuccess{
    
    [self.tableView deselectRowAtIndexPath:self.seleIndexPath animated:YES];
}
- (void)actionSheet:(FDActionSheet *)sheet clickedButtonIndex:(NSInteger)buttonIndex{
    
    [self.tableView deselectRowAtIndexPath:self.seleIndexPath animated:YES];
    
    KLGoodsModel *model = (KLGoodsModel *)self.dataArray[self.seleIndexPath.row];
    
    if (buttonIndex == 0) {
        
        KLGoodsDetailedViewController *vc = [[KLGoodsDetailedViewController alloc] initWithGoodsId:model.productId theFootButtonHidden:NO];
        [self.navigationController pushViewController:vc animated:YES];
        
        [[vc rac_signalForSelector:@selector(footButtonClick:theSenderVC:)] subscribeNext:^(id x) {
            
            RACTuple *Tuple = x;
            [self senderGoods:model.productId theSenderVc:Tuple.second];
        }];
        
    }else if (buttonIndex == 1)
    {
        [self senderGoods:model.productId theSenderVc:self];
    }
}
- (void)senderGoods:(NSString *)goodsId theSenderVc:(UIViewController *)vc{
}

@end
