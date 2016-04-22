//
//  MainViewController.m
//  DemoCollectOC
//
//  Created by Shawn.Du on 16/3/31.
//  Copyright © 2016年 Shawn.Du. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation MainViewController {
    UITableView *_tableView;
    NSArray *_classNames;
}

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    _classNames = @[@"AppListViewController", @"GifDisplayViewController"];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

#pragma mark - tableView datasouce

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _classNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"MainTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = _classNames[indexPath.row];
    return cell;
}


#pragma mark tableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Class cls = NSClassFromString(_classNames[indexPath.row]);
    if (cls) {
        UIViewController *ctrl = cls.new;
        ctrl.title = _classNames[indexPath.row];
        [self.navigationController pushViewController:ctrl animated:YES];
    }
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
