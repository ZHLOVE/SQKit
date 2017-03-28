//
//  AppDelegate.h
//  侧滑父子控制器
//
//  Created by Qian Shen on 2017/3/4.
//  Copyright © 2017年 Qian Shen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BottomController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


/**bottomVc*/
@property (nonatomic, strong) BottomController *rootVc;



- (UINavigationController*)getTabBarNavigationController;

@end

