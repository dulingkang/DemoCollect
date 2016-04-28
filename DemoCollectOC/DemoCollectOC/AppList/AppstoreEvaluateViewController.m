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
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:AppstoreUrl]];
    // Do any additional setup after loading the view.
}

@end
