//
//  LWPatientCenterCell.h
//  BreatheDoctor
//
//  Created by comv on 15/11/10.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWPatientCenterCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *patientIcon;
@property (weak, nonatomic) IBOutlet UILabel *patientNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *patientLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *typeWidth;

@property (nonatomic, strong) LWPatientRows *patient;
@end
