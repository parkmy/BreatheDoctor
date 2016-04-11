//
//  KLDatePickNumberView.h
//  COButton
//
//  Created by comv on 16/3/30.
//  Copyright © 2016年 comv. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KLDatePickNumberView;

@protocol KLDatePickNumberViewDataSource <NSObject>

@required
- (UIView *)datePickNumberView:(KLDatePickNumberView *)datePickNumberView
         cellForRowAtIndexPath:(NSInteger)index;

@end

@protocol KLDatePickNumberViewDelegate <NSObject>
- (NSInteger)numberDatePickNumberView:(KLDatePickNumberView *)datePickNumberView;

- (void)datePickNumberView:(KLDatePickNumberView *)datePickNumberView
    didScrollToPageAtIndex:(NSInteger)index;

@end


@interface KLDatePickNumberView : UIView

@property (nonatomic, copy) NSString *period;
@property (nonatomic, weak) id<KLDatePickNumberViewDelegate>delegate;
@property (nonatomic, weak) id<KLDatePickNumberViewDataSource>dataSource;
- (void)moveIndexCountInfo:(NSInteger)index;
- (void)reloadData;

@end
