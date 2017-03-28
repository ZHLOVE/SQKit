//
//  UTCommonTabBarButton.m
//  tabBarCustomDemo
//
//  Created by xiongdexi on 16/8/31.
//  Copyright © 2016年 UTSFOT. All rights reserved.
//

#import "UTCommonTabBarButton.h"

#define UTImageRidio 0.7

@implementation UTCommonTabBarButton

// 取消高亮做的事情
- (void)setHighlighted:(BOOL)highlighted{}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 设置字体颜色
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        
    }
    return self;
}
// 传递UITabBarItem给tabBarButton,给tabBarButton内容赋值
- (void)setItem:(UITabBarItem *)item
{
    _item = item;
    
    [self setImage:item.image forState:UIControlStateNormal];
    [self setImage:item.selectedImage forState:UIControlStateSelected];
    
    [self setTitle:item.title forState:UIControlStateNormal];
    
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
    
    // KVO：
    [item addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:NSKeyValueObservingOptionNew context:nil];
    
}
// 实时监听方法: 只要监听的属性一有新值，就会调用
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    [self setTitle:_item.title forState:UIControlStateNormal];
    
    [self setImage:_item.image forState:UIControlStateNormal];
    
    [self setImage:_item.selectedImage forState:UIControlStateSelected];
    
    
}

- (void)dealloc
{
    //    [_item removeObserver:self forKeyPath:@"badgeValue"];
    [_item removeObserver:self forKeyPath:@"image"];
    [_item removeObserver:self forKeyPath:@"selectedImage"];
    [_item removeObserver:self forKeyPath:@"title"];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1.imageView
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageW = self.bounds.size.width;
    CGFloat imageH = self.bounds.size.height * UTImageRidio;
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    
    
    // 2.title
    CGFloat titleX = 0;
    CGFloat titleY = imageH - 3;
    CGFloat titleW = self.bounds.size.width;
    CGFloat titleH = self.bounds.size.height - titleY;
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
}

@end
