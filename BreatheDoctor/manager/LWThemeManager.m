
//
//  LWThemeManager.m
//  BreatheDoctor
//
//  Created by comv on 15/12/30.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWThemeManager.h"

@implementation LWThemeManager

+ (LWThemeManager *)shareInstance
{
    static dispatch_once_t onceToken;
    static LWThemeManager *manager = nil;
    dispatch_once(&onceToken, ^{
        manager = [[LWThemeManager alloc] init];
    });
    return manager;
}

- (void)setThemeType:(themeType)themeType
{
    _themeType = themeType;
    
    switch (_themeType) {
        case themeTypeDefault:
            self.navBackgroundColor = [UIColor colorWithHexString:@"#9cc75e"];
            self.vcBackgroundColor = [UIColor colorWithRed:244/255.0f green:244/255.0f blue:244/255.0f alpha:1.0f];
            break;
            
        default:
            break;
    }    
}



@end
