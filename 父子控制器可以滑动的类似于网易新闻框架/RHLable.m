//
//  RHLable.m
//  iOS开发常见技术-每日一记
//
//  Created by Qian Shen on 2017/3/4.
//  Copyright © 2017年 Qian Shen. All rights reserved.
//

#import "RHLable.h"

@implementation RHLable

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //1:设置自身的属性
        self.font = [UIFont systemFontOfSize:15];
        self.textAlignment = NSTextAlignmentCenter;
        //self.textColor = [UIColor colorWithRed:RHRed green:RHGreen blue:RHBlue alpha:1];
        self.userInteractionEnabled = YES;
    }

    return self;
}

- (void)setSca:(CGFloat)sca {
    
    _sca = sca;

    // R G B
    // 默认：0.4 0.6 0.7
    // 红色：1   0   0
    /*CGFloat redScale = RHRed + (1 - RHRed) *sca;
    CGFloat greenScale = RHGreen - RHGreen *sca;
    CGFloat blueScale = RHBlue - RHBlue *sca;
    self.textColor = [UIColor colorWithRed:redScale green:greenScale blue:blueScale alpha:1];
    */
    CGFloat fontScale = 1 +sca *0.3;
    self.transform = CGAffineTransformMakeScale(fontScale, fontScale);
    
}

@end
