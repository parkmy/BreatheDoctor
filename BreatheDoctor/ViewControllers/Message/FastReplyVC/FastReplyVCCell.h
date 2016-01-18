//
//  FastReplyVCCell.h
//  ComveeDoctor
//
//  Created by JYL on 14-10-11.
//  Copyright (c) 2014年 zhengjw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FastReplyVCCell : UITableViewCell

@property (nonatomic, strong) UILabel * line;
@property (nonatomic, strong) UILabel * detailLable;

+ (CGFloat)calculateMethodWith:(NSString*)string withFont:(int)fonts;
- (void)setDetailTetil:(NSString*)title;

@end
