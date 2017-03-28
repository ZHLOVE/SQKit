//
//  UTHomeCommomController.m
//  tabBarCustomDemo
//
//  Created by xiongdexi on 16/8/31.
//  Copyright © 2016年 UTSFOT. All rights reserved.
//

#import "UTHomeCommomController.h"


@interface UTHomeCommomController ()

@end

@implementation UTHomeCommomController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
    
    UIButton *backBtn = [[UIButton alloc] init];
    backBtn.frame = CGRectMake(self.view.center.x - 20, self.view.center.y, 50, 30);
    [backBtn setTitle:@"返回主页" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [backBtn sizeToFit];
    [backBtn addTarget:self action:@selector(didClickBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发起页面" style:UIBarButtonItemStylePlain target:self action:@selector(didClickItem)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)didClickBtn {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didClickItem {
    NSLog(@"点击了发起页面按钮");
    //UTOtherViewController *otherVc = [[UTOtherViewController alloc] init];
    //[self.navigationController pushViewController:otherVc animated:YES];
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
