//
//  UTCommonTabBar.m
//  tabBarCustomDemo
//
//  Created by xiongdexi on 16/8/31.
//  Copyright © 2016年 UTSFOT. All rights reserved.
//

#import "UTCommonTabBar.h"
#import "UIView+UTLayout.h"
#import "UTCommonTabBarButton.h"

@interface UTCommonTabBar ()
/** 按钮数组 */
@property (nonatomic, strong) NSMutableArray *btnsArray;

/** 记录当前选中按钮 */
@property (nonatomic, weak) UIButton *selectedButton;

@end

@implementation UTCommonTabBar

#pragma mark - lazy
- (NSMutableArray *)btnsArray {
    if (!_btnsArray) {
        _btnsArray = [NSMutableArray array];
    }
    return _btnsArray;
}

- (void)addTabBarButtonWithItem:(UITabBarItem *)item {
    UTCommonTabBarButton *button = [UTCommonTabBarButton buttonWithType:UIButtonTypeCustom];
    
    button.item = item;
    
    [button addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchDown];
    
    button.tag = self.btnsArray.count;
    
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
    
}



- (void)setUpAllTabBarButtonFrame
{
    NSInteger i = 0;
    NSInteger count = self.btnsArray.count;
    CGFloat btnW = self.width / count;
    CGFloat btnH = self.height;
    
    for (UIView *tabBarButton in self.btnsArray) {
        
        tabBarButton.frame = CGRectMake(i * btnW, 0, btnW, btnH);
        
        i++;
        
    }
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
