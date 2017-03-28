//
//  OneViewController.m
//  iOS开发常见技术-每日一记
//
//  Created by Qian Shen on 2017/3/4.
//  Copyright © 2017年 Qian Shen. All rights reserved.
//

#import "OneViewController.h"
#import "AppDelegate.h"

@interface OneViewController ()

{
    BOOL _isOpen;
}

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [delegate.rootVc setPanEnabled:NO];
    
    NSLog(@"-----------%zd",self.navigationController.viewControllers.count);
    self.view.tag = 1000;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)click:(id)sender{
    _isOpen = YES;
    AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    if (!_isOpen) {
       
    }else{
        [delegate.rootVc openLeftView];
    }
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
