//
//  KLRegistModel.m
//  BreatheDoctor
//
//  Created by comv on 16/5/18.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLRegistModel.h"

@implementation KLRegistModel

+ (NSMutableArray *)initializeRegistModels{

    NSMutableArray *array = [NSMutableArray array];
    for (int j = 0; j < 4; j++) {
     
        KLRegistModel *model = [KLRegistModel new];
        model.isSecureTextEntry = NO;
        model.type = 0;
        
        switch (j) {
            case 0:
            {
                model.title = @"手机号";
                model.placeholderString = @"11位手机号码";
                model.maxCount = 10;

            }
                break;
            case 1:
            {
                model.title = @"验证码";
                model.placeholderString = @"短信验证码";
                model.type = 1;
                model.maxCount = 5;
            }
                break;
            case 2:
            {
                model.title = @"密码";
                model.placeholderString = @"密码不少于6位";
                model.isSecureTextEntry = YES;
//                model.keyType = UIKeyboardTypeDefault;
                model.maxCount = 16;

            }
                break;
            case 3:
            {
                model.title = @"邀请码";
                model.placeholderString = @"必填";
                model.maxCount = 10;
            }
                break;
            default:
                break;
        }
                
        [array addObject:model];
    }
    
    return array;
}

+ (NSString *)fieldTextTheIndex:(NSInteger)index withArray:(NSMutableArray *)array{

    KLRegistModel *model = array[index];
    return  model.fieldText.length>0?model.fieldText:@"";
}

@end
