//
//  ViewController.m
//  类似于键盘的选择器
//
//  Created by Qian Shen on 2017/3/4.
//  Copyright © 2017年 Qian Shen. All rights reserved.
//

#import "ViewController.h"
#import "ClassViewController.h"
#import "AddressModel.h"

@interface ViewController ()<ClassViewControllerDelegate>

@property(nonatomic,strong)ClassViewController *vc;
@property(nonatomic,strong)NSArray *aarr;
@property (weak, nonatomic) IBOutlet UILabel *showLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"address" ofType:@"plist"];
    NSDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    
    NSLog(@"---%@---",data);
    NSArray *arr = data[@"address"];
    NSMutableArray *marr = [@[]mutableCopy];
    for (NSDictionary *info in arr) {
        AddressModel *model = [[AddressModel alloc]initWithDictionary:info error:nil];
        [marr addObject:model];
    }
    NSLog(@"%@",marr);
    
    _aarr = [marr copy];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)click:(id)sender{
    self.vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    self.vc.dataSource = _aarr;
    [self presentViewController:_vc animated:NO completion:^{
        _vc.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
        [_vc show];
    }];
    
}

-(ClassViewController *)vc{
    if (!_vc) {
        _vc = [[ClassViewController alloc]initWithDelegate:self];
    }
    return _vc;
}

#pragma - classVcDelegate

- (void)ClassViewController:(ClassViewController *)viewController classInfo:(NSDictionary *)info {
    _showLabel.text = [NSString stringWithFormat:@"%@---%@",info[@"st1"],info[@"st2"]];
}


@end
