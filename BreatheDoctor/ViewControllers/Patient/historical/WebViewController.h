//
//  WebViewController.h
//  WebBrowser
//
//  Created by trendpower on 15/10/8.
//  Copyright © 2015年 Trendpower. All rights reserved.
//

#import "BaseViewController.h"

@interface WebViewController : BaseViewController

@property (nonatomic, copy) NSString * url;

- (void)updateWithUrl:(NSString *)url;

@end
