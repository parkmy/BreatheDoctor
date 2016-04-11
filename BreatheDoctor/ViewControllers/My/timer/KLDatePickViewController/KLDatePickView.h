//
//  KLDatePickView.h
//  COButton
//
//  Created by comv on 16/3/31.
//  Copyright © 2016年 comv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KLDatePickView : UIView

- (void)setDateCount:(NSInteger)indexCount;
- (void)refDateCount:(NSInteger)index;
- (void)setDatePeriodInfo:(NSString *)period;
- (NSString *)seleIndexString;
@end
