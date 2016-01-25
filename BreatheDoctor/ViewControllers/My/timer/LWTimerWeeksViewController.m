//
//  LWTimerWeeksViewController.m
//  BreatheDoctor
//
//  Created by comv on 16/1/11.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWTimerWeeksViewController.h"

@interface LWTimerWeeksViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation LWTimerWeeksViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [super addNavBar:@"重复"];
    [super addBackButton:@"nav_btnBack.png"];

}
- (void)navLeftButtonAction
{
    _backBlock?_backBlock(self.weeks):nil;
    [self.navigationController popViewControllerAnimated:YES];
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.frame = CGRectMake(0, 64, screenWidth, screenHeight-64);
    [self.view addSubview:self.tableView];
    

    if ((screenHeight-10)/7 > 60) {
        self.tableView.rowHeight = 60;
    }else{
        self.tableView.rowHeight = (screenHeight-10)/7;
    }
    self.tableView.scrollEnabled = NO;
    setExtraCellLineHidden(self.tableView);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


#pragma mark - tableviewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        UIImageView *itmImageView = [[UIImageView alloc] initWithImage:kImage(@"xuanze@2x")];
        itmImageView.tag = 888;
        [cell addSubview:itmImageView];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        itmImageView.sd_layout.topSpaceToView(cell,(cell.height-16)/2).rightSpaceToView(cell,10).widthIs(16).heightIs(16);
    }
    
    UIImageView *itmView = [cell viewWithTag:888];
    itmView.hidden = YES;
    for (NSString *str in self.weeks) {
        if (indexPath.row == (str.integerValue -1)) {
            itmView.hidden = NO;
        }
    }
    cell.textLabel.text = @[@"每周一",@"每周二",@"每周三",@"每周四",@"每周五",@"每周六",@"每周日"][indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    UIImageView *itmView = [cell viewWithTag:888];
    itmView.hidden = !itmView.hidden;
    if (!itmView.hidden) {
        [self.weeks addObject:[NSString stringWithFormat:@"%ld",indexPath.row+1]];
    }else
    {
        [self.weeks removeObject:[NSString stringWithFormat:@"%ld",indexPath.row+1]];
    }
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
