//
//  UIButton+Click.m
//  iOS开发常见技术-每日一记
//
//  Created by Qian Shen on 2017/3/13.
//  Copyright © 2017年 Qian Shen. All rights reserved.
//

#import "UIButton+UnClick.h"
#import <objc/runtime.h>

// 因category不能添加属性，只能通过关联对象的方式。
static NSString const *UIButton_acceptEventInterval = @"UIButton_acceptEventInterval";
static NSString const *UIButton_acceptEventTime = @"UIButton_acceptEventTime";


@implementation UIButton (UnClick)


- (void)setAcceptClickInterval:(NSInteger)interval {
    self.userInteractionEnabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(interval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.userInteractionEnabled = YES;
    });
}

/**
 *  objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy)
    id object                     :表示关联者，是一个对象，变量名理所当然也是object
    const void *key               :获取被关联者的索引key
    id value                      :被关联者，这里是一个block
    objc_AssociationPolicy policy : 关联时采用的协议，有assign，retain，copy等协议，一般使用OBJC_ASSOCIATION_RETAIN_NONATOMIC
 */

- (NSTimeInterval)acceptEventInterval {
    return  [objc_getAssociatedObject(self, &UIButton_acceptEventInterval) doubleValue];
}

- (void)setAcceptEventInterval:(NSTimeInterval)acceptEventInterval {
    objc_setAssociatedObject(self, &UIButton_acceptEventInterval, @(acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (NSTimeInterval)acceptEventTime {
    return  [objc_getAssociatedObject(self, &UIButton_acceptEventTime) doubleValue];
}

- (void)setAcceptEventTime:(NSTimeInterval)acceptEventTime {
    objc_setAssociatedObject(self, &UIButton_acceptEventTime, @(acceptEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


// 在load时执行hook
+ (void)load {
    Method before   = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    Method after    = class_getInstanceMethod(self, @selector(sq_sendAction:to:forEvent:));
    method_exchangeImplementations(before, after);
}

- (void)sq_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    if ([NSDate date].timeIntervalSince1970 - self.acceptEventTime < self.acceptEventInterval) {
        return;
    }
    if (self.acceptEventInterval > 0) {
        self.acceptEventTime = [NSDate date].timeIntervalSince1970;
    }
    [self sq_sendAction:action to:target forEvent:event];
}


- (void)startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color {
    
    //倒计时时间
    __block NSInteger timeOut = timeLine;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //每秒执行一次
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        //倒计时结束，关闭
        if (timeOut <= 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.backgroundColor = mColor;
                [self setTitle:title forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
            });
        } else {
            int allTime = (int)timeLine + 1;
            int seconds = timeOut % allTime;
            NSString *timeStr = [NSString stringWithFormat:@"%0.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.backgroundColor = color;
                [self setTitle:[NSString stringWithFormat:@"%@%@",timeStr,subTitle] forState:UIControlStateNormal];
                self.userInteractionEnabled = NO;
            });
            timeOut--;
        }
    });
    dispatch_resume(_timer);
}


@end
