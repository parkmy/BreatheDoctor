//
//  LWChatModel.m
//  BreatheDoctor
//
//  Created by comv on 15/11/18.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWChatModel.h"
#import "NSDate+Utils.h"

@implementation LWChatModel

+ (LWChatModel *)modelWith:(LWChatBaseModel *)model WithRow:(LWChatRows *)row
{
    return [[self alloc] initWithModel:model WithRow:row];
}

- (id)initWithModel:(LWChatBaseModel *)model WithRow:(LWChatRows *)row
{
    self = [super init];
    if (self) {
        
        self.reqNum = model.reqNum;
        self.sessionId = model.sessionId;
        self.valid = model.valid;
        self.resNum = model.resNum;
        self.joinId = model.joinId;
        
        self.remark = model.body.remark;
        self.refreshDate = model.body.refreshDate;
        self.patientName = model.body.patientName;
        self.headImgUrl = model.body.headImgUrl;
        self.controlLevel = model.body.controlLevel;
        self.returnDate = model.body.returnDate;
        
        self.endRow = model.body.pager.endRow;
        self.pageSize = model.body.pager.pageSize;
        self.getCount = model.body.pager.getCount;
        self.lastPage = model.body.pager.lastPage;
        self.startRow = model.body.pager.startRow;
        self.totalRows = model.body.pager.totalRows;
        self.currentPage = model.body.pager.currentPage;
        self.firstPage = model.body.pager.firstPage;
        self.totalPages = model.body.pager.totalPages;
        
        
        self.timeStamp = row.timeStamp;
        self.isCount = row.isCount;
        self.insertDt = row.insertDt;
        self.isDispose = row.isDispose;
        self.modifyDt = row.modifyDt;
        self.msgType = row.msgType;
        self.doctorId = row.doctorId;
        self.memberId = row.memberId;
        self.msgContent = row.msgContent;
        self.sid = row.sid;
        self.isValid = row.isValid;
        self.foreignId = row.foreignId;
        self.ownerType = row.ownerType;
        self.voiceFileName = row.voiceFileName;
        
        self.chatCellType = row.chatCellType;
        self.chatMessageType = row.chatMessageType;
        self.assessDt = row.dataStruct.assessDt;
        self.content = row.dataStruct.content;
        self.recordDt = row.dataStruct.recordDt;
        self.timeFrame = row.dataStruct.timeFrame;
        self.doctorText = row.dataStruct.doctorText;
        self.contentType = row.dataStruct.contentType;
        self.voiceMin = row.dataStruct.voiceMin;
        self.pEFLevel = row.dataStruct.pEFLevel;
        self.patientText = row.dataStruct.patientText;
        self.assessResult = row.dataStruct.assessResult;
        self.pEFValue = row.dataStruct.pEFValue;
        
        [self changeTheDateString:self.insertDt];
//        [self changRowhight];
    }
    return self;
}
//"08-10 晚上08:09:41.0" ->
//"昨天 上午10:09"或者"2012-08-10 凌晨07:09"
- (NSString *)changeTheDateString:(NSString *)Str
{
    NSDate *lastDate = [NSDate dateFromString:Str withFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:lastDate];
    lastDate = [lastDate dateByAddingTimeInterval:interval];
    
    NSString *dateStr;  //年月日
    NSString *period;   //时间段
    NSString *hour;     //时
    
    if ([lastDate year]==[[NSDate date] year]) {
        NSInteger days = [NSDate daysOffsetBetweenStartDate:lastDate endDate:[NSDate date]];
        if (days <= 2) {
            dateStr = [lastDate stringYearMonthDayCompareToday];
        }else{
            dateStr = [lastDate stringMonthDay];
        }
    }else{
        dateStr = [lastDate stringYearMonthDay];
    }
    
    
    if ([lastDate hour]>=5 && [lastDate hour]<12) {
        period = @"AM";
        hour = [NSString stringWithFormat:@"%02d",(int)[lastDate hour]];
    }else if ([lastDate hour]>=12 && [lastDate hour]<=18){
        period = @"PM";
        hour = [NSString stringWithFormat:@"%02d",(int)[lastDate hour]-12];
    }else if ([lastDate hour]>18 && [lastDate hour]<=23){
        period = @"Night";
        hour = [NSString stringWithFormat:@"%02d",(int)[lastDate hour]-12];
    }else{
        period = @"Dawn";
        hour = [NSString stringWithFormat:@"%02d",(int)[lastDate hour]];
    }
    return [NSString stringWithFormat:@"%@ %@ %@:%02d",dateStr,period,hour,(int)[lastDate minute]];
}

- (void)minuteOffSetStart:(NSString *)start end:(NSString *)end
{
    if (!start) {
        self.showDateLabel = YES;
        return;
    }
    
    NSString *subStart = [start substringWithRange:NSMakeRange(0, 19)];
    NSDate *startDate = [NSDate dateFromString:subStart withFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *subEnd = [end substringWithRange:NSMakeRange(0, 19)];
    NSDate *endDate = [NSDate dateFromString:subEnd withFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    //这个是相隔的秒数
    NSTimeInterval timeInterval = [startDate timeIntervalSinceDate:endDate];
    
    //相距5分钟显示时间Label
    if (fabs (timeInterval) > 5*60) {
        self.showDateLabel = YES;
    }else{
        self.showDateLabel = NO;
    }
    
}




@end
