//
//  LWPopAlatView.h
//  BreatheDoctor
//
//  Created by comv on 16/1/19.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWPopAlatView : UIView

+ (LWPopAlatView *)sharedPopAlatView;

+ (void)showView:(NSString *)content;

+ (void)dissMiss;

@end
