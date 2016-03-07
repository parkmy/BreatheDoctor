//
//  LWDetailedOrderListModel.h
//  BreatheDoctor
//
//  Created by comv on 16/3/1.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LWDetailedOrderListModel : NSObject

@property (nonatomic, copy) NSString *quantity;
@property (nonatomic, copy) NSString *accountPaid;
@property (nonatomic, copy) NSString *patientName;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSString *fullName;
@property (nonatomic, copy) NSString *createDt;

- (id)initWithDetailedOrderlistModelDic:(NSDictionary *)dic;
@end
