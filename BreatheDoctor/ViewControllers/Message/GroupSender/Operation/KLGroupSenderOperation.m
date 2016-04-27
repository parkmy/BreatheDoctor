//
//  KLGroupSenderOperation.m
//  BreatheDoctor
//
//  Created by comv on 16/4/26.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLGroupSenderOperation.h"
#import "KLPatientListModel.h"

@implementation KLGroupSenderOperation

+ (NSString *)getGroupSenderListStringWithPatientArray:(NSMutableArray *)array{
    
    NSMutableArray *nameArray = [NSMutableArray array];
    
    for (KLPatientListModel *model in array) {
        
        [nameArray addObject:model.patientName];
    }
    NSString *nameList = [nameArray componentsJoinedByString:@"，"];
    
    //    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //    [paragraphStyle setLineSpacing:5];
    //    UIColor *color = [UIColor blackColor];
    
    return nameList;
}

+ (NSAttributedString *)getGoodsPriceLabeString:(NSString *)string{
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    
    [attributedString addAttributes:@{NSFontAttributeName:kNSPXFONT(22)} range:NSMakeRange(0, 1)];
    
    return attributedString;

}

@end
