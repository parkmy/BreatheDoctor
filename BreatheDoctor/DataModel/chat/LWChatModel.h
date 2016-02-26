//
//  LWChatModel.h
//  BreatheDoctor
//
//  Created by comv on 15/11/18.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LWChatModel : NSObject

@property (nonatomic, strong) NSString *reqNum;
@property (nonatomic, strong) NSString *sessionId;
@property (nonatomic, strong) NSString *valid;
@property (nonatomic, strong) NSString *resNum;
@property (nonatomic, strong) NSString *joinId;

@property (nonatomic, strong) NSString *remark;
@property (nonatomic, strong) NSString *refreshDate;//返回时间(用于下次刷新)
@property (nonatomic, strong) NSString *patientName;
@property (nonatomic, strong) NSString *headImgUrl;
@property (nonatomic, assign) double controlLevel;
@property (nonatomic, strong) NSString *returnDate;

@property (nonatomic, assign) double endRow;
@property (nonatomic, assign) double pageSize;//每一页条数
@property (nonatomic, assign) BOOL getCount;
@property (nonatomic, assign) BOOL lastPage;
@property (nonatomic, assign) double startRow;
@property (nonatomic, assign) double totalRows; //总条数
@property (nonatomic, assign) double currentPage;//当前页数
@property (nonatomic, assign) BOOL firstPage;
@property (nonatomic, assign) double totalPages;//总页数
//类型
@property (nonatomic, assign) WSChatCellType chatCellType;//单元格类型
@property (nonatomic, assign) WSChatMessageType  chatMessageType;// 消息类型
@property (nonatomic, assign) double timeStamp;
@property (nonatomic, assign) double isCount;//是否算红点
@property (nonatomic, strong) NSString *insertDt;//插入时间
@property (nonatomic, assign) double isDispose;//处理状态
@property (nonatomic, strong) NSString *modifyDt;
@property (nonatomic, assign) NSInteger msgType;//消息类型
@property (nonatomic, strong) NSString *doctorId;//医生id
@property (nonatomic, strong) NSString *memberId;//患者id
@property (nonatomic, strong) NSString *msgContent;//消息
@property (nonatomic, strong) NSString *sid;//消息ID
@property (nonatomic, assign) NSInteger isValid;//是否有效
@property (nonatomic, strong) NSString *foreignId;
@property (nonatomic, assign) BOOL ownerType;//消息类型 1 患者 2 医生
@property (nonatomic, assign) float  rowHeight;

//消息
@property (nonatomic, strong) NSString *assessDt;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *recordDt;
@property (nonatomic, assign) double timeFrame;
@property (nonatomic, strong) NSString *doctorText;
@property (nonatomic, assign) NSInteger contentType;//消息类型
@property (nonatomic, assign) double voiceMin; //语音长度
@property (nonatomic, strong) NSString *pEFLevel;
@property (nonatomic, strong) NSString *patientText;
@property (nonatomic, assign) double assessResult;
@property (nonatomic, assign) double pEFValue;

@property (nonatomic, assign) double pharmacyUrgency;
@property (nonatomic, assign) double symptomChestdistress;
@property (nonatomic, assign) double symptomDyspnea;
@property (nonatomic, assign) double symptomCough;
@property (nonatomic, assign) double pharmacyControl;
@property (nonatomic, strong) NSString *pefremark;
@property (nonatomic, assign) double symptomNightWoke;
@property (nonatomic, assign) double symptomGood;


@property (nonatomic, strong) NSString *voiceFileName;
@property (nonatomic, assign) BOOL showDateLabel;

@property (nonatomic, assign) BOOL voiceIsPlay;

+ (LWChatModel *)modelWith:(LWChatBaseModel *)model WithRow:(LWChatRows *)row;


@end
