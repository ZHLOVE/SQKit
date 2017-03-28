//
//  ReachabilityUtil.m
//  iOS开发常见技术-每日一记
//
//  Created by Qian Shen on 2017/3/10.
//  Copyright © 2017年 Qian Shen. All rights reserved.
//

#import "ReachabilityUtil.h"
#import "Reachability.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"

@interface ReachabilityUtil ()

@property (nonatomic, strong) Reachability *hostReach;


@end

@implementation ReachabilityUtil

static ReachabilityUtil *_util;

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _util = [super allocWithZone:zone];
    });
    return _util;
}

+ (instancetype)shareReachabilityUtil {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _util = [[self alloc]init];
    });
    return _util;
}

+ (BOOL)getCurrentReachabilityState {
    Reachability * reach = [Reachability reachabilityForInternetConnection];
    NSString * tips = @"";
    BOOL state = YES;
    switch (reach.currentReachabilityStatus)
    {
        case NotReachable:
            tips = @"无网络连接";
            state = NO;
            break;
            
        case ReachableViaWiFi:
            tips = @"当前网络为Wifi";
            state = YES;
            break;
            
        case ReachableViaWWAN:
            state = YES;
            //NSLog(@"当前网络为移动流量");
        case kReachableVia2G:
            state = YES;
            tips = @"当前网络为2G";
            break;
            
        case kReachableVia3G:
            state = YES;
            tips = @"当前网络为3G";
            break;
            
        case kReachableVia4G:
            state = YES;
            tips = @"当前网络为4G";
            break;
    }
    [self show:tips];
    return state;
}

+ (BOOL)getCurrentAFNetworkingState {
    /**
     * 这个网络请求状态获取非常准确，每次改变网络都能准确的监听。
     */
    __block NSString *netState;
    __block BOOL state = YES;
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            state = NO;
            NSLog(@"未识别的网络");
            break;
            case AFNetworkReachabilityStatusNotReachable:
            state = YES;
            netState = @"无网络连接";
            break;
            
            case AFNetworkReachabilityStatusReachableViaWWAN:
            state = YES;
            netState = @"当前网络为移动流量";
            break;
             
            case AFNetworkReachabilityStatusReachableViaWiFi:
            state = YES;
            netState = @"当前网络为Wifi";
            break;
        }
        [self show:netState];
         
    }];
    [manager startMonitoring];
    return state;
}

- (void)addReachability {
    // 监测网络情况
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name: kReachabilityChangedNotification
                                               object: nil];
    _hostReach = [Reachability reachabilityWithHostName:@"https://www.baidu.com"];
    [_hostReach startNotifier];
    [self updateInterfaceWithReachability:_hostReach];
}

- (void)reachabilityChanged:(NSNotification *) note {
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    [self updateInterfaceWithReachability:curReach];
}

- (NSString*)updateInterfaceWithReachability:(Reachability *)reach
{
    NetworkStatus status = [reach currentReachabilityStatus];
    NSString *tips;
    switch (status)
    {
        case NotReachable:
            tips = @"无网络连接";
            break;
        case ReachableViaWiFi:
            tips = @"当前网络为wifi";
            break;
        case ReachableViaWWAN:
            tips = @"当前网络为移动流量";
            break;
        case kReachableVia2G:
            tips = @"当前网络为2G";
            break;
        case kReachableVia3G:
            tips = @"当前网络为3G";
            break;
        case kReachableVia4G:
            tips = @"当前网络为4G";
            break;
    }
    [self show:tips toView:nil];
    return tips;
}

- (void)show:(NSString *)text toView:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = text;
    hud.color = [UIColor lightGrayColor];
    // 再设置模式
    hud.mode = MBProgressHUDModeText;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // 1秒之后再消失
    [hud hide:YES afterDelay:0.7];
}

+ (void)show:(NSString *)text
{
    UIView *view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = text;
    hud.color = [UIColor lightGrayColor];
    // 再设置模式
    hud.mode = MBProgressHUDModeText;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // 1秒之后再消失
    [hud hide:YES afterDelay:0.7];
}




@end
