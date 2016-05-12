//
//  KLGroupSenderPatientListModel.m
//  BreatheDoctor
//
//  Created by comv on 16/5/4.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLGroupSenderPatientListModel.h"
#import "KLPatientListModel.h"
#import "KLGroupSenderChatModel.h"
#import "YRJSONAdapter.h"

@implementation KLGroupSenderPatientListModel

#pragma mark -aft
+ (KLGroupSenderPatientListModel *)againSenderPatientListModelWith:(KLGroupSenderChatModel *)model{

    if (!model) {
        return nil;
    }
    KLGroupSenderPatientListModel *ls = [KLGroupSenderPatientListModel new];
    ls.patientIDs = model.patientIds;
    ls.patientNmaes = model.patientNames;
    ls.patientListCount = model.patientNum;
    return ls;
}

+ (KLGroupSenderPatientListModel *)listVcGroupSenderPatientLisetModelWithList:(NSMutableArray *)array{

    if (array.count <= 0) {
        return nil;
    }
    
    NSMutableArray *patientNameList = [NSMutableArray array];
    NSMutableArray *patientIDList = [NSMutableArray array];
    
    for (KLPatientListModel *model in array) {
        
        [patientNameList addObject:model.patientName];
        [patientIDList addObject:model.patientId];
        
    }
    KLGroupSenderPatientListModel *ls = [KLGroupSenderPatientListModel new];
    ls.patientIDs = [patientIDList componentsJoinedByString:@","];
    ls.patientNmaes = [patientNameList componentsJoinedByString:@","];
    ls.patientListCount = array.count;

    return ls;
}

- (NSString *)patientIDJsonString{

    if (self.patientIDs.length > 0) {
        return [[self.patientIDs componentsSeparatedByString:@","] JSONString];
    }
    return @"";
}
- (NSString *)patientNameJsonString{
    
    if (self.patientNmaes.length > 0) {
        return [[self.patientNmaes componentsSeparatedByString:@","] JSONString];
    }
    return @"";
}
- (NSArray *)patientIds{
    
    if (self.patientIDs.length > 0) {
        return [self.patientIDs componentsSeparatedByString:@","];
    }
    return nil;
}
- (NSArray *)patientNames{
    
    if (self.patientNmaes.length > 0) {
        return [self.patientNmaes componentsSeparatedByString:@","];
    }
    return nil;
}
@end
