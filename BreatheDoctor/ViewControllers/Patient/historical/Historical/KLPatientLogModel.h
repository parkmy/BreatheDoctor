//
//  KLPatientLogBody.h
//
//  Created by   on 16/3/24
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface KLPatientLogModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *recordDt;//到天
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, strong) NSString *recordId;
@property (nonatomic, strong) NSString *insertDt;//到时分秒
@property (nonatomic, strong) NSString *modifyDt;
@property (nonatomic, strong) NSString *patientId;

@property (nonatomic, assign) double inducementSpecialSmell;//诱因-特殊气味
@property (nonatomic, assign) double inducementCold;//诱因-寒冷
@property (nonatomic, assign) double inducementPet; //诱因-宠物
@property (nonatomic, assign) double inducementSmoking; //诱因-吸烟环境
@property (nonatomic, assign) double inducementFeverCold; //诱因-感冒发热
@property (nonatomic, assign) double inducementBlubbered;//诱因-大哭大闹
@property (nonatomic, assign) double inducementSports;//诱因-运动
@property (nonatomic, assign) double inducementFabricPlush;//诱因-布艺毛绒
@property (nonatomic, assign) double inducementPollen;//诱因-花粉

@property (nonatomic, assign) double controlRate;//控制率
@property (nonatomic, assign) double pefValue;
@property (nonatomic, assign) double pharmacyControl;//控制用药 0 1
@property (nonatomic, assign) double pharmacyUrgency;//紧急用药
@property (nonatomic, assign) double inducementOthers;//诱因-其它 0 1
@property (nonatomic, assign) double perfValue;//
@property (nonatomic, assign) double timeFrame;//时段 1早上 2晚上

@property (nonatomic, assign) double symptomOthers;// 症状-其他
@property (nonatomic, assign) double symptomDyspnea;//症状记录--呼吸困难
@property (nonatomic, assign) double symptomChestdistress;//症状记录--胸闷
@property (nonatomic, assign) double symptomRhinocnesmus;// 症状-鼻痒
@property (nonatomic, assign) double symptomNightWoke;//症状记录--夜间憋醒
@property (nonatomic, assign) double symptomRunny;// 症状-流清涕
@property (nonatomic, assign) double symptomActLimited;// 症状-活动受限
@property (nonatomic, assign) double symptomCough;//症状记录--咳嗽
@property (nonatomic, assign) double symptomSneeze;// 症状-打喷嚏
@property (nonatomic, assign) double symptomGasp;//症状记录--喘息
@property (nonatomic, assign) double symptomEczema;// 症状-湿疹
@property (nonatomic, assign) double symptomGood;//症状记录--感觉良好

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
