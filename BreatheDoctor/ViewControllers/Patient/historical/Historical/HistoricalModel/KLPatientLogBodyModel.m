//
//  KLPatientLogBodyModel.m
//  BreatheDoctor
//
//  Created by comv on 16/3/25.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLPatientLogBodyModel.h"
#import "KLPatientLogModel.h"

@implementation KLPatientLogBodyModel

- (instancetype)initWithDictionary:(NSDictionary *)dict{

    if ([super init]) {
        
        id pefPredictedValueObjc = [dict objectForKey:@"pefPredictedValue"];
        self.pefPredictedValue = [[NSString stringJudgeNullInfoString:pefPredictedValueObjc] doubleValue];
        NSArray *list = [dict objectForKey:@"recordList"];
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in list) {
            KLPatientLogModel *model = [[KLPatientLogModel alloc] initWithDictionary:dic];
            [array addObject:model];
        }
        self.recordList = [NSMutableArray arrayWithArray:array];
    }
    return self;
}

@end
