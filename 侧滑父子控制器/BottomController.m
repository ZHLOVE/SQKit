//
//  BottomController.m
//  iOS开发常见技术-每日一记
//
//  Created by Qian Shen on 2017/3/4.
//  Copyright © 2017年 Qian Shen. All rights reserved.
//

#import "BottomController.h"
#import "UIView+SFrame.h"

#define vSpeedFloat   0.7    //滑动速度

#define kScreenSize           [[UIScreen mainScreen] bounds].size
#define kScreenWidth          [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight         [[UIScreen mainScreen] bounds].size.height

#define kMainPageDistance   100   //打开左侧窗时，中视图(右视图)露出的宽度
#define kMainPageScale      0.8      //打开左侧窗时，中视图(右视图）缩放比例
#define kMainPageCenter  CGPointMake(kScreenWidth + kScreenWidth * kMainPageScale / 2.0 - kMainPageDistance, kScreenHeight / 2)  //打开左侧窗时，中视图中心点
#define vCouldChangeDeckStateDistance  (kScreenWidth - kMainPageDistance) / 2.0 - 40 //滑动距离大于此数时，状态改变（关--》开，或者开--》关）

#define kLeftAlpha 0.9  //左侧蒙版的最大值
#define kLeftCenterX 30 //左侧初始偏移量
#define kLeftScale 0.7  //左侧初始缩放比例

@interface BottomController ()<UIGestureRecognizerDelegate>

{
    CGFloat _scalef;  //实时横向位移
}

@property (nonatomic,strong) UILabel *leftTableview;
@property (nonatomic,assign) CGFloat     leftTableviewW;
@property (nonatomic,strong) UIView      *contentView;

/**侧滑点击手势*/
@property (nonatomic, strong) UITapGestureRecognizer *sideslipTapGes;
@property (nonatomic, weak  ) UIPanGestureRecognizer *sideslipPanGes;

@end

@implementation BottomController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 @brief 初始化底部控制器
 @param leftVc 左视图控制器
 @param mainVc 视图控制器
 @result instancetype 初始化生成的对象
 */
- (instancetype)initWithLeftView:(UIViewController *)leftVc
                     andMainView:(UIViewController *)mainVc{
    if (self = [super init]) {
        self.speedf = vSpeedFloat;
        self.leftVc = (LeftViewController*)leftVc;
        self.mainVc = (MainViewController*)mainVc;
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
        _sideslipPanGes = pan;
        pan.delegate = self;
        [self.mainVc.view addGestureRecognizer:pan];
        [pan setCancelsTouchesInView:YES];
        [self.view addSubview:self.leftVc.view];
        //蒙版
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        view.backgroundColor = [UIColor blackColor];
        view.alpha = 0.5;
        self.contentView = view;
        [self.leftVc.view addSubview:view];
        
        //获取左侧tableview
        for (UIView *obj in self.leftVc.view.subviews) {
            if ([obj isKindOfClass:[UILabel class]]) {
                self.leftTableview = (UILabel *)obj;
            }
        }
        self.leftTableview.backgroundColor = [UIColor clearColor];
        self.leftTableview.frame = CGRectMake(0, 0, kScreenWidth - kMainPageDistance, kScreenHeight);
        //设置左侧tableview的初始位置和缩放系数
        self.leftTableview.transform = CGAffineTransformMakeScale(kLeftScale, kLeftScale);
        //self.leftTableview.center = CGPointMake(kLeftCenterX, kScreenHeight * 0.5);
        [self.view addSubview:self.mainVc.view];
        self.closed = YES;//初始时侧滑窗关闭
    }
    
    return self;
}

/**
 locationInView:    获取到的是手指点击屏幕实时的坐标点；
 translationInView：获取到的是手指移动后，在相对坐标中的偏移量
 */

- (void)handlePan:(UIPanGestureRecognizer*)gesture{
    CGPoint point = [gesture translationInView:self.view];
    //NSLog(@"%@------",NSStringFromCGPoint(point));
    _scalef = (point.x * self.speedf + _scalef);
    NSLog(@"%@------",[NSString stringWithFormat:@"%f",_scalef]);
    //是否还需要跟随手指移动
    BOOL needMoveWithTap = YES;
    if (((self.mainVc.view.x <= 0) && (_scalef <= 0)) || ((self.mainVc.view.x >= (kScreenWidth - kMainPageDistance )) && (_scalef >= 0)))
    {
        //边界值管控
        _scalef = 0;
        needMoveWithTap = NO;
    }
    //根据视图位置判断是左滑还是右边滑动
    if (needMoveWithTap && (gesture.view.frame.origin.x >= 0) && (gesture.view.frame.origin.x <= (kScreenWidth - kMainPageDistance)))
    {
        CGFloat recCenterX = gesture.view.center.x + point.x * self.speedf;
        if (recCenterX < kScreenWidth * 0.5 - 2) {
            recCenterX = kScreenWidth * 0.5;
        }
        
        CGFloat recCenterY = gesture.view.center.y;
        
        gesture.view.center = CGPointMake(recCenterX,recCenterY);
        
        //scale 1.0~kMainPageScale
        CGFloat scale = 1 - (1 - kMainPageScale) * (gesture.view.frame.origin.x / (kScreenWidth - kMainPageDistance));
        
        gesture.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,scale, scale);
        [gesture setTranslation:CGPointMake(0, 0) inView:self.view];
        
        //CGFloat leftTabCenterX = kLeftCenterX + ((kScreenWidth - kMainPageDistance) * 0.5 - kLeftCenterX) * (gesture.view.frame.origin.x / (kScreenWidth - kMainPageDistance));
        
        //leftScale kLeftScale~1.0
        CGFloat leftScale = kLeftScale + (1 - kLeftScale) * (gesture.view.frame.origin.x / (kScreenWidth - kMainPageDistance));
        
        //self.leftTableview.center = CGPointMake(leftTabCenterX, kScreenHeight * 0.5);
        self.leftTableview.transform = CGAffineTransformScale(CGAffineTransformIdentity, leftScale,leftScale);
        
        //tempAlpha kLeftAlpha~0
        CGFloat tempAlpha = kLeftAlpha - kLeftAlpha * (gesture.view.frame.origin.x / (kScreenWidth - kMainPageDistance));
        self.contentView.alpha = tempAlpha;
        
    }else
    {
        //超出范围，
        if (self.mainVc.view.x < 0)
        {
            [self closeLeftView];
            _scalef = 0;
        }
        else if (self.mainVc.view.x > (kScreenWidth - kMainPageDistance))
        {
            [self openLeftView];
            _scalef = 0;
        }
    }
    
    //手势结束后修正位置,超过约一半时向多出的一半偏移
    if (gesture.state == UIGestureRecognizerStateEnded) {
        if (fabs(_scalef) > vCouldChangeDeckStateDistance)
        {
            if (self.closed)
            {
                [self openLeftView];
            }
            else
            {
                [self closeLeftView];
            }
        }
        else
        {
            if (self.closed)
            {
                [self closeLeftView];
            }
            else
            {
                [self openLeftView];
            }
        }
        _scalef = 0;
    }
    
}
#pragma mark - 单击手势
-(void)handeTap:(UITapGestureRecognizer *)tap{
    if ((!self.closed) && (tap.state == UIGestureRecognizerStateEnded))
    {
        [UIView beginAnimations:nil context:nil];
        tap.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
        tap.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2,[UIScreen mainScreen].bounds.size.height/2);
        self.closed = YES;
        
        //self.leftTableview.center = CGPointMake(kLeftCenterX, kScreenHeight * 0.5);
        self.leftTableview.transform = CGAffineTransformScale(CGAffineTransformIdentity,kLeftScale,kLeftScale);
        self.contentView.alpha = kLeftAlpha;
        
        [UIView commitAnimations];
        _scalef = 0;
        [self removeSingleTap];
    }
    
}

#pragma mark - 修改视图位置
/**
 @brief 关闭左视图
 */
- (void)closeLeftView
{
    [UIView beginAnimations:nil context:nil];
    self.mainVc.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
    self.mainVc.view.center = CGPointMake(kScreenWidth / 2, kScreenHeight / 2);
    self.closed = YES;
    
    //self.leftTableview.center = CGPointMake(kLeftCenterX, kScreenHeight * 0.5);
    self.leftTableview.transform = CGAffineTransformScale(CGAffineTransformIdentity,kLeftScale,kLeftScale);
    self.contentView.alpha = kLeftAlpha;
    
    [UIView commitAnimations];
    [self removeSingleTap];
}

/**
 @brief 打开左视图
 */
- (void)openLeftView;
{
    [UIView beginAnimations:nil context:nil];
    self.mainVc.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,kMainPageScale,kMainPageScale);
    self.mainVc.view.center = kMainPageCenter;
    self.closed = NO;
    
    //self.leftTableview.center = CGPointMake((kScreenWidth - kMainPageDistance) * 0.5, kScreenHeight * 0.5);
    self.leftTableview.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
    self.contentView.alpha = 0;
    
    [UIView commitAnimations];
    [self disableTapButton];
}

#pragma mark - 行为收敛控制
- (void)disableTapButton
{
    for (UIButton *tempButton in [_mainVc.view subviews])
    {
        [tempButton setUserInteractionEnabled:NO];
    }
    //单击
    if (!self.sideslipTapGes)
    {
        //单击手势
        self.sideslipTapGes= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handeTap:)];
        [self.sideslipTapGes setNumberOfTapsRequired:1];
        
        [self.mainVc.view addGestureRecognizer:self.sideslipTapGes];
        self.sideslipTapGes.cancelsTouchesInView = YES;  //点击事件盖住其它响应事件,但盖不住Button;
    }
}

//关闭行为收敛
- (void) removeSingleTap
{
    for (UIButton *tempButton in [self.mainVc.view  subviews])
    {
        [tempButton setUserInteractionEnabled:YES];
    }
    [self.mainVc.view removeGestureRecognizer:self.sideslipTapGes];
    self.sideslipTapGes = nil;
}


/**询问delegate是否允许手势接收者接收一个touch对象
 * 返回YES，则允许对这个touch对象审核，NO，则不允许。
 * 这个方法在touchesBegan:withEvent:之前调用，为一个新的touch对象进行调用
*/
-(BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldReceiveTouch:(UITouch*)touch {
    
    if(touch.view.tag == 1000)
    {
        NSLog(@"不响应侧滑");
        return NO;
    }
    else
    {
        NSLog(@"响应侧滑");
        return YES;
    }
}

-(void)setPanEnabled:(BOOL)enabled{
    _sideslipPanGes.enabled = enabled;
}







@end
