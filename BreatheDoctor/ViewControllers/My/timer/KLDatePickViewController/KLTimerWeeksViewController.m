//
//  KLTimerWeeksViewController.m
//  BreatheDoctor
//
//  Created by comv on 16/3/31.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLTimerWeeksViewController.h"
#import "KLTimerWeeksView.h"

@interface KLTimerWeeksViewController ()
@property (nonatomic, strong) KLTimerWeeksView *timerWeeksView;
@end

@implementation KLTimerWeeksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    [self load];
}
- (void)load{

    _timerWeeksView = [KLTimerWeeksView new];
    _timerWeeksView.weeks = self.weeks;
    [self.view addSubview:_timerWeeksView];

    _timerWeeksView.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).bottomSpaceToView(self.view,0).heightIs(250);
    
    __weak typeof(self)weakSelf = self;
    [_timerWeeksView setLeftButtonClikBlock:^{
        weakSelf.completeDismiss?weakSelf.completeDismiss():nil;
        [weakSelf.view removeFromSuperview];
    }];
    
    [_timerWeeksView setRightButtonClikBlock:^(NSMutableArray *weeks) {
        weakSelf.backBlock?weakSelf.backBlock(weeks):nil;
        weakSelf.completeDismiss?weakSelf.completeDismiss():nil;
        [weakSelf.view removeFromSuperview];
    } ];
    
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
