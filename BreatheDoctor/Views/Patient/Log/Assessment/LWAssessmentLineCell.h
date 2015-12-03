//
//  LWAssessmentLineCell.h
//  BreatheDoctor
//
//  Created by comv on 15/11/27.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWDrawView.h"

@interface LWAssessmentLineCell : UITableViewCell
@property (weak, nonatomic) IBOutlet LWDrawView *ACTlineView;
@property (nonatomic, strong) LWAsthmaAssessLogModel *model;
- (void)changeTimerDate:(NSDate *)date;

@end
