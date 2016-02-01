//
//  LWTool.m
//  BreatheDoctor
//
//  Created by comv on 15/11/12.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWTool.h"
#import "LWChatModel.h"
#import "NSDate+Extension.h"
#import "LWPatientListModel.h"
#import "LWACTAssessmentModel.h"
#import "UUMessageFrame.h"
#import "LWTheFromBaseModel.h"

@implementation LWTool
//控制等级 1 未确认 2 已控制 3 部分控制 4 未控制
+ (void)atientControlLevel:(double)controLevel withLayoutConstraint:(NSLayoutConstraint *)traint withLabel:(id)objc
{
    NSString *title = nil;
    UIColor *color = nil;
    NSString *bgImageNmae = nil;
    
    if (controLevel == 1) {
        title = @"未确认";
        color = RGBA(203, 203, 203, 1);
        bgImageNmae = @"weiqueren";
    }else if (controLevel == 2)
    {
        color = RGBA(119, 204, 78, 1);
        title = @"完全控制";
        bgImageNmae = @"wanquankongzhi";
        
    }else if (controLevel == 3)
    {
        title = @"部分控制";
        color = RGBA(251, 186, 94, 1);
        bgImageNmae = @"bufenkongzhi";
        
    }else if (controLevel == 4)
    {
        title = @"未控制";
        color = RGBA(248, 140, 143, 1);
        bgImageNmae = @"weikongzhi";
        
    }else
    {
        title = @"";
        color = [UIColor clearColor];
        bgImageNmae = @"weiqueren";
        
    }
    
    CGSize size = [title sizeWithFont:[UIFont systemFontOfSize:13] constrainedToHeight:20];
    
    if ([objc isKindOfClass:[UILabel class]]) {
        UILabel *label = (UILabel *)objc;
        label.backgroundColor = color;
        label.text = title;
        [label setCornerRadius:label.height/2];
        
    }else if ([objc isKindOfClass:[UIButton class]])
    {
        UIButton *button = (UIButton *)objc;
        [button setBackgroundImage:kImage(bgImageNmae) forState:UIControlStateNormal];
        [button setTitle:title forState:UIControlStateNormal];
        
    }
    traint.constant = size.width+20;
    
}


+ (CGFloat)personalMessageSource:(NSString *)title WithLabel:(LWPersonalMessageCell *)cell WithModel:(LWPatientRecordsBaseModel *)model
{
    if (!model) {
        return 44;
    }
    NSString *message = @"";
    
    if ([title isEqualToString:@"姓名"]) {
        message = model.body.patientArchives.patientName;
    }else if ([title isEqualToString:@"性别"])
    {
        message = model.body.patientArchives.sex == 1?@"男":@"女";
    }else if ([title isEqualToString:@"出生日期"])
    {
        message = model.body.patientArchives.birthday;
        
    }else if ([title isEqualToString:@"身高"])
    {
        
        message = [NSString stringWithFormat:@"%@cm",kNSString(kNSNumDouble(model.body.patientArchives.height))];
        
    }else if ([title isEqualToString:@"体重"])
    {
        message = [NSString stringWithFormat:@"%@kg",kNSString(kNSNumDouble(model.body.patientArchives.weight))] ;
    }else if ([title isEqualToString:@"是否有以下症状"])
    {
        message = model.body.patientArchives.symptom;
        
        NSMutableString *m_mssage = [[NSMutableString alloc] init];
        if ([[self class] mesageIsArray:message]) {
            for (NSString *msg in [[self class] mesageIsArray:message]) {
                if ([msg isEqualToString:@"1"]) {
                    [m_mssage appendString:@"感觉良好"];
                }else if ([msg isEqualToString:@"2"]){
                    [m_mssage appendString:@",喘息"];
                }else if ([message isEqualToString:@"3"]){
                    [m_mssage appendString:@",咳嗽"];
                }else if ([message isEqualToString:@"4"]){
                    [m_mssage appendString:@",呼吸困难"];
                }else if ([message isEqualToString:@"5"]){
                    [m_mssage appendString:@",胸闷"];
                }else if ([message isEqualToString:@"6"]){
                    [m_mssage appendString:@",夜间憋醒"];
                }
            }
        }
        message = [m_mssage copy];
        
    }else if ([title isEqualToString:@"是否有以下症状诱导因素"])
    {
        message = model.body.patientArchives.symptomFactor;
        NSMutableString *m_mssage = [[NSMutableString alloc] init];
        if ([[self class] mesageIsArray:message]) {
            for (NSString *msg in [[self class] mesageIsArray:message]) {
                if ([msg isEqualToString:@"1"]) {
                    [m_mssage appendString:@"夜间发作(后半夜,清晨)"];
                }else if ([msg isEqualToString:@"2"]){
                    [m_mssage appendString:@",运动相关"];
                }else if ([message isEqualToString:@"3"]){
                    [m_mssage appendString:@",感染后引起"];
                }
            }
        }
        message = [m_mssage copy];
        
    }else if ([title isEqualToString:@"是否有以下并发症"])
    {
        message = model.body.patientArchives.syndrome;
        
        NSMutableString *m_mssage = [[NSMutableString alloc] init];
        if ([[self class] mesageIsArray:message]) {
            for (NSString *msg in [[self class] mesageIsArray:message]) {
                if ([msg isEqualToString:@"1"]) {
                    [m_mssage appendString:@"打喷嚏"];
                }else if ([msg isEqualToString:@"2"]){
                    [m_mssage appendString:@",流鼻涕"];
                }
            }
        }
        message = [m_mssage copy];
        
        if (model.body.patientArchives.syndromeRemark.length > 0) { //备注
            [message stringByAppendingString:[NSString stringWithFormat:@"\n备注:%@",model.body.patientArchives.syndromeRemark]];
        }
    }else if ([title isEqualToString:@"是否有以下病史"])
    {
        message = model.body.patientArchives.medicalHistory;
        
        NSMutableString *m_mssage = [[NSMutableString alloc] init];
        if ([[self class] mesageIsArray:message]) {
            for (NSString *msg in [[self class] mesageIsArray:message]) {
                if ([msg isEqualToString:@"1"]) {
                    [m_mssage appendString:@"湿疹"];
                }else if ([msg isEqualToString:@"2"]){
                    [m_mssage appendString:@",荨麻疹"];
                }else if ([msg isEqualToString:@"3"]){
                    [m_mssage appendString:@",鼻炎"];
                }
            }
        }
        
        
        if ([[self class] mesageIsArray:message]) {
            for (NSString *msg in [[self class] mesageIsArray:model.body.patientArchives.allergicHistory]) {
                if ([msg isEqualToString:@"1"]) {
                    [m_mssage appendString:@"有药物过敏"];
                }else if ([msg isEqualToString:@"2"]){
                    [m_mssage appendString:@",食物过敏"];
                }else if ([msg isEqualToString:@"3"]){
                    [m_mssage appendString:@",吸入物过敏"];
                }else if ([msg isEqualToString:@"4"]){
                    [m_mssage appendString:@",其他过敏"];
                }
            }
        }
        
        message = [m_mssage copy];
        
    }else if ([title isEqualToString:@"是否有以下家族史"])
    {
        message = model.body.patientArchives.familyHistoryParent;
        NSMutableString *m_mssage = [[NSMutableString alloc] init];
        if ([[self class] mesageIsArray:message]) {
            for (NSString *msg in [[self class] mesageIsArray:message]) {
                if ([msg isEqualToString:@"1"]) {
                    [m_mssage appendString:@"哮喘"];
                }else if ([msg isEqualToString:@"2"]){
                    [m_mssage appendString:@",过敏"];
                }else if ([msg isEqualToString:@"3"]){
                    [m_mssage appendString:@",湿疹"];
                }else if ([msg isEqualToString:@"4"]){
                    [m_mssage appendString:@",鼻炎"];
                }else if ([msg isEqualToString:@"5"]){
                    [m_mssage appendString:@",吸烟"];
                }else if ([msg isEqualToString:@"6"]){
                    [m_mssage appendString:@",结缔组织病"];
                }
            }
        }
        if ([model.body.patientArchives.familyHistoryOther isEqualToString:@"1"]) {
            [m_mssage appendString:@"\n其它家属 哮喘史"];
        }
        message = [m_mssage copy];
    }else if ([title isEqualToString:@"FVC"])
    {
        message = [[self class] messageIsNull:model.body.patientArchives.fvc];
        if (![message isEqualToString:@"未填写"]) {
            message = [NSString stringWithFormat:@"%@L",message];
        }
    }else if ([title isEqualToString:@"FVC%"])
    {
        message = [[self class] messageIsNull:model.body.patientArchives.fvcPercent];
        if (![message isEqualToString:@"未填写"]) {
            message = [NSString stringWithFormat:@"%@%@",message,@"%"];
        }
    }else if ([title isEqualToString:@"FEV1%"])
    {
        message = [[self class] messageIsNull:model.body.patientArchives.fev1Percent];
        if (![message isEqualToString:@"未填写"]) {
            message = [NSString stringWithFormat:@"%@%@",message,@"%"];
        }
    }else if ([title isEqualToString:@"FEV1"])
    {
        message = [[self class] messageIsNull:model.body.patientArchives.fev1];
        if (![message isEqualToString:@"未填写"]) {
            message = [NSString stringWithFormat:@"%@L",message];
        }
    }else if ([title isEqualToString:@"舒张实验"])
    {
        if (model.body.patientArchives.diastoleTest == 0)
            message = @"未填写";
        else
            message = model.body.patientArchives.diastoleTest == 1?@"阳性":@"阴性";
        
    }else if ([title isEqualToString:@"激发实验"])
    {
        if (model.body.patientArchives.provocationTest == 0) {
            message = @"未填写";
        }else{
            message = model.body.patientArchives.provocationTest == 1?@"阳性":@"阴性";
        }
        
    }else if ([title isEqualToString:@"过敏原检测"])
    {
        message = [[self class] messageIsNull:model.body.patientArchives.allergenTest];
        
    }else if ([title isEqualToString:@"FeNO"])
    {
        message = [[self class] messageIsNull:model.body.patientArchives.feno];
    }
    if (cell) {
        
        if (message.length > 1) {
            NSMutableString *string = [NSMutableString stringWithString:message];
            
            if (string.length > 2) {
                NSString *s = [string substringWithRange:NSMakeRange(0, 1)];
                if ([s isEqualToString:@","]) {
                    [string deleteCharactersInRange:NSMakeRange(0, 1)];
                }
                NSString *m = [string substringWithRange:NSMakeRange(string.length-1, 1)];
                if ([m isEqualToString:@","]) {
                    [string deleteCharactersInRange:NSMakeRange(string.length-1, 1)];
                }
            }
            [cell setMessage:string];
        }else{
            [cell setMessage:message];
        }
        
    }
    
    CGFloat hight = [message sizeWithFont:[UIFont systemFontOfSize:14] constrainedToWidth:100].height+10;
    return  MAX(hight, 44);
}

+ (NSArray *)mesageIsArray:(NSString *)msg
{
    if (msg.length > 2) {
        return [msg componentsSeparatedByString:@"|"];
    }
    if (msg.length > 0) {
        return @[msg];
    }
    return [NSArray array];
}
+ (NSString *)messageIsNull:(NSString *)mes
{
    if (mes.length <= 0 || [mes isEqualToString:@""] || [mes isEqualToString:@"Null"]) {
        return @"未填写";
    }
    return mes;
}


+ (void)traverseChatMessage:(NSMutableArray *)array
{
    [array sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if ([obj1 isKindOfClass:[UUMessageFrame class]] && [obj2 isKindOfClass:[UUMessageFrame class]]) {
            
            UUMessageFrame *model1 = obj1;
            UUMessageFrame *model2 = obj2;
            
            NSDate *time1 = [NSDate dateWithString:model1.model.insertDt format:[NSDate ymdHmsFormat]];
            NSDate *time2 = [NSDate dateWithString:model2.model.insertDt format:[NSDate ymdHmsFormat]];
            
            NSComparisonResult result = [time1 compare:time2];
            
            return result;
        }else
        {
            
            LWChatModel *model1 = obj1;
            LWChatModel *model2 = obj2;
            
            NSDate *time1 = [NSDate dateWithString:model1.insertDt format:[NSDate ymdHmsFormat]];
            NSDate *time2 = [NSDate dateWithString:model2.insertDt format:[NSDate ymdHmsFormat]];
            
            NSComparisonResult result = [time1 compare:time2];
            
            return result;
        }
    }];
    
    UUMessageFrame *messageFram = [array firstObject];
    if (messageFram) {
        messageFram.showTime = YES;
    }
}

+ (NSMutableArray *)forGrouping:(NSMutableArray *)array
{
    NSInteger suoyou = array.count;
    NSInteger weiQueDing = 0;
    NSInteger wanquankongz = 0;
    NSInteger bufenkongz = 0;
    NSInteger weikongz = 0;
    for (LWPatientRows *patin in array) {
        //1 未确认 2 已控制 3 部分控制 4 未控制
        if (patin.controlLevel == 1) {
            weiQueDing++;
        }
        if (patin.controlLevel == 2) {
            wanquankongz++;
        }
        if (patin.controlLevel == 3) {
            bufenkongz++;
        }
        if (patin.controlLevel == 4) {
            weikongz++;
        }
    }
    NSMutableArray *arr = [NSMutableArray array];
    
    for (int a = 0; a < 5; a++) {
        LWPatientListModel *model = [[LWPatientListModel alloc] init];
        if (a == 0) {
            model.title = @"所有患者";
            model.count = suoyou;
        }else if (a == 1){
            model.title = @"未确定";
            model.count = weiQueDing;
            
        }else if (a == 2){
            model.title = @"完全控制";
            model.count = wanquankongz;
            
        }else if (a == 3){
            model.title = @"部分控制";
            model.count = bufenkongz;
            
        }else if (a == 4){
            model.title = @"未控制";
            model.count = weikongz;
        }
        [arr addObject:model];
    }
    
    return arr;
}

+ (void)ACTAssessmentChangeWithModel:(LWACTModel *)model withArray:(NSMutableArray *)array
{
    
    if (!model) {
        return;
    }
    for (int a = 0; a < array.count; a++)
    {
        LWACTAssessmentModel *asModle = array[a];
        if (a == 0) {//"在过去4周内，在工作、学习或家中，有多少时候哮喘妨碍您进行日常活动?"
            NSArray *actss = @[@"所有时间",@"大多数时候",@"有些时候",@"很少时候",@"没有"];
            [[self class] trarray:actss withModel:asModle withid:model.act1];
            
        }else if (a == 1)//"在过去4周内，您有多少次呼吸困难"
        {
            NSArray *actss = @[@"每天不止1次",@"一天1次",@"每周3至6次",@"每周1至2次",@"完全没有"];
            [[self class] trarray:actss withModel:asModle withid:model.act2];
        }else if (a == 2)//"在过去4周内，因为哮喘症状(喘息、咳嗽、呼吸困难、胸闷或疼痛)，您有多少次在夜间醒来或早上比平时早醒?"
        {
            NSArray *actss = @[@"每周4晚或更多",@"每周2至3晚",@"每周1次",@"1至2次",@"没有"];
            [[self class] trarray:actss withModel:asModle withid:model.act3];
        }else if (a == 3)//@"在过去4周内，您有多少次使用急救药物治疗?"
        {
            NSArray *actss = @[@"每天3次以上",@"每天1至2次",@"每周2至3次",@"每周1次或更少",@"没有"];
            [[self class] trarray:actss withModel:asModle withid:model.act4];
            
        }
        else if (a == 4)//"您如何评估过去4周内您的哮喘控制情况?"
        {
            //没有控制①，控制很差②，有所控制③，控制很好④，完全控制⑤
            NSArray *actss = @[@"没有控制",@"控制很差",@"有所控制",@"控制很好",@"完全控制"];
            [[self class] trarray:actss withModel:asModle withid:model.act5];
        }
        
    }
}

+ (void)trarray:(NSArray *)array withModel:(LWACTAssessmentModel *)model withid:(double)dId
{
    int index = dId;
    if (index <= array.count) {
        model.daan = [NSString stringWithFormat:@"患者选项: %@",array[index-1]];
    }
}

+ (NSMutableArray *)LogrowsCount
{
    NSMutableArray *array = [NSMutableArray array];
    
    LWPEFLineModel *lineModel = [LWPublicDataManager shareInstance].logModle;
    
    for (LWPEFRecordList *model in lineModel.body.recordList)
    {
        if (model.symptomGood == 1) {//症状记录--感觉良好	1 选中 0 未选中
            
            [array addObject:model];
            continue;
        }
        if (model.symptomGasp == 1) {//    症状记录--喘息	1 选中 0 未选中
            
            [array addObject:model];
            continue;
        }
        if (model.symptomCough == 1) {//    症状记录--咳嗽	1 选中 0 未选中
            
            [array addObject:model];
            continue;
        }
        if (model.symptomDyspnea == 1) {//    症状记录--呼吸困难	1 选中 0 未选中
            
            [array addObject:model];
            continue;
        }
        if (model.symptomChestdistress == 1) {//    症状记录--胸闷	1 选中 0 未选中
            
            [array addObject:model];
            continue;
        }
        if (model.symptomNightWoke) {
            
            [array addObject:model];
            continue;
        }
        
    }
    return array;
}

+ (NSMutableArray *)LoglabelsCount:(LWPEFRecordList *)model
{
    NSMutableArray *array = [NSMutableArray array];
    
    if (model.symptomGood == 1) {//症状记录--感觉良好	1 选中 0 未选中
        UILabel *label = [[self class] createLabelWithBackgroundColor:RGBA(148, 210, 116, 1) withText:@"感觉良好"];
        [array addObject:label];
    }
    if (model.symptomGasp == 1) {//    症状记录--喘息	1 选中 0 未选中
        UILabel *label = [[self class] createLabelWithBackgroundColor:RGBA(248, 138, 130, 1) withText:@"喘息"];
        [array addObject:label];
    }
    if (model.symptomCough == 1) {//    症状记录--咳嗽	1 选中 0 未选中
        UILabel *label = [[self class] createLabelWithBackgroundColor:RGBA(248, 138, 130, 1) withText:@"咳嗽"];
        [array addObject:label];
    }
    if (model.symptomDyspnea == 1) {//    症状记录--呼吸困难	1 选中 0 未选中
        UILabel *label = [[self class] createLabelWithBackgroundColor:RGBA(248, 138, 130, 1) withText:@"呼吸困难"];
        [array addObject:label];
    }
    if (model.symptomChestdistress == 1) {//    症状记录--胸闷	1 选中 0 未选中
        UILabel *label = [[self class] createLabelWithBackgroundColor:RGBA(248, 138, 130, 1) withText:@"胸闷"];
        [array addObject:label];
    }
    if (model.symptomNightWoke) {
        UILabel *label = [[self class] createLabelWithBackgroundColor:RGBA(0, 0, 0, .3) withText:@"夜间憋醒"];
        [array addObject:label];
    }
    
    return array;
    
}
+ (UILabel *)createLabelWithBackgroundColor:(UIColor *)color
                                   withText:(NSString *)labelText
{
    UILabel *label = [[UILabel alloc] init];
    CGSize size = [stringJudgeNull(labelText) sizeWithFont:[UIFont systemFontOfSize:15] constrainedToHeight:30];
    label.bounds = CGRectMake(0, 0, size.width+20, 30);
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = color;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:15];
    label.text = labelText;
    
    return label;
}

+ (NSArray *)AsthmaAssessLogcontens
{
    return @[@"您的哮喘已得到完全控制。如果有变化，请联系你的医生！",@"您的哮喘已得到良好控制。但是没有完全控制，请继续治疗！",@"您的哮喘没有得到控制。您需要医生帮你制定一个哮喘管理计划！"];
}

+ (NSMutableArray *)toDealWithAsthmaAssessLogModel:(LWAsthmaAssessLogModel *)model
{
    NSArray *body = model.body;
    NSMutableArray *array = [NSMutableArray array];
    
    @autoreleasepool {
        for (LWAsthmaAssessLogBody *base in body)
        {
            if (base.controlLevelY == 0) {
                continue;
            }
            LWAssessmentModel *assessmentModel = [[LWAssessmentModel alloc] init];
            assessmentModel.type = base.controlLevelY;
            NSDate *date = [NSDate dateWithString:base.dateX format:[NSDate ymdFormat]];
            assessmentModel.xdate = date;
            NSString *string = [NSDate stringWithDate:[date dateAfterDay:6] format:[NSDate ymdFormat]];
            assessmentModel.starDate = base.dateX;
            assessmentModel.endDate = string;
            assessmentModel.date = [NSString stringWithFormat:@"%@ - %@",base.dateX,string];
            NSString *content;
            if (base.controlLevelY == 1) {
                content = [[[self class] AsthmaAssessLogcontens] objectAtIndex:0];
            }else if (base.controlLevelY == 2)
            {
                content = [[[self class] AsthmaAssessLogcontens] objectAtIndex:1];
            }else
            {
                content = [[[self class] AsthmaAssessLogcontens] objectAtIndex:2];
            }
            assessmentModel.content = content;
            [array addObject:assessmentModel];
        }
    }
    
    
    [array sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        LWAssessmentModel *model1 = obj1;
        LWAssessmentModel *model2 = obj2;
        
        if ([model1.xdate day] < [model2.xdate day]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    return array;
}

+ (NSDictionary *)patientPEFDateLineSx:(NSString *)date
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    if (!date) { //如果没有日期就默认当前日期
        NSString *star = [NSDate stringWithDate:[NSDate dateAfterDate:[NSDate date] day:-6] format:[NSDate ymdFormat]];
        NSString *end = [NSDate stringWithDate:[NSDate date] format:[NSDate ymdFormat]];
        [dic setObject:star forKey:@"star"];
        [dic setObject:end forKey:@"end"];
        
    }else //有日期 进行分析
    {
        NSDate *xsDate = [NSDate dateWithString:date format:[NSDate ymdHmsFormat]];
        NSInteger count = [NSDate daysAgo:xsDate];//传入日期和当前时间相差多少天
        NSInteger wek = count/7;//相差多少周
        //算出存在那一周的最后日期 也就是那周的结尾日期
        NSString *end = [NSDate stringWithDate:[NSDate dateAfterDate:[NSDate date] day:(-(wek*7))] format:[NSDate ymdFormat]];
        //根据结尾日期算出开始日期
        NSString *star = [NSDate stringWithDate:[NSDate dateAfterDate:[NSDate dateWithString:end format:[NSDate ymdFormat]] day:-6] format:[NSDate ymdFormat]];
        [dic setObject:star forKey:@"star"];
        [dic setObject:end forKey:@"end"];
    }
    return dic;
}


+ (NSDictionary *)chatMessageCardModel:(LWChatModel *)model
{
    
    NSString *title = @"";
    NSString *content = @"";
    
    switch (model.chatMessageType) {
        case WSChatMessageType_FirstSeeDoctorRemind:
        {
            title = @"首次就诊";
            content = model.doctorText;
        }
            break;
        case WSChatMessageType_FirstSeeDoctorReport:
        {
            title = @"首诊就诊报告";
            content = model.doctorText;
            
        }
            break;
        case WSChatMessageType_VisitReport:
        {
            title = @"复诊就诊报告";
            content = model.doctorText;
        }
            break;
        case WSChatMessageType_PEFRemind:
        {
            title = @"记录PEF提醒";
            content = model.doctorText;
        }
            break;
        case WSChatMessageType_ACAassessment:
        {
            title = @"ACT评估通知";
            content = model.doctorText;
        }
            break;
        case WSChatMessageType_AsthmaAassessment:
        {
            title = @"我有哮喘症状评估通知";
            content = model.doctorText;
        }
            break;
        case WSChatMessageType_VisitRemind:
        {
            title = @"复诊提醒";
            content = model.doctorText;
        }
            break;
        case WSChatMessageType_PEFRecord:
        {
            title = @"PEF值异常通知";
            content = [NSString stringWithFormat:@"记录时间:%@\nPEF值:%@L/min\nPEF水平:%@",model.insertDt,kNSNumDouble(model.pEFValue),model.pEFLevel];
        }
            break;
        case WSChatMessageType_BiaoDan:
        {
            title = @"哮喘诊断判定表";
            content = [NSString stringWithFormat:@"记录时间:%@",model.insertDt];
        }
            break;
            
        default:
            break;
    }
    
    return @{@"title":title,@"content":content};
    
}

//表单数据分析
+ (LWTheFromBaseModel *)BiaoDanDataFenXiModel:(LWPatientBiaoDanBody *)model
{
    
    //    symptom 症状
    //    cause  诱因
    //    day_symptoms  日间症状
    //    night_symptoms 夜间症状
    //    activity 活动受限
    //    acute 急性发作
    //    urgent_medicine 使用应急缓解药物
    //    make_medicine 是否服用以下药物
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"LWVisitList" ofType:@"plist"];
    NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:path];
    LWTheFromBaseModel *theFromModel = [[LWTheFromBaseModel alloc] initWithDictionary:dic];
        // 外3数组[ 区头 ， 数组[标题， 是否多选 ，数组[ID 标题] ] ]

    NSArray *symptoms           = [[self class] stringBayArrayWithString:model.symptom];
    NSArray *cause              = [[self class] stringBayArrayWithString:model.cause];
    NSArray *day_symptoms       = [[self class] stringBayArrayWithString:model.daySymptoms];
    NSArray *night_symptoms     = [[self class] stringBayArrayWithString:model.nightSymptoms];
    NSArray *activity           = [[self class] stringBayArrayWithString:model.activity];
    NSArray *acute              = [[self class] stringBayArrayWithString:model.acute];
    NSArray *urgent_medicine    = [[self class] stringBayArrayWithString:model.urgentMedicine];
    NSArray *make_medicine      = [[self class] stringBayArrayWithString:model.makeMedicine];
    
    for (int i = 0; i < theFromModel.mrows.count; i++)
    {
        LWTheFromMrows *mModel = theFromModel.mrows[i];
        
        for (int a = 0; a < mModel.arows.count; a++)
        {
            LWTheFromArows *aModel = mModel.arows[a];
            
            NSMutableArray *array = [NSMutableArray array];
            
            for (LWTheFromRowArray *row in aModel.rowArray)
            {
                if (i == 0 && a == 0)
                {
                    [[self class] forAreDataArray:symptoms addArray:array row:row];
                    
                }else if (i == 0 && a == 1)
                {
                    [[self class] forAreDataArray:cause addArray:array row:row];
                }else if (i == 1 && a == 0)
                {
                    [[self class] forAreDataArray:day_symptoms addArray:array row:row];

                }else if (i == 1 && a == 1)
                {
                    [[self class] forAreDataArray:night_symptoms addArray:array row:row];
                    
                }else if (i == 1 && a == 2)
                {
                    [[self class] forAreDataArray:activity addArray:array row:row];
                    
                }else if (i == 1 && a == 3)
                {
                    [[self class] forAreDataArray:acute addArray:array row:row];
                    
                }else if (i == 2 && a == 0)
                {
                    [[self class] forAreDataArray:urgent_medicine addArray:array row:row];
                    
                }else if (i == 2 && a == 1)
                {
                    [[self class] forAreDataArray:make_medicine addArray:array row:row];
                    
                }
            }
            
            aModel.rowArray = array; //替换
        }
    }

    
    return theFromModel;//返回
    
}
// 包含的添加进去
+ (void)forAreDataArray:(NSArray *)array addArray:(NSMutableArray *)addArray row:(LWTheFromRowArray  *)row
{
    for (NSString *mid in array)
    {
        if ([mid isEqualToString:row.mid])
        {
            [addArray addObject:row];
        }
        
    }
    if (array.count <= 0) {
        
    }
}

+ (NSArray *)stringBayArrayWithString:(NSString *)string
{
    return [stringJudgeNull(string) componentsSeparatedByString:@"|"];
}


@end
