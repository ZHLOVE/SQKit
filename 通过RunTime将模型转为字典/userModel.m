//
//  userModel.m
//  iOS开发常见技术-每日一记
//
//  Created by Qian Shen on 2017/3/10.
//  Copyright © 2017年 Qian Shen. All rights reserved.
//

#import "userModel.h"
#import <objc/runtime.h>

@implementation userModel


CMSingleton_m(userModel)

/**
 * 模型转字典
 */

- (NSDictionary*)modelToDict{
    NSMutableDictionary *propsDic = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    // class:获取哪个类的成员属性列表
    // count:成员属性总数
    // 拷贝属性列表
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    
    for (i = 0; i<outCount; i++) {
        objc_property_t property = properties[i];
        const char* char_f = property_getName(property);
        // 属性名
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        // 属性值
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        // 设置KeyValues
        if (propertyValue) [propsDic setObject:propertyValue forKey:propertyName];
    }
    // 需手动释放 不受ARC约束
    free(properties);
    return propsDic;
}

-(NSString *)description {
    return [NSString stringWithFormat:@"name = %@,height = %@,weight = %@,age = %d",_name,_height,_weight,_age];
}

@end
