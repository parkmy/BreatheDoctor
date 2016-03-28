//
//  LWHistoricalCountModel.m
//  BreatheDoctor
//
//  Created by comv on 16/3/18.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWHistoricalCountModel.h"

@implementation LWHistoricalCountModel

+ (NSMutableArray *)historicalType:(showHistoricalType)type
{
    NSMutableArray *array = [NSMutableArray array];
    if (type == showHistoricalTypePEF) {
        for (int i = 0; i < 3; i++)
        {
            LWHistoricalCountModel *model = [LWHistoricalCountModel new];
            model.typeTitle = i==0?@"正常":i==1?@"异常":@"警告";
            model.countColor = i==0?[LWHistoricalCountModel normalColor]:i==1?[LWHistoricalCountModel abnormalColor]:[LWHistoricalCountModel warningColor];
            model.typeTag = i;
            [array addObject:model];
        }
    }else if(type == showHistoricalTypeSymptoms)
    {
        for (int i = 0; i < 2; i++)
        {
            LWHistoricalCountModel *model = [LWHistoricalCountModel new];
            model.typeTitle = i==0?@"正常":@"异常";
            model.countColor = i==0?[LWHistoricalCountModel normalColor]:[LWHistoricalCountModel abnormalColor];
            model.typeTag = i;
            [array addObject:model];
        }
    }else
    {
        for (int i = 0; i < 3; i++)
        {
            LWHistoricalCountModel *model = [LWHistoricalCountModel new];
            model.typeTitle = i==0?@"控制用药":i==1?@"紧急用药":@"未  服  药";
            model.countColor = i==0?[LWHistoricalCountModel normalColor]:i==1?[LWHistoricalCountModel warningColor]:[LWHistoricalCountModel noMeColor];
            model.typeTag = i;
            [array addObject:model];
        }
    }
    return array;
}

+ (UIColor *)normalColor
{
    return [UIColor colorWithHexString:@"#83cb6d"];
}
+ (UIColor *)abnormalColor
{
    return [UIColor colorWithHexString:@"#febf47"];
}
+ (UIColor *)warningColor
{
    return [UIColor colorWithHexString:@"#ff3333"];
}
+ (UIColor *)noMeColor
{
    return [UIColor colorWithHexString:@"#999999"];
}

- (NSMutableAttributedString *)historicalCountAttributedString
{
    NSString *type = stringJudgeNull(self.typeTitle);
    NSString *count = kNSString(kNSNumInteger(self.count));
    NSString *string = [NSString stringWithFormat:@"%@  %@  次",type,count];
//    if (self.count >= 10) {
//        string = [NSString stringWithFormat:@"%@  %@  次",type,count];
//    }else
//    {
//        string = [NSString stringWithFormat:@"%@  %@    次",type,count];
//    }
    
    NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:string];
    [attributed addAttributes:@{NSFontAttributeName:kNSPXFONT(24)} range:NSMakeRange(string.length-1, 1)];
    [attributed addAttributes:@{NSFontAttributeName:kNSPXFONT(38),NSForegroundColorAttributeName:self.countColor} range:NSMakeRange(type.length, string.length-1-type.length)];
    return attributed;
}

@end
