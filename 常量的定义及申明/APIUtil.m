//
//  APIUtil.m
//  iOS开发常见技术-每日一记
//
//  Created by Qian Shen on 2017/3/8.
//  Copyright © 2017年 Qian Shen. All rights reserved.
//

#import "APIUtil.h"

#define ProductEnvironment 0
#define DeveloperEnvironment 1

typedef NS_ENUM(NSUInteger, TTGState) {
    TTGStateOK = 0,
    TTGStateError,
    TTGStateUnknow
};



@implementation APIUtil

#if ProductEnvironment

NSString *const strBKAPI = @"http://api.bestkeep.cn/";
NSString *const strBackAPI = @"http://api.backkeep.cn/";
NSString *const str = @"-------";

CGFloat const num = 10;

CGFloat const age = 10;

#elif DeveloperEnvironment

NSString *const strBKAPI = @"http://api.bestkeep.cn/";
NSString *const strBackAPI = @"http://api.backkeep.cn/";
NSString *const str = @"-------";

CGFloat const num = 10;

CGFloat const age = 10;


#endif




@end
