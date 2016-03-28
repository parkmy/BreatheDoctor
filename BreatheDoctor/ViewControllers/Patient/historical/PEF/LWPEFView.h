//
//  LWPEFView.h
//  BreatheDoctor
//
//  Created by comv on 16/3/16.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWBaseHistoricalView.h"

@interface LWPEFView : LWBaseHistoricalView

- (void)setLogDateText:(NSString *)string;
- (void)reloadPEFViewData:(KLPatientLogBodyModel *)model;
- (void)setPefDateList:(NSInteger)dateCount;
@end
