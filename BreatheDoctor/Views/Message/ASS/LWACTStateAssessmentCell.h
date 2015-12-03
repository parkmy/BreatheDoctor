//
//  LWACTStateAssessmentCell.h
//  BreatheDoctor
//
//  Created by comv on 15/11/23.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWACTStateAssessmentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *actResultsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *starImageView;

- (void)initACTStateAssessmentCelWith:(NSString *)patienNmae actResult:(double)actResult date:(NSString *)date;
//@property (nonatomic, strong) LWACTModel *model;

@end
