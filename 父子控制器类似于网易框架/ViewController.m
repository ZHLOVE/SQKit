//
//  ViewController.m
//  父子控制器类似于网易框架
//
//  Created by Qian Shen on 2017/3/4.
//  Copyright © 2017年 Qian Shen. All rights reserved.
//

#import "ViewController.h"

#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"

#define SCREEN_W [UIScreen mainScreen].bounds.size.width
#define SCREEN_H [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@property (nonatomic ,strong) ThreeViewController  *thirdVC;
@property (nonatomic ,strong) OneViewController    *firstVC;
@property (nonatomic ,strong) TwoViewController    *secondVC;

@property (nonatomic ,strong) UIViewController *currentVC;

@property (nonatomic ,strong) UIScrollView *headScrollView;  //  顶部滚动视图

@property (nonatomic ,strong) NSArray *headArray;

@property (nonatomic, strong) UIView  *lineView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"网易新闻Demo";
    
    self.headArray = @[@"头条",@"娱乐",@"体育"];
    /**
     *   automaticallyAdjustsScrollViewInsets   又被这个属性坑了
     *   我"UI高级"里面一篇文章着重讲了它,大家可以去看看
     */
    //self.automaticallyAdjustsScrollViewInsets = NO;
    self.headScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 40)];
    self.headScrollView.backgroundColor = [UIColor purpleColor];
    //self.headScrollView.contentSize = CGSizeMake(SCREEN_W, 0);
    self.headScrollView.bounces = NO;
    self.headScrollView.pagingEnabled = YES;
    CGFloat button_w = SCREEN_W / (CGFloat)[self.headArray count];
    _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, button_w, 5)];
    _lineView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_lineView];
    
    
    [self.view addSubview:self.headScrollView];
    for (int i = 0; i < [self.headArray count]; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor redColor];
        
        button.frame = CGRectMake(0 + i*button_w, 0, button_w, 40);
        [button setTitle:[self.headArray objectAtIndex:i] forState:UIControlStateNormal];
        button.tag = i + 100;
        [button addTarget:self action:@selector(didClickHeadButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.headScrollView addSubview:button];
    }
    
    /*
     苹果新的API增加了addChildViewController方法，并且希望我们在使用addSubview时，同时调用[self addChildViewController:child]方法将sub view对应的viewController也加到当前ViewController的管理中。
     对于那些当前暂时不需要显示的subview，只通过addChildViewController把subViewController加进去；需要显示时再调用transitionFromViewController方法。将其添加进入底层的ViewController中。
     这样做的好处：
     
     1.无疑，对页面中的逻辑更加分明了。相应的View对应相应的ViewController。
     2.当某个子View没有显示时，将不会被Load，减少了内存的使用。
     3.当内存紧张时，没有Load的View将被首先释放，优化了程序的内存释放机制。
     */
    
    /**
     *  在iOS5中，ViewController中新添加了下面几个方法：
     *  addChildViewController:
     *  removeFromParentViewController
     *  transitionFromViewController:toViewController:duration:options:animations:completion:
     *  willMoveToParentViewController:
     *  didMoveToParentViewController:
     */
    self.firstVC = [[OneViewController alloc] init];
    [self.firstVC.view setFrame:CGRectMake(0, 45, SCREEN_W, SCREEN_H-40)];
    [self addChildViewController:_firstVC];
    
    self.secondVC = [[TwoViewController alloc] init];
    [self.secondVC.view setFrame:CGRectMake(0, 45, SCREEN_W, SCREEN_H-40)];
    
    self.thirdVC = [[ThreeViewController alloc] init];
    [self.thirdVC.view setFrame:CGRectMake(0, 45, SCREEN_W, SCREEN_H-40)];
    //  默认,第一个视图(你会发现,全程就这一个用了addSubview)
    [self.view addSubview:self.firstVC.view];
    
    self.currentVC = self.firstVC;
}
- (IBAction)start:(id)sender {
}


- (void)didClickHeadButtonAction:(UIButton *)button
{
    //  点击处于当前页面的按钮,直接跳出
    if ((self.currentVC == self.firstVC && button.tag == 100)||(self.currentVC == self.secondVC && button.tag == 101.)) {
        return;
    }else{
        CGFloat button_w = SCREEN_W / (CGFloat)[self.headArray count];
        [UIView animateWithDuration:0.3 animations:^{
            self.lineView.frame = CGRectMake(button_w * (button.tag % 100), 40, button_w, 5);
        }];
        
        //  展示2个,其余一样,自行补全噢
        switch (button.tag) {
            case 100:
                [self replaceController:self.currentVC newController:self.firstVC];
                break;
            case 101:
                [self replaceController:self.currentVC newController:self.secondVC];
                break;
            case 102:
                [self replaceController:self.currentVC newController:self.thirdVC];
                break;
            case 103:
                //.......
                break;
            case 104:
                //.......
                break;
            case 105:
                //.......
                break;
            case 106:
                //.......
                break;
                //.......
            default:
                break;
        }
    }
    
}

//  切换各个标签内容
- (void)replaceController:(UIViewController *)oldController newController:(UIViewController *)newController
{
    /**
     *			着重介绍一下它
     *  transitionFromViewController:toViewController:duration:options:animations:completion:
     *  fromViewController	  当前显示在父视图控制器中的子视图控制器
     *  toViewController		将要显示的姿势图控制器
     *  duration				动画时间(这个属性,old friend 了 O(∩_∩)O)
     *  options				 动画效果(渐变,从下往上等等,具体查看API)
     *  animations			  转换过程中得动画
     *  completion			  转换完成
     */
    
    [self addChildViewController:newController];
    [self transitionFromViewController:oldController toViewController:newController duration:0.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
        
        if (finished) {
            [newController didMoveToParentViewController:self];
            [oldController willMoveToParentViewController:nil];
            [oldController removeFromParentViewController];
            self.currentVC = newController;
        }else{
            self.currentVC = oldController;
        }
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
