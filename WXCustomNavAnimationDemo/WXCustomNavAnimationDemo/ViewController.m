//
//  ViewController.m
//  WXCustomNavAnimationDemo
//
//  Created by wx on 2018/9/29.
//  Copyright © 2018年 wx. All rights reserved.
//

#import "ViewController.h"
#import "ThirdViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationController.navigationBarHidden = YES;
//    self.navigationItem.title = @"我是首页";
    
    self.view.backgroundColor = [UIColor redColor];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = 40;
    
    UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(20, 100, width-40, height);
    [btn1 setTitle:@"自定义Push" forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor orangeColor];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.view addSubview:btn1];
    [btn1 addTarget:self action:@selector(btn1Action) forControlEvents:UIControlEventTouchUpInside];
}


- (void)btn1Action{
    ThirdViewController *thirdVC = [ThirdViewController new];
    [self.navigationController pushViewController:thirdVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
