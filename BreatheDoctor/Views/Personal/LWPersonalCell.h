//
//  LWPersonalCell.h
//  BreatheDoctor
//
//  Created by comv on 15/11/10.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWPersonalMenuButton.h"

@interface LWPersonalCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *lefticon;
@property (weak, nonatomic) IBOutlet UILabel *leftmenuTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *rightIcon;
@property (weak, nonatomic) IBOutlet UILabel *rightMenuLabel;
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *whs;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconh;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconw;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *riconw;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *riconh;
@property (weak, nonatomic) IBOutlet LWPersonalMenuButton *leftButton;
@property (weak, nonatomic) IBOutlet LWPersonalMenuButton *rightButton;

@property (nonatomic, copy) void(^personalMenuButtonTapBlock)(tapType tapy);

@end
