//
//  AppstoreEvaluateViewController.m
//  DemoCollectOC
//
//  Created by ShawnDu on 16/4/28.
//  Copyright © 2016年 Shawn.Du. All rights reserved.
//

#import "AppstoreEvaluateViewController.h"

#define AppstoreUrl @"https://itunes.apple.com/cn/app/ai-pai-mei-tu-zi-pai-mei-yan/id995074579?mt=8"

@interface AppstoreEvaluateViewController ()

@end

@implementation AppstoreEvaluateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(20, 70, 50, 50);
    [button setTitle:@"评价" forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"login_icon_pass_highlight"] forState:UIControlStateNormal];
    [button addTarget: self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    // Do any additional setup after loading the view.
}

- (void)buttonPressed:(UIButton *)sender {
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:AppstoreUrl]];
}
@end
