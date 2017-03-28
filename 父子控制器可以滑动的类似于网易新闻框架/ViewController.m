//
//  ViewController.m
//  父子控制器可以滑动的类似于网易新闻框架
//
//  Created by Qian Shen on 2017/3/4.
//  Copyright © 2017年 Qian Shen. All rights reserved.
//

#import "ViewController.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"
#import "FourViewController.h"
#import "FiveViewController.h"
#import "SixViewController.h"
#import "SevenViewController.h"
#import "RHLable.h"

#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREENWIDTH  [UIScreen mainScreen].bounds.size.width
static const CGFloat lableCount = 7;
//static const CGFloat lableWidth = (SCREENWIDTH / 7.0);
static const CGFloat lableHeight = 40;


@interface ViewController ()<UIScrollViewDelegate>
/**one*/
@property (nonatomic, strong) OneViewController *oneVc;

/**two*/
@property (nonatomic, strong) TwoViewController *twoVc;

/**three*/
@property (nonatomic, strong) ThreeViewController *threeVc;

/**four*/
@property (nonatomic, strong) FourViewController *fourVc;

/**five*/
@property (nonatomic, strong) FiveViewController *fiveVc;

/**six*/
@property (nonatomic, strong) SixViewController *sixVc;

/**seven*/
@property (nonatomic, strong) SevenViewController *sevenVc;


/*顶部标题scrollView*/
@property (nonatomic,strong)UIScrollView *titleScrollView;
/*底部的bottomScrollView*/
@property (nonatomic,strong)UIScrollView *bottomScrollView;


@property (nonatomic,assign)NSInteger oldIndex;

@property (nonatomic,strong)UIView *lineView;


@property(nonatomic,strong)NSArray *titles;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _oldIndex = 0;
    //0:添加子控制器
    [self setupChildViewControllers];
    _titles = @[@"控制器1",
                @"控制器2",
                @"控制器3",
                @"控制器4",
                @"控制器5",
                @"控制器6",
                @"控制器7"];
    //1:创建顶部标题的scrollView
    [self setupTopScrollView];
    //2:创建底部的scrollView
    [self setupBottomScrollView];
    //3:默认第一个新闻被选中
    [self scrollViewDidEndScrollingAnimation:self.bottomScrollView];
    
    
}

 - (void)setupTopScrollView {
    //2:创建顶部的标题滚动视图
    _titleScrollView = [[UIScrollView alloc]init];
    _titleScrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, 40);
    _titleScrollView.showsVerticalScrollIndicator = NO;
    _titleScrollView.showsHorizontalScrollIndicator = NO;
    _titleScrollView.bounces = NO;
    [self.view addSubview:_titleScrollView];
     CGFloat lableWidth = (SCREENWIDTH / 7.0);
    //3:创建顶部scrollView上的按钮
    for (int i = 0; i <lableCount; i++) {
        RHLable *lable = [[RHLable alloc]init];
        lable.backgroundColor = [UIColor redColor];
        lable.text = _titles[i];
        lable.font = [UIFont systemFontOfSize:10];
        lable.textColor = [UIColor whiteColor];
        lable.frame = CGRectMake(i *lableWidth, 0, lableWidth, lableHeight);
        [lable addGestureRecognizer:  [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)]];
        //lable.text = [self.childViewControllers[i] title];
        lable.tag = i;
        [_titleScrollView addSubview:lable];
    }
     
     _lineView = [[UIView alloc]init];
     _lineView.frame = CGRectMake(0, 40, lableWidth, 5);
     _lineView.backgroundColor = [UIColor blueColor];
     [self.view addSubview:_lineView];

    _titleScrollView.contentSize = CGSizeMake(lableCount *lableWidth, 0);
    
}

- (void)setupBottomScrollView {
    
    //1:创建底部的scrollView
    UIScrollView *bottomScrollView = [[UIScrollView alloc]init];
    bottomScrollView.frame = CGRectMake(0,CGRectGetMaxY(self.titleScrollView.frame) + 5 ,SCREENWIDTH , SCREENHEIGHT - 40);
    bottomScrollView.bounces = NO;
    bottomScrollView.showsVerticalScrollIndicator = NO;
    bottomScrollView.showsHorizontalScrollIndicator = NO;
    bottomScrollView.pagingEnabled = YES;
    bottomScrollView.contentSize = CGSizeMake(lableCount *SCREENWIDTH, 0);
    self.bottomScrollView = bottomScrollView;
    bottomScrollView.delegate = self;
    [self.view addSubview:bottomScrollView];
}


- (void)setupChildViewControllers {
    
    //新闻
    _oneVc = [[OneViewController alloc]init];
    [self addChildViewController:_oneVc];

    //历史
    _twoVc = [[TwoViewController alloc]init];
    [self addChildViewController:_twoVc];

    //阅读
    _threeVc = [[ThreeViewController alloc]init];
    [self addChildViewController:_threeVc];

    //视频
    _fourVc = [[FourViewController alloc]init];
    [self addChildViewController:_fourVc];

    //图片
    _fiveVc = [[FiveViewController alloc]init];
    [self addChildViewController:_fiveVc];

    //朋友
    _sixVc = [[SixViewController alloc]init];
    [self addChildViewController:_sixVc];

    //问答
    _sevenVc  = [[SevenViewController alloc]init];
    [self addChildViewController:_sevenVc];
    
}


- (void)tapAction:(UITapGestureRecognizer*)tap {

     //1:切换底部的scrollView的视图
      NSUInteger index = tap.view.tag;
     [self.bottomScrollView setContentOffset:CGPointMake(index *SCREENWIDTH, 0) animated:YES];
 
 }


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    NSInteger index = scrollView.contentOffset.x / SCREENWIDTH;
    RHLable *currentLable = self.titleScrollView.subviews[index];

    //1:当点击lable时，先将点击的lable自身居中
    CGFloat moveX = currentLable.center.x - SCREENWIDTH *0.5;
    CGFloat offset = self.titleScrollView.contentSize.width - SCREENWIDTH;
    if (moveX < 0)   moveX = 0;
    if (moveX > offset)  moveX = offset;

    [self.titleScrollView setContentOffset:CGPointMake(moveX, 0) animated:YES];
    //2:设置其他lable为正常比例
    for (RHLable *lable in self.titleScrollView.subviews) {
        if (lable != currentLable) lable.sca = 0.0;
    }
    UIViewController *old = self.childViewControllers[_oldIndex];
    [old.view removeFromSuperview];
    UIViewController *new = self.childViewControllers[index];
    //如果控制器的view已经加载过了，直接返回
    //if ([new isViewLoaded]) return;
    new.view.frame = CGRectMake(index *SCREENWIDTH, 0, SCREENWIDTH, self.bottomScrollView.frame.size.height);
    [self.bottomScrollView addSubview:new.view];
    _oldIndex = index;
}


/**
 * 只要scrollView在滚动，就会调用
 */
 - (void)scrollViewDidScroll:(UIScrollView *)scrollView {

     CGFloat scale = scrollView.contentOffset.x / SCREENWIDTH;
     CGFloat lableWidth = (SCREENWIDTH / 7.0);
     
     
    if (scale < 0 || scale > self.childViewControllers.count -1) return;
     
     _lineView.frame = CGRectMake(lableWidth*scale, 40, lableWidth, 5);
     
    NSInteger leftIndex = scale;//将浮点型数转换为整数，小数无论多少全部去掉
    NSInteger rightIndex = leftIndex + 1;

    //左侧的lable
     RHLable *leftLable = self.titleScrollView.subviews[leftIndex];

    //右侧的lable
     RHLable *rightLable = (rightIndex == self.titleScrollView.subviews.count) ? nil :  self.titleScrollView.subviews[rightIndex];

    CGFloat rightScale = scale - leftIndex;
    CGFloat leftScale = 1 - rightScale;
    leftLable.sca = leftScale;
    rightLable.sca = rightScale;
    
     }
/**
 * 手指松开scrollView后，scrollView停止减速完毕就会调用这个
 */

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
 
     [self scrollViewDidEndScrollingAnimation:scrollView];
 }




@end
