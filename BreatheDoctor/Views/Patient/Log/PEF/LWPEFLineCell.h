//
//  LWPEFLineCell.h
//  BreatheDoctor
//
//  Created by comv on 15/11/25.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawView.h"

@interface LWPEFLineCell : UITableViewCell
@property (nonatomic, strong) LWPEFLineModel *model;
@property (weak, nonatomic) IBOutlet DrawView *PEFLineView;

- (void)changeTimerMonth:(NSString *)star end:(NSString *)end;
- (void)changeYnumbers:(double)pefPredictedValue;

@end
