//
//  LWReservationHeardCell.h
//  BreatheDoctor
//
//  Created by comv on 16/2/25.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger ,ProductType) {
    ProductTypeProductOrder  = 1,
    ProductTypeGraphicOrder = 2,
    ProductTypePhoneOrder   = 3,
};
@interface LWOrderDetailedLisetCell : UITableViewCell
@property (nonatomic, strong) id model;
@property (nonatomic, assign) ProductType productType;

@end
