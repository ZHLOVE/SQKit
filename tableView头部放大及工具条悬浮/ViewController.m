//
//  ViewController.m
//  tableView头部放大及工具条悬浮
//
//  Created by Qian Shen on 2017/3/8.
//  Copyright © 2017年 Qian Shen. All rights reserved.
//

#import "ViewController.h"


#define kscreen_w ([UIScreen mainScreen].bounds.size.width)

#define screen_h  ([UIScreen mainScreen].bounds.size.height)


@interface ViewController ()<UIScrollViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

/**头部*/
@property (nonatomic, strong) UIView *headView;

/**工具条*/
@property (nonatomic, strong) UIView *toolView;

/**头部背景*/
@property (nonatomic, strong) UIImageView *headImgView;

@property (nonatomic, assign) CGFloat oldOffsetY;




@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableHeaderView = self.headView;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"这是测试数据%ld",indexPath.row + 1];
    return cell;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat cuurenOffsetY = (scrollView.contentOffset.y);
    if(cuurenOffsetY < 0){
        self.toolView.frame = CGRectMake(0, 0, kscreen_w, 40);
        [self.headImgView addSubview:self.toolView];
        return;
    }
    
    //[self demo1:cuurenOffsetY];
    // 下拉
    if (cuurenOffsetY < _oldOffsetY) {
        self.toolView.frame = CGRectMake(0, 64, kscreen_w, 40);
        [self.view addSubview:self.toolView];
    }else{
        self.toolView.frame = CGRectMake(0, 0, kscreen_w, 40);
        [self.headImgView addSubview:self.toolView];
    }
    _oldOffsetY = cuurenOffsetY;
}



- (void)demo1:(CGFloat)offsetY {
    if (offsetY > 260) {
        self.toolView.frame = CGRectMake(0, 64, kscreen_w, 40);
        [self.view addSubview:self.toolView];
    }else{
        self.toolView.frame = CGRectMake(0, 260, kscreen_w, 40);
        [self.headView addSubview:self.toolView];
    }
}


- (UIView *)headView {
    if (!_headView) {
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kscreen_w, 300)];
        _headView.backgroundColor = [UIColor blueColor];
        
        _headImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kscreen_w, 300)];
        _headImgView.backgroundColor = [UIColor redColor];
        _headImgView.image = [UIImage imageNamed:@"kk.jpg"];
        [_headView addSubview:_headImgView];
        
        _toolView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kscreen_w, 40)];
        _toolView.backgroundColor = [UIColor yellowColor];
        [_headImgView addSubview:_toolView];
    }
    return _headView;
}




@end
