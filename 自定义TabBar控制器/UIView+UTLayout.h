//
//  UIView+UTLayout.h
//  uhoo
//
//  Created by 杨常勇 on 16/8/16.
//  Copyright © 2016年 UTOUU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (UTLayout)
@property (nonatomic, assign)CGFloat centerX;
@property (nonatomic, assign)CGFloat centerY;
@property (nonatomic, assign)CGSize size;

- (CGFloat)maxX;
- (CGFloat)maxY;
- (CGFloat)minX;
- (CGFloat)minY;
- (CGFloat)midX;
- (CGFloat)midY;

- (CGFloat)X;
- (CGFloat)Y;
- (void)setX:(CGFloat)x;
- (void)setY:(CGFloat)y;

- (CGFloat)height;
- (CGFloat)width;
- (void)setWidth:(CGFloat)width;
- (void)setHeight:(CGFloat)height;

- (void)setFrameCenterWithSuperView:(UIView *)superView size:(CGSize)size;
- (void)setFrameInBottomCenterWithSuperView:(UIView *)superView size:(CGSize)size;

@end
