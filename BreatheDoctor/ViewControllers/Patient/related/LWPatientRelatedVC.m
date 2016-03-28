//
//  LWPatientRelatedVC.m
//  BreatheDoctor
//
//  Created by comv on 16/3/23.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWPatientRelatedVC.h"
#import "LWPatientRelatedPhotoCell.h"
#import "ZZPhotoKit.h"
#import "ALActionSheetView.h"
#import "LWUpLoadingManager.h"
#import "ZZPhotoHud.h"
#import "SVProgressHUD.h"
#import "UITextView+placeholder.h"
#import "ZZBrowserPickerViewController.h"
#import "KLPatientRelatedModel.h"

@interface LWPatientRelatedVC ()<UITableViewDataSource,UITableViewDelegate,LWPatientRelatedPhotoCellDelegate,ZZBrowserPickerDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) LWPatientRelatedModel *model;

@property (nonatomic, strong) ZZBrowserPickerViewController *browserPicker;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation LWPatientRelatedVC
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [super addNavBar:@"患者病情相关"];
    [super addBackButton:@"nav_btnBack.png"];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataArray = [KLPatientRelatedModel patientRelatedModels];
    
    [self setUI];
    [self loadRelated];
}

- (void)setUI
{
    [self.view addSubview:self.tableView];
    self.tableView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[LWBasePatientRelatedCell class] forCellReuseIdentifier:@"LWBasePatientRelatedCell"];
        [_tableView registerClass:[LWPatientRelatedPhotoCell class] forCellReuseIdentifier:@"LWPatientRelatedPhotoCell"];
    }
    return _tableView;
}

#pragma mark -void
- (void)loadRelated
{
    [ZZPhotoHud showActiveHudWithTitle:@"正在加载..."];
    [LWHttpRequestManager httploadDiseaseRelate:self.patientId Success:^(LWPatientRelatedModel *model) {
        [ZZPhotoHud hideActiveHud];
        self.model = model;
        [KLPatientRelatedModel patientRelatedModelsWithModel:model andArray:self.dataArray];
        KLPatientRelatedModel *patientRelatedModel = [self imagePatientRelatedModel];
        [patientRelatedModel imagesChangeHeight:patientRelatedModel.images];
        [self.tableView reloadData];
    } failure:^(NSString *errorMes) {
        [ZZPhotoHud hideActiveHud];
        [LCCoolHUD showFailure:errorMes zoom:YES shadow:NO];
    }];
}

- (void)uploadImagesSuccess:(void (^)(NSMutableArray *models))success
{
    
    NSMutableArray *array = [self traverseimages];
    
    if ([array count] > 0)
    {
        [ZZPhotoHud showActiveHudWithTitle:@"正在保存..."];
        [LWUpLoadingManager startMultiPartUploadTaskWithURL:nil imagesArray:array WithType:WSChatCellType_Image compressionRatio:.3 success:^(NSMutableArray *models)
         {
             success?success(models):nil;
         } failure:^(NSString *errorMes) {
             [ZZPhotoHud hideActiveHud];
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:errorMes delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
             [alert show];
         }];
    }else{
        if (self.model.sid) {
            [self updateImagesWithArray:nil];
            [self updateRelated];
        }else{
            [ZZPhotoHud showActiveHudWithTitle:@"正在保存..."];
            [self senderRelated];
        }
    }
    
}
- (NSMutableArray *)traverseimages
{
    NSMutableArray *array = [NSMutableArray array];
    KLPatientRelatedModel *patientRelatedModel = [self imagePatientRelatedModel];
    for (id objc in patientRelatedModel.images)
    {
        if ([objc isKindOfClass:[UIImage class]]) {
            [array addObject:objc];
        }
    }
    return array;
}
//更新
- (void)updateRelated
{
    [ZZPhotoHud showActiveHudWithTitle:@"正在修改..."];
    [LWHttpRequestManager httpupdateDiseaseRelateWithSid:self.model.sid treatmentResult:[self treatmentResult] basicCondition:[self basicCondition] images:[self updateImageString] Success:^(NSMutableArray *models) {
        [ZZPhotoHud hideActiveHud];
        [LCCoolHUD showSuccess:@"修改成功" zoom:YES shadow:NO];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    } failure:^(NSString *errorMes) {
        [ZZPhotoHud hideActiveHud];
        [LCCoolHUD showFailure:errorMes zoom:YES shadow:NO];
    }];
    [self cancelChange];
}
//增加
- (void)senderRelated
{
    [LWHttpRequestManager httpsubmitDiseaseRelateWithPatientId:self.patientId treatmentResult:[self treatmentResult] basicCondition:[self basicCondition] images:[self updateImageString] Success:^(NSMutableArray *models) {
        [ZZPhotoHud hideActiveHud];
        [LCCoolHUD showSuccess:@"保存成功" zoom:YES shadow:NO];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    } failure:^(NSString *errorMes) {
        [ZZPhotoHud hideActiveHud];
        [LCCoolHUD showFailure:errorMes zoom:YES shadow:NO];
    }];
    [self cancelChange];
}
//保存
- (void)baocunButtonClick:(UIButton *)sender
{
    [self uploadImagesSuccess:^(NSMutableArray *models) {
        
        NSMutableArray *updateImages = [NSMutableArray array];
        
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
            [updateImages addObject:contentString];
        }
       
        [self updateImagesWithArray:updateImages];
        
        if (self.model.sid) {
            [self updateRelated];
        }else{
            [self senderRelated];
        }
    }];
}
- (void)updateImagesWithArray:(NSMutableArray *)array
{
    KLPatientRelatedModel *patientRelatedModel = [self imagePatientRelatedModel];
    
    [patientRelatedModel updateImagesString:array];
}
- (NSString *)treatmentResult
{
    KLPatientRelatedModel *patientRelatedModel = self.dataArray[0];
    return patientRelatedModel.contentString;
}
- (NSString *)basicCondition
{
    KLPatientRelatedModel *patientRelatedModel = self.dataArray[1];
    return patientRelatedModel.contentString;
}
- (NSString *)updateImageString
{
    KLPatientRelatedModel *patientRelatedModel = [self imagePatientRelatedModel];
    return patientRelatedModel.imagesString;
}
#pragma mark -UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KLPatientRelatedModel *model = self.dataArray[indexPath.section];
    return model.cellRowHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return section == 2?75:10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return .1;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == self.dataArray.count-1) {
        return [self saveView];
    }
    return nil;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    KLPatientRelatedModel *patientRelatedModel = self.dataArray[indexPath.section];
    
    if (indexPath.section == 0 || indexPath.section == 1)
    {
        LWBasePatientRelatedCell *patientRelatedCell = [tableView dequeueReusableCellWithIdentifier:@"LWBasePatientRelatedCell" forIndexPath:indexPath];
        patientRelatedCell.model = patientRelatedModel;
        patientRelatedCell.iconImageView.image = kImage(patientRelatedModel.iconImageNmae);
        patientRelatedCell.titleLabel.text = patientRelatedModel.titleNmae;
        
        if (patientRelatedModel.contentString.length > 0) {
            [patientRelatedCell.mContentTextView setText:stringJudgeNull(patientRelatedModel.contentString)];
            patientRelatedCell.mContentTextView.placeholder = @"";
        }else
        {
            patientRelatedCell.mContentTextView.placeholder = patientRelatedModel.placeholder;
        }
        cell = patientRelatedCell;
    }else
    {
        LWPatientRelatedPhotoCell *patientRelatedPhotoCell = [tableView dequeueReusableCellWithIdentifier:@"LWPatientRelatedPhotoCell" forIndexPath:indexPath];
        patientRelatedPhotoCell.model = patientRelatedModel;
        patientRelatedPhotoCell.iconImageView.image = kImage(patientRelatedModel.iconImageNmae);
        patientRelatedPhotoCell.titleLabel.text = patientRelatedModel.titleNmae;
        patientRelatedPhotoCell.delegate = self;
        [patientRelatedPhotoCell setImages:patientRelatedModel.images];
        cell = patientRelatedPhotoCell;
    }
    return cell;
}
- (UIView *)saveView
{
    UIView *saveView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 75)];
    saveView.backgroundColor = [UIColor clearColor];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, screenWidth-20, 75-30)];
    [btn setCornerRadius:3.0f];
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = kNSPXFONT(32);
    btn.backgroundColor = [LWThemeManager shareInstance].navBackgroundColor;
    [btn addTarget:self action:@selector(baocunButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [saveView addSubview:btn];
    return saveView;
}

#pragma mark -LWPatientRelatedViewDelegate
- (void)selectItemAtIndexPath:(NSIndexPath *)indexPath
{
    KLPatientRelatedModel *patientRelatedModel = [self imagePatientRelatedModel];

    if (indexPath.row == patientRelatedModel.images.count)
    {
        ALActionSheetView *view = [[ALActionSheetView alloc] initWithTitle:@"上传图片" cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@[@"相册",@"相机"] handler:^(ALActionSheetView *actionSheetView, NSInteger buttonIndex) {
            
            if (buttonIndex == 0) {
                
                ZZPhotoController *photoController = [[ZZPhotoController alloc]init];
                photoController.selectPhotoOfMax = 9;
                [photoController showIn:self result:^(id responseObject){
                    [self addImages:responseObject];
                }];
            }else if (buttonIndex == 1)
            {
                ZZCameraController *cameraController = [[ZZCameraController alloc]init];
                cameraController.takePhotoOfMax = 9;
                [cameraController showIn:self result:^(id responseObject){
                    [self addImages:responseObject];
                }];
            }
        }];
        
        [view show];
    }else
    {
        self.browserPicker = [[ZZBrowserPickerViewController alloc]init];
        self.browserPicker.showType = showTypeWindow;
        self.browserPicker.delegate = self;
        [self.browserPicker reloadData];
        [self.browserPicker showIn:self animation:ShowAnimationOfPresent];
        
    }
    
}
//。添加图片
- (void)addImages:(id )responseObject
{
    NSArray *array = (NSArray *)responseObject;

    KLPatientRelatedModel *patientRelatedModel = [self imagePatientRelatedModel];

    [patientRelatedModel addImages:array];
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
    
}
- (void)deleteItemWithImage:(id )objc withCollectionView:(UICollectionView *)collectionView
{
    KLPatientRelatedModel *patientRelatedModel = [self imagePatientRelatedModel];
    [patientRelatedModel deleteImage:objc];
    [collectionView reloadData];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
}
- (KLPatientRelatedModel *)imagePatientRelatedModel
{
    KLPatientRelatedModel *patientRelatedModel = self.dataArray[2];
    return patientRelatedModel;
}
#pragma mark -

-(NSInteger)zzbrowserPickerPhotoNum:(ZZBrowserPickerViewController *)controller
{
    KLPatientRelatedModel *patientRelatedModel = [self imagePatientRelatedModel];
    return patientRelatedModel.images.count;
}
-(NSArray *)zzbrowserPickerPhotoContent:(ZZBrowserPickerViewController *)controller
{
    KLPatientRelatedModel *patientRelatedModel = [self imagePatientRelatedModel];

    return patientRelatedModel.images;
}
-(void)zzbrowerPickerPhotoRemove:(NSInteger) indexPath
{
    KLPatientRelatedModel *patientRelatedModel = [self imagePatientRelatedModel];
    patientRelatedModel.isChange = YES;
    [patientRelatedModel.images rewriteRemoveObjectAtIndex:indexPath];
    [patientRelatedModel imagesChangeHeight:patientRelatedModel.images];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:0];
}
#pragma mark -nav
- (void)navLeftButtonAction
{
    BOOL isChange = NO;
    for (KLPatientRelatedModel *model in self.dataArray) {
        if (model.isChange)
        {
            isChange = YES;
            break;
        }
    }
    if (isChange) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您没有保存，是否保存？" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
        [alert show];
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }else
    {
        [self baocunButtonClick:nil];
    }
}
- (void)cancelChange
{
    for (KLPatientRelatedModel *model in self.dataArray) {
        model.isChange = NO;
    }
}


@end
