//
//  LWBaseHistoricalHeardView.m
//  BreatheDoctor
//
//  Created by comv on 16/3/15.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWHistoricalHeardView.h"
#import "LWHistoricalCountModel.h"
#import "LWScaleCircleView.h"
#import "KLHistoricalOperation.h"
#import "KLHistoricalHeardCell.h"
#import "LWBaseHistoricalView.h"

static const CGFloat tableHeight = 60 + 15*2;

@interface LWHistoricalHeardView ()
@property (nonatomic, strong) LWScaleCircleView *scaleCircleView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation LWHistoricalHeardView

- (id)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.footLabel];
        [self addSubview:self.leftView];
        [self addSubview:self.rightView];
        
//        [self.breadView addSubview:self.scaleCircleView];
        [self.leftView addSubview:self.scaleCircleView];
        [self.rightView addSubview:self.tableView];
        
        self.footLabel.sd_layout
        .leftSpaceToView(self,10)
        .rightSpaceToView(self,10)
        .bottomSpaceToView(self,15)
        .heightIs(25);
        
        self.leftView.sd_layout
        .leftSpaceToView(self,0)
        .widthRatioToView(self,.5)
        .topSpaceToView(self,22)
        .bottomSpaceToView(self.footLabel,15);
        
        self.rightView.sd_layout
        .rightSpaceToView(self,0)
        .leftSpaceToView(self.leftView,0)
        .topSpaceToView(self,25)
        .bottomSpaceToView(self.footLabel,15);
        
//        self.breadView.sd_layout
//        .widthIs(104*MULTIPLEVIEW)
//        .heightIs(104*MULTIPLEVIEW)
//        .centerYEqualToView(self.leftView)
//        .rightSpaceToView(self.leftView,10);
        
        self.tableView.sd_layout
        .widthIs(145*MULTIPLEVIEW)
        .heightIs(tableHeight*MULTIPLEVIEW)
        .centerYEqualToView(self.rightView)
        .leftSpaceToView(self.rightView,10);
        
        self.scaleCircleView.sd_layout
        .widthIs(104*MULTIPLEVIEW)
        .heightIs(104*MULTIPLEVIEW)
        .centerYEqualToView(self.leftView)
        .rightSpaceToView(self.leftView,10);
        
    }
    return self;
}

- (UIView *)breadView
{
    if (!_breadView) {
        _breadView = [UIView new];
        _breadView.backgroundColor = [UIColor whiteColor];
    }
    return _breadView;
}
- (LWScaleCircleView *)scaleCircleView
{
    if (!_scaleCircleView) {
        _scaleCircleView = [LWScaleCircleView new];
        _scaleCircleView.isFourth = NO;
    }
    return _scaleCircleView;
}

- (UIView *)leftView
{
    if (!_leftView) {
        _leftView = [UIView new];
        _leftView.backgroundColor = [UIColor whiteColor];
        
    }
    return _leftView;
}
- (UIView *)rightView
{
    if (!_rightView) {
        _rightView = [UIView new];
        _rightView.backgroundColor = [UIColor whiteColor];
    }
    return _rightView;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.scrollEnabled = NO;
        _tableView.separatorStyle = 0;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[KLHistoricalHeardCell class] forCellReuseIdentifier:@"KLHistoricalHeardCell"];
    }
    return _tableView;
}
- (UILabel *)footLabel
{
    if (!_footLabel) {
        _footLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _footLabel.textAlignment = 1;
        _footLabel.font = kNSPXFONT(28);
        _footLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    }
    return _footLabel;
}

- (void)setFootLabelTitle:(NSString *)string
{
    self.footLabel.text = stringJudgeNull(string);
}
- (void)setHistoricalType:(showHistoricalType)historicalType
{
    _historicalType = historicalType;
    self.dataArray = [LWHistoricalCountModel historicalType:_historicalType];
    [self.tableView reloadData];
}
- (BOOL)isShowNoDataViewInfoCount:(NSInteger)count{
    if (count <= 0) {
        [self.baseHistoricalView.noDataView setErrorLabelMessageInfo:@"患者偷懒了，没有数据记录~"];
        self.baseHistoricalView.noDataView.hidden = NO;
        return YES;
    }
    return NO;
}
- (void)setScaleCircleWithObjc:(KLPatientLogBodyModel *)objc
{
    self.scaleCircleView.isShowBottomLabel = NO;

    self.scaleCircleView.lineWith = 3.0f;
    self.scaleCircleView.animation_time = 0;
    self.baseHistoricalView.noDataView.hidden = YES;
    
    if (self.historicalType == showHistoricalTypePEF)
    {
        NSInteger count = [KLHistoricalOperation historicalCountInfo:objc.recordList];
        if ([self isShowNoDataViewInfoCount:count]) {
            return;
        }
        self.scaleCircleView.centerLable.attributedText = [self attributed:[NSString stringWithFormat:@"%@ 次",kNSNumInteger(count)]];
        
        self.scaleCircleView.firstColor = [LWHistoricalCountModel normalColor];
        self.scaleCircleView.secondColor = [LWHistoricalCountModel abnormalColor];
        self.scaleCircleView.thirdColor = [LWHistoricalCountModel warningColor];
        //@{@"normal":kNSNumInteger(normal),@"abnormal":kNSNumInteger(abnormal),@"warning":kNSNumInteger(warning)}
        
        NSDictionary *pefDic = [KLHistoricalOperation historicalPefRecordCoutInfo:objc thepefDataArray:self.dataArray];
        NSInteger  normal = [[pefDic objectForKey:@"normal"] integerValue];
        NSInteger  abnormal = [[pefDic objectForKey:@"abnormal"] integerValue];
        NSInteger  warning = [[pefDic objectForKey:@"warning"] integerValue];
        
        self.scaleCircleView.firstScale = (CGFloat)normal/count;
        self.scaleCircleView.secondScale = (CGFloat)abnormal/count;
        self.scaleCircleView.thirdScale = (CGFloat)warning/count;
        
    }else if (self.historicalType == showHistoricalTypeSymptoms)
    {
        self.scaleCircleView.firstColor = [LWHistoricalCountModel normalColor];
        self.scaleCircleView.secondColor = [LWHistoricalCountModel abnormalColor];
        

        NSDictionary *symptomsdic  = [KLHistoricalOperation historicalSymptomsRecordCountInfo:objc.recordList theSymptomsLogArray:nil thehistoricalDataArray:self.dataArray];
//@{@"normal":kNSNumInteger(normal),@"abnormal":kNSNumInteger(abnormal)}
        NSInteger  normal = [[symptomsdic objectForKey:@"normal"] integerValue];
        NSInteger  abnormal = [[symptomsdic objectForKey:@"abnormal"] integerValue];
        NSInteger  count = [[symptomsdic objectForKey:@"count"] integerValue];
        
        if ([self isShowNoDataViewInfoCount:count]) {
            return;
        }
        
        self.scaleCircleView.centerLable.attributedText = [self attributed:[NSString stringWithFormat:@"%@ 次",kNSNumInteger(count)]];
        self.scaleCircleView.firstScale = (CGFloat)normal/count;
        self.scaleCircleView.secondScale = (CGFloat)abnormal/count;
    }else
    {
        self.scaleCircleView.firstColor = [LWHistoricalCountModel normalColor];
        self.scaleCircleView.secondColor = [LWHistoricalCountModel warningColor];
        self.scaleCircleView.thirdColor = [LWHistoricalCountModel abnormalColor];
        
        NSDictionary *medicationDic  = [KLHistoricalOperation historicalMedicationRecordCountInfo:objc.recordList thehistoricalDataArray:self.dataArray];
        //@{@"pharmacyControl":kNSNumInteger(pharmacyControl),@"pharmacyUrgency":kNSNumInteger(pharmacyUrgency),@"noPharmacy":kNSNumInteger(noPharmacy)}
        NSInteger  pharmacyControl = [[medicationDic objectForKey:@"pharmacyControl"] integerValue];
        NSInteger  pharmacyUrgency = [[medicationDic objectForKey:@"pharmacyUrgency"] integerValue];
        NSInteger  noPharmacy = [[medicationDic objectForKey:@"noPharmacy"] integerValue];
        NSInteger count = [[medicationDic objectForKey:@"count"] integerValue];

        if ([self isShowNoDataViewInfoCount:count]) {
            return;
        }
        
        self.scaleCircleView.firstScale = (CGFloat)pharmacyControl/count;
        self.scaleCircleView.secondScale = (CGFloat)pharmacyUrgency/count;
        self.scaleCircleView.thirdScale = (CGFloat)noPharmacy/count;
        self.scaleCircleView.centerLable.attributedText = [self attributed:[NSString stringWithFormat:@"%@ 次",kNSNumInteger(count)]];
    }
    [self.scaleCircleView setNeedsDisplay];
    [self.tableView reloadData];
}
- (NSMutableAttributedString *)attributed:(NSString *)string
{
    if (string.length <= 0) {
        return [[NSMutableAttributedString alloc] initWithString:@""];
    }
    NSMutableAttributedString *atr = [[NSMutableAttributedString alloc] initWithString:string];
    [atr addAttributes:@{NSFontAttributeName:kNSPXFONT(18),NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#333333"]} range:NSMakeRange(atr.length-1, 1)];
    return atr;
}
- (void)setScaleCircleDateText:(NSString *)text
{
    [self.scaleCircleView setdateText:text];
}
#pragma mark -dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KLHistoricalHeardCell *historicalHeardCell = [tableView dequeueReusableCellWithIdentifier:@"KLHistoricalHeardCell" forIndexPath:indexPath];

    LWHistoricalCountModel *model = self.dataArray[indexPath.row];
    [historicalHeardCell setModel:model];
//    cell.textLabel.attributedText = [model historicalCountAttributedStringInfoDataArray:self.dataArray];
    return historicalHeardCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _historicalType==showHistoricalTypePEF?tableHeight/3.0*MULTIPLEVIEW:_historicalType==showHistoricalTypeSymptoms?tableHeight/2.0*MULTIPLEVIEW:tableHeight/3.0*MULTIPLEVIEW;
}

@end
