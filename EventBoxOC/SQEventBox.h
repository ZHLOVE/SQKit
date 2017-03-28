//
//  SQEventBox.h
//  iOS开发常见技术-每日一记
//
//  Created by Qian Shen on 2017/3/12.
//  Copyright © 2017年 Qian Shen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>




@interface SQEventBox : NSObject

@end


@interface Static : NSObject


/**EventBox*/
@property (nonatomic, strong) SQEventBox *instance;


/**队列*/
@property (nonatomic, strong) dispatch_queue_t queue;



@end


@interface NamedObserver : NSObject


/***/
//@property (nonatomic, weak) NSObjectProtocol *observer;

/**通知名字*/
@property (nonatomic, strong) NSString *name;


@end







