//
//  ViewController.m
//  自定义倒计时分秒
//
//  Created by Qian Shen on 2017/3/13.
//  Copyright © 2017年 Qian Shen. All rights reserved.
//

#import "ViewController.h"
#import "TXCountdownView.h"

@interface ViewController ()


/**倒计时View*/
@property (nonatomic, strong) TXCountdownView *countdownView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.countdownView];
    [self.countdownView startTimeCompleteBlock:^{
        self.countdownView.descLabel.text = @"活动结束了";
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


-(TXCountdownView *)countdownView {
    if (!_countdownView) {
        _countdownView = [[TXCountdownView alloc]initWithAllReverseTime:0];
        _countdownView.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 44);
    }
    return _countdownView;
}


@end
