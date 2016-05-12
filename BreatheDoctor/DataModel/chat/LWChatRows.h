//
//  LWChatRows.h
//
//  Created by   on 15/11/16
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LWChatDeft.h"

#define kCellReuseIDWithSenderAndType(ownerType,chatCellType)    ([NSString stringWithFormat:@"%d-%ld",ownerType,chatCellType])

//根据模型得到可重用Cell的 重用ID
#define kCellReuseID(model)      ((model.chatCellType == WSChatCellType_Time)?kTimeCellReusedID:(model.chatCellType == WSChatCellType_Card)?kCardCellReusedID:(kCellReuseIDWithSenderAndType(model.ownerType,(long)model.chatCellType)))

@class LWChatDataStruct;

/**
 *  @brief  单元格类型
 */
typedef NS_OPTIONS(NSInteger,WSChatCellType)
{
    /**
     *  @brief  文本消息
     */
    WSChatCellType_Text = 1,
    
    /**
     *  @brief  图片消息
     */
    WSChatCellType_Image = 2,
    
    /**
     *  @brief  语音消息
     */
    WSChatCellType_Audio = 3,
    
    /**
     *  @brief  卡片类型
     */
    WSChatCellType_Card = 5,
    
    /**
     *  @brief  同意消息
     */
    WSChatCellType_Agreed  = 0,
    
    /**
     *  @brief  商品
     */
    WSChatCellType_Goods  = 6,
};


@interface LWChatRows : NSObject <NSCoding, NSCopying>
/**
 *  @brief  本消息类型？文本？图片？还是语音？
 */
@property (nonatomic, assign) WSChatCellType chatCellType;//单元格类型
@property (nonatomic, assign) WSChatMessageType  chatMessageType;// 消息类型
@property (nonatomic, assign) double timeStamp;
@property (nonatomic, strong) LWChatDataStruct *dataStruct;
@property (nonatomic, assign) double isCount;
@property (nonatomic, strong) NSString *insertDt;
@property (nonatomic, assign) double isDispose;
@property (nonatomic, strong) NSString *modifyDt;
@property (nonatomic, assign) NSInteger msgType;
@property (nonatomic, strong) NSString *doctorId;
@property (nonatomic, strong) NSString *memberId;
@property (nonatomic, strong) NSString *msgContent;
@property (nonatomic, strong) NSString *sid;
@property (nonatomic, assign) double isValid;
@property (nonatomic, strong) NSString *foreignId;
@property (nonatomic, assign) BOOL ownerType;
@property (nonatomic, assign) float  height;

@property (nonatomic, strong) NSString *voiceFileName;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
