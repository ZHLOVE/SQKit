//
//  ViewController.m
//  SDCycleScrollView的使用
//
//  Created by Qian Shen on 2017/3/7.
//  Copyright © 2017年 Qian Shen. All rights reserved.
//

#import "ViewController.h"
#import "SDCycleScrollView.h"

@interface ViewController ()<SDCycleScrollViewDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *button;

//本地图片实现数组
@property (nonatomic, strong) NSArray *imageNames;

//网络图片实现数组
@property (nonatomic, strong) NSArray *imagesURLStrings;

//图片配文字数组
@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) NSTimer *timer;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //1.初始化数据
    [self initData];
    
    //2.初始化UI
    [self initUI];
    
}

#pragma mark - 初始化数据
- (void)initData{
    
    //本地图片实现数组
    self.imageNames = @[@"h1.jpg",
                        @"h2.jpg",
                        @"h3.jpg",
                        @"h4.jpg",
                        @"h7.png"];
    
    //网络图片实现数组
    self.imagesURLStrings = @[@"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                              @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                              @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"];
    
    //配文字数组
    self.titles = @[@"新建交流QQ群：185534916 ",
                    @"感谢您的支持，如果下载的",
                    @"如果代码在使用过程中出现问题",
                    @"您可以发邮件到gsdios@126.com"];
    
    
}
#pragma mark - 初始化UI
- (void)initUI{
    
    //1.本地加载 --- 创建不带标题的图片轮播器
    //[self demo1];
    
    //2.网络加载 --- 创建带标题的图片轮播器
    [self demo2];
    
    //3.网络加载 --- 创建自定义图片的pageControlDot的图片轮播器
    [self demo3];
    
    //4.网络加载 --- 创建只上下滚动展示文字的轮播器
    [self demo4];
    
    //5.实现电商app上常用的文字上下滚动
    [self demo5];
}

//本地加载 --- 创建不带标题的图片轮播器

-(void)demo1{
    // 本地加载 --- 创建不带标题的图片轮播器
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 180) shouldInfiniteLoop:YES imageNamesGroup:self.imageNames];
    cycleScrollView.delegate = self;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    [self.view addSubview:cycleScrollView];
    cycleScrollView.scrollDirection = UICollectionViewScrollDirectionVertical;
    // 轮播时间间隔，默认1.0秒，可自定义
    cycleScrollView.autoScrollTimeInterval = 4.0;
}

// 网络加载 --- 创建带标题的图片轮播器
-(void)demo2{
 
    
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 210, self.view.bounds.size.width, 180) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder@2x.png"]];
    
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    cycleScrollView2.titlesGroup = self.titles;
    cycleScrollView2.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    // 设置分页控制器的左右位置
    cycleScrollView2.pageControlRightOffset = [UIScreen mainScreen].bounds.size.width  - 100;
    // 设置分页控制器的上下位置
    cycleScrollView2.pageControlBottomOffset = 100;
    // 设置分页控制器的大小 - 无效
    //cycleScrollView2.pageControlDotSize = CGSizeMake(20, 20);
    // 设置分页控制器的颜色
    cycleScrollView2.currentPageDotColor = [UIColor redColor];
    [self.view addSubview:cycleScrollView2];
    cycleScrollView2.delegate = self;
    
    // 模拟加载延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cycleScrollView2.imageURLStringsGroup = self.imagesURLStrings;
    });
    
    
     //block监听点击方式
     
     cycleScrollView2.clickItemOperationBlock = ^(NSInteger index) {
         NSLog(@">>>>>  %ld", (long)index);
     };
     
     
}

// 网络加载 --- 创建自定义图片的pageControlDot的图片轮播器
-(void)demo3{
    
    SDCycleScrollView *cycleScrollView3 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 400, self.view.bounds.size.width, 180) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder@2x.png"]];
    cycleScrollView3.currentPageDotImage = [UIImage imageNamed:@"pageControlCurrentDot@2x.png"];
    cycleScrollView3.pageDotImage = [UIImage imageNamed:@"pageControlDot@2x.png"];
    cycleScrollView3.imageURLStringsGroup = self.imagesURLStrings;
    // 设置分页控制器的上下位置
    cycleScrollView3.pageControlBottomOffset = -30;
    
    [self.view addSubview:cycleScrollView3];
}

// 网络加载 --- 创建只上下滚动展示文字的轮播器
-(void)demo4{

    // 由于模拟器的渲染问题，如果发现轮播时有一条线不必处理，模拟器放大到100%或者真机调试是不会出现那条线的
    SDCycleScrollView *cycleScrollView4 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 620, self.view.bounds.size.width, 40) delegate:self placeholderImage:nil];
    cycleScrollView4.scrollDirection = UICollectionViewScrollDirectionVertical;
    cycleScrollView4.onlyDisplayText = YES;
    
    NSMutableArray *titlesArray = [NSMutableArray new];
    [titlesArray addObject:@"纯文字上下滚动轮播"];
    [titlesArray addObject:@"纯文字上下滚动轮播 -- demo轮播图4"];
    [titlesArray addObjectsFromArray:self.titles];
    cycleScrollView4.titlesGroup = [titlesArray copy];
    
    [self.view addSubview:cycleScrollView4];
    
}


-(void)demo5{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 20, 300, 100)];
    _scrollView.backgroundColor = [UIColor redColor];
    _scrollView.delegate = self;
    _scrollView.userInteractionEnabled = NO;
    // 设置分页效果
    _scrollView.pagingEnabled = YES;
    [self.view addSubview:_scrollView];
    
    for (NSInteger i = 0; i < 5; i ++) {
        UILabel *lable = [[UILabel alloc]init];
        lable.textColor = [UIColor whiteColor];
        lable.text = [NSString stringWithFormat:@"这是测试数据%zd",i];
        if (i == 0) {
            lable.text = [NSString stringWithFormat:@"这是测试数据%zd",3];
        }else if (i == 4) {
            lable.text = [NSString stringWithFormat:@"这是测试数据%zd",1];
        }
        lable.frame = CGRectMake(0, 100 * i, 300, 100);
        [_scrollView addSubview:lable];
    }
    
    _scrollView.contentOffset = CGPointMake(0, 100);

    _scrollView.contentSize = CGSizeMake(0, 100 * 5);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self startTime];
    });
    
    [_button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)click:(UIButton*)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self stopTimer];
    }else{
        [self startTime];
    }
}

- (void)change {
    NSLog(@"----");
    // 获得当前的偏移量
    CGFloat currentOffset = self.scrollView.contentOffset.y;
    // 带有动画功能
    [UIView animateWithDuration:1 animations:^{
        [self.scrollView setContentOffset:CGPointMake(0,currentOffset + 100) animated:NO];
    }];
    [self scrollViewDidEndDecelerating:_scrollView];
}


// 滚动结束时调用

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 获得当前偏移量
    CGFloat offsetY = scrollView.contentOffset.y;
    // 判断偏移量
    if (offsetY > 100 * (5 - 2)) {
        // 改变当前偏移量
        scrollView.contentOffset = CGPointMake(0, 100);
    }
    if (offsetY < 100) {
        scrollView.contentOffset = CGPointMake(0,100 * (5 - 2));
    }
}


- (void)startTime {
    if (!_timer) {
        _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(change) userInfo:nil repeats:YES];
    }
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    [_timer setFireDate:[NSDate distantPast]];
}

- (void)stopTimer{
    [_timer setFireDate:[NSDate distantFuture]];
}




- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"---点击了第%zd张图片", index);
}






@end
