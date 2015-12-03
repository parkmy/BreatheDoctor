//
//  LWMedicationLogTimerOneCell.h
//  BreatheDoctor
//
//  Created by comv on 15/11/26.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWMedicationModel.h"

@interface LWMedicationLogTimerOneCell : UITableViewCell
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *heights;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *PeriodTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *ctrLabel;
@property (weak, nonatomic) IBOutlet UILabel *emyLabel;
@property (nonatomic, strong) LWMedicationModel *model;

@end
