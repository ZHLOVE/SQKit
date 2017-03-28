//
//  UIButton+Click.h
//  iOS开发常见技术-每日一记
//
//  Created by Qian Shen on 2017/3/13.
//  Copyright © 2017年 Qian Shen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UIButton (UnClick)

/**
 * interval 间隔时间
 */
- (void)setAcceptClickInterval:(NSInteger)interval;


/**
 *  Category不能给类添加属性, 所以以上的cs_acceptEventInterval和cs_acceptEventTime只会有对应的getter和setter方法, 不会添加真正的成员变量
 */

@property (nonatomic, assign) NSTimeInterval acceptEventInterval; // 重复点击的间隔

@property (nonatomic, assign) NSTimeInterval acceptEventTime;


- (void)startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color;

@end
