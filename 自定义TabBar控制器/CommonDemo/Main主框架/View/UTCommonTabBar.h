//
//  UTCommonTabBar.h
//  tabBarCustomDemo
//
//  Created by xiongdexi on 16/8/31.
//  Copyright © 2016年 UTSFOT. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UTCommonTabBar;

@protocol UTCommonTabBarDelegate <NSObject>

/**
 *  点击tabBar的按钮调用
 */
- (void)tabBar:(UTCommonTabBar *)tabBar didCilckButtonSelectedIndex:(NSInteger)index;

@end

@interface UTCommonTabBar : UITabBar

/**
 *  tabbar的代理
 */
@property (nonatomic, weak) id<UTCommonTabBarDelegate> myDelegate;

/**
 *  添加tabbar中item的方法
 */
- (void)addTabBarButtonWithItem:(UITabBarItem *)item;

@end
