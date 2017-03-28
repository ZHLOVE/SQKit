//
//  UTSpecialTabBar.m
//  tabBarCustomDemo
//
//  Created by xiongdexi on 16/9/1.
//  Copyright © 2016年 UTSFOT. All rights reserved.
//

#import "UTSpecialTabBar.h"
#import "UIView+UTLayout.h"
#import "UTSpecialTabBarbutton.h"

@interface UTSpecialTabBar ()
/** 按钮数组 */
@property (nonatomic, strong) NSMutableArray *btnsArray;
/** 记录当前选中按钮 */
@property (nonatomic, weak) UIButton *selectedButton;
/** plus按钮 */
@property (nonatomic, weak) UIButton *plusBtn ;

@end

@implementation UTSpecialTabBar

#pragma mark - lazy
- (NSMutableArray *)btnsArray {
    if (!_btnsArray) {
        _btnsArray = [NSMutableArray array];
    }
    return _btnsArray;
}

- (UIButton *)plusBtn
{
    if (_plusBtn == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [button setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        [button setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        
        [button addTarget:self action:@selector(clickAddBtn) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        _plusBtn = button;
    }
    return _plusBtn;
}

- (void)clickAddBtn
{
    if ((_myDelegate != nil) && [_myDelegate respondsToSelector:@selector(tabBarPlusBtnClick:)]) {
        [_myDelegate tabBarPlusBtnClick:self];
    }
}


#pragma mark - 方法实现
- (void)addTabBarButtonWithSpecialItem:(UITabBarItem *)item {
    
    UTSpecialTabBarbutton *button = [UTSpecialTabBarbutton buttonWithType:UIButtonTypeCustom];
    button.item = item;
    button.tag = self.btnsArray.count;
    [button addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchDown];
    
    if (self.btnsArray.count == 0) {
        [self didClickButton:button];
    }
    
    [self addSubview:button];
    [self.btnsArray addObject:button];
}

#pragma mark - 按钮的点击事件
- (void)didClickButton:(UIButton *)button {
    
    NSLog(@"点击了第%ld个按钮", (long)button.tag);
    
    _selectedButton.selected = NO;
    button.selected = YES;
    _selectedButton = button;
    
    // 通知tabBar切换控制器  调用代理方法
    if ((_myDelegate != nil) && [_myDelegate respondsToSelector:@selector(tabBar:didCilckButtonSelectedIndex:)]) {
        [_myDelegate tabBar:self didCilckButtonSelectedIndex:button.tag];
    }
}

#pragma mark - 布局控件
- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 设置内部按钮的位置
    [self setUpAllTabBarButtonFrame];
    // 设置发布按钮的位置
    [self setUpAddButtonFrame];
    
}

- (void)setUpAddButtonFrame
{
    CGFloat centerX = self.width * 0.5;
    CGFloat centerY = self.height * 0.5 - 15;
    self.plusBtn.size = [self.plusBtn backgroundImageForState:UIControlStateNormal].size;
    self.plusBtn.center = CGPointMake(centerX, centerY);
}

- (void)setUpAllTabBarButtonFrame
{
    NSInteger i = 0;
    NSInteger count = self.btnsArray.count + 1;
    CGFloat btnW = self.width / count;
    CGFloat btnH = self.height;
    
    for (UIView *tabBarButton in self.btnsArray) {
        if (i == 2) {
            i += 1;
        }
        tabBarButton.frame = CGRectMake(i * btnW, 0, btnW, btnH);
        i++;
    }
}



@end
