//
//  WXCustomAnimation.m
//  WXCustomNavAnimationDemo
//
//  Created by wx on 2018/9/29.
//  Copyright © 2018年 wx. All rights reserved.
//

#import "WXCustomPushAnimation.h"

@implementation WXCustomPushAnimation
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.5;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView* toView = nil;
    UIView* fromView = nil;
    
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    } else {
        fromView = fromViewController.view;
        toView = toViewController.view;
    }
    
    [[transitionContext containerView] addSubview:toView];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    toView.frame = CGRectMake(width, 0, width, height);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        toView.frame = CGRectMake(0, 0, width, height);
        fromView.frame = CGRectMake(0, 40, width, height - 80);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
    
}
@end

@implementation WXCustomPopAnimation
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.7;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView* toView = nil;
    UIView* fromView = nil;
    
    
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    } else {
        fromView = fromViewController.view;
        toView = toViewController.view;
    }
    
    [[transitionContext containerView] insertSubview:toView belowSubview:fromView];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    fromView.frame = CGRectMake(0, 0, width, height);
    toView.frame = CGRectMake(0, 40, width, height - 80);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        fromView.frame = CGRectMake(width, 0, width, height);
        toView.frame = CGRectMake(0, 0, width, height);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}
@end
