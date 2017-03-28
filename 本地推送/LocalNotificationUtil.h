//
//  LocalNotificationUtil.h
//  iOS开发常见技术-每日一记
//
//  Created by Qian Shen on 2017/3/9.
//  Copyright © 2017年 Qian Shen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UserNotifications/UserNotifications.h>
#import <UIKit/UIKit.h>



@interface LocalNotificationUtil : NSObject

+ (void)registerLocalNotification:(NSInteger)alertTime;

@end
