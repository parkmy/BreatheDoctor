//
//  LWPersonalHeardCell.h
//  BreatheDoctor
//
//  Created by comv on 15/11/10.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWPersonalHeardCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *doctorIcon;
@property (weak, nonatomic) IBOutlet UILabel *doctorNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *doctorTypeLabel;
- (void)setDoctorIconImage:(NSString *)imageUrl;
- (void)setDoctordoctorName:(NSString *)name;
- (void)setDoctorType:(NSString *)type;

@end
