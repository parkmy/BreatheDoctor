//
//  KLGroupSenderChatModel.h
//  BreatheDoctor
//
//  Created by comv on 16/4/28.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  群发类型
 */
typedef NS_ENUM(NSInteger, GroupSenderChatType) {
    /**
     *  文字
     */
    GroupSenderChatTypeText =  1,
    /**
     *  语音
     */
    GroupSenderChatTypeVoice = 3,
    /**
     *  图片
     */
    GroupSenderChatTypeImage = 2,
    /**
     *  商品
     */
    GroupSenderChatTypeGoods = 13,
};

typedef NS_ENUM(NSInteger ,RefreshType)
{
    RefreshTypeTypeOld = 1, //向上加载旧数据
    RefreshTypeNew = 2, //加载最新数据
};

@interface KLGroupSenderChatModel : NSObject

@property (nonatomic, assign) GroupSenderChatType groupSenderChatType;

@property (nonatomic, copy)  NSString *returnDate;

@property (nonatomic, copy)  NSString *patientIds;

@property (nonatomic, copy)  NSString *doctorIds;

@property (nonatomic, copy)  NSString *createDt;

@property (nonatomic, copy)  NSString *modifyDt;

@property (nonatomic, copy)  NSString *msgContent;

@property (nonatomic, assign) NSInteger msgType;

@property (nonatomic, copy)  NSString *content;

@property (nonatomic, assign) NSInteger contentType;

@property (nonatomic, assign) NSInteger voiceCount;

@property (nonatomic, copy)  NSString *patientNames;

@property (nonatomic, copy)  NSString *sid;

@property (nonatomic, assign)  BOOL      isValid;

@property (nonatomic, copy)  NSString *dataStr;

@property (nonatomic, copy)  NSString *foreignId;

@property (nonatomic, assign)  BOOL     ownerType;

@property (nonatomic, assign) NSInteger patientNum;

@property (nonatomic, copy)  NSString *productName;

@property (nonatomic, copy)  NSString *productimageURL;

@property (nonatomic, copy)  NSString *productID;

@property (nonatomic, copy)  NSString *tags;

@property (nonatomic, assign) BOOL  voiceIsPlay;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

/**
 *  获取本地缓存群发记录
 *
 *  @param ref 时间
 *
 */
+ (NSMutableArray *)loadSqlDataTheReftimerWhere:(NSString *)where;

+ (NSString *)refWhereTheRefTimer:(NSString *)refDate theRefType:(RefreshType)type;
@end
