//
//  LWPersonalHeardCell.m
//  BreatheDoctor
//
//  Created by comv on 15/11/10.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import "LWPersonalHeardCell.h"
#import <UIImageView+WebCache.h>

@implementation LWPersonalHeardCell

- (void)awakeFromNib {
    // Initialization code
    [self.doctorIcon setCornerRadius:self.doctorIcon.width/2];
    self.doctorTypeLabel.backgroundColor = RGBA(0, 0, 0, .3);
    [self.doctorTypeLabel setCornerRadius:self.doctorTypeLabel.height/2];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDoctorIconImage:(NSString *)imageUrl
{
    [self.doctorIcon sd_setImageWithURL:kNSURL(imageUrl) placeholderImage:kImage(@"personalcenter_14.png")];
    
}
- (void)setDoctordoctorName:(NSString *)name
{
    self.doctorNameLabel.text = stringJudgeNull(name);
}
- (void)setDoctorType:(NSString *)type
{
    self.doctorTypeLabel.text = stringJudgeNull(type);
    self.doctorTypeLabel.hidden = NO;
    if (self.doctorTypeLabel.text.length <= 0) {
        self.doctorTypeLabel.hidden = YES;
    }
    CGFloat w = [self.doctorTypeLabel.text sizeWithFont:self.doctorTypeLabel.font constrainedToHeight:20].width + 20;
    self.doctorTypeWidth.constant = w;
    
}

@end
