//
//  ViewController.m
//  自动计算文本高度刷新约束
//
//  Created by Qian Shen on 2017/3/6.
//  Copyright © 2017年 Qian Shen. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "CustomTextField.h"
#import <objc/runtime.h>
#import "Masonry.h"

@interface ViewController ()<UITextViewDelegate>

@property (weak, nonatomic) UITextView *textView;
//@property (weak, nonatomic) UIButton *btn;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    //设置leftView
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    imageView.image = [UIImage imageNamed:@"image.jpg"];
    imageView.clipsToBounds = YES;
    imageView.layer.cornerRadius = imageView.frame.size.height/2;
    //初始化
    CustomTextField *textField = [[CustomTextField alloc]initWithFrame:CGRectMake(10, 340, 300, 30) placeholder:@"自动换行textField" clear:YES leftView:imageView fontSize:20.0];
    textField.layer.borderWidth = 1.0;
    textField.layer.borderColor = [UIColor purpleColor].CGColor;
    textField.layer.cornerRadius = textField.frame.size.height/2;
    
    [self.view addSubview:textField];
    
    UITextField *textF = [[UITextField alloc]init];
    textF.clearButtonMode = UITextFieldViewModeWhileEditing;
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

- (void)setupTextView
{
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 400, 200, 30)];
    [textView setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:textView];
    // _placeholderLabel
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.text = @"请输入内容";
    placeHolderLabel.numberOfLines = 0;
    placeHolderLabel.textColor = [UIColor lightGrayColor];
    [placeHolderLabel sizeToFit];
    [textView addSubview:placeHolderLabel];
    textView.delegate = self;
    // same font
    textView.font = [UIFont systemFontOfSize:13.f];
    placeHolderLabel.font = [UIFont systemFontOfSize:13.f];
    [textView setValue:placeHolderLabel forKey:@"_placeholderLabel"];
    _textView = textView;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(200 - 50, 0, 30, 30);
//    btn.center = CGPointMake(btn.center.x, _textView.center.y);
    [btn setImage:[UIImage imageNamed:@"clear"] forState:UIControlStateNormal];
    //btn.frame = CGRectMake(200 - 50, 0, 30, 30);
    [textView addSubview:btn];
    NSLog(@"%@",[NSString stringWithFormat:@" x == %f -- y == %f",textView.center.x,textView.center.y]);
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(@(200 - 50));
        make.width.mas_equalTo(@(30));
        make.height.mas_equalTo(btn.mas_width);
        make.centerY.mas_equalTo(@((CGRectGetHeight(_textView.frame) - 30) / 2.0));
    }];
    
    
    
}



-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    // 文本内容
    NSString *newStr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    // 动态计算文本高度
    CGSize size = [self sizeWithFont:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(200, MAXFLOAT) str:newStr];
    textView.frame = CGRectMake(textView.frame.origin.x, textView.frame.origin.y, 200, size.height + 13);
    return YES;
}


- (CGFloat)heightForWidth:(float)width andFont:(UIFont * _Nonnull)font str:(NSString *)str{
    return [self sizeWithFont:font maxSize:CGSizeMake(width, MAXFLOAT) str:str].height;
}

- (CGSize)sizeWithFont:(UIFont * _Nonnull)font maxSize:(CGSize)maxSize str:(NSString*)str
{
    CGSize size = CGSizeZero;
    if (str.length > 0) {
        CGRect frame = [str boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{ NSFontAttributeName: font } context:nil];
        size = CGSizeMake(frame.size.width, frame.size.height + 1);
    }
    return size;
}

@end
