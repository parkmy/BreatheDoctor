//
//  KLHomeItmModel.h
//  COButton
//
//  Created by liaowh on 16/6/2.
//  Copyright © 2016年 comv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KLHomeItmModel : NSObject

@property (nonatomic, assign) CGSize itmSize;
@property (nonatomic, copy) NSString *itmTitle;
@property (nonatomic, strong) UIImage *itmImage;
@property (nonatomic, assign) NSInteger patientCount;

+ (NSMutableArray *)getInitHomeItms;

@end
