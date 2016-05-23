//
//  KLServiceAgreementModel.h
//  BreatheDoctor
//
//  Created by comv on 16/5/18.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KLServiceAgreementModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;

@property (nonatomic, assign) CGFloat rowHight;

+ (NSMutableArray *)serviceAgreements;

@end
