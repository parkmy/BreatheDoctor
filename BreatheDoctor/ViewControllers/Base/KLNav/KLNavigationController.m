//
//  KLNavigationController.m
//  COButton
//
//  Created by comv on 16/5/17.
//  Copyright © 2016年 comv. All rights reserved.
//

#import "KLNavigationController.h"

@interface KLNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation KLNavigationController

- (id)init{
    
    if (self = [super init]) {
        
        _maxAllowedDistance = [UIScreen mainScreen].bounds.size.width;
    }
    return self;
}

- (void)loadView{

    [super loadView];
    
    self.navigationBarHidden = true;
    
    [self registPanGestureRecognizer];
}

- (void)registPanGestureRecognizer{

    id target = self.interactivePopGestureRecognizer.delegate;
    
    SEL internalAction = NSSelectorFromString(@"handleNavigationTransition:");
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:target action:internalAction];
    panGesture.delegate = self;
    panGesture.maximumNumberOfTouches = 1;
    [self.view addGestureRecognizer:panGesture];
    
    self.interactivePopGestureRecognizer.enabled = true;
}

#pragma mark - Delegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    
    if (!self.interactivePopGestureRecognizer.enabled) {
        
        return false;
    }
    
    CGPoint beginningLocation = [gestureRecognizer locationInView:gestureRecognizer.view];
    CGFloat maxAllowedInitialDistance = self.maxAllowedDistance;
    if (maxAllowedInitialDistance > 0 && beginningLocation.x > maxAllowedInitialDistance) {
        return NO;
    }
    if (self.childViewControllers.count == 1) {
        return NO;
    }
    if ([[self valueForKey:@"_isTransitioning"] boolValue]) {
        return NO;
    }
    return YES;
}


@end
