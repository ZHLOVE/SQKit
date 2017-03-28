//
//  TXAccuracyStarView.m
//  iOS开发常见技术-每日一记
//
//  Created by Qian Shen on 2017/3/14.
//  Copyright © 2017年 Qian Shen. All rights reserved.
//

#import "TXAccuracyStarView.h"
#define kStarBtnTag 1000

@implementation TXAccuracyStarView


+ (instancetype)setupAccuracyStarViewWithFrame:(CGRect)frame delegate:(id)delegate{
    TXAccuracyStarView *accuracyStarView = [[NSBundle mainBundle]loadNibNamed:@"TXAccuracyStarView" owner:self options:nil].lastObject;
    accuracyStarView.frame = frame;
    accuracyStarView.delegate = delegate;
    return accuracyStarView;
}

- (IBAction)clickBtn:(UIButton *)sender {
    NSArray *views = self.subviews;
    for (NSInteger i = 0; i < views.count; i ++) {
        UIView *tempView = views[i];
        UIButton *starBtn = (UIButton*)tempView.subviews.lastObject;
        UIImage *img = starBtn.tag <= sender.tag ? [UIImage imageNamed:@"item2default"] :[UIImage imageNamed:@"item2checked"];
        [starBtn setImage:img forState:UIControlStateNormal];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(TXAccuracyStarView:clickStarBtn:ofIndex:)]) {
        [_delegate TXAccuracyStarView:self clickStarBtn:sender ofIndex:sender.tag % kStarBtnTag];
    }
}







@end
