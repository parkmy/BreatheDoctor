//
//  LWPEFRecordView.m
//  BreatheDoctor
//
//  Created by comv on 15/11/30.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWPEFRecordView.h"
#import "MZFormSheetPresentationController Swift Example-Bridging-Header.h"
#import "NSDate+Extension.h"

@interface LWPEFRecordView ()
@property (weak, nonatomic) IBOutlet UILabel *timerTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *PEFVelueLabel;
@property (weak, nonatomic) IBOutlet UIView *zhengzhuangView;
@property (weak, nonatomic) IBOutlet UIView *yongYaoView;
@property (weak, nonatomic) IBOutlet UILabel *noteLabel;

@end

@implementation LWPEFRecordView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadDataViews];
}

- (void)loadDataViews
{
    LWPEFRecordList *Record = self.record;
    
    NSString *dateString = [NSDate stringWithDate:[NSDate dateWithString:Record.recordDt format:[NSDate ymdFormat]] format:@"MM月dd日"];
    if (Record.timeFrame == 1) {
        dateString = [NSString stringWithFormat:@"%@早上",dateString];
    }else
    {
        dateString = [NSString stringWithFormat:@"%@晚上",dateString];
    }
    
    self.timerTitleLabel.text = dateString;
    
    
    
    self.PEFVelueLabel.text = [NSString stringWithFormat:@"%@ L/min",kNSNumDouble(Record.pefValue)];
    
    NSMutableAttributedString *AttributedString = [[NSMutableAttributedString alloc] initWithString:self.PEFVelueLabel.text];
    [AttributedString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} range:NSMakeRange(AttributedString.length-5, 5)];
    
    self.PEFVelueLabel.attributedText = AttributedString;
    

    NSMutableArray *labels = [NSMutableArray array];
    
    if (Record.symptomGood == 1) {//症状记录--感觉良好	1 选中 0 未选中
        UILabel *label =  [self createLabelWithText:@"感觉良好"];
        label.backgroundColor = RGBA(119, 204, 78, 1);
        [labels addObject:label];
    }
    if (Record.symptomGasp == 1) {//    症状记录--喘息	1 选中 0 未选中
        UILabel *label =  [self createLabelWithText:@"喘息"];
        [labels addObject:label];
    }
    if (Record.symptomCough == 1) {//    症状记录--咳嗽	1 选中 0 未选中
        UILabel *label =  [self createLabelWithText:@"咳嗽"];
        [labels addObject:label];
    }
    if (Record.symptomDyspnea == 1) {//    症状记录--呼吸困难	1 选中 0 未选中
        UILabel *label =  [self createLabelWithText:@"呼吸困难"];
        [labels addObject:label];
    }
    if (Record.symptomChestdistress == 1) {//    症状记录--胸闷	1 选中 0 未选中
        UILabel *label =  [self createLabelWithText:@"胸闷"];
        [labels addObject:label];
    }
    if (Record.symptomNightWoke) {
        UILabel *label =  [self createLabelWithText:@"夜间憋醒"];
        [labels addObject:label];
    }

    for (int i = 0; i < labels.count; i++)
    {
        UIView *view = labels[i];
        view.centerX = (50 + 5) *i + 50/2 + 5;
        if (i == 0) {
            view.centerX = 5+50/2;
        }
        view.centerY = 5+50/2;
        [view setCornerRadius:50/2];
        [self.zhengzhuangView addSubview:view];
    }
    
    //pharmacyControl	recordList			用药记录--控制用药	1 选中 0 未选中
//    pharmacyUrgency	recordList			用药记录--紧急用药	1 选中 0 未选中
    
    
    if (Record.pharmacyControl == 1)
    {
        UIView *view = [self createpharmacyViewWithString:@"控制用药" withImage:kImage(@"log_act_yao")];
        view.xCenter = view.width/2 + 10;
        [self.yongYaoView addSubview:view];
    }
    
    if (Record.pharmacyUrgency == 1)
    {
        UIView *view = [self createpharmacyViewWithString:@"紧急用药" withImage:kImage(@"log_act_naoz")];
        CGFloat x;
        if (Record.pharmacyControl == 1) {
            x = view.width/2+ view.width + 20;
        }else
        {
            x = view.width/2 + 10;
        }
        view.xCenter = x;
        [self.yongYaoView addSubview:view];
    }
    
    if (Record.remark.length > 2) {
        self.noteLabel.text = Record.remark;
    }
    
    
    for (int a = 0; a < 3; a++) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectZero];
        line.backgroundColor = RGBA(0, 0, 0, .4);
        line.size = CGSizeMake(self.view.width, .5);
        line.centerX= self.view.width/2;
        if (a == 0) {
            line.yCenter = self.timerTitleLabel.maxY +10;
        }else if (a == 1)
        {
            line.yCenter = self.zhengzhuangView.maxY+.5;
        }else
        {
            line.yCenter = self.yongYaoView.maxY+.5;
        }
        [self.view addSubview:line];
    }
    

}
- (UIView *)createpharmacyViewWithString:(NSString *)string withImage:(UIImage *)image
{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.size = CGSizeMake(110, 50);
    view.backgroundColor = RGBA(46, 109, 252, .6);
    [view setCornerRadius:5.0f];

    UIImageView *leftimageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    leftimageView.image = image;
    leftimageView.size = CGSizeMake(20, 20);
    leftimageView.centerX = 30/2+5;
    leftimageView.centerY = view.height/2;
    [view addSubview:leftimageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(leftimageView.maxX+5, 0, view.width-leftimageView.maxX-5, view.height)];
    label.text = string;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor whiteColor];

    [view addSubview:label];
    
    return view;
}


- (UILabel *)createLabelWithText:(NSString *)string

{
    UILabel *label = [[UILabel alloc] init];
    label.text = string;
    label.size = CGSizeMake(50, 50);
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = RGBA(248, 140, 143, 1);
    label.textColor = [UIColor whiteColor];
    if (label.text.length >=4) {
        label.font = [UIFont systemFontOfSize:12];
    }else
    {
        label.font = [UIFont systemFontOfSize:14];

    }
    return label;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)hiddenButtonClick:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
