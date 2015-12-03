//
//  LWPEFCountCell.h
//  BreatheDoctor
//
//  Created by comv on 15/11/25.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWPEFCountCell : UITableViewCell
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *contentLabels;
@property (nonatomic, strong) LWPEFLineModel *model;
@end
