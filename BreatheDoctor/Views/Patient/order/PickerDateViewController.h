//
//  PickerDateViewController.h
//  PickerViewProduct
//
//  Created by SanJin on 16-1-8.
//  Copyright (c) 2016年 SanJin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickerDateViewController : UIViewController

@property (nonatomic, assign) NSString * selectedDate;
@property (nonatomic, copy) void (^selectedBlock) (NSString * selectedDate);

@property (nonatomic, copy) void (^dismissBlock)();

- (void)cancelButtonClick;

@end
