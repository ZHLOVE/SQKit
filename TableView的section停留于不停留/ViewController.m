//
//  ViewController.m
//  TableView的section停留于不停留
//
//  Created by Qian Shen on 2017/3/13.
//  Copyright © 2017年 Qian Shen. All rights reserved.
//

#import "ViewController.h"

static NSString *const cellID = @"cellID";
static NSString *const headerID = @"headerID";
static NSString *const footerID = @"footerID";

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, strong)UITableView *tableView;





@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /**
     * UITableViewStyleGrouped 的section 不会停留
     */
    
    [self.view addSubview:self.tableView];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"这是测试数据%zd",indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 20;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerID];
    if (!headerView) {
        headerView = [[UIView alloc]init];
        headerView.backgroundColor = [UIColor redColor];
    }
    return headerView;
}




-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footerID];
    if (!footerView) {
        footerView = [[UIView alloc]init];
        footerView.backgroundColor = [UIColor yellowColor];
    }
    return footerView;
}




- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}


@end
