//
//  ViewController.m
//  设置导航栏为透明
//
//  Created by Qian Shen on 2017/3/4.
//  Copyright © 2017年 Qian Shen. All rights reserved.
//

#import "ViewController.h"
#import "DetalViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor redColor];
    
    NSLog(@"-------%zd",self.navigationController.viewControllers.count);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)click:(id)sender {
    
    DetalViewController *vc = [DetalViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}


/**
 * 设置导航栏
 */
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
 
    
    self.navigationController.navigationBar.subviews.firstObject.alpha = 0;
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
   
    
    
    UIImage *img = [UIImage imageNamed:@"返回白色"];
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.navigationController.navigationBar setBackIndicatorImage:img];
    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:img];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回白色"] style:UIBarButtonItemStylePlain target:nil action:nil];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.subviews.firstObject.alpha = 1;
    
    
    
//    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"redTheme"]) {
//        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent]; // 状态栏设置为白色
//    } else {
//        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault]; // 状态栏设置为黑色
//    }
    // 取消收藏并返回收藏夹时 刷新数据
//    if (self.backBlock && self.lovedSelected == NO) {
//        self.backBlock();
//    }
}



@end
