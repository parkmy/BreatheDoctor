//
//  KLGoodsDetailedViewController.m
//  BreatheDoctor
//
//  Created by comv on 16/4/29.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLGoodsDetailedViewController.h"
#import "KLGoodsDetailedImageCell.h"
#import "KLGoodsDetailedIntroductionCell.h"
#import "KLGoodsDetailedModel.h"
#import "KLGoodsDetailedImageView.h"
#import "KLGroupSenderOperation.h"
#import <UIImageView+WebCache.h>
#import <SDImageCache.h>
#import "KLGoodsImageModel.h"

@interface KLGoodsDetailedViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UIButton *footSenderButton;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) KLGoodsDetailedModel *goodsDetailedModel;
@property (nonatomic, copy)   NSString    *goodsID;

@property (nonatomic, strong) KLGoodsDetailedImageView *goodsDetailedImageView;
@property (nonatomic, assign) BOOL               isHiddenFootButton;

@property (nonatomic, strong) NSMutableArray  *imageUrls;
@property (nonatomic, strong) UILabel         *tableFootLabel;

@end

@implementation KLGoodsDetailedViewController
- (id)initWithGoodsId:(NSString *)goodsId theFootButtonHidden:(BOOL)isHidden{
    
    if ([super init]) {
        self.goodsID = goodsId;
        self.isHiddenFootButton = isHidden;
        _imageUrls = [NSMutableArray array];
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [super addNavBar:@"商品详情"];
    [super addBackButton:@"nav_btnBack"];
}
- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self loadSubView];
    
    [self loadGoodsDetailedData];
    
    [self racEvent];
}

- (void)loadSubView{
    
//    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.footSenderButton];
    
    [self setFootView];
    
    CGFloat footButtonHeight = self.isHiddenFootButton?0:(40*MULTIPLEVIEW);
    
    self.footSenderButton.sd_layout
    .leftSpaceToView(self.view,10)
    .rightSpaceToView(self.view,10)
    .bottomSpaceToView(self.view,10)
    .heightIs(footButtonHeight);
    
    self.tableView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .bottomSpaceToView(self.footSenderButton,10)
    .topSpaceToView(self.view,BARHIGHT);
}
- (void)loadGoodsDetailedData{
    WEAKSELF
    [LWHttpRequestManager httploadProductDetailWithproductId:self.goodsID Success:^(KLGoodsDetailedModel *models) {
        
        KL_weakSelf.tableFootLabel.text = [NSString stringWithFormat:@"您有任何疑问，请与客服人员联系 \n电话: %@    QQ: %@",models.servicePhone,models.serviceQq];
        KL_weakSelf.goodsDetailedModel = models;
        KL_weakSelf.goodsDetailedImageView.model = models;
        [KL_weakSelf.imageUrls removeAllObjects];
        [KL_weakSelf.imageUrls addObjectsFromArray:[KLGroupSenderOperation goodsImageUrlListWithList:models.imageUrlList]];
        [KL_weakSelf.tableView reloadData];
    } failure:^(NSString *errorMes) {
        [[KLPromptViewManager shareInstance] kl_showPromptViewWithTitle:@"温馨提示" theContent:errorMes];
    }];
    
}

- (void)racEvent{
    
    
}
#pragma mark - init
- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                  style:UITableViewStyleGrouped];
        _tableView.backgroundColor  = [UIColor clearColor];
        _tableView.dataSource       = self;
        _tableView.delegate         = self;
        
        [_tableView registerClass:[KLGoodsDetailedImageCell class]
           forCellReuseIdentifier:@"KLGoodsDetailedImageCell"];
        [_tableView registerClass:[KLGoodsDetailedIntroductionCell class] forCellReuseIdentifier:@"KLGoodsDetailedIntroductionCell"];
    }
    return _tableView;
}
- (KLGoodsDetailedImageView *)goodsDetailedImageView{
    
    if (!_goodsDetailedImageView) {
        _goodsDetailedImageView = [KLGoodsDetailedImageView new];
    }
    return _goodsDetailedImageView;
}
- (void)setFootView{
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    view.frame = CGRectMake(0, 0, screenWidth, 35);
    
    _tableFootLabel = [UILabel new];
    _tableFootLabel.numberOfLines = 0;
    _tableFootLabel.backgroundColor = [UIColor clearColor];
    _tableFootLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    _tableFootLabel.font = kNSPXFONT(24);
    _tableFootLabel.frame = CGRectMake(10, 0, screenWidth-20, 35);
    
    [view addSubview:self.tableFootLabel];
    
    self.tableView.tableFooterView = view;
}

- (UIButton *)footSenderButton{
    
    if (!_footSenderButton) {
        _footSenderButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _footSenderButton.backgroundColor = [UIColor colorWithHexString:@"#ff9402"];
        [_footSenderButton setTitle:@"发给给患者" forState:UIControlStateNormal];
        [_footSenderButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _footSenderButton.titleLabel.font = kNSPXFONT(30);
        [_footSenderButton setCornerRadius:4.0f];
        [_footSenderButton addTarget:self action:@selector(footButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _footSenderButton;
}
- (void)footButtonClick:(UIButton *)sender{
    
    [self footButtonClick:sender theSenderVC:self];
}
- (void)footButtonClick:(UIButton *)sender theSenderVC:(UIViewController *)vc{
}
#pragma mark -delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return section==0?1:self.imageUrls.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = nil;
    if (indexPath.section == 0) {
        KLGoodsDetailedIntroductionCell *introductionCell = [tableView dequeueReusableCellWithIdentifier:@"KLGoodsDetailedIntroductionCell" forIndexPath:indexPath];
        [introductionCell setModel:self.goodsDetailedModel];
        cell = introductionCell;
    }else{
        KLGoodsDetailedImageCell *imageCell = [tableView dequeueReusableCellWithIdentifier:@"KLGoodsDetailedImageCell" forIndexPath:indexPath];
        
        KLGoodsImageModel *imageModel = self.imageUrls[indexPath.row];
        WEAKSELF
        [imageCell.goodsimageView sd_setImageWithURL:kNSURL(imageModel.imageUrl) placeholderImage:kImage(@"defaultIconImage") completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            CGSize size = [imageModel imageCFsizeWithSize:image.size];
            if (size.width != imageModel.imageSize.width || size.height != imageModel.imageSize.height) {
                [KL_weakSelf.tableView.cellAutoHeightManager clearHeightCache];
                imageModel.imageSize = [imageModel imageCFsizeWithSize:image.size];
                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:0];
            }
        }];
        
        cell = imageCell;
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 13;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return .1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        CGFloat height = [self.tableView cellHeightForIndexPath:indexPath model:self.goodsDetailedModel keyPath:@"model" cellClass:[KLGoodsDetailedIntroductionCell class] contentViewWidth:[self cellContentViewWith]];
        return height;
    }
    else{
    
        KLGoodsImageModel *imageModel = self.imageUrls[indexPath.row];

        return imageModel.imageSize.height;
    }
    
}
- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && systemVersion < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}
#pragma mark -click
- (void)navLeftButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
