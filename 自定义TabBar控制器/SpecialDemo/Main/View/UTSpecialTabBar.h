//
//  UTSpecialTabBar.h
//  tabBarCustomDemo
//
//  Created by xiongdexi on 16/9/1.
//  Copyright © 2016年 UTSFOT. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UTSpecialTabBar;

@protocol UTSpecialTabBarDelegate <NSObject>

/**
 *  发布按钮的代理事件
 */
- (void)tabBarPlusBtnClick:(UTSpecialTabBar *)tabBar;

/**
 *  点击tabBar的按钮调用
 */
- (void)tabBar:(UTSpecialTabBar *)tabBar didCilckButtonSelectedIndex:(NSInteger)index;

@end

@interface UTSpecialTabBar : UITabBar

/**
 *  tabbar的代理
 */
@property (nonatomic, weak) id<UTSpecialTabBarDelegate> myDelegate;

/**
 *  添加tabbar中item的方法
 */
- (void)addTabBarButtonWithSpecialItem:(UITabBarItem *)item;

@end
