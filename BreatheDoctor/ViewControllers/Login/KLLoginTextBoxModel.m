//
//  KLLoginTextBoxModel.m
//  BreatheDoctor
//
//  Created by comv on 16/5/17.
//  Copyright © 2016年 lwh. All rights reserved.
//

#import "KLLoginTextBoxModel.h"

@implementation KLLoginTextBoxModel

+ (KLLoginTextFieldBox *)createBoxFieldTheType:(FIELDTYPE)type
                                    theContent:(NSString *)content
                                    theFiedTag:(NSInteger)tag
                                   theDelegate:(id)delegate{

    KLLoginTextFieldBox *box = [[KLLoginTextFieldBox alloc] initWithType:type];
    box.boxField.tag = tag;
    box.boxField.delegate = delegate;
    
    return box;
}


@end
