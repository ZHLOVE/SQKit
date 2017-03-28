//
//  UTPushViewController.m
//  tabBarCustomDemo
//
//  Created by xiongdexi on 16/9/1.
//  Copyright © 2016年 UTSFOT. All rights reserved.
//

#import "UTPushViewController.h"

@interface UTPushViewController ()

@end

@implementation UTPushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"发布";
    self.view.backgroundColor = [UIColor redColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消发布" style:UIBarButtonItemStylePlain target:self action:@selector(didClickLeftItem)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)didClickLeftItem {
    NSLog(@"点击了取消发布按钮");
    [self dismissViewControllerAnimated:YES completion:nil];
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
