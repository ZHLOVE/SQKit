//
//  ViewController.m
//  gif图加载
//
//  Created by Qian Shen on 2017/3/8.
//  Copyright © 2017年 Qian Shen. All rights reserved.
//

#import "ViewController.h"
#import "CADisplayLineImageView.h"
@interface ViewController ()

/**gif图*/
@property (nonatomic, strong) CADisplayLineImageView *displayImageView;

@property (nonatomic, strong)dispatch_source_t time;

/**跳过*/
@property (nonatomic, strong) UIButton *btn;



@end

@implementation ViewController
{
    
}
NSInteger count = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadCADisplayLineImageView];
    
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn.frame = CGRectMake(0, 64, 300, 30);
    [_btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn];
    
    [self start];
    
    
}

- (void)start{
    //获得队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    //创建一个定时器
    
    self.time = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //设置开始时间
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC));
    //设置时间间隔
    uint64_t interval = (uint64_t)(1.0* NSEC_PER_SEC);
    //设置定时器
    dispatch_source_set_timer(self.time, start, interval, 0);
    //设置回调
    dispatch_source_set_event_handler(self.time, ^{
        count++;
        NSLog(@"------");
        // 主线程执行
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *text = [NSString stringWithFormat:@"%zd - s",count];
            [_btn setTitle:text forState:UIControlStateNormal];
        });
        if(count == 10){
            [self cancel];
        }
    });
    //启动定时器
    dispatch_resume(self.time);
}

-(void)click{
    [self cancel];
}

-(void)cancel{
    dispatch_cancel(self.time);
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:1.5 animations:^{
            _displayImageView.alpha = 0;
            _btn.alpha = 0;
        }completion:^(BOOL finished) {
            [_displayImageView removeFromSuperview];
            _displayImageView = nil;
            
            [_btn removeFromSuperview];
            _btn = nil;
        }];
    });
}

- (IBAction)start:(id)sender{
    [self start];
}

-(IBAction)stop:(id)sender{
    [self cancel];
}


-(void)loadCADisplayLineImageView
{
    _displayImageView = [[CADisplayLineImageView alloc] initWithFrame:self.view.bounds];
    [_displayImageView setCenter:self.view.center];
    [self.view addSubview:_displayImageView];
    [_displayImageView setImage:[CADisplayLineImage imageNamed:@"image2.jpg"]];
    
}


@end
