//
//  LWPatientPEFLogVC.m
//  BreatheDoctor
//
//  Created by comv on 15/11/22.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWPatientPEFLogVC.h"
#import "LWPEFCountCell.h"
#import "LWPEFLineCell.h"
#import "DrawView.h"
#import "LWPEFRecordView.h"
#import "MZFormSheetPresentationController Swift Example-Bridging-Header.h"

@interface LWPatientPEFLogVC ()<UITableViewDataSource,UITableViewDelegate,DrawViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation LWPatientPEFLogVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.backgroundColor = RGBA(245, 245, 245, 1);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)refreshPEFRecord
{
    [self.tableView reloadData];
}
#pragma mark - tableviewdelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.row == 0?320:150;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (0 == indexPath.row) {
        LWPEFLineCell *lineCell = [tableView dequeueReusableCellWithIdentifier:@"LWPEFLineCell" forIndexPath:indexPath];
        lineCell.PEFLineView.drawViewdelegate = self;
        [lineCell changeTimerMonth:[LWPublicDataManager shareInstance].starDate end:[LWPublicDataManager shareInstance].endDate];
        [lineCell changeYnumbers:[LWPublicDataManager shareInstance].logModle.body.pefPredictedValue];
        [lineCell setModel:[LWPublicDataManager shareInstance].logModle];
        cell = lineCell;

    }else
    {
        LWPEFCountCell *countCell = [tableView dequeueReusableCellWithIdentifier:@"LWPEFCountCell" forIndexPath:indexPath];
        [countCell setModel:[LWPublicDataManager shareInstance].logModle];
        cell = countCell;
    }
    return cell;
}

#pragma mark - DrawViewDelegate

- (void)chooseItmButtonClick:(LWLineButton *)sender
{
    LWPEFRecordView *vc = (LWPEFRecordView *)[[UIStoryboard storyboardWithName:@"PatientLog" bundle:nil] instantiateViewControllerWithIdentifier:@"LWPEFRecordView"];
    vc.dataItm = sender.itm;
    MZFormSheetPresentationViewController *formSheetController = [[MZFormSheetPresentationViewController alloc] initWithContentViewController:vc];
    formSheetController.presentationController.shouldUseMotionEffect = YES;
    formSheetController.contentViewControllerTransitionStyle = MZFormSheetPresentationTransitionStyleFade;
    formSheetController.presentationController.shouldDismissOnBackgroundViewTap = YES;
    formSheetController.presentationController.contentViewSize = CGSizeMake(320, 480-30);
    formSheetController.presentationController.portraitTopInset = (Screen_SIZE.height-450)/2-20;
    [self presentViewController:formSheetController animated:YES completion:nil];
}

@end
