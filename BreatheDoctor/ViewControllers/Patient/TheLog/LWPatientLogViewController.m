//
//  LWPatientLogViewController.m
//  BreatheDoctor
//
//  Created by comv on 15/11/22.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWPatientLogViewController.h"
#import "SegmentTapView.h"
#import "FlipTableView.h"
#import "LWPatientLogDateIndexView.h"
#import "LWYerChangIndexView.h"
#import "LWPatientPEFLogVC.h"
#import "LWPatientAssessmentLogVC.h"
#import "LWPatientSymptomsLogVC.h"
#import "LWPatientMedicationLogVC.h"
#import "NSDate+Extension.h"

@interface LWPatientLogViewController ()<SegmentTapViewDelegate,FlipTableViewDelegate,LWPatientLogDateIndexViewDeleagte>
@property (nonatomic, strong) SegmentTapView *segment;
@property (nonatomic, strong) LWPatientLogDateIndexView *dateView;
@property (nonatomic, strong) LWYerChangIndexView *yerIndexView;
@property (nonatomic, strong) FlipTableView *flipView;
@property (strong, nonatomic) NSMutableArray *controllsArray;

@property (nonatomic, strong) LWPatientPEFLogVC *PEFLog;
@property (nonatomic, strong) LWPatientAssessmentLogVC *AssessmentLog;
@property (nonatomic, strong) LWPatientSymptomsLogVC *SymptomsLog;
@property (nonatomic, strong) LWPatientMedicationLogVC *MedicationLog;

@property (nonatomic, strong) LWPEFLineModel *logDataModel;

//@property (nonatomic, assign) NSInteger seleIndex;
@end

@implementation LWPatientLogViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [super addNavBar:@"患者日志"];
    [super addBackButton:@"nav_btnBack.png"];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initSegment];
    [self initDateView];
    [self initproperty];
    [self initFlipTableView];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self loadLogRecord];
    [self.AssessmentLog refreshAssessmentLog:self.patientId];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc
{
    [LWPublicDataManager shareInstance].starDate = nil;
    [LWPublicDataManager shareInstance].endDate = nil;
    [LWPublicDataManager shareInstance].logModle = nil;
    [LWPublicDataManager shareInstance].yer = nil;
    [LWPublicDataManager shareInstance].month = nil;
    [LWPublicDataManager shareInstance].changeDate = nil;
}
#pragma mark - data
- (void)loadLogRecord
{
    [LWPublicDataManager shareInstance].logModle = nil;
    [LWProgressHUD displayProgressHUD:self.view.window displayText:@"请稍后..."];
    [LWHttpRequestManager httpLoadPEFRecordWithPatientId:self.patientId StartDt:[LWPublicDataManager shareInstance].starDate EndDt:[LWPublicDataManager shareInstance].endDate success:^(LWPEFLineModel *model) {
        [LWProgressHUD closeProgressHUD:self.view.window];
        [LWPublicDataManager shareInstance].logModle = model;
        [self releadView];
    } failure:^(NSString *errorMes) {
        [self releadView];
        [LWProgressHUD showALAlertBannerWithView:self.view.window Style:SALAlertBannerStyleWarning  Position:SALAlertBannerPositionTop Subtitle:errorMes ];
    }];
    
}

#pragma mark - init
- (void)initproperty
{
    [LWPublicDataManager shareInstance].starDate = [NSDate stringWithDate:[NSDate dateAfterDate:[NSDate date] day:-6] format:[NSDate ymdFormat]];
    [LWPublicDataManager shareInstance].endDate = [NSDate stringWithDate:[NSDate date] format:[NSDate ymdFormat]];
    [LWPublicDataManager shareInstance].yer =  [NSString stringWithFormat:@"%@",kNSNumInteger([[NSDate date] year])];
    [LWPublicDataManager shareInstance].month = [NSString stringWithFormat:@"%@",kNSNumInteger([[NSDate date] month])];
    [LWPublicDataManager shareInstance].changeDate = [NSDate date];
}
- (void)initDateView
{
    self.dateView = [[LWPatientLogDateIndexView alloc] initWithFrame:CGRectZero WithDelegate:self];
    self.dateView.backgroundColor = RGBA(245, 245, 245, 1);
    [self.view addSubview:self.dateView];
    self.dateView.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).topSpaceToView(self.segment,0).heightIs(40);
    
    self.yerIndexView = [[LWYerChangIndexView alloc] initWithFrame:CGRectZero WithDelegate:self];
    self.yerIndexView.backgroundColor = RGBA(245, 245, 245, 1);
    [self.view addSubview:self.yerIndexView];
    self.yerIndexView.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).topSpaceToView(self.segment,0).heightIs(40);
    self.yerIndexView.hidden = YES;
}
- (void)initSegment{
    self.segment = [[SegmentTapView alloc] initWithFrame:CGRectMake(0, 64, Screen_SIZE.width, 40) withDataArray:[NSArray arrayWithObjects:@"PEF日志",@"评估日志",@"症状日志",@"用药日志", nil] withFont:15];
    self.segment.delegate = self;
    [self.view addSubview:self.segment];
}
- (void)initFlipTableView{
    if (!self.controllsArray) {
        self.controllsArray = [[NSMutableArray alloc] init];
    }
    
    _PEFLog = [[UIStoryboard storyboardWithName:@"PatientLog" bundle:nil] instantiateViewControllerWithIdentifier:@"LWPatientPEFLogVC"];
    _AssessmentLog = [[UIStoryboard storyboardWithName:@"PatientLog" bundle:nil] instantiateViewControllerWithIdentifier:@"LWPatientAssessmentLogVC"];
    _AssessmentLog.vc = self;
    
    _SymptomsLog = [[UIStoryboard storyboardWithName:@"PatientLog" bundle:nil] instantiateViewControllerWithIdentifier:@"LWPatientSymptomsLogVC"];
    _MedicationLog = [[UIStoryboard storyboardWithName:@"PatientLog" bundle:nil] instantiateViewControllerWithIdentifier:@"LWPatientMedicationLogVC"];
    
    [self.controllsArray addObject:_PEFLog];
    [self.controllsArray addObject:_AssessmentLog];
    [self.controllsArray addObject:_SymptomsLog];
    [self.controllsArray addObject:_MedicationLog];
    
    self.flipView = [[FlipTableView alloc] initWithFrame:CGRectMake(0, 104+40, Screen_SIZE.width, self.view.frame.size.height - 104-40) withArray:_controllsArray];
    self.flipView.delegate = self;
    [self.view addSubview:self.flipView];
}
#pragma mark -------- select Index
- (void)selectedIndex:(NSInteger)index//0123
{
    [self.flipView selectIndex:index];
    if (index == 1) {
        self.yerIndexView.hidden = NO;
        self.dateView.hidden = YES;
        [self.AssessmentLog refreshAssessmentLog:self.patientId];
    }else{
        self.dateView.hidden = NO;
        self.yerIndexView.hidden = YES;
    }
}
- (void)scrollChangeToIndex:(NSInteger)index //1234
{
    [self.segment selectIndex:index];
    if (index == 2) {
        self.yerIndexView.hidden = NO;
        self.dateView.hidden = YES;
        [self.AssessmentLog refreshAssessmentLog:self.patientId];
    }else{
        self.dateView.hidden = NO;
        self.yerIndexView.hidden = YES;

    }
}
- (void)releadView
{
    //[NSArray arrayWithObjects:@"PEF日志",@"评估日志",@"症状日志",@"用药日志", nil]
    [self.PEFLog refreshPEFRecord];
    [self.SymptomsLog refreshSymptomsLog];
    [self.MedicationLog refreshMedicationLog];
}
#pragma mark - nav
- (void)navLeftButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -LWPatientLogDateIndexViewDeleagte
- (void)indexDateChnageLeftDate:(NSString *)leftdate RightDate:(NSString *)rightdate
{
    [LWPublicDataManager shareInstance].starDate = leftdate;
    [LWPublicDataManager shareInstance].endDate = rightdate;
    [self loadLogRecord];
}

- (void)indexDateChnagecenterLabelDate:(NSDate *)date
{
    [LWPublicDataManager shareInstance].yer =  [NSString stringWithFormat:@"%@",kNSNumInteger([date year])];
    [LWPublicDataManager shareInstance].month = [NSString stringWithFormat:@"%@",kNSNumInteger([date month])];
    [LWPublicDataManager shareInstance].changeDate = date;
    
    
    [LWProgressHUD displayProgressHUD:self.view displayText:@"请稍后..."];
    [self.AssessmentLog refreshAssessmentLog:self.patientId];
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
