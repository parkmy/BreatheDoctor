//
//  KLPatientOperation.h
//  BreatheDoctor
//
//  Created by comv on 16/4/21.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LWCustomMenu;

/**
 *  列表类型
 */
typedef NS_ENUM(NSInteger, LISTTYPE) {
    /**
     *  默认患者列表
     */
    LISTTYPEDEFT  = 0,
    /**
     *  群发列表
     */
    LISTTYPEGROUPSENDER,
    /**
     *  再次群发编辑
     */
    LISTTYPEGROUPAGAINSENDER,
};

#define ALPHA	@"ABCDEFGHIJKLMNOPQRSTUVWXYZ"

typedef NS_ENUM(NSInteger , ShowGroupingType) {
    ShowGroupingTypeAll = 0, //所有
    ShowGroupingTypeNoDetermined ,//未确定
    ShowGroupingTypeCompleteControl ,//完全控制
    ShowGroupingTypePartControl ,//部分控制
    ShowGroupingTypeNoControl ,//为控制
};

@interface KLPatientOperation : NSObject

+ (KLPatientOperation *)sharePatientOperation;

+ (void)patientsInfoShowGroupingType:(ShowGroupingType)type
                        theDataArray:(NSMutableArray *)array
                             theSucc:(void(^)(NSMutableArray *patients,NSMutableDictionary *listDic,NSArray *keys))succBlock;

+ (void)loadCachePatientListSucc:(void(^)(NSMutableArray *dataArray,NSString *refTimer))succBlock;


+ (void)httploadPatientListTheRefreshDate:(NSString *)refDate
                                     Succ:(void(^)(NSArray *list))succBlock
                                  failure:(void (^)(NSString * errorMes))failure;
//- (void)showPullView:(NSMutableArray *)patients;
//- (void)hiddenPullView;

@end
