//
//  HomeTitleView.h
//  iOS开发常见技术-每日一记
//
//  Created by Qian Shen on 2017/3/8.
//  Copyright © 2017年 Qian Shen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTitleView : UIView
@property (weak, nonatomic) IBOutlet UIButton *titleBtn;

+ (instancetype)setUpTitleView;

@end
