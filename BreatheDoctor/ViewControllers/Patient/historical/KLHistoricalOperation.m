//
//  KLHistoricalOperation.m
//  BreatheDoctor
//
//  Created by comv on 16/3/25.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLHistoricalOperation.h"
#import "KLPatientLogModel.h"
#import "KLPatientLogBodyModel.h"
#import "KLSymptomsLogModel.h"
#import "LWHistoricalCountModel.h"
#import "LWMedicationModel.h"
#import "NSDate+Extension.h"
#import "LWHistoricalCountModel.h"
#import <objc/runtime.h>
#import "NSObject+ProperList.h"

@implementation KLHistoricalOperation

+ (NSInteger)historicalCountInfo:(NSMutableArray *)array{
    return [array count];
}
+ (NSDictionary *)historicalPefRecordCoutInfo:(KLPatientLogBodyModel *)body thepefDataArray:(NSMutableArray *)pefArray{
    
    NSInteger normal = 0;
    NSInteger abnormal = 0;
    NSInteger warning = 0;
    for (KLPatientLogModel *model in body.recordList) {
        //        NSLog(@"%f ---- 0&%f --- 6&%f --- 8&%f",model.pefValue , body.pefPredictedValue,body.pefPredictedValue*.6 ,body.pefPredictedValue*.8);
        
        if ([KLHistoricalOperation areaNormalValueInfo:body.pefPredictedValue thePefValue:model.pefValue]){
            normal++;
        }
        if ([KLHistoricalOperation areaAbnormalValueInfo:body.pefPredictedValue thePefValue:model.pefValue]) {
            abnormal++;
        }
        if ([KLHistoricalOperation areaWarningValueInfo:body.pefPredictedValue thePefValue:model.pefValue]) {
            warning++;
        }
        
    }
    if (pefArray) {
        LWHistoricalCountModel *model1 = [pefArray rewriteObjectAtIndex:0];
        LWHistoricalCountModel *model2 = [pefArray rewriteObjectAtIndex:1];
        LWHistoricalCountModel *model3 = [pefArray rewriteObjectAtIndex:2];
        model1.count = normal;
        model2.count = abnormal;
        model3.count = warning;
    }
    return @{@"normal":kNSNumInteger(normal),@"abnormal":kNSNumInteger(abnormal),@"warning":kNSNumInteger(warning)};
}
/**
 *  Description
 *
 *  @return 是否异常警告
 */
+ (BOOL)areaAbnormalValueInfo:(double)pefPredictedValue thePefValue:(double)pefValue{
    if (pefPredictedValue*.8 > pefValue && pefValue >= pefPredictedValue*.6 ) {
        return YES;
    }
    return NO;
}
/**
 *  Description
 *
 *  @return 是否危险警告
 */
+ (BOOL)areaWarningValueInfo:(double)pefPredictedValue thePefValue:(double)pefValue{
    if (pefValue < pefPredictedValue*.6) {
        return YES;
    }
    return NO;
}
/**
 *  Description
 *
 *  @return 是否正常
 */
+ (BOOL)areaNormalValueInfo:(double)pefPredictedValue thePefValue:(double)pefValue{
    if (pefValue >= pefPredictedValue*.8) {
        return YES;
    }
    return NO;
}

+ (NSDictionary *)historicalSymptomsRecordCountInfo:(NSMutableArray *)array
                                theSymptomsLogArray:(NSMutableArray *)logArray
                             thehistoricalDataArray:(NSMutableArray *)historicalArray{
    
    NSInteger normal = 0;
    NSInteger abnormal = 0;
    NSInteger count = 0;
    NSInteger symptomOthers = 0;// 症状-其他
    NSInteger symptomDyspnea = 0;//症状记录--呼吸困难
    NSInteger symptomChestdistress = 0;//症状记录--胸闷
    NSInteger symptomRhinocnesmus = 0;// 症状-鼻痒
    NSInteger symptomNightWoke = 0;//症状记录--夜间憋醒
    NSInteger symptomRunny = 0;// 症状-流清涕
    NSInteger symptomActLimited = 0;// 症状-活动受限
    NSInteger symptomCough = 0;//症状记录--咳嗽
    NSInteger symptomSneeze = 0;// 症状-打喷嚏
    NSInteger symptomGasp = 0;//症状记录--喘息
    NSInteger symptomEczema = 0;// 症状-湿疹
    NSInteger symptomGood = 0;//症状记录--感觉良好
    
    for (KLSymptomsLogModel *model in logArray) {
        model.count = 0;
    }
    
    for (KLPatientLogModel *model in array)
    {
        if (model.symptomOthers == 1)
        {
            [KLHistoricalOperation addSymptomsLogModelCountInfoIndex:10 theLogArray:logArray];
            symptomOthers++;
        }
        if (model.symptomDyspnea == 1)
        {
            [KLHistoricalOperation addSymptomsLogModelCountInfoIndex:3 theLogArray:logArray ];
            symptomDyspnea++;
        }
        if (model.symptomChestdistress == 1)
        {
            [KLHistoricalOperation addSymptomsLogModelCountInfoIndex:2 theLogArray:logArray];
            symptomChestdistress++;
        }
        if (model.symptomRhinocnesmus == 1)
        {
            [KLHistoricalOperation addSymptomsLogModelCountInfoIndex:6 theLogArray:logArray ];
            symptomRhinocnesmus++;
        }
        if (model.symptomNightWoke == 1)
        {
            [KLHistoricalOperation addSymptomsLogModelCountInfoIndex:5 theLogArray:logArray];
            symptomNightWoke++;
        }
        if (model.symptomRunny == 1)
        {
            [KLHistoricalOperation addSymptomsLogModelCountInfoIndex:8 theLogArray:logArray ];
            symptomRunny++;
        }
        if (model.symptomActLimited == 1)
        {
            [KLHistoricalOperation addSymptomsLogModelCountInfoIndex:4 theLogArray:logArray ];
            symptomActLimited++;
        }
        if (model.symptomCough == 1)
        {
            [KLHistoricalOperation addSymptomsLogModelCountInfoIndex:0 theLogArray:logArray ];
            symptomCough++;
        }
        if (model.symptomSneeze == 1)
        {
            [KLHistoricalOperation addSymptomsLogModelCountInfoIndex:9 theLogArray:logArray];
            symptomSneeze++;
        }
        if (model.symptomGasp == 1)
        {
            [KLHistoricalOperation addSymptomsLogModelCountInfoIndex:1 theLogArray:logArray ];
            symptomGasp++;
        }
        if (model.symptomEczema == 1)
        {
            [KLHistoricalOperation addSymptomsLogModelCountInfoIndex:7 theLogArray:logArray];
            symptomEczema++;
        }
        if (model.symptomGood == 1)
        {
            [KLHistoricalOperation addSymptomsLogModelCountInfoIndex:11 theLogArray:logArray];
            symptomGood++;
        }
    }
    
    count = symptomOthers + symptomDyspnea + symptomChestdistress + symptomRhinocnesmus +  symptomNightWoke + symptomRunny + symptomActLimited + symptomCough + symptomSneeze +
    symptomGasp + symptomEczema + symptomGood;
    
    normal = symptomGood;
    abnormal = count - symptomGood;
    
    if (historicalArray) {
        LWHistoricalCountModel *model1 = [historicalArray rewriteObjectAtIndex:0];
        LWHistoricalCountModel *model2 = [historicalArray rewriteObjectAtIndex:1];
        model1.count = normal;
        model2.count = abnormal;
    }
    return @{@"normal":kNSNumInteger(normal),@"abnormal":kNSNumInteger(abnormal),@"count":kNSNumInteger(count)};
}

+ (void)addSymptomsLogModelCountInfoIndex:(NSInteger)index
                              theLogArray:(NSMutableArray *)array{
    if (array.count <= 0) {
        return;
    }
    KLSymptomsLogModel *model = [array rewriteObjectAtIndex:index];
    model.count++;
    
}


+ (NSDictionary *)historicalMedicationRecordCountInfo:(NSMutableArray *)array
                               thehistoricalDataArray:(NSMutableArray *)historicalArray{
    
    NSInteger pharmacyControl = 0;//控制用药 0 1
    NSInteger pharmacyUrgency = 0;//紧急用药
    NSInteger noPharmacy = 0; //未服药
    NSInteger count = 0;//次数
    for (KLPatientLogModel *model in array) {
        if (model.pharmacyControl == 1)
        {
            pharmacyControl++;
        }else if (model.pharmacyControl == 0)
        {
            noPharmacy++;
        }
        if (model.pharmacyUrgency == 1)
        {
            pharmacyUrgency++;
        }else if (model.pharmacyUrgency == 0)
        {
            noPharmacy++;
        }
    }
    count = noPharmacy + pharmacyUrgency;
    
    if (historicalArray) {
        LWHistoricalCountModel *model1 = [historicalArray rewriteObjectAtIndex:0];
        LWHistoricalCountModel *model2 = [historicalArray rewriteObjectAtIndex:1];
        LWHistoricalCountModel *model3 = [historicalArray rewriteObjectAtIndex:2];
        model1.count = pharmacyControl;
        model2.count = pharmacyUrgency;
        model3.count = noPharmacy;
    }
    return @{@"pharmacyControl":kNSNumInteger(pharmacyControl),@"pharmacyUrgency":kNSNumInteger(pharmacyUrgency),@"noPharmacy":kNSNumInteger(noPharmacy),@"count":kNSNumInteger(count)};
}

+ (NSMutableArray *)mergeHistoricalListInfo:(NSMutableArray *)array{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSMutableArray *datas = [NSMutableArray array];
    
    for (KLPatientLogModel *model in array)
    {
        if ([dic objectForKey:model.recordDt]) {
            NSMutableArray *array = [dic objectForKey:model.recordDt];
            [array addObject:model];
        }else
        {
            NSMutableArray *array = [NSMutableArray array];
            [array addObject:model];
            [dic setObject:array forKey:model.recordDt];
        }
    }
    
    NSArray *keys = [dic allKeys];
    
    for (NSString *key in keys)
    {
        NSMutableArray *array = dic[key];
        LWMedicationModel *base = [[LWMedicationModel alloc] init];
        if (array.count >= 2)
        {
            KLPatientLogModel *model1 = array[0];
            KLPatientLogModel *model2 = array[1];
  
            NSDictionary *sssdic = [model1 dictionaryRepresentation];

            
            NSLog(@"%@",sssdic);
            
            
            base.recordDt = model1.recordDt;
            base.isOne = NO;
            if (model1.timeFrame == 1) {
                base.morningPharmacyControl = model1.pharmacyControl;
                base.morningPharmacyUrgency = model1.pharmacyUrgency;
                base.afternoonPharmacyControl = model2.pharmacyControl;
                base.afternoonPharmacyUrgency = model2.pharmacyUrgency;
                base.morningpefValue = model1.pefValue;
                base.eveningpefValue = model2.pefValue;
            }else
            {
                base.morningPharmacyControl = model2.pharmacyControl;
                base.morningPharmacyUrgency = model2.pharmacyUrgency;
                base.afternoonPharmacyControl = model1.pharmacyControl;
                base.afternoonPharmacyUrgency = model1.pharmacyUrgency;
                base.morningpefValue = model2.pefValue;
                base.eveningpefValue = model1.pefValue;
            }
            
        }else
        {
            KLPatientLogModel *model = array[0];
            base.recordDt = model.recordDt;
            base.isOne = YES;
            base.timeFrame = model.timeFrame;
            if (model.timeFrame == 1) {
                base.morningPharmacyControl = model.pharmacyControl;
                base.morningPharmacyUrgency = model.pharmacyUrgency;
                base.afternoonPharmacyControl = 2;
                base.afternoonPharmacyUrgency = 2;
                base.morningpefValue = model.pefValue;
                base.eveningpefValue = 0;
            }else
            {
                base.afternoonPharmacyControl = model.pharmacyControl;
                base.afternoonPharmacyUrgency = model.pharmacyUrgency;
                base.morningPharmacyControl = 2;
                base.morningPharmacyUrgency = 2;
                base.eveningpefValue = model.pefValue;
                base.morningpefValue = 0;
            }
        }
        [datas addObject:base];
    }
    
    [datas sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        LWMedicationModel *model1 = obj1;
        LWMedicationModel *model2 = obj2;
        NSDate *date1 = [NSDate dateWithString:model1.recordDt format:[NSDate ymdFormat]];
        NSDate *date2 = [NSDate dateWithString:model2.recordDt format:[NSDate ymdFormat]];
        
        return [date1 compare:date2];
    }];
    
    return datas;
}
+ (UIColor *)pefColorInfo:(double)pefPredictedValue thePefValue:(double)value{
    
    if ([KLHistoricalOperation areaNormalValueInfo:pefPredictedValue thePefValue:value]){
        return [LWHistoricalCountModel normalColor];
    }
    if ([KLHistoricalOperation areaAbnormalValueInfo:pefPredictedValue thePefValue:value])
    {
        return [LWHistoricalCountModel abnormalColor];
    }
    if ([KLHistoricalOperation areaWarningValueInfo:pefPredictedValue thePefValue:value])
    {
        return [LWHistoricalCountModel warningColor];
    }
    return  [LWHistoricalCountModel normalColor];
}


@end
