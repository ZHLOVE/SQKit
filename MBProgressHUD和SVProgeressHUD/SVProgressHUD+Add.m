//
//  SVProgressHUD+Add.m
//  封装MB和SVProgress
//
//  Created by Qian Shen on 2017/3/2.
//  Copyright © 2017年 Qian Shen. All rights reserved.
//

#import "SVProgressHUD+Add.h"

@implementation SVProgressHUD (Add)

/**
 * 加载菊花
 */

+ (void)showHud {
    [self show];
    [self setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    
    //[self setBackgroundColor:[UIColor redColor]];
    [self setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [self dismissWithDelay:0.7];
}

/**
 *  显示信息带菊花
 *  @param message 显示信息
 */

+ (void)showMessage:(NSString *)message{
    //[self showWithStatus:message];
    [self showImage:nil status:message];
    //[self showInfoWithStatus:message];
    // 显示菊花还是环形
    [self setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    // 默认 没有遮罩
    //[self setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [self setDefaultMaskType:SVProgressHUDMaskTypeCustom];
    [self setBackgroundLayerColor:[UIColor colorWithWhite:1 alpha:0.8]];
    
    [self setOffsetFromCenter:UIOffsetMake(0, 200)];
    
    // 加载框的背景颜色
    //[self setDefaultStyle:SVProgressHUDStyleDark];
    // 自定义加载框的背景颜色
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    // view的背景颜色
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom]; //设置HUD的Style
    [SVProgressHUD setForegroundColor:[UIColor redColor]];    //设置HUD和文本的颜色
    [SVProgressHUD setBackgroundColor:[UIColor magentaColor]];//设置HUD的背景颜色
    [self setCornerRadius:2];
    // view上面的旋转小图标的 颜色
    // [SVProgressHUD setForegroundColor:[UIColor blueColor]];
    [SVProgressHUD setRingRadius:2];
    [self dismissWithDelay:0.7];
}


/**
 *  显示成功信息
 *  @param message 显示信息
 */

+ (void)showSuccessMessage:(NSString *)message {
    [self showSuccessWithStatus:message];
    [self setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [self dismissWithDelay:0.7];
}

/**
 *  显示信息带菊花
 *  @param progress 显示进度
 *  @param message  显示信息
 */

+ (void)showProgress:(CGFloat)progress message:(NSString*)message {
    [self showProgress:progress status:message];
    [self setDefaultMaskType:SVProgressHUDMaskTypeClear];
    //[self setDefaultStyle:SVProgressHUDStyleDark];
    if ((int)progress == 1) {
        [self dismiss];
    }
}


@end
