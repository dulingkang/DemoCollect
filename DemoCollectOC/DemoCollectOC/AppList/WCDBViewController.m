//
//  WCDBViewController.m
//  DemoCollectOC
//
//  Created by Shawn on 2017/9/26.
//  Copyright © 2017年 Shawn.Du. All rights reserved.
//

#import "WCDBViewController.h"
#import "DCGlobalDef.h"
#import "Message.h"
#import "WCTDatabase+Database.h"

@interface WCDBViewController ()

@end

@implementation WCDBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"path: %@", kDocumentPath);
    WCTDatabase *database = [[WCTDatabase alloc] initWithPath: kDocumentPath];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
