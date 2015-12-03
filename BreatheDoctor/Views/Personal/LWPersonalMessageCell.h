//
//  LWPersonalMessageCell.h
//  BreatheDoctor
//
//  Created by comv on 15/11/11.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWPersonalMessageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *messageHight;
@property (weak, nonatomic) IBOutlet UILabel *M_titleLabel;
@property (nonatomic, strong) LWPatientRecordsBaseModel *model;

- (void)setMessage:(NSString *)message;

@end
