//
//  LWPEFListView.h
//  BreatheDoctor
//
//  Created by comv on 16/3/15.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWPEFListView : UIView
@property (nonatomic, assign) double pefPredictedValue;
- (void)setPefHistorical:(NSMutableArray *)array;
- (void)setLineViewYnumber:(double)pefPredictedValue;
- (void)changePefDateList:(NSInteger)dateCount;
- (void)setItmLineView:(KLPatientLogBodyModel *)body;
@end
