//
//  KLPatientLisetCell.h
//  BreatheDoctor
//
//  Created by comv on 16/4/22.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KLPatientOperation.h"

@interface KLPatientLisetCell : UITableViewCell

@property (nonatomic, strong) id model;
@property (nonatomic, assign) LISTTYPE type;
@end
