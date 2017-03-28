//
//  AppDelegate.h
//  本地推送
//
//  Created by Qian Shen on 2017/3/9.
//  Copyright © 2017年 Qian Shen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,UNUserNotificationCenterDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

