//
//  NSMutableArray+Sort.m
//  DiabetesPatient
//
//  Created by Wayne on 16/1/19.
//  Copyright © 2016年 com.comvee. All rights reserved.
//

#import "NSMutableArray+Sort.h"

@implementation NSMutableArray (Sort)

-(void)rewriteAddObject:(id)anObject
{
    if (!anObject) {
        NSLog(@"%@\n--------------------->>>>插入对象为空",self);
        return;
    }
    [self addObject:anObject];
}

- (void)rewriteInsertObject:(id)anObject atIndex:(NSUInteger)index
{
    NSInteger count = self.count;
    if (index > count) {
        NSLog(@"%@\n--------------------->>>>数组越界",self);
        return;
    }
    if (!anObject) {
        NSLog(@"%@\n--------------------->>>>插入对象为空",self);
        return;
    }
    [self insertObject:anObject atIndex:index];
}

- (id)rewriteObjectAtIndex:(NSUInteger)index
{
    if ([self isOutOfArray:index]) {
        return nil;
    }
    return [self objectAtIndex:index];
}

- (void)rewriteRemoveObjectAtIndex:(NSUInteger)index
{
    if ([self isOutOfArray:index]) {
        return;
    }
    [self removeObjectAtIndex:index];
}

- (void)rewriteReplaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject
{
    if ([self isOutOfArray:index]) {
        return;
    }
    if (!anObject) {
        return;
    }
    [self replaceObjectAtIndex:index withObject:anObject];
}


//判断数组是否越界
- (BOOL)isOutOfArray:(NSInteger)index
{
    NSInteger count = self.count;
    if (index >= count) {
        NSLog(@"%@\n--------------------->>>>数组越界",self);
        return YES;
    }else{
        return NO;
    }
}
@end
