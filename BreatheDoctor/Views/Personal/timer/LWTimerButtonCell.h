//
//  LWTimerButtonCell.h
//  BreatheDoctor
//
//  Created by comv on 15/12/31.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWTimerButtonCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *starLabel;
@property (weak, nonatomic) IBOutlet UILabel *endLabel;
@property (weak, nonatomic) IBOutlet UILabel *weekslabel;
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *whs;
@property (nonatomic, copy) void(^tapMoreButtonBlock)(UILabel *weeksLabel);
@property (nonatomic, copy) void(^tapStarButtonBlock)(UILabel *starLabel);
@property (nonatomic, copy) void(^tapEndButtonBlock)(UILabel *endLabel);
@property (weak, nonatomic) IBOutlet UILabel *indexLabel;

@end

