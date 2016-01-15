//
//  LWTheFormCell.h
//  BreatheDoctor
//
//  Created by comv on 16/1/13.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWTheFormView.h"

@interface LWTheFormCell : UITableViewCell
@property (nonatomic, strong) LWTheFormView *theFormView;

- (void)setModel:(LWTheFromArows *)model withType:(showTheFormType)type;
@end
