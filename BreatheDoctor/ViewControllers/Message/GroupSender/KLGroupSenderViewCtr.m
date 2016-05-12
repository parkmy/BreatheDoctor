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
#import "KLImagePickerManager.h"
#import "FastReplyVC.h"
#import "LWUpLoadingManager.h"
#import "YRJSONAdapter.h"
#import "KLGroupSenderPatientListModel.h"
#import "LWPatientListCtr.h"
#import "KLIndicatorViewManager.h"

@interface KLGroupSenderViewCtr ()

@property (nonatomic, strong) KLGroupSenderTableHeardView      *heardView;
@property (nonatomic, strong) KLChatMessageInputBar            *inputBar;
@property (nonatomic, strong) UIView                           *centerView;
@property (nonatomic, strong) KLGroupSenderPatientListModel    *listModel;
@end

@implementation KLGroupSenderViewCtr

- (instancetype)initWithGroupSenderPatientListModel:(KLGroupSenderPatientListModel *)listModel{
    
    if ([super init]) {
        
        self.listModel = listModel;
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
        if (KL_weakSelf.pushType == PUSHTYPEAGAIN) {
            
            LWPatientListCtr *vc = [[LWPatientListCtr alloc] initWithListType:LISTTYPEGROUPAGAINSENDER];
            vc.ListModel = KL_weakSelf.listModel;
            [KL_weakSelf.navigationController pushViewController:vc animated:YES];
            
            [[vc rac_signalForSelector:@selector(againSenderEdtiorSuccModel:)] subscribeNext:^(id x) {
                
                [KL_weakSelf.navigationController popViewControllerAnimated:YES];
                RACTuple *tuple = x;
                KL_weakSelf.listModel = tuple.first;
                KL_weakSelf.heardView.listModel = tuple.first;
                KL_weakSelf.heardView.sd_layout.heightIs(KL_weakSelf.heardView.getHeight);
            }];
        }else{
            
            [KL_weakSelf.navigationController popViewControllerAnimated:YES];
        }
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
    /**
     *  群发语音
     */
    [[self.inputBar rac_signalForSelector:@selector(kl_voiceSenderWithVoiceData:theVoiceCount:)] subscribeNext:^(id x) {
        
        RACTuple *tuple = x;
        NSInteger voiceCount = [tuple.second integerValue];
        [KL_weakSelf uploadData:tuple.first theType:3 count:voiceCount];
    }];
    /**
     *  群发文字
     */
    [[self.inputBar rac_signalForSelector:@selector(kl_textSenderWithText:)] subscribeNext:^(id x) {
        
        RACTuple *tuple = x;
        [[KLIndicatorViewManager standardIndicatorViewManager] showLoadingWithContent:@"正在发送" theView:KL_weakSelf.view];
        [KL_weakSelf senderMessageWithContent:tuple.first theType:1 coiceCount:0 foreignId:nil theSenderView:KL_weakSelf.view];
    }];
}

- (void)senderMessageWithContent:(NSString *)content theType:(NSInteger )type coiceCount:(NSInteger)count foreignId:(NSString *)foreignId theSenderView:(UIView *)senderView{
    
    WEAKSELF
    [LWHttpRequestManager httploadProductDetailWithContent:content patientIdJsonStr:[self.listModel patientIDJsonString] contentType:type voiceMin:count foreignId:foreignId Success:^{

        [[KLIndicatorViewManager standardIndicatorViewManager] showErrorWith:@"发送成功" theView:senderView theImage:nil showSucc:^{
            
            if (type == 13) {
                [MobClick event:@"goodssender" label:@"商品发送"];
            }
            [KL_weakSelf guoupSenderSuccess];
        }];
    } failure:^(NSString *errorMes) {
        
        [[KLPromptViewManager shareInstance] kl_showPromptViewWithTitle:@"温馨提示" theContent:errorMes];
    }];
}
- (void)guoupSenderSuccess{

}
- (void)uploadData:(NSData *)data
           theType:(NSInteger)type
             count:(NSInteger)count{
    [[KLIndicatorViewManager standardIndicatorViewManager] showLoadingWithContent:@"正在发送" theView:self.view];
    WEAKSELF
    [LWUpLoadingManager httpUpLoadData:data withType:type withVocMain:count success:^(NSDictionary *dic) {
        [KL_weakSelf senderMessageWithContent:[LWUpLoadingManager getUploadSuccessString:dic] theType:type coiceCount:count foreignId:nil theSenderView:KL_weakSelf.view];
    } failure:nil];
}
-  (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
#pragma mark - click
- (void)didSelecollectionView:(UICollectionView *)collectionView IndexPath:(NSIndexPath *)indexPath{
    
    WEAKSELF
    switch (indexPath.row) {
        case 0: //照片
        {
            [[KLImagePickerManager shareInstance] photoLibraryTheNav:self.navigationController succBlock:^(NSData *imageData) {
                
                [KL_weakSelf uploadData:imageData theType:2 count:0];
            }];
        }
            break;
        case 1://相机
        {
            [[KLImagePickerManager shareInstance] cameraTheNav:self.navigationController succBlock:^(NSData *imageData) {
                
                [KL_weakSelf uploadData:imageData theType:2 count:0];
            }];
        }
            break;
        case 2://快捷回复
        {
            
            FastReplyVC *vc = (FastReplyVC *)[UIViewController CreateControllerWithTag:CtrlTag_FastReply];
            [vc setChooseFastRepBlock:^(NSString *content) {
                
                [KL_weakSelf.inputBar kl_fastReplyContent:content];
            }];
            [self.navigationController pushViewController:vc animated:YES];
            
            [MobClick event:@"FastReply" label:@"快捷回复按钮的点击量"];
            
        }
            break;
        case 3:
        {
            KLGoodsViewController *vc = [KLGoodsViewController new];
            [self.navigationController pushViewController:vc animated:YES];
            /**
             *  群发商品
             */
            WEAKSELF
            [[vc rac_signalForSelector:@selector(senderGoods:theSenderVc:)] subscribeNext:^(id x) {
                
                RACTuple *tuple = x;
                UIViewController *senderVc = tuple.second;

                [[KLIndicatorViewManager standardIndicatorViewManager] showLoadingWithContent:@"正在发送" theView:senderVc.view];
                [KL_weakSelf senderMessageWithContent:nil theType:13 coiceCount:0 foreignId:tuple.first theSenderView:senderVc.view];
            }];
            
        }
            break;
            
        default:
            break;
    }
    
}

#pragma mark - init
- (KLGroupSenderTableHeardView *)heardView{
    
    if (!_heardView) {
        
        _heardView = [[KLGroupSenderTableHeardView alloc] initWithPatientListModel:self.listModel];
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
