//
//  LWTimerRemindIndexView.h
//  BreatheDoctor
//
//  Created by comv on 15/12/31.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LWTimerRemindIndexViewDeleagte <NSObject>

@optional
- (void)indexDateChnagecenterLabelDate:(NSInteger )index;
@end


@interface LWTimerRemindIndexView : UIView
@property (nonatomic, weak) id<LWTimerRemindIndexViewDeleagte>delegate;

- (id)initWithFrame:(CGRect)frame WithDelegate:(id)delegate;

@end
