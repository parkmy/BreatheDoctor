//
//  KLHistoricalLogViewController.m
//  BreatheDoctor
//
//  Created by liaowh on 16/6/1.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLHistoricalLogViewController.h"
#import "JSDropmenuView.h"
#import "LWHttpDefine.h"

@interface KLHistoricalLogViewController ()<JSDropmenuViewDelegate>
{
    NSInteger _seleIndex;
}
@property (nonatomic, strong) NSMutableArray *menuArray;
@property (nonatomic, assign) NSInteger requestDay;

@end

@implementation KLHistoricalLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setInit];
    
    [self update];
}
- (void)setInit{

    [super addNavBar:@"患者日志"];
    [super addRightButton:@"rili.png"];
    [super addBackButton:@"nav_btnBack.png"];
    
    self.requestDay = 7;
}
- (void)update{

    [self updateWithUrl:[self getRequestUrl]];
}
- (NSString *)getRequestUrl{
    
    return [NSString stringWithFormat:@"%@?patientId=%@&recentDays=%@",kangLianPatientLog_URL,self.patientID,kNSNumInteger(self.requestDay)];
}

- (void)navRightButtonAction
{
    JSDropmenuView *dropmenuView = [[JSDropmenuView alloc] initWithFrame:CGRectMake(screenWidth-120*MULTIPLEVIEW-10, 64-12, 120*MULTIPLEVIEW, 39*2+14)];
    dropmenuView.delegate = self;
    dropmenuView.seleIndex = _seleIndex;
    [dropmenuView showViewInView:self.navigationController.view];
}
- (NSMutableArray *)menuArray
{
    if (!_menuArray) {
        
        _menuArray = [NSMutableArray arrayWithArray:@[[NSMutableDictionary dictionaryWithDictionary:@{@"title":@"最近7天",@"isSele":@"1"}],[NSMutableDictionary dictionaryWithDictionary:@{@"title":@"最近30天",@"isSele":@"0"}]]];
    }
    return _menuArray;
}
#pragma mark -JSDropmenuViewDelegate
- (NSArray*)dropmenuDataSource
{
    return self.menuArray;
}
- (void)dropmenuView:(JSDropmenuView*)dropmenuView didSelectedRow:(NSInteger)index
{
    [self setLogDateTextIndexTag:index];
}
- (void)setLogDateTextIndexTag:(NSInteger)index
{
    NSMutableDictionary *dic = self.menuArray[index];
    [dic setObject:@"1" forKey:@"isSele"];
    
    if (_seleIndex == index) {
        return;
    }
    NSMutableDictionary *oldDic = self.menuArray[_seleIndex];
    [oldDic setObject:@"0" forKey:@"isSele"];
    _seleIndex = index;
    self.requestDay = index==0?7:30;
    //刷新数据
    [self update];
}
@end
