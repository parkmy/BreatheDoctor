//
//  LWMedicationLogTimerCell.h
//  BreatheDoctor
//
//  Created by comv on 15/11/26.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWMedicationModel.h"

@interface LWMedicationLogTimerCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *morningCtrLabel;
@property (weak, nonatomic) IBOutlet UILabel *morningMergencyLabel;
@property (weak, nonatomic) IBOutlet UILabel *afternoonCtrLabel;
@property (weak, nonatomic) IBOutlet UILabel *afternoonEmergencyLabel;
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *heights;
@property (nonatomic, strong) LWMedicationModel *model;
@end
