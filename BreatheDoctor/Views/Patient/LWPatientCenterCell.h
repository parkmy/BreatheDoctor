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
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *patientNameWidth;
@property (weak, nonatomic) IBOutlet UIButton *patientTypeButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *typeWidth;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *patientDataLabels;

@property (nonatomic, strong) LWPatientRecordsBaseModel *patientRecordsModel;
//@property (nonatomic, strong) LWPatientRows *patient;
@end
