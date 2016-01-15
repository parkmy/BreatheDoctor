//
//  LWPersonalMenuButton.h
//  BreatheDoctor
//
//  Created by comv on 16/1/11.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger , tapType) {
    tapTypeRecoverytime = 0, //TIMER 时间
    tapTypePurchaseRecords ,//TIMER 购买记录
    tapTypeMoreSettings,//TIMER 更多设置
    tapTypeStayTunedFor,//TIMER 敬请期待
};

@interface LWPersonalMenuButton : UIButton

@property (nonatomic, assign) tapType tapType;

@end
