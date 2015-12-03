//
//  LWYerChangIndexView.h
//  DrawTool
//
//  Created by comv on 15/11/27.
//  Copyright © 2015年 li_yong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LWYerChangIndexViewDeleagte <NSObject>

@optional
- (void)indexDateChnagecenterLabelDate:(NSDate *)date;
@end

@interface LWYerChangIndexView : UIView
@property (nonatomic, weak) id<LWYerChangIndexViewDeleagte>delegate;

- (id)initWithFrame:(CGRect)frame WithDelegate:(id)delegate;
@end
