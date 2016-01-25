//
//  LWPatientRelatedViewController.m
//  BreatheDoctor
//
//  Created by comv on 16/1/12.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWPatientRelatedViewController.h"
#import "LWPatientRelatedView.h"
#import "ZZPhotoKit.h"
#import "ALActionSheetView.h"
#import "LWUpLoadingManager.h"
#import "ZZPhotoHud.h"
#import "SVProgressHUD.h"
#import "UITextView+placeholder.h"
#import "ZZBrowserPickerViewController.h"

@interface LWPatientRelatedViewController ()<LWPatientRelatedViewDelegate,ZZBrowserPickerDelegate>
@property (nonatomic, strong) UIView *saveView;
@property (nonatomic, strong) UIScrollView *mScrollView;

@property (nonatomic, strong) LWPatientRelatedView *patientRelatedView1;//诊断结果
@property (nonatomic, strong) LWPatientRelatedView *patientRelatedView2;//基本病情
@property (nonatomic, strong) LWPatientRelatedView *patientRelatedView3;//相关照片
@property (nonatomic, strong) NSMutableArray *mimageAssets;
@property (nonatomic, strong) NSMutableArray *relatedImages;
@property (nonatomic, strong) NSMutableArray *imageStrings;

@property (nonatomic, strong) LWPatientRelatedModel *model;

@property (nonatomic, copy) NSMutableString *imagesString;
@property (nonatomic, copy) NSString *treatmentResult;
@property (nonatomic, copy) NSString *basicCondition;

@property (nonatomic, strong) ZZBrowserPickerViewController *browserPicker;
@end

@implementation LWPatientRelatedViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [super addNavBar:@"患者病情相关"];
    [super addBackButton:@"nav_btnBack.png"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setUI];
    
    [self loadRelated];
}
- (NSMutableString *)imagesString
{
    if (!_imagesString) {
        _imagesString = [[NSMutableString alloc] initWithString:@""];
    }
    return _imagesString;
}
- (void)setUI
{
    _mScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height-64)];
    [self.view addSubview:_mScrollView];
    
    _patientRelatedView1 = [[LWPatientRelatedView alloc] init];
    _patientRelatedView1.patientRelatedType = PatientRelatedTypediagnosis;

    [_mScrollView addSubview:_patientRelatedView1];
    _patientRelatedView1.mScrollView = _mScrollView;
    
    
    _patientRelatedView2 = [[LWPatientRelatedView alloc] init];
    _patientRelatedView2.patientRelatedType = PatientRelatedTypecondition;
    [_mScrollView addSubview:_patientRelatedView2];
    _patientRelatedView2.mScrollView = _mScrollView;

    _patientRelatedView3 = [[LWPatientRelatedView alloc] init];
    _patientRelatedView3.patientRelatedType = PatientRelatedTypephoto;
    [_mScrollView addSubview:_patientRelatedView3];
    _patientRelatedView3.mScrollView = _mScrollView;
    _patientRelatedView3.delegate = self;
    
    _patientRelatedView1.sd_layout.topSpaceToView(_mScrollView,0).leftSpaceToView(_mScrollView,0).rightSpaceToView(_mScrollView,0).heightIs(115);
    
    _patientRelatedView2.sd_layout.topSpaceToView(_patientRelatedView1,15).leftSpaceToView(_mScrollView,0).rightSpaceToView(_mScrollView,0).heightIs(115);
    
    CGFloat h = 204;
    if (screenHeight > 570) {
        h = _mScrollView.height-60-115*2-70;
    }
    _patientRelatedView3.sd_layout.topSpaceToView(_patientRelatedView2,15).leftSpaceToView(_mScrollView,0).rightSpaceToView(_mScrollView,0).heightIs(h);
    
    [_mScrollView addSubview:self.saveView];
    
    self.saveView.sd_layout.topSpaceToView(_patientRelatedView3,10).leftSpaceToView(_mScrollView,0).rightSpaceToView(_mScrollView,0).heightIs(60);
    
    _mScrollView.contentHeight = 115*2+h+15*2+60+10;
    

}

- (UIView *)saveView
{
    if (!_saveView) {
        _saveView = [[UIView alloc] initWithFrame:CGRectZero];
        _saveView.backgroundColor = [UIColor clearColor];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectZero];
        [btn setCornerRadius:5.0f];
        [btn setTitle:@"保存" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        btn.backgroundColor = [LWThemeManager shareInstance].navBackgroundColor;
        [btn addTarget:self action:@selector(baocunButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_saveView addSubview:btn];
        
        
        btn.sd_layout.topSpaceToView(_saveView,5).leftSpaceToView(_saveView,15).rightSpaceToView(_saveView,15).bottomSpaceToView(_saveView,5);
    }
    return _saveView;
}
- (NSMutableArray *)relatedImages
{
    if (!_relatedImages) {
        _relatedImages = [NSMutableArray array];
    }
    return _relatedImages;
}
- (NSMutableArray *)imageStrings
{
    if (!_imageStrings) {
        _imageStrings = [NSMutableArray array];
    }
    return _imageStrings;
}
- (NSMutableArray *)mimageAssets
{
    if (!_mimageAssets) {
        _mimageAssets = [NSMutableArray array];
    }
    return _mimageAssets;
}

#pragma mark - click
- (void)baocunButtonClick:(UIButton *)sender
{
    self.treatmentResult = _patientRelatedView1.contentTextView.text;
    self.basicCondition = _patientRelatedView2.contentTextView.text;

    [self uploadImagesSuccess:^(NSMutableArray *models) {
        
        for (NSDictionary *dic in models) {
            NSArray *body = dic[@"body"];
            if (body.count <= 0) {
                return;
            }
            NSDictionary *dicDic = body[0];
            NSString *key = dicDic[@"key"];
            NSString *url = dicDic[@"url"];
            NSString *contentString =[NSString stringWithFormat:@"%@/%@",url,key];
            contentString = [contentString stringByReplacingOccurrencesOfString:@" " withString:@""];
            [contentString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
            [self.imageStrings addObject:contentString];
        }
        
        [self updateImages];
        if (self.model.sid) {
            [self updateRelated];
        }else{
            [self senderRelated];
        }
    }];
}
- (NSMutableArray *)traverseimages
{
    NSMutableArray *array = [NSMutableArray array];
    
    for (id objc in self.relatedImages)
    {
        if ([objc isKindOfClass:[UIImage class]]) {
            [array addObject:objc];
        }
    }
    return array;
}
- (void)updateImages
{
    NSMutableString *string = [[NSMutableString alloc] initWithString:@""];
    for (id objc in self.relatedImages) {
        if ([objc isKindOfClass:[NSString class]]) {
            [string appendString:[NSString stringWithFormat:@"%@|",objc]];
        }
    }
    for (NSString *url in self.imageStrings) {
        [string appendString:[NSString stringWithFormat:@"%@|",url]];
    }
    if (string.length > 0) {
        if ([[string substringWithRange:NSMakeRange(string.length-1, 1)] isEqualToString:@"|"]) {
            [string deleteCharactersInRange:NSMakeRange(string.length-1, 1)];
        }
    }
    self.imagesString = string;
}
- (void)uploadImagesSuccess:(void (^)(NSMutableArray *models))success
{
    if ([(NSMutableArray *)[self traverseimages] count] > 0)
    {
        [ZZPhotoHud showActiveHudWithTitle:@"正在保存..."];
        [LWUpLoadingManager startMultiPartUploadTaskWithURL:nil imagesArray:[self traverseimages] WithType:WSChatCellType_Image compressionRatio:.3 success:^(NSMutableArray *models)
        {
            success?success(models):nil;
        } failure:^(NSString *errorMes) {
            [ZZPhotoHud hideActiveHud];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:errorMes delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
            [alert show];
        }];
    }else{
        if (self.model.sid) {
            [self updateImages];
            [self updateRelated];
        }else{
            [ZZPhotoHud showActiveHudWithTitle:@"正在保存..."];
            [self senderRelated];
        }
    }

}

- (void)senderRelated
{
    [LWHttpRequestManager httpsubmitDiseaseRelateWithPatientId:self.patientId treatmentResult:self.treatmentResult basicCondition:self.basicCondition images:self.imagesString Success:^(NSMutableArray *models) {
        [ZZPhotoHud hideActiveHud];
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    } failure:^(NSString *errorMes) {
        [ZZPhotoHud hideActiveHud];
        [SVProgressHUD showErrorWithStatus:errorMes];
    }];
    
}
- (void)updateRelated
{
    [ZZPhotoHud showActiveHudWithTitle:@"正在修改..."];
    [LWHttpRequestManager httpupdateDiseaseRelateWithSid:self.model.sid treatmentResult:self.treatmentResult basicCondition:self.basicCondition images:self.imagesString Success:^(NSMutableArray *models) {
        [ZZPhotoHud hideActiveHud];
        [SVProgressHUD showSuccessWithStatus:@"修改成功"];
    } failure:^(NSString *errorMes) {
        [ZZPhotoHud hideActiveHud];
        [SVProgressHUD showErrorWithStatus:errorMes];
    }];

}

- (void)loadRelated
{
    [ZZPhotoHud showActiveHudWithTitle:@"正在加载..."];
    [LWHttpRequestManager httploadDiseaseRelate:self.patientId Success:^(LWPatientRelatedModel *model) {
        [ZZPhotoHud hideActiveHud];
        self.model = model;
        
        if (self.model.treatmentResult.length > 0) {
            [_patientRelatedView1 setContentTextViewText:stringJudgeNull(self.model.treatmentResult)];
        }else
        {
            _patientRelatedView1.contentTextView.placeholder = @"请描述患者基本病情...";
        }
        if (self.model.basicCondition.length > 0) {
            [_patientRelatedView2 setContentTextViewText:stringJudgeNull(self.model.basicCondition)];
        }else
        {
            _patientRelatedView2.contentTextView.placeholder = @"请填写诊断结果...";

        }
        self.imagesString = [[NSMutableString alloc] initWithString:stringJudgeNull(self.model.images)];
        [self.relatedImages removeAllObjects];
        if (self.model.images.length > 0) {
            for (NSString *url in [NSMutableArray arrayWithArray:[stringJudgeNull(self.model.images) componentsSeparatedByString:@"|"]])
            {
                if (url.length > 0) {
                    [self.relatedImages addObject:url];
                }
            }
        }
        
        [_patientRelatedView3 setImages:self.relatedImages ];
        
    } failure:^(NSString *errorMes) {
        [ZZPhotoHud hideActiveHud];
        
    }];
}


#pragma mark -LWPatientRelatedViewDelegate
- (void)selectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.relatedImages.count)
    {
        
        ALActionSheetView *view = [[ALActionSheetView alloc] initWithTitle:@"上传图片" cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@[@"相册",@"相机"] handler:^(ALActionSheetView *actionSheetView, NSInteger buttonIndex) {
            
            if (buttonIndex == 0) {
                
                ZZPhotoController *photoController = [[ZZPhotoController alloc]init];
                photoController.selectPhotoOfMax = 9;
                
                [photoController showIn:self result:^(id responseObject){
                    
                    NSArray *array = (NSArray *)responseObject;
                    [self.relatedImages addObjectsFromArray:array];
                    [self.patientRelatedView3 setImages:self.relatedImages];
                    
                }];

                
            }else if (buttonIndex == 1)
            {
                ZZCameraController *cameraController = [[ZZCameraController alloc]init];
                cameraController.takePhotoOfMax = 9;
                [cameraController showIn:self result:^(id responseObject){
                    
                    NSArray *array = (NSArray *)responseObject;
                    [self.relatedImages addObjectsFromArray:array];
                    [self.patientRelatedView3 setImages:self.relatedImages];
                }];

            }
            
        }];
        
        [view show];
    }else
    {
        self.browserPicker = [[ZZBrowserPickerViewController alloc]init];
        self.browserPicker.delegate = self;
        [self.browserPicker reloadData];
        [self.browserPicker showIn:self animation:ShowAnimationOfPresent];
    
    }

}
- (void)deleteItemWithImage:(id )objc withCollectionView:(UICollectionView *)collectionView
{
    [self.relatedImages removeObject:objc];
    [collectionView reloadData];
}

#pragma mark -

-(NSInteger)zzbrowserPickerPhotoNum:(ZZBrowserPickerViewController *)controller
{
    return self.relatedImages.count;
}
-(NSArray *)zzbrowserPickerPhotoContent:(ZZBrowserPickerViewController *)controller
{
    return self.relatedImages;
}
-(void)zzbrowerPickerPhotoRemove:(NSInteger) indexPath
{
    if (self.relatedImages.count > indexPath) {
        [self.relatedImages removeObjectAtIndex:indexPath];
    }
    [self.patientRelatedView3 setImages:self.relatedImages];
}
#pragma mark -nav
- (void)navLeftButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
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
