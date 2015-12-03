//
//  NSObject+Encodeing.h
//  HMExtents
//
//  Created by yons on 15/7/8.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Encodeing)<NSCoding>

// 反归档
- (void)dencoder:(NSCoder *)decoder;

///归档
-(void)encoder:(NSCoder*)encoder;


@end
