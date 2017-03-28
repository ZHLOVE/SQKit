//
//  HomeTitleView.m
//  iOS开发常见技术-每日一记
//
//  Created by Qian Shen on 2017/3/8.
//  Copyright © 2017年 Qian Shen. All rights reserved.
//

#import "HomeTitleView.h"

@implementation HomeTitleView

+ (instancetype)setUpTitleView {
    HomeTitleView *titleView =   [[NSBundle mainBundle] loadNibNamed:@"HomeTitleView" owner:self options:nil].lastObject;
    titleView.backgroundColor = [UIColor clearColor];
    return titleView;
}
@end
