//
//  ViewController+WX_CustomPopPushAnimation.m
//  WXCustomNavAnimationDemo
//
//  Created by wx on 2018/9/29.
//  Copyright © 2018年 wx. All rights reserved.
//

#import "UIViewController+WX_CustomPopPushAnimation.h"
#import "WXCustomPushAnimation.h"
#import <objc/runtime.h>

@interface panDelegate : NSObject<UINavigationControllerDelegate>
+(instancetype)shareInstance;
@property (nonatomic,strong) UIView *view;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactiveTransition;
@property (nonatomic,strong) UINavigationController *navigationController;
@end

static panDelegate *instance = nil;

@implementation panDelegate

+(instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[panDelegate alloc] init];
    });
    return instance;
}

- (void)panGestureRecognizerAction:(UIPanGestureRecognizer *)pan{
    
    //产生百分比
    CGFloat process = [pan translationInView:self.view].x / ([UIScreen mainScreen].bounds.size.width);
    
    process = MIN(1.0,(MAX(0.0, process)));
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        self.interactiveTransition = [UIPercentDrivenInteractiveTransition new];
        //触发pop转场动画
        [self.navigationController popViewControllerAnimated:YES];
        
    }else if (pan.state == UIGestureRecognizerStateChanged){
        [self.interactiveTransition updateInteractiveTransition:process];
    }else if (pan.state == UIGestureRecognizerStateEnded
              || pan.state == UIGestureRecognizerStateCancelled){
        if (process > 0.2) {
            [ self.interactiveTransition finishInteractiveTransition];
        }else{
            [ self.interactiveTransition cancelInteractiveTransition];
        }
        self.interactiveTransition = nil;
    }
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    if ([animationController isKindOfClass:[WXCustomPopAnimation class]]) {
        return [panDelegate shareInstance].interactiveTransition;
    }
    
    return nil;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    
    if (operation == UINavigationControllerOperationPush) {
        return [[WXCustomPushAnimation alloc] init];
    }
    
    if (operation == UINavigationControllerOperationPop) {
        return [[WXCustomPopAnimation alloc] init];
    }
    
    return nil;
}

@end

@implementation UIViewController (WX_CustomPopPushAnimation)

+ (void)load
{
    Method originalMethod = class_getInstanceMethod(self, @selector(viewDidLoad));
    Method swizzledMethod = class_getInstanceMethod(self, @selector(wx_viewDidLoad));
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

-(void)wx_viewDidLoad{
    [self wx_viewDidLoad];
    [self addCustomPushPopAnimation];
}

-(void)addCustomPushPopAnimation
{
    [panDelegate shareInstance].view = self.view;
    [panDelegate shareInstance].navigationController = self.navigationController;
    self.navigationController.delegate = [panDelegate shareInstance];
    //添加手势
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] init];
    [pan addTarget:[panDelegate shareInstance] action:@selector(panGestureRecognizerAction:)];
    [self.view addGestureRecognizer:pan];
}

@end
