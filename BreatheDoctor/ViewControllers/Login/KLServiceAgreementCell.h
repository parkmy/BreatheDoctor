//
//  KLServiceAgreementCell.h
//  BreatheDoctor
//
//  Created by comv on 16/5/18.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KLServiceAgreementModel;

@interface KLServiceAgreementCell : UITableViewCell

@property (nonatomic, strong) UILabel *agTitleLabel;
@property (nonatomic, strong) UILabel *agContentLabel;

@property (nonatomic, strong) KLServiceAgreementModel *model;
@end
