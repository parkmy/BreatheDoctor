//
//  LWPEFHistorListCell.h
//  BreatheDoctor
//
//  Created by comv on 16/3/15.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWPEFHistorListCell : UITableViewCell
@property (nonatomic, assign) double pefPredictedValue;
- (void)setBackgroundColorWithTag:(int)tag;
- (void)setModel:(id)model;
@end
