//
//  UIView+BorderLine.h
//  COButton
//
//  Created by comv on 15/10/31.
//  Copyright © 2015年 comv. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+TKGeometry.h"

typedef NS_ENUM(NSInteger, LBordeLineType) {
    LBordeLineLEFT              = 1,
    LBordeLineTOP               = 1 << 1,
    LBordeLineDOWN              = 1 << 2,
    LBordeLineRIGHT             = 1 << 3,
};
@interface UIView (BorderLine)

- (void)bordeLineType:(LBordeLineType)type boedeClolor:(UIColor *)color; //边框

- (void)byRoundingCorners:(UIRectCorner)corners withSize:(CGSize)size; //边角

@end
