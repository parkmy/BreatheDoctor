//
//  LWMedicationLogCountCell.h
//  BreatheDoctor
//
//  Created by comv on 15/11/26.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWMedicationLogCountCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *controlCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *emergencyCountLabel;

- (void)reloadData;
@end
