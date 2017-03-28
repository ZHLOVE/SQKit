//
//  ViewController.m
//  第三方分页控制器
//
//  Created by Qian Shen on 2017/3/7.
//  Copyright © 2017年 Qian Shen. All rights reserved.
//

#import "ViewController.h"
#import "TAPageControl.h"
#import "SMPageControl.h"

@interface ViewController ()

@property (nonatomic, strong) TAPageControl *pageControl;

@property (nonatomic, strong) SMPageControl *pageCt1;

@property (nonatomic, strong) SMPageControl *pageCt2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.pageCt1];
    [self.view addSubview:self.pageCt2];
}


- (TAPageControl *)pageControl {
    if (!_pageControl) {
        //_pageControl = [[TAPageControl alloc]init];
        _pageControl.backgroundColor = [UIColor redColor];
        _pageControl.currentDotImage = [UIImage imageNamed:@"pageControlCurrentDot@2x"];
        _pageControl.dotImage = [UIImage imageNamed:@"pageControlDot@2x"];
        _pageControl.currentPage = 0;
        _pageControl.numberOfPages  = 5;
    }
    return _pageControl;
}

- (SMPageControl *)pageCt1 {
    if (!_pageCt1) {
        _pageCt1 = [[SMPageControl alloc]initWithFrame:CGRectMake(100, 100, 100, 30)];
        _pageCt1.backgroundColor = [UIColor redColor];
        _pageCt1.numberOfPages = 3;
        // 间距
        _pageCt1.indicatorMargin = 10;
        _pageCt1.currentPageIndicatorTintColor = [UIColor yellowColor];
        _pageCt1.pageIndicatorTintColor = [UIColor blueColor];
        
        _pageCt1.currentPage = 0;
    }
    return _pageCt1;
}


- (SMPageControl *)pageCt2{
    if (!_pageCt2) {
        _pageCt2 = [[SMPageControl alloc]initWithFrame:CGRectMake(100, CGRectGetMaxY(self.pageCt1.frame) + 20, 100, 30)];
        _pageCt2.backgroundColor = [UIColor redColor];
        _pageCt2.numberOfPages = 3;
        // 间距
        _pageCt2.indicatorMargin = 10;
        _pageCt2.currentPageIndicatorImage = [UIImage imageNamed:@"pageControlCurrentDot@2x"];
        _pageCt2.pageIndicatorImage = [UIImage imageNamed:@"pageControlDot@2x"];
        _pageCt2.currentPage = 0;
    }
    return _pageCt2;
}

@end
