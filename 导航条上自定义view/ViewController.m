//
//  ViewController.m
//  导航条上自定义view
//
//  Created by Qian Shen on 2017/3/8.
//  Copyright © 2017年 Qian Shen. All rights reserved.
//

#import "ViewController.h"
#import "HomeTitleView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HomeTitleView *titleView = [HomeTitleView setUpTitleView];
    [titleView .titleBtn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    titleView.backgroundColor = [UIColor redColor];
    titleView.bounds = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 100, 40);
    self.navigationItem.titleView = titleView;
}

- (void)click{
    NSLog(@"----");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
