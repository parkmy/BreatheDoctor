//
//  KLLoginTextBoxModel.h
//  BreatheDoctor
//
//  Created by comv on 16/5/17.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KLLoginTextFieldBox.h"

@interface KLLoginTextBoxModel : NSObject

/**
 *  新建输入框
 *
 *  @param type    类型
 *  @param content 内容
 *
 *  @return 输入框
 */
+ (KLLoginTextFieldBox *)createBoxFieldTheType:(FIELDTYPE)type
                                    theContent:(NSString *)content
                                    theFiedTag:(NSInteger)tag
                                   theDelegate:(id)delegate;


@end
