//
//  LWAsthmaAssessmentCell.h
//  BreatheDoctor
//
//  Created by comv on 15/11/23.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWAsthmaAssessmentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *starLabels;
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *lineHights;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (nonatomic, strong) LWAsthmaModel *model;
@end
