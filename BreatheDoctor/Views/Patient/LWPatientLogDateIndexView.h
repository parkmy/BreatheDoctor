//
//  LWPatientLogDateIndexView.h
//  BreatheDoctor
//
//  Created by comv on 15/11/22.
//  Copyright © 2015年 lwh. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LWPatientLogDateIndexViewDeleagte <NSObject>

@optional
- (void)indexDateChnageLeftDate:(NSString *)leftdate RightDate:(NSString *)rightdate;
@end

@interface LWPatientLogDateIndexView : UIView

@property (nonatomic, weak) id<LWPatientLogDateIndexViewDeleagte>delegate;
- (id)initWithFrame:(CGRect)frame WithDelegate:(id)delegate withRefDateDic:(NSDictionary *)dic;

@end
