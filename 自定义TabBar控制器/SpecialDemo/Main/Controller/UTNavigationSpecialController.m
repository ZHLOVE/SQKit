//
//  UTNavigationSpecialController.m
//  tabBarCustomDemo
//
//  Created by xiongdexi on 16/8/31.
//  Copyright © 2016年 UTSFOT. All rights reserved.
//

#import "UTNavigationSpecialController.h"
#import "UTTabBarSpecialController.h"
#import "UTSpecialTabBar.h"

#define UTNavgationBarTitleFont [UIFont boldSystemFontOfSize:20]
@interface UTNavigationSpecialController ()<UINavigationControllerDelegate>

@end

@implementation UTNavigationSpecialController

#pragma mark - init
// 拦截initialize,给导航栏设置一些统一的属性
+ (void)initialize {
    
    if (self == [UTNavigationSpecialController class]) {
        // 设置导航条的标题
        [self setUpNavBarTitle];
        // 设置导航条的按钮
        [self setUpNavBarButton];
    }
}

+ (void)setUpNavBarTitle {
    
    UINavigationBar *nav = [UINavigationBar appearanceWhenContainedIn:[UTNavigationSpecialController class], nil];
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[NSFontAttributeName] = UTNavgationBarTitleFont;
    [nav setTitleTextAttributes:dictM];
    
}

+ (void)setUpNavBarButton {
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    // 设置不可用状态下的按钮颜色
    NSMutableDictionary *disableDictM = [NSMutableDictionary dictionary];
    disableDictM[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [item setTitleTextAttributes:disableDictM forState:UIControlStateDisabled];
    
    // 设置普通状态下的按钮颜色
    NSMutableDictionary *normalDictM = [NSMutableDictionary dictionary];
    normalDictM[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [item setTitleTextAttributes:normalDictM forState:UIControlStateNormal];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.interactivePopGestureRecognizer.delegate = nil;
    self.delegate = self;
    
}

#pragma mark - 代理方法
/**
 * 可以在这个方法中拦截所有push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.childViewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

/**
 * navigationController即将显示的时候调用
 */
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    UTTabBarSpecialController *tabBarVc = (UTTabBarSpecialController *)[self getCurrentViewController];
    
    // 删除系统自带的tabBarButton
    for (UIView *tabBarButton in tabBarVc.tabBar.subviews) {
        if (![tabBarButton isKindOfClass:[UTSpecialTabBar class]]) {
            [tabBarButton removeFromSuperview];
        }
    }
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

/** 获取当前View的控制器对象 */
-(UIViewController *)getCurrentViewController{
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}

@end
