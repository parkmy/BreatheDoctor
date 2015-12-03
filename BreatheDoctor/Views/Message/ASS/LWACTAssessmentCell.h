//
//  LWACTAssessmentCell.h
//  BreatheDoctor
//
//  Created by comv on 15/11/23.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWACTAssessmentModel.h"

@interface LWACTAssessmentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *problemLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultsLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *problemHight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *resultsHight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineHight;
@property (nonatomic, strong) LWACTAssessmentModel *model;
@end
