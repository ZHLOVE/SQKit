//
//  ViewController.m
//  防止按钮重复点
//
//  Created by Qian Shen on 2017/3/13.
//  Copyright © 2017年 Qian Shen. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+UnClick.h"

#define kUnclickTime 1 // 防止按钮重复点击的时间间隔

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *Btn;

@property (weak, nonatomic) IBOutlet UILabel *showL;


/**num*/
@property (nonatomic, assign) NSInteger num;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _num = 0;
    //_Btn.acceptEventInterval = 3;
    // Do any additional setup after loading the view, typically from a nib.
    
   
}


- (IBAction)clickAddBtn:(UIButton*)sender {
    //[sender setAcceptEventInterval:1];
    _num += 1;
    NSString *text = [NSString stringWithFormat:@"%zd",_num];
    self.showL.text = text;
    
     [self.Btn startWithTime:6 title:@"获取验证码" countDownTitle:@"重新获取" mainColor:[UIColor redColor] countColor:[UIColor blueColor]];
}



@end
