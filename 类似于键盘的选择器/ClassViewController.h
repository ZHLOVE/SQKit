//
//  ClassViewController.h
//  iOS开发常见技术-每日一记
//
//  Created by Qian Shen on 2017/3/4.
//  Copyright © 2017年 Qian Shen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ClassViewController;
@protocol ClassViewControllerDelegate <NSObject>

@required

-(void)ClassViewController:(ClassViewController*)viewController classInfo:(NSDictionary *)info;

@end


@interface ClassViewController : UIViewController


/**数据源*/
@property (nonatomic, strong) NSArray *dataSource;

/**代理*/
@property (nonatomic, weak) id<ClassViewControllerDelegate> delegate;

-(instancetype)initWithDelegate:(id)delegate;

-(void)show;



@end
