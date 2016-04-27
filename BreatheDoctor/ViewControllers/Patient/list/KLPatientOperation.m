//
//  KLPatientOperation.m
//  BreatheDoctor
//
//  Created by comv on 16/4/21.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLPatientOperation.h"
#import "LWCustomMenu.h"
#import "KLPatientListModel.h"
#import "LWTool.h"

@interface KLPatientOperation ()<LWCustomMenuDelegate>

//@property (nonatomic, assign) BOOL isShowPullView;
//@property (nonatomic, strong) LWCustomMenu  *pullView;

@end

@implementation KLPatientOperation

+ (KLPatientOperation *)sharePatientOperation{
    static dispatch_once_t onceToken;
    static KLPatientOperation *_op;
    dispatch_once(&onceToken, ^{
        _op = [KLPatientOperation new];
    });
    return _op;
}

+ (void)patientsInfoShowGroupingType:(ShowGroupingType)type
                        theDataArray:(NSMutableArray *)array
                             theSucc:(void(^)(NSMutableArray *patients,NSMutableDictionary *listDic,NSArray *keys))succBlock{
    
    NSMutableArray *patients = [NSMutableArray array];
    
    if (type == ShowGroupingTypeAll) {
        [patients addObjectsFromArray:array];
    }else
    {
        @autoreleasepool
        {
            for (KLPatientListModel *pat in array)
            {
                if (pat.controlLevel == type)
                {
                    [patients addObject:pat];
                }
            }
        }
    }
    
    
    NSMutableDictionary *listDic = [NSMutableDictionary dictionary];
    
    @autoreleasepool {
        
        for (KLPatientListModel *pat in patients)
        {
            if (!pat.PinYin || ![ALPHA containsaString:stringJudgeNull(pat.PinYin)]) {
                if ([listDic objectForKey:@"#"]) {
                    NSMutableArray *arr = [listDic objectForKey:@"#"];
                    [arr addObject:pat];
                }else
                {
                    NSMutableArray *arr = [NSMutableArray array];
                    [arr addObject:pat];
                    [listDic setObject:arr forKey:@"#"];
                }
            }else
            {
                if ([listDic objectForKey:pat.PinYin]) {
                    NSMutableArray *arr = [listDic objectForKey:pat.PinYin];
                    [arr addObject:pat];
                }else
                {
                    NSMutableArray *arr = [NSMutableArray array];
                    [arr addObject:pat];
                    [listDic setObject:arr forKey:pat.PinYin];
                }
            }
            
        }
    }
    SEL sel = @selector(localizedCompare:);
    //对拼音排序
    NSArray *keys = [listDic.allKeys sortedArrayUsingSelector:sel];
    
    succBlock?succBlock(patients,listDic,keys):nil;
    
}
+ (void)loadCachePatientListSucc:(void(^)(NSMutableArray *dataArray,NSString *refTimer))succBlock{
    
    NSMutableArray *array = [[LKDBHelper getUsingLKDBHelper] search:[KLPatientListModel class] where:nil orderBy:@"refTimer DESC" offset:0 count:10000];
    
    NSString *refreshTime = nil;
    if (array.count > 0) {
        KLPatientListModel *model = [array firstObject];
        refreshTime = model.refTimer;
    }
    succBlock?succBlock(array,refreshTime):nil;
}


@end
