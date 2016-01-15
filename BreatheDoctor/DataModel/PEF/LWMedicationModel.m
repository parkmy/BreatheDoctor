//
//  LWMedicationModel.m
//  BreatheDoctor
//
//  Created by comv on 15/11/26.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWMedicationModel.h"
#import "NSDate+Extension.h"

@implementation LWMedicationModel



+ (NSMutableArray *)MedicationModels
{
    LWPEFLineModel *LineModel = [LWPublicDataManager shareInstance].logModle;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSMutableArray *datas = [NSMutableArray array];
    
    for (LWPEFRecordList *model in LineModel.body.recordList)
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
            LWPEFRecordList *model1 = array[0];
            LWPEFRecordList *model2 = array[1];
            
            base.recordDt = model1.recordDt;
            base.isOne = NO;
            if (model1.timeFrame == 1) {
                base.morningPharmacyControl = model1.pharmacyControl;
                base.morningPharmacyUrgency = model1.pharmacyUrgency;
                base.afternoonPharmacyControl = model2.pharmacyControl;
                base.afternoonPharmacyUrgency = model2.pharmacyUrgency;
            }else
            {
                base.morningPharmacyControl = model2.pharmacyControl;
                base.morningPharmacyUrgency = model2.pharmacyUrgency;
                base.afternoonPharmacyControl = model1.pharmacyControl;
                base.afternoonPharmacyUrgency = model1.pharmacyUrgency;
            }
            
        }else
        {
            LWPEFRecordList *model = array[0];
            base.recordDt = model.recordDt;
            base.isOne = YES;
            base.timeFrame = model.timeFrame;
            base.pharmacyUrgency = model.pharmacyUrgency;
            base.pharmacyControl = model.pharmacyControl;
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
    
    
    
    
    //    NSMutableArray *array = [NSMutableArray array];
    //
    //    NSInteger count = LineModel.body.recordList.count;
    //    if (count <= 0) {
    //        return array;
    //    }
    //    NSMutableArray *ssArray = [NSMutableArray arrayWithArray:LineModel.body.recordList];
    //
    //    for (NSInteger i = ssArray.count; i < 0; i--)
    //    {
    //        LWPEFRecordList *model1 = LineModel.body.recordList[i];
    //        for (NSInteger a = ssArray.count-1; a < 0; a--) {
    //            LWPEFRecordList *model2 = LineModel.body.recordList[a];
    //            LWMedicationModel *base = [[LWMedicationModel alloc] init];
    //
    //            if ([model1.recordDt isEqualToString:model2.recordDt]) {
    //                base.recordDt = model1.recordDt;
    //                base.isOne = NO;
    //                if (model1.timeFrame == 1) {
    //                    base.morningPharmacyControl = model1.pharmacyControl;
    //                    base.morningPharmacyUrgency = model1.pharmacyUrgency;
    //                    base.afternoonPharmacyControl = model2.pharmacyControl;
    //                    base.afternoonPharmacyUrgency = model2.pharmacyUrgency;
    //                }else
    //                {
    //                    base.morningPharmacyControl = model2.pharmacyControl;
    //                    base.morningPharmacyUrgency = model2.pharmacyUrgency;
    //                    base.afternoonPharmacyControl = model1.pharmacyControl;
    //                    base.afternoonPharmacyUrgency = model1.pharmacyUrgency;
    //                }
    //                [ssArray removeObject:model1];
    //                [ssArray removeObject:model2];
    //                [array addObject:base];
    //            }else
    //            {
    //                base.timeFrame = model1.timeFrame;
    //                base.pharmacyUrgency = model1.pharmacyUrgency;
    //                base.pharmacyControl = model1.pharmacyControl;
    //                [ssArray removeObject:model1];
    //                [array addObject:base];
    //            }
    //
    //        }
    //
    //    }
    
    return datas;
}

@end
