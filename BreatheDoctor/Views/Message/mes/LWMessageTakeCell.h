//
//  LWMessageTakeCell.h
//  BreatheDoctor
//
//  Created by comv on 15/11/10.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LWMessageTakeCellDelegate <NSObject>
@optional
- (void)tapAcceptButtonEventWith:(LWMainRows *)row;
@end

@interface LWMessageTakeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *refuseLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userIcon;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *acceptButton;
@property (nonatomic, weak) id<LWMessageTakeCellDelegate>delegate;
@property (nonatomic, strong) LWMainRows *message;

@end
