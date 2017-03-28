//
//  ViewController.m
//  为UITextView添加提示文本
//
//  Created by Qian Shen on 2017/3/6.
//  Copyright © 2017年 Qian Shen. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>

static NSString *const placeholderLabel = @"_placeholderLabel";

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 通过运行时，发现UITextView有一个叫做“_placeHolderLabel”的私有变量
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([UITextView class], &count);
    
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        NSString *objcName = [NSString stringWithUTF8String:name];
        NSLog(@"%d : %@",i,objcName);
    }
    
    [self setupTextView];
}



#pragma - 方法一

- (void)setupTextView
{
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 400, 200, 50)];
    [textView setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:textView];
    // _placeholderLabel
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.text = @"请输入内容";
    placeHolderLabel.numberOfLines = 0;
    placeHolderLabel.textColor = [UIColor lightGrayColor];
    [placeHolderLabel sizeToFit];
    [textView addSubview:placeHolderLabel];
    
    // same font
    textView.font = [UIFont systemFontOfSize:13.f];
    placeHolderLabel.font = [UIFont systemFontOfSize:13.f];
    
    [textView setValue:placeHolderLabel forKey:placeholderLabel];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
