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

@interface LWPatientRelatedViewController ()<LWPatientRelatedViewDelegate>
@property (nonatomic, strong) UIView *saveView;
@property (nonatomic, strong) UIScrollView *mScrollView;

@property (nonatomic, strong) LWPatientRelatedView *patientRelatedView1;//诊断结果
@property (nonatomic, strong) LWPatientRelatedView *patientRelatedView2;//基本病情
@property (nonatomic, strong) LWPatientRelatedView *patientRelatedView3;//相关照片
@property (nonatomic, strong) NSMutableArray *mimageAssets;
@property (nonatomic, strong) NSMutableArray *relatedImages;
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
- (NSMutableArray *)mimageAssets
{
    if (!_mimageAssets) {
        _mimageAssets = [NSMutableArray array];
    }
    return _mimageAssets;
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
//        DNImagePickerController *imagePicker = [[DNImagePickerController alloc] init];
//        imagePicker.imagePickerDelegate = self;
//        [self presentViewController:imagePicker animated:YES completion:nil];
    }

}
- (void)deleteItemWithImage:(UIImage *)image withCollectionView:(UICollectionView *)collectionView
{
    [self.relatedImages removeObject:image];
    [collectionView reloadData];
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
