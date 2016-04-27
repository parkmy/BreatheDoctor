//
//  KLPromptViewManager.h
//  BreatheDoctor
//
//  Created by comv on 16/4/19.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^HiddenBlock)();

@interface KLPromptViewManager : NSObject

+ (KLPromptViewManager *)shareInstance;

- (void)kl_showPromptViewWithTitle:(NSString *)title
                        theContent:(NSString *)content;
- (void)kl_showPromptViewWithTitle:(NSString *)title
                        theContent:(NSString *)content
                    theHiddenBlock:(HiddenBlock)hiddenSuccBlock;
@end
