//
//  KLRegistPublicFootView.h
//  BreatheDoctor
//
//  Created by comv on 16/5/18.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,RegistPublicType) {

    RegistPublicTypeDef     = 0,
    RegistPublicTypeForget  = 1,
};
@interface KLRegistPublicFootView : UIView

@property (nonatomic, assign) RegistPublicType registPublicType;

@property (nonatomic, copy) void(^nextButtonClickBlock)();
@property (nonatomic, copy) void(^pushAgreementClickBlock)();

@end
