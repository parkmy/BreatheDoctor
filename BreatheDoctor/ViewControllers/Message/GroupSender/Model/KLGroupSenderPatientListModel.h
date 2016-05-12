//
//  KLGroupSenderPatientListModel.h
//  BreatheDoctor
//
//  Created by comv on 16/5/4.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <Foundation/Foundation.h>
@class KLGroupSenderChatModel;

@interface KLGroupSenderPatientListModel : NSObject

@property (nonatomic, copy)   NSString *patientNmaes;
@property (nonatomic, copy)   NSString *patientIDs;
@property (nonatomic, assign) NSInteger patientListCount;
/**
 *  再次发送得到群发联系人
 *
 *  @param model model description
 *
 *  @return return value description
 */
+ (KLGroupSenderPatientListModel *)againSenderPatientListModelWith:(KLGroupSenderChatModel *)model;
/**
 *  患者列表得到群发联系人
 *
 *  @param array array description
 *
 *  @return return value description
 */
+ (KLGroupSenderPatientListModel *)listVcGroupSenderPatientLisetModelWithList:(NSMutableArray *)array;
- (NSString *)patientIDJsonString;

- (NSString *)patientNameJsonString;

- (NSArray *)patientIds;

- (NSArray *)patientNames;

@end
