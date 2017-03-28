//
//  ReachabilityUtil.h
//  iOS开发常见技术-每日一记
//
//  Created by Qian Shen on 2017/3/10.
//  Copyright © 2017年 Qian Shen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface ReachabilityUtil : NSObject

/**
 * 创建ReachabilityUtil实列
 */

+ (instancetype)shareReachabilityUtil;

/**
 * 获得当前网络的状态，未连接为NO，其余皆为Yes
 */
+ (BOOL)getCurrentReachabilityState;

/**
 * 用AFNetworking获得当前网络 
 * 这个用于监听网络状态的改变
 */

+ (BOOL)getCurrentAFNetworkingState;

/**
 * 注册网络监听
 */
- (void)addReachability;

@end
