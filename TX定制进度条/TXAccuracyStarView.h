//
//  TXAccuracyStarView.h
//  iOS开发常见技术-每日一记
//
//  Created by Qian Shen on 2017/3/14.
//  Copyright © 2017年 Qian Shen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TXAccuracyStarView;

@protocol TXAccuracyStarViewDelegate <NSObject>

@required

- (void)TXAccuracyStarView:(TXAccuracyStarView*)accuracyStarView clickStarBtn:(UIButton*) starBtn ofIndex:(NSInteger)index;

@end

@interface TXAccuracyStarView : UIView

/**
 * 快速创建 TXAccuracyStarView
 */
+ (instancetype)setupAccuracyStarViewWithFrame:(CGRect)frame delegate:(id)delegate;


/**代理*/
@property (nonatomic, weak) id<TXAccuracyStarViewDelegate> delegate;


@end
