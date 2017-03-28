//
//  NetErrorView.h
//  iOS开发常见技术-每日一记
//
//  Created by Qian Shen on 2017/3/4.
//  Copyright © 2017年 Qian Shen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NetErrorView;
@protocol NetErrorViewDelegate <NSObject>

-(void)reloadDataNetErrorView:(NetErrorView*)errorView;

@end

@interface NetErrorView : UIView


/**代理*/
@property (nonatomic, weak) id<NetErrorViewDelegate> delegate;

- (void)stopNetViewLoadingFail:(BOOL)fail error:(BOOL)error;


@end
