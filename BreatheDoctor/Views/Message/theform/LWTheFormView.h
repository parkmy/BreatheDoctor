//
//  LWTheFormView.h
//  BreatheDoctor
//
//  Created by comv on 15/12/30.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWTheFormTypeView.h"

@interface LWTheFormView : UIView

@property (nonatomic, copy)  NSString *title;
@property (nonatomic, assign) BOOL isMulti;
- (void)setTypes:(NSMutableArray *)array andShowType:(showTheFormType)type;

@end
