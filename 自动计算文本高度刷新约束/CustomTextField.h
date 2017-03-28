//
//  CustomTextField.h
//  iOS开发常见技术-每日一记
//
//  Created by Qian Shen on 2017/3/6.
//  Copyright © 2017年 Qian Shen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTextField : UITextField<UITextFieldDelegate>


/**
 *  自定义初始化方法
 *
 *  @param frame       frame
 *  @param placeholder 提示语
 *  @param clear       是否显示清空按钮 YES为显示
 *  @param view        是否设置leftView不设置传nil
 *  @param font        设置字号
 *
 *  @return
 */
-(id)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder clear:(BOOL)clear leftView:(id)view fontSize:(CGFloat)font;


@end
