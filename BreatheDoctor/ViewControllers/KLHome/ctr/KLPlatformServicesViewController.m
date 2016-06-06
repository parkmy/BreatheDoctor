//
//  KLPlatformServicesViewController.m
//  BreatheDoctor
//
//  Created by liaowh on 16/6/6.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLPlatformServicesViewController.h"
#import "KLGuideModel.h"

@interface KLPlatformServicesViewController ()

@end

@implementation KLPlatformServicesViewController

- (void)setupWithTableStyle:(UITableViewStyle)style{
    
    [super setupWithTableStyle:style];
    
    self.dataArray = [KLGuideModel getInitGuidePlatformServicesModels];
}


@end
