//
//  LWMessageAgreedCell.h
//  BreatheDoctor
//
//  Created by comv on 16/1/4.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWMessageAgreedCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *leftbutton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;

@property (nonatomic, copy) void(^TongYiBlock)();
@property (nonatomic, copy) void(^JuJueBlock)();

@end
