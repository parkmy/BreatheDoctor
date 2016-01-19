//
//  LWTheFormTypeView.h
//  BreatheDoctor
//
//  Created by comv on 15/12/30.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LWTheFormTypeView;

@interface LWTheFormTypeViewItm : UIView
@property (nonatomic, strong) UILabel *itmLabel;
@property (nonatomic, strong) UIButton *seleButton;

- (id)initWithFrame:(CGRect)frame withType:(showTheFormType)type;
@end



@interface LWTheFormTypeView : UIView
@property (nonatomic, strong) NSMutableArray *types;
@property (nonatomic, assign) showTheFormType showType;
@end
