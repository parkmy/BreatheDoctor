//
//  KLGroupSenderChatModel.m
//  BreatheDoctor
//
//  Created by comv on 16/4/28.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLGroupSenderChatModel.h"
#import "YRJSONAdapter.h"
@implementation KLGroupSenderChatModel

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    
    if ([super init]) {
        
        self.msgType   = [dict[@"msgType"] integerValue];

        self.dataStr = dict[@"dataStr"];
        
        self.msgContent = dict[@"msgContent"];
        self.patientIds = dict[@"patientIds"];
        self.doctorIds = dict[@"doctorIds"];
        self.createDt = dict[@"createDt"];
        self.modifyDt = dict[@"modifyDt"];
        self.patientNames = dict[@"patientNames"];
        self.sid = dict[@"sid"];
        self.isValid = [dict[@"isValid"] boolValue];
        self.foreignId = dict[@"foreignId"];
        self.ownerType = [dict[@"ownerType"] boolValue];
        self.patientNum = [dict[@"patientNum"] integerValue];
        
        [self setUp];
    }
    return self;
}
//{\"imageUrl\":\"http:\/\/comveedoctor.oss-cn-hangzhou.aliyuncs.com\/201603\/0717\/1603071711053734.jpg\",\"productId\":\"1603071446060008\",\"productName\":\"欧姆龙医用雾化式压缩器NE-C900\",\"tags\":\"货到付款@#@上门指导\"}
- (void)setUp{

    if (self.dataStr.length <= 0) {
        return;
    }
    
    NSDictionary *dic = [YRJSONAdapter objectFromJSONString:self.dataStr];
    
    if (self.msgType == 1) {
        if ([dic objectForKey:@"contentType"]) {
            
            self.contentType = [[dic objectForKey:@"contentType"] integerValue];
            self.groupSenderChatType = self.contentType;
        }
    }else{
        
        self.groupSenderChatType = self.msgType;
    }
    
    
    if ([dic objectForKey:@"content"]) {
        
        self.content = [dic objectForKey:@"content"];
    }
    
    if (self.groupSenderChatType == GroupSenderChatTypeVoice) {
        if ([dic objectForKey:@"voiceMin"]) {
            
            self.voiceCount = [[dic objectForKey:@"voiceMin"] integerValue];
        }
    }else if (self.groupSenderChatType == GroupSenderChatTypeGoods){
        
        if ([dic objectForKey:@"productId"]) {
            
            self.productID = [dic objectForKey:@"productId"];
        }
        
        if ([dic objectForKey:@"productName"]) {
            
            self.productName = [dic objectForKey:@"productName"];
        }
        
        if ([dic objectForKey:@"imageUrl"]) {
            
            self.productimageURL = [dic objectForKey:@"imageUrl"];
        }
        
        if ([dic objectForKey:@"tags"]) {
            
            self.tags = [dic objectForKey:@"tags"];
        }
        
    }
}

+ (NSMutableArray *)loadSqlDataTheReftimerWhere:(NSString *)where{
    
    NSMutableArray* array = [[LKDBHelper getUsingLKDBHelper] search:[KLGroupSenderChatModel class] where:where orderBy:@"createDt DESC" offset:0 count:10];
    return array;
}
+ (NSString *)refWhereTheRefTimer:(NSString *)refDate theRefType:(RefreshType)type{
    
    NSString *where = nil;
    
    if (refDate.length <= 0) {
        
        return where;
    }
    if (type == RefreshTypeNew) {
        
        where = [NSString stringWithFormat:@"createDt > '%@'",refDate];
    }else{
        
        where = [NSString stringWithFormat:@"createDt < '%@'",refDate];
    }
    

    
    return where;
}
@end
