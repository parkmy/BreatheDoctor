//
//  NSMutableArray+Sort.h
//  DiabetesPatient
//
//  Created by Wayne on 16/1/19.
//  Copyright © 2016年 com.comvee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Sort)
//加入对数组越界的判断

//添加对象
-(void)rewriteAddObject:(id)anObject;
//在指定位置插入对象
- (void)rewriteInsertObject:(id)anObject atIndex:(NSUInteger)index;
//获取指定位置的对象
- (id)rewriteObjectAtIndex:(NSUInteger)index;
//移除指定位置的对象
- (void)rewriteRemoveObjectAtIndex:(NSUInteger)index;
//替换指定位置的对象
- (void)rewriteReplaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;
@end
