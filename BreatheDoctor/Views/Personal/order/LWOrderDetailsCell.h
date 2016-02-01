//
//  LWOrderDetailsCell.h
//  BreatheDoctor
//
//  Created by comv on 15/12/31.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWOrderDetailsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *labelWidths;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *Labels;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *lins;

@end
