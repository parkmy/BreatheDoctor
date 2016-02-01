//
//  CommonReturn.m
//  DiabetesPatient
//
//  Created by 郑建武 on 15-2-26.
//  Copyright (c) 2015年 com.comvee. All rights reserved.
//

#import "CommonReturn.h"

@implementation CommonReturn

@synthesize res_code;
@synthesize res_msg;

- (void)dealloc
{
    res_msg = nil;
}
@end
