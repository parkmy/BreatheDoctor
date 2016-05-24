
//
//  KLSetInstructionsViewController.m
//  BreatheDoctor
//
//  Created by comv on 16/4/14.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLSetInstructionsViewController.h"

@interface KLSetInstructionsViewController ()
@property (nonatomic, strong) UITextView *textView;
@end

@implementation KLSetInstructionsViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [super addNavBar:@"设置说明"];
    [super addBackButton:@"nav_btnBack.png"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setSubViews];
    
    [self setTextData];
}
- (UITextView *)textView
{
    if (!_textView) {
        _textView = [UITextView new];
        _textView.editable = NO;
        _textView.font = kNSPXFONT(30);
        _textView.textColor = [UIColor colorWithHexString:@"#333333"];
        _textView.frame = self.view.bounds;
    }
    return _textView;
}
- (void)setTextData
{
    self.textView.text = @"\n\n设置说明:\n\n1、在医生设置的时间内回复用户的图文咨询;\n\n2、设置时间从00:00~23:59,夜班请在第二天凌晨开始设置;\n\n3、为保证资讯效果，最小在线时间不得小于30分钟;";
}
- (void)setSubViews
{
    [self.view addSubview:self.textView];
    self.textView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(BARHIGHT, 0, 0, 0));
}

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
