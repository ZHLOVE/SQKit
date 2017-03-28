//
//  ClassViewController.m
//  iOS开发常见技术-每日一记
//
//  Created by Qian Shen on 2017/3/4.
//  Copyright © 2017年 Qian Shen. All rights reserved.
//

#import "ClassViewController.h"
#import "AddressModel.h"

@interface ClassViewController ()

{
    NSString *str1;
    NSString *str2;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;

@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;






@end

@implementation ClassViewController


-(instancetype)initWithDelegate:(id)delegate {
    if (self = [super init] ) {
        _delegate = delegate;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickTap)];
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];
}


#pragma - methods

-(void)show{
    _bottomConstraint.constant = -300;
    [self.view layoutIfNeeded];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.2
                         animations:^{
                             self.view.alpha = 1;
                             self.bottomConstraint.constant = 0;
                             [self.view layoutIfNeeded];
                         }];
    });
}

#pragma - events

-(void)clickTap{
    [self cancel:nil];
}

/**
 * 取消
 */

- (IBAction)cancel:(id)sender{
    [UIView animateWithDuration:0.3 animations:^{
        self.bottomConstraint.constant = -300;
        [self.view layoutIfNeeded];
        self.view.alpha = 0;
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:^{
        }];
    }];
}

/**
 * 确定
 */

-(IBAction)sure:(id)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(ClassViewController:classInfo:)]) {
        [_delegate ClassViewController:self classInfo:@{@"st1":str1,@"st2":str2}];
    }
}


#pragma - pickerViewDelegate 

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}


//pickerView 数据内容
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (component == 0) {
        return self.dataSource.count;
    }
    else if (component == 1) {
        NSInteger row = [pickerView selectedRowInComponent:0];
        AddressSencodModel *model = self.dataSource[row];
        return [model.sub count];
    }
    return 0;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (component == 0) {
         AddressModel *model = self.dataSource[row];
        return model.name;
    }
    else if(component == 1){
        NSInteger row0 = [pickerView selectedRowInComponent:0];
        AddressModel *model = self.dataSource[row0];
        AddressSencodModel *m = model.sub[row];
        return m.name;
    }
    return nil;
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *pickerLabel = (UILabel *)view;
    if (!pickerLabel) {
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        pickerLabel.font = [UIFont systemFontOfSize:15];
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    //在该代理方法里添加以下两行代码删掉上下的黑线
    [[pickerView.subviews objectAtIndex:1] setBackgroundColor:[UIColor redColor]];
    [[pickerView.subviews objectAtIndex:2] setBackgroundColor:[UIColor blueColor]];
    return pickerLabel;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSLog(@"%@-----",[NSString stringWithFormat:@"%zd",row]);
    
    if (component == 0) {
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        
        AddressModel *model = self.dataSource[row];
        str1 = model.name;
        str2 = ((AddressSencodModel*)model.sub.firstObject).name;
        
    }else if(component == 1){
        NSInteger row0 = [pickerView selectedRowInComponent:0];
        AddressModel *model = self.dataSource[row0];
        str2 = ((AddressSencodModel*)model.sub[row]).name;
    }
    NSLog(@"%@----%@",str1,str2);
    
}











@end























