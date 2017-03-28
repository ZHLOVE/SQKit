//
//  MBProgressHUD+Add.h
//  封装MB和SVProgress
//
//  Created by Qian Shen on 2017/3/2.
//  Copyright © 2017年 Qian Shen. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (Add)

+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view;

+ (void)show:(NSString *)text toView:(UIView *)view;

+ (void)showSuccess:(NSString *)success toView:(UIView *)view;

+ (void)showError:(NSString *)error toView:(UIView *)view;


+ (MBProgressHUD *)showMessage:(NSString *)message;

- (void)hideHud;

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;

- (void)hideHUDAtView:(UIView *)view;

+ (void)showMessage:(NSString *)message toView:(UIView *)view yOffset:(float)yOffset;

+ (MBProgressHUD *)showProgressMessage:(NSString *)message toView:(UIView *)view;

@end
