//
//  ViewController.m
//  自定义TabBar控制器
//
//  Created by Qian Shen on 2017/3/9.
//  Copyright © 2017年 Qian Shen. All rights reserved.
//

#import "ViewController.h"
#import "UTTabBarCommonController.h"
#import "UTTabBarSpecialController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)clickOrdinaryBtn {
    UTTabBarCommonController *commonTabBarVc = [[UTTabBarCommonController alloc] init];
    
    [self presentViewController:commonTabBarVc animated:YES completion:nil];
}

- (IBAction)clickSpecialBtn {
    UTTabBarSpecialController *specialTabBarVc = [[UTTabBarSpecialController alloc] init];
    
    [self presentViewController:specialTabBarVc animated:YES completion:nil];
}


@end
