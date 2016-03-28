//
//  LWHistoricalLogModel.m
//  BreatheDoctor
//
//  Created by comv on 16/3/22.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWHistoricalLogModel.h"
#import "LWMedicationModel.h"
#import "KLHistoricalOperation.h"
#import "NSObject+ProperList.h"
#import "KLStateModel.h"

@implementation LWHistoricalLogModel

+ (UIColor *)theBestDeepColor
{
    return [UIColor colorWithHexString:@"#77c75e"];
}
+ (UIColor *)theBestShallowColor
{
    return [UIColor colorWithHexString:@"#d2e6b5"];
}

+ (UIColor *)generalDeepColor
{
    return [UIColor colorWithHexString:@"#febf47"];
}
+ (UIColor *)generalShallowColor
{
    return [UIColor colorWithHexString:@"#ffebc4"];
}

+ (UIColor *)poorDeepColor
{
    return [UIColor colorWithHexString:@"#ff3333"];
}
+ (UIColor *)poorShallowColor
{
    return [UIColor colorWithHexString:@"#ffc8c8"];
}


+ (NSMutableArray *)historicalLogModelArrayInfo:(KLPatientLogBodyModel *)model
{
    NSMutableArray *array = [NSMutableArray array];
    for (KLPatientLogModel *LogModel in model.recordList)
    {
        LWHistoricalLogModel *hisModel = [[LWHistoricalLogModel alloc] init];
        hisModel.recordDt = LogModel.recordDt;
        hisModel.pefValue = LogModel.pefValue;
        hisModel.logModel = LogModel;
        hisModel.pefPredictedValue = model.pefPredictedValue;
        if ([KLHistoricalOperation areaNormalValueInfo:model.pefPredictedValue thePefValue:LogModel.pefValue]) {
            hisModel.historicalLogType = HistoricalLogTypeTheBest;
        }else if ([KLHistoricalOperation areaAbnormalValueInfo:model.pefPredictedValue thePefValue:LogModel.pefValue]){
            hisModel.historicalLogType = HistoricalLogTypeGeneral;
        }else{
            hisModel.historicalLogType = HistoricalLogTypePoor;
        }
        [hisModel setsymptomsAndmedication:[LogModel properties_aps]];

        [array addObject:hisModel];
    }
    return array;
}
- (void)addModelInfo:(NSString *)title theArray:(NSMutableArray *)array{
    KLStateModel *model = [KLStateModel new];
    model.title = title;
//    if (self.historicalLogType == HistoricalLogTypeTheBest) {
//        model.stateColor = [[self class] theBestShallowColor];
//    }else if (self.historicalLogType == HistoricalLogTypeGeneral){
//        model.stateColor = [[self class] generalShallowColor];
//    }else{
//        model.stateColor = [[self class] poorShallowColor];
//    }
    model.stateColor = [LWThemeManager shareInstance].navBackgroundColor;
    [array addObject:model];
}
- (void)setsymptomsAndmedication:(NSDictionary *)dic{

    NSMutableArray *sym = [NSMutableArray array];
    NSMutableArray *med = [NSMutableArray array];
    
    if ([[dic objectForKey:@"symptomOthers"] integerValue] == 1){
        [self addModelInfo:@"其他" theArray:sym];
    }
    if ([[dic objectForKey:@"symptomDyspnea"] integerValue] == 1) {
        [self addModelInfo:@"呼吸困难" theArray:sym];
    }
    if ([[dic objectForKey:@"symptomChestdistress"] integerValue] == 1) {
        [self addModelInfo:@"胸闷" theArray:sym];
    }
    if ([[dic objectForKey:@"symptomRhinocnesmus"] integerValue] == 1) {
        [self addModelInfo:@"鼻痒" theArray:sym];
    }
    if ([[dic objectForKey:@"symptomNightWoke"] integerValue] == 1) {
        [self addModelInfo:@"夜间憋醒" theArray:sym];
    }
    if ([[dic objectForKey:@"symptomRunny"] integerValue] == 1) {
        [self addModelInfo:@"流清涕" theArray:sym];
    }
    if ([[dic objectForKey:@"symptomActLimited"] integerValue] == 1) {
        [self addModelInfo:@"活动受限" theArray:sym];
    }
    if ([[dic objectForKey:@"symptomCough"] integerValue] == 1) {
        [self addModelInfo:@"咳嗽" theArray:sym];
    }
    if ([[dic objectForKey:@"symptomSneeze"] integerValue] == 1) {
        [self addModelInfo:@"打喷嚏" theArray:sym];
    }
    if ([[dic objectForKey:@"symptomGasp"] integerValue] == 1) {
        [self addModelInfo:@"喘息" theArray:sym];
    }
    if ([[dic objectForKey:@"symptomEczema"] integerValue] == 1) {
        [self addModelInfo:@"湿疹" theArray:sym];
    }
    if ([[dic objectForKey:@"symptomGood"] integerValue] == 1) {
        [self addModelInfo:@"感觉良好" theArray:sym];
    }
    if ([[dic objectForKey:@"pharmacyControl"] integerValue] == 1) {
        [self addModelInfo:@"控制用药" theArray:med];
    }
    if ([[dic objectForKey:@"pharmacyUrgency"] integerValue] == 1) {
        [self addModelInfo:@"紧急用药" theArray:med];
    }
    if (med.count <= 0) {
        [self addModelInfo:@"未按医嘱服药" theArray:med];
    }
    if (sym.count <= 0) {
        [self addModelInfo:@"无记录" theArray:sym];
    }
    self.symptoms = sym;
    self.medication = med;
    
    int hang = self.symptoms.count/4 + 1;
    
    if (hang>1) {
        self.rowHeight = 285*MULTIPLEVIEW + hang*20*MULTIPLEVIEW;
    }else{
        self.rowHeight = 285*MULTIPLEVIEW;
    }
    
 
}


@end
