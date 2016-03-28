//
//  KLStateModel.m
//  BreatheDoctor
//
//  Created by comv on 16/3/27.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLStateModel.h"

@implementation KLStateModel

- (void)setTitle:(NSString *)title{
    
    _title = title;
    CGSize size = [stringJudgeNull(_title) sizeWithFont:kNSPXFONT(28) constrainedToHeight:20*MULTIPLEVIEW];
    self.itmSize = CGSizeMake(size.width+15, 20*MULTIPLEVIEW);
}

@end
