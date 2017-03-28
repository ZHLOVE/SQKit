//
//  ViewController.m
//  网络加载失败时的提示视图
//
//  Created by Qian Shen on 2017/3/4.
//  Copyright © 2017年 Qian Shen. All rights reserved.
//

#import "ViewController.h"
#import "NetErrorView.h"

@interface ViewController ()<NetErrorViewDelegate>

@property(nonatomic,strong)NetErrorView *netErrorView;


/**三次消失*/
@property (nonatomic, assign) NSInteger num;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _num = 0;
    [self.view addSubview:self.netErrorView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.netErrorView stopNetViewLoadingFail:NO error:YES];
    });
}


- (void)reloadDataNetErrorView:(NetErrorView *)errorView{
    _num += 1;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.netErrorView stopNetViewLoadingFail:YES error:NO];
    });
    
    if (!(_num % 4)) {
        [self.netErrorView stopNetViewLoadingFail:NO error:NO];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NetErrorView *)netErrorView{
    if (!_netErrorView) {
        _netErrorView = [[NetErrorView alloc]initWithFrame:self.view.bounds];
        _netErrorView.delegate = self;
    }
    return _netErrorView;
}


@end
