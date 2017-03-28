//
//  BottomController.h
//  iOS开发常见技术-每日一记
//
//  Created by Qian Shen on 2017/3/4.
//  Copyright © 2017年 Qian Shen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftViewController.h"
#import "MainViewController.h"


@interface BottomController : UIViewController


//滑动速度系数-建议在0.5-1之间。默认为0.5
@property (nonatomic, assign) CGFloat speedf;



/**leftVc*/
@property (nonatomic, strong) LeftViewController *leftVc;

/**mainVc*/
@property (nonatomic, strong) MainViewController *mainVc;

/**侧滑窗是否关闭(关闭时显示为主页)*/
@property (nonatomic, assign) BOOL closed;


/**
 @brief 初始化侧滑控制器
 leftVc 右视图控制器
 mainVc 中间视图控制器
 @result instancetype 初始化生成的对象
 */
- (instancetype)initWithLeftView:(UIViewController *)leftVc
                     andMainView:(UIViewController *)mainVc;

/**
 @brief 关闭左视图
 */
- (void)closeLeftView;


/**
 @brief 打开左视图
 */
- (void)openLeftView;

/**
 *  设置滑动开关是否开启
 *
 *  @param enabled YES:支持滑动手势，NO:不支持滑动手势
 */
- (void)setPanEnabled: (BOOL) enabled;


@end
