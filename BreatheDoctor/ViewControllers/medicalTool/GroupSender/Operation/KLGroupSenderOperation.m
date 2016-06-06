//
//  KLGroupSenderOperation.m
//  BreatheDoctor
//
//  Created by comv on 16/4/26.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLGroupSenderOperation.h"
#import "KLPatientListModel.h"
#import "KLGoodsDetailedImageUrlList.h"
#import "KLGoodsImageModel.h"

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
+ (NSMutableArray *)goodsImageUrlListWithList:(NSArray *)list{

    NSMutableArray *array = [NSMutableArray array];
    for (KLGoodsDetailedImageUrlList *listModel in list) {
        if (listModel.type == 2) {
            KLGoodsImageModel *model = [KLGoodsImageModel new];
            model.imageUrl = listModel.imageUrl;
            [array addObject:model];
        }
    }
    return array;
}
+ (NSString *)priceFloatEqlistThePrice:(NSString *)price{
    
    if (price.length <= 0) {
        
        return @"";
    }
    
    NSArray *priceArray = [price componentsSeparatedByString:@"."];
    NSString *floatSting = @"";
    if (priceArray.count > 1) {
        
        NSString *fString = priceArray[1];
        NSString *float1 = [fString substringWithRange:NSMakeRange(0, 1)];
        NSString *float2 = [fString substringWithRange:NSMakeRange(1, 1)];
        if ([float2 isEqualToString:@"0"]&&[float1 isEqualToString:@"0"]) {
            
            floatSting = @"";
        }else if (![float1 isEqualToString:@"0"]&&![float2 isEqualToString:@"0"]){
            
            floatSting = [NSString stringWithFormat:@".%@",fString];
        }else if ([float1 isEqualToString:@"0"]&&![float2 isEqualToString:@"0"]){
            
            floatSting = [NSString stringWithFormat:@".0%@",float2];
        }else if (![float1 isEqualToString:@"0"]&&[float2 isEqualToString:@"0"]){
            
            floatSting = [NSString stringWithFormat:@".%@",float1];
        }
    }
    
    return [NSString stringWithFormat:@"%@%@",priceArray[0],floatSting];
}

+ (CGSize)imageCFsizeWithSize:(CGSize)size{
    
    CGSize cfSzie ;
    if (size.width > screenWidth) {
        
        cfSzie.width = screenWidth;
        CGFloat sp = (size.width/size.height);
        cfSzie.height =  cfSzie.width/sp;
    }else{
        
        cfSzie.width = size.width;
        cfSzie.height = size.height;
    }
    return cfSzie;
}

@end
