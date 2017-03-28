//
//  SVProgressHUD+Add.h
//  封装MB和SVProgress
//
//  Created by Qian Shen on 2017/3/2.
//  Copyright © 2017年 Qian Shen. All rights reserved.
//

#import <SVProgressHUD/SVProgressHUD.h>

@interface SVProgressHUD (Add)

+ (void)showMessage:(NSString *)message;

+ (void)showSuccessMessage:(NSString *)message;

+ (void)showProgress:(CGFloat)progress message:(NSString*)message;

@end
