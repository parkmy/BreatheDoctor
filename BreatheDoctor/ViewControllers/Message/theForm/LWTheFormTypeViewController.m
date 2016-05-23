//
//  LWTheFormTypeViewController.m
//  BreatheDoctor
//
//  Created by comv on 15/12/30.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWTheFormTypeViewController.h"
#import "LWTheFormViewController.h"
#import "YRJSONAdapter.h"
#import "LWPatientBiaoDanBody.h"

@interface LWTheFormTypeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation LWTheFormTypeViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [super addNavBar:@"选择量表"];
    [super addBackButton:@"nav_btnBack"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addSubViews];
    

    
    [self loadData];
}
- (void)addSubViews{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    _tableView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    
    self.tableView.rowHeight = 60;
    self.tableView.separatorStyle = 0;
    setExtraCellLineHidden(self.tableView);
}
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)loadData
{
    if (self.showType == showTheFormTypeBiaoDan) {
        [LWProgressHUD displayProgressHUD:self.view displayText:@"请稍后..."];
        WEAKSELF
        [LWHttpRequestManager httploadPatientFirstDiagnosticList:self.patientId Success:^(NSMutableArray *models) {
            [LWProgressHUD closeProgressHUD:KL_weakSelf.view];
            [KL_weakSelf.dataArray removeAllObjects];
            [KL_weakSelf.dataArray addObjectsFromArray:models];
            [KL_weakSelf.tableView reloadData];
            if (KL_weakSelf.dataArray.count <= 0) {
                [KL_weakSelf showErrorMessage:@"暂无已填表单～" isShowButton:YES type:showErrorType64Hight];
            }else
            {
                [KL_weakSelf hiddenNonetWork];
            }
        } failure:^(NSString *errorMes) {
            
            [LWProgressHUD closeProgressHUD:KL_weakSelf.view];
            [KL_weakSelf showErrorMessage:errorMes isShowButton:NO type:showErrorTypeHttp];
        }];
    }
}
- (void)reloadRequestWithSender:(UIButton *)sender
{
    [self loadData];
}
- (void)navLeftButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableviewdelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _showType == showTheFormTypeMouKuai?1:self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
//        cell.accessoryType = 1;
        cell.textLabel.font = [UIFont systemFontOfSize:kNSPXFONTFLOAT(30)];
        cell.textLabel.textColor  = [UIColor colorWithHexString:@"#333333"];
//        cell.detailTextLabel.font = [UIFont systemFontOfSize:kNSPXFONTFLOAT(30)];
        UIView *line = [[UIView alloc] initWithFrame:CGRectZero];
        line.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
        [cell addSubview:line];
        
        line.sd_layout.bottomSpaceToView(cell,0).leftSpaceToView(cell,0).rightSpaceToView(cell,0).heightIs(.5);
        
        UIImageView *rightImageView = [UIImageView new];
        rightImageView.image = kImage(@"yishengzhushou_14");
        [cell addSubview:rightImageView];
        rightImageView.sd_layout.rightSpaceToView(cell,10).centerYEqualToView(cell).widthIs(15).heightIs(18);
        
        UILabel *countLabel = [UILabel new];
        countLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        countLabel.font = [UIFont systemFontOfSize:kNSPXFONTFLOAT(30)];
        countLabel.textAlignment = NSTextAlignmentRight;
        [cell addSubview:countLabel];
        countLabel.tag = 888;
        countLabel.sd_layout.rightSpaceToView(rightImageView,5).centerYEqualToView(cell).widthIs(100).heightIs(20);
        
    }
    UILabel *countLabel = (UILabel *)[cell viewWithTag:888];
    
    if (self.showType == showTheFormTypeMouKuai)
    {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"哮喘患者初诊模块";
            cell.imageView.image = kImage(@"biaodan2");
        }
        countLabel.text = @"";
    }else{
        LWPatientBiaoDanBody *model = self.dataArray[indexPath.row];
        cell.textLabel.text = @"哮喘患者初诊模块";
        cell.imageView.image = kImage(@"biaodan2");
        countLabel.text = model.createDt;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    LWTheFormViewController *vc = (LWTheFormViewController *)[UIViewController CreateControllerWithTag:CtrlTag_TheForm];
    vc.showType = self.showType;
    vc.patientId = self.patientId;
    if (self.showType != showTheFormTypeMouKuai)
    {
        LWPatientBiaoDanBody *model = self.dataArray[indexPath.row];
        vc.foreignId = model.sid;
        vc.model = model;
    }
    [self.navigationController pushViewController:vc animated:YES];
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
