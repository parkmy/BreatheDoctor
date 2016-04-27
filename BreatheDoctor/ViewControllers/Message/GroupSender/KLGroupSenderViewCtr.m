//
//  KLGroupSenderViewCtr.m
//  BreatheDoctor
//
//  Created by comv on 16/4/25.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLGroupSenderViewCtr.h"
#import "KLGroupSenderTableHeardView.h"
#import "KLChatMessageInputBar.h"
#import <IQKeyboardManager.h>
#import "KLChatMessageMoreView.h"
#import "KLGoodsViewController.h"

@interface KLGroupSenderViewCtr ()

@property (nonatomic, strong) KLGroupSenderTableHeardView      *heardView;
@property (nonatomic, strong) KLChatMessageInputBar            *inputBar;
@property (nonatomic, strong) UIView                           *centerView;
@property (nonatomic, strong) NSMutableArray                   *patientArray;
@end

@implementation KLGroupSenderViewCtr

- (instancetype)initWithGroupSenderArray:(NSMutableArray *)array{

    if ([super init]) {
        self.patientArray = array;
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enable = NO;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [super addNavBar:@"群发"];
    [super addBackButton:@"nav_btnBack"];
}
- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self addSubViews];
    
    [self racEvent];
}
- (void)addSubViews{
    
    
    [self.view sd_addSubviews:@[self.heardView,self.inputBar]];
    
    self.heardView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,64)
    .heightIs(self.heardView.getHeight);
    
    self.inputBar.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .bottomSpaceToView(self.view,0)
    .heightIs(defHeight);
    
}
- (void)racEvent{
    
    WEAKSELF
    /**
     *  重新添加群发人
     */
    [[self.heardView rac_signalForSelector:@selector(backClick)] subscribeNext:^(id x) {
        [KL_weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    /**
     *  群发更多按钮点击
     */
    [[self.inputBar.mMoreView rac_signalForSelector:@selector(collectionView:didSelectItemAtIndexPath:)] subscribeNext:^(id x) {
        RACTuple *tuple = x;
        UICollectionView *collectionView = tuple.first;
        NSIndexPath      *indexPath = tuple.second;
        [KL_weakSelf didSelecollectionView:collectionView IndexPath:indexPath];
    }];
    
}
#pragma mark - click
- (void)didSelecollectionView:(UICollectionView *)collectionView IndexPath:(NSIndexPath *)indexPath{

    switch (indexPath.row) {
        case 0:
        {
        
        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {
            
        }
            break;
        case 3:
        {
            
        }
            break;
        case 4:
        {
            KLGoodsViewController *vc = [KLGoodsViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
    
}

#pragma mark - init
- (KLGroupSenderTableHeardView *)heardView{
    
    if (!_heardView) {
        _heardView = [[KLGroupSenderTableHeardView alloc] initWithPatientArray:self.patientArray];
    }
    return _heardView;
}
- (KLChatMessageInputBar *)inputBar{
    
    if (!_inputBar) {
        _inputBar = [KLChatMessageInputBar new];
    }
    return _inputBar;
}

#pragma mark -click

- (void)navLeftButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
