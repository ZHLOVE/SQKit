//
//  UTTabBarCommonController.m
//  tabBarCustomDemo
//
//  Created by xiongdexi on 16/8/31.
//  Copyright © 2016年 UTSFOT. All rights reserved.
//

#import "UTTabBarCommonController.h"
#import "UTNavigationCommonController.h"
#import "UTHomeCommomController.h"
#import "UTDiscoverCommomController.h"
#import "UTMessageCommonController.h"
#import "UTMyCenterCommonController.h"

#import "UTCommonTabBar.h"

#define TEXTFONT 13
@interface UTTabBarCommonController ()<UTCommonTabBarDelegate>
/** tabBar的item的title文字数组 */
@property (nonatomic, copy) NSArray *titleArray;
/** tabBar的item的normal状态下的image图片数组 */
@property (nonatomic, copy) NSArray *normalImageArray;
/** tabBar的item的selected状态下的image图片数组 */
@property (nonatomic, copy) NSArray *selectedImageArray;

/** 子控制器 */
@property (nonatomic, strong) UTHomeCommomController *mainPageVc;
@property (nonatomic, strong) UTMessageCommonController *messageVc;
@property (nonatomic, strong) UTDiscoverCommomController *discoverVc;
@property (nonatomic, strong) UTMyCenterCommonController *myCenterVc;

/** 自定义tabBar */
@property (nonatomic, weak) UTCommonTabBar *customTabBar;

@end

@implementation UTTabBarCommonController

#pragma mark - init

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _titleArray = @[@"首页",
                    @"消息",
                    @"发现",
                    @"我的"];
    
    _normalImageArray = @[@"tabbar_home",
                          @"tabbar_message_center",
                          @"tabbar_discover",
                          @"tabbar_profile"];
    
    _selectedImageArray = @[@"tabbar_home_selected",
                            @"tabbar_message_center_selected",
                            @"tabbar_discover_selected",
                            @"tabbar_profile_selected"];
    
    // 自定义tabBar
    [self setupCustomTabBar];
    
    // 添加子控制器
    [self setUpAllChildVc];
    
}


+ (void)initialize
{
    UITabBarItem *tabBarItem = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    
    NSMutableDictionary *dictNormal = [NSMutableDictionary dictionary];
    dictNormal[NSForegroundColorAttributeName] = [UIColor blackColor];
    dictNormal[NSFontAttributeName] = [UIFont systemFontOfSize:TEXTFONT];
    
    NSMutableDictionary *dictSelected = [NSMutableDictionary dictionary];
    dictSelected[NSForegroundColorAttributeName] = [UIColor orangeColor];
    dictSelected[NSFontAttributeName] = [UIFont systemFontOfSize:TEXTFONT];
    
    [tabBarItem setTitleTextAttributes:dictNormal forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:dictSelected forState:UIControlStateSelected];
    
}


- (void)setupCustomTabBar {
    
    // 自定义tabBar
    UTCommonTabBar *tabBar = [[UTCommonTabBar alloc] init];
    tabBar.frame = self.tabBar.bounds;
    tabBar.backgroundColor = [UIColor whiteColor];
    tabBar.myDelegate = self;
    
    // 添加自定义tabBar
    [self.tabBar addSubview:tabBar];
    
    _customTabBar = tabBar;
    
    
}


- (void)setUpAllChildVc
{
    
    // mainPageVc
    UTHomeCommomController *homePageVc = [[UTHomeCommomController alloc] init];
    [self setupChildViewController:homePageVc titleStr:_titleArray[0] imageName:_normalImageArray[0] seleImageName:_selectedImageArray[0]];
    self.mainPageVc = homePageVc;
    
    // message
    UTMessageCommonController *messageVc = [[UTMessageCommonController alloc] init];
    [self setupChildViewController:messageVc titleStr:_titleArray[1] imageName:_normalImageArray[1] seleImageName:_selectedImageArray[1]];
    self.messageVc = messageVc;
    
    // discoverVc
    UTDiscoverCommomController *discoverVc = [[UTDiscoverCommomController alloc] init];
    [self setupChildViewController:discoverVc titleStr:_titleArray[2]imageName:_normalImageArray[2] seleImageName:_selectedImageArray[2]];
    self.discoverVc = discoverVc;
    
    // myCenterVc
    UTMyCenterCommonController *myCenterVc = [[UTMyCenterCommonController alloc] init];
    [self setupChildViewController:myCenterVc titleStr:_titleArray[3] imageName:_normalImageArray[3] seleImageName:_selectedImageArray[3]];
    self.myCenterVc = myCenterVc;
    
}

// 封装创建一个子控制器的属性
- (void)setupChildViewController:(UIViewController *)VC titleStr:(NSString *)titleStr imageName:(NSString *)imageName seleImageName:(NSString *)seleImageName {
    
    VC.title = titleStr;
    VC.tabBarItem.image = [UIImage imageNamed:imageName];
    VC.tabBarItem.selectedImage = [[UIImage imageNamed:seleImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UTNavigationCommonController *navVc = [[UTNavigationCommonController alloc] initWithRootViewController:VC];
    [self addChildViewController:navVc];
    
    [self.customTabBar addTabBarButtonWithItem:VC.tabBarItem];
}

#pragma mark - <DXTabBarDelegate>实现
// 点击了tabBar按钮的代理方法
- (void)tabBar:(UTCommonTabBar *)tabBar didCilckButtonSelectedIndex:(NSInteger)index {
    self.selectedIndex = index;
}

#pragma mark - lazy

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = [NSArray array];
    }
    return _titleArray;
}

- (NSArray *)normalImageArray {
    if (!_normalImageArray) {
        _normalImageArray = [NSArray array];
    }
    return _normalImageArray;
}

- (NSArray *)selectedImageArray {
    if (!_selectedImageArray) {
        _selectedImageArray = [NSArray array];
    }
    return _selectedImageArray;
}


@end
