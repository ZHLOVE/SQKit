//
//  ViewController.m
//  TX定制进度条
//
//  Created by Qian Shen on 2017/3/14.
//  Copyright © 2017年 Qian Shen. All rights reserved.
//

#import "ViewController.h"

#import "TXCustomProgressView.h"

#import "TXAccuracyStarView.h"

@interface ViewController ()<TXAccuracyStarViewDelegate>


/**五星评价*/
@property (nonatomic, strong) TXAccuracyStarView *starBtns;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *titles = @[@"验布验布",@"剪裁",@"缝制剪裁",@"整烫剪裁",@"检验剪裁",@"包装包装"];
    TXCustomProgressView *customProgressView = [[TXCustomProgressView alloc]initWithFrame:CGRectMake(20, 100, [UIScreen mainScreen].bounds.size.width-40, 100) titles:titles];
    customProgressView.customProgressViewColor = [UIColor blueColor];
    customProgressView.currentColor = [UIColor redColor];
    customProgressView.currentIndex = 5;
    customProgressView.currentIndex = 0;
    [self.view addSubview:customProgressView];
    
    [self.view addSubview:self.starBtns];
}

- (void)TXAccuracyStarView:(TXAccuracyStarView *)accuracyStarView clickStarBtn:(UIButton *)starBtn ofIndex:(NSInteger)index{
    NSLog(@"----------%zd",index);
}



- (TXAccuracyStarView *)starBtns {
    if (!_starBtns) {
        _starBtns = [TXAccuracyStarView setupAccuracyStarViewWithFrame:CGRectMake(100, 200, [UIScreen mainScreen].bounds.size.width-280, 44) delegate:self];
    }
    return _starBtns;
}


@end
