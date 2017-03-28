//
//  userModel.h
//  iOS开发常见技术-每日一记
//
//  Created by Qian Shen on 2017/3/10.
//  Copyright © 2017年 Qian Shen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CMSingleton.h"
@interface userModel : NSObject



/**姓名*/
@property (nonatomic, strong) NSString *name;

/**身高*/
@property (nonatomic, strong) NSString *height;

/**体重*/
@property (nonatomic, strong) NSString *weight;

/**年龄*/
@property (nonatomic, assign) int      age;


CMSingleton_h(userModel)

/**
 * 模型转字典
 */

- (NSDictionary*)modelToDict;


@end
