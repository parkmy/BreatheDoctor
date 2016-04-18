//
//  LWPatientCell.h
//  BreatheDoctor
//
//  Created by comv on 15/11/10.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KLPatientListModel;

@interface LWPatientCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *patientIcon;
@property (weak, nonatomic) IBOutlet UILabel *patientNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *patientTypeLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *typeWith;

@property (nonatomic, strong) KLPatientListModel *patient;

@end
