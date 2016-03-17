//
//  LWSymptomsButton.m
//  BreatheDoctor
//
//  Created by comv on 16/3/17.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "LWSymptomsButton.h"

@implementation LWSymptomsButton

-(void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat mr = (self.height - (self.imageView.height+self.titleLabel.height))/2;

    // Center image
    CGPoint center = self.imageView.center;
    center.x = self.frame.size.width/2;
    center.y = self.imageView.frame.size.height/2 + mr;
    self.imageView.center = center;
    
    //Center text
    CGRect newFrame = [self titleLabel].frame;
    newFrame.origin.x = 0;
    newFrame.origin.y = self.imageView.frame.size.height + 5 + mr;
    newFrame.size.width = self.frame.size.width;
    
    
    
    
    self.titleLabel.frame = newFrame;
    self.titleLabel.textAlignment = 1;
}

@end
