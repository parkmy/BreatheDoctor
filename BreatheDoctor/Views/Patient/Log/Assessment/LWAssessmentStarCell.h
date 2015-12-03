//
//  LWAssessmentStarCell.h
//  BreatheDoctor
//
//  Created by comv on 15/11/27.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWAssessmentModel.h"

@interface LWAssessmentStarCell : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *width;
@property (weak, nonatomic) IBOutlet UIImageView *typeImageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeight;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (nonatomic, strong) LWAssessmentModel *model;
@end
