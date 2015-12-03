//
//  LWPatientRemarksIconCell.h
//  BreatheDoctor
//
//  Created by comv on 15/11/11.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWPatientRemarksIconCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *patienticon;
@property (weak, nonatomic) IBOutlet UILabel *patientNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *typeWidth;

@property (nonatomic, strong) LWPatientRows *patient;

@end
