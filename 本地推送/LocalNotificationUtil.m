//
//  LocalNotificationUtil.m
//  iOS开发常见技术-每日一记
//
//  Created by Qian Shen on 2017/3/9.
//  Copyright © 2017年 Qian Shen. All rights reserved.
//

#import "LocalNotificationUtil.h"

@implementation LocalNotificationUtil

+ (void)registerLocalNotification:(NSInteger)alertTime {
    CGFloat version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version >= 10.0) {
        //第二步：新建通知内容对象
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.title = @"iOS10通知";
        content.subtitle = @"新通知学习笔记";
        content.body = @"新通知变化很大，之前本地通知和远程推送是两个类，现在合成一个了。这是一条测试通知，";
        content.badge = @1;
        UNNotificationSound *sound = [UNNotificationSound soundNamed:@"caodi.m4a"];
        content.sound = sound;
        
        //第三步：通知触发机制。（重复提醒，时间间隔要大于60s）
        UNTimeIntervalNotificationTrigger *trigger1 = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:NO];
        
        //第四步：创建UNNotificationRequest通知请求对象
        NSString *requertIdentifier = @"RequestIdentifier";
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requertIdentifier content:content trigger:trigger1];
        
        //第五步：将通知加到通知中心
        [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
            NSLog(@"Error:%@",error);
        }];
    }else{
        UILocalNotification *notifiction = [[UILocalNotification alloc]init];
        if (notifiction){
            // 设置通知触发时间
            NSDate *fireDate = [NSDate dateWithTimeIntervalSinceNow:alertTime];
            notifiction.fireDate = fireDate;
            // 设置时区 8:北京时间
            notifiction.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:8];
            // 通知被触发的声音
            notifiction.soundName = UILocalNotificationDefaultSoundName;
            notifiction.alertBody = @"这是条测试信息";
            //notifiction.alertTitle = @"ShenQian";
            // 通知参数
            NSDictionary *userInfo = @{@"key":@"这是条测试信息"};
            notifiction.userInfo = userInfo;
            // 执行通知
            [[UIApplication sharedApplication] presentLocalNotificationNow:notifiction];
            //[[UIApplication sharedApplication] scheduleLocalNotification:notifiction];
        }
    }
    
    
    
}

@end
