//
//  SyncViewController.m
//  DemoCollectOC
//
//  Created by Shawn on 2017/8/7.
//  Copyright © 2017年 Shawn.Du. All rights reserved.
//

#import "SyncViewController.h"

@interface SyncViewController ()

@end

@implementation SyncViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addWhileLoop];
    
}

- (void)addWhileLoop {
    dispatch_queue_t queue = dispatch_queue_create("com.shawn.whileLoopQueue", DISPATCH_QUEUE_CONCURRENT);
    __block BOOL complete;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        complete = YES;
    });
    dispatch_async(queue, ^{
        while (!complete) {
        }
        NSLog(@"loop end.");
    });
}

@end
