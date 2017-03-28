//
//  ViewController.m
//  通过RunTime将模型转为字典
//
//  Created by Qian Shen on 2017/3/10.
//  Copyright © 2017年 Qian Shen. All rights reserved.
//

#import "ViewController.h"
#import "userModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    userModel *model = [userModel shareduserModel];
    model.name = @"沈钱";
    model.height = @"174";
    model.weight = @"64kg";
    model.age = 21;
    
    NSLog(@"%@-----",model);
    
    NSDictionary *modelDict = [model modelToDict];
    
    NSLog(@"%@",modelDict);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
