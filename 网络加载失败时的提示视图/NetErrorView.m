//
//  NetErrorView.m
//  iOS开发常见技术-每日一记
//
//  Created by Qian Shen on 2017/3/4.
//  Copyright © 2017年 Qian Shen. All rights reserved.
//

#import "NetErrorView.h"
#import "Masonry.h"

@interface NetErrorView ()


/**加载动画*/

@property (nonatomic,strong)UIImageView *animationImgView;

/**加载失败图片*/

@property (nonatomic,strong)UIImageView *statusImgView;

/**加载失败or断网*/

@property (nonatomic,strong)UILabel *contentL;

/**点击屏幕重新加载*/
@property (nonatomic, strong) UILabel *descL;

/**点击手势*/
@property (nonatomic, strong) UITapGestureRecognizer *tap;





@end

@implementation NetErrorView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpViews];
    }
    return self;
}


-(void)setUpViews{
    _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hanleTap:)];
    [self addGestureRecognizer:_tap];
    self.statusImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"网络异常"]];
    [self addSubview:self.statusImgView];
    [self.statusImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(100);
    }];
    self.statusImgView.hidden = YES;
    
    self.contentL = [[UILabel alloc]init];
    self.contentL.text = @"加载失败";
    [self addSubview:self.contentL];
    [self.contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(_statusImgView.mas_bottom).offset(20);
    }];
    self.contentL.hidden = YES;
    
    self.descL = [[UILabel alloc]init];
    self.descL.text = @"点击屏幕，重新加载";
    [self addSubview:self.descL];
    [self.descL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(_contentL.mas_bottom).offset(20);
    }];
    
    self.descL.hidden = YES;
    
    
    self.animationImgView= [[UIImageView alloc]init];
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for (int i = 0; i < 33; i++) {
        NSString *str;
        if (i <10) {
            str = [NSString stringWithFormat:@"PR_2_0000%d", i];
        }else{
            str = [NSString stringWithFormat:@"PR_2_000%d", i];
        }
        UIImage *image = [UIImage imageNamed:str];
        [arr addObject:image];
    }
    self.animationImgView.animationImages = arr;
    self.userInteractionEnabled = NO;
    [self.animationImgView setAnimationDuration:0.6];
    [self.animationImgView setAnimationRepeatCount:0];
    [self.animationImgView startAnimating];
    [self addSubview:self.animationImgView];
    [self.animationImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(180);
    }];
}

- (void)startAnimaiton{
    self.animationImgView.hidden = NO;
    [self.animationImgView startAnimating];
    self.statusImgView.hidden = YES;
    self.contentL.hidden = YES;
    self.descL.hidden = YES;
}


- (void)stopNetViewLoadingFail:(BOOL)fail error:(BOOL)error{
    [self.animationImgView stopAnimating];
    self.animationImgView.hidden = YES;
    if (fail || error) {
        self.userInteractionEnabled = YES;
        //[self addGestureRecognizer:_tap];
        self.statusImgView.hidden = NO;
        self.contentL.hidden = NO;
        self.descL.hidden = NO;
        if (fail) {
            self.contentL.text = @"网络异常";
        }else{
            self.contentL.text = @"加载失败";
        }
    }else{
        self.statusImgView.hidden = YES;
        self.contentL.hidden = YES;
        self.descL.hidden = YES;
        [self removeFromSuperview];
    }
}


- (void)hanleTap:(UIGestureRecognizer*)gesture{
    //[self removeGestureRecognizer:_tap];
    [self startAnimaiton];
    if ([self.delegate respondsToSelector:@selector(reloadDataNetErrorView:)]) {
        [self.delegate reloadDataNetErrorView:self];
    }
}


@end







