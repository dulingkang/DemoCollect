//
//  RuntimeViewController.m
//  DemoCollectOC
//
//  Created by ShawnDu on 2016/11/8.
//  Copyright © 2016年 Shawn.Du. All rights reserved.
//

#import "RuntimeViewController.h"
#import <mach/mach_time.h>


@interface RuntimeViewController ()

@end

@implementation RuntimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    mach_timebase_info_data_t info;
    if (mach_timebase_info(&info) != KERN_SUCCESS) {
        return ;
    }
    UInt64 startTime = mach_absolute_time();
//    [self createArray];
    void (*setter)(id, SEL, BOOL);
    int i;
    setter = (void (*)(id, SEL, BOOL))[self methodForSelector:@selector(createArray)];
    for (NSInteger i = 0; i < 1000; i++) {
        
    }
    UInt64 endTime = mach_absolute_time();
    uint64_t elapsedNanoSeconds = (endTime - startTime) * info.numer / info.denom;

    NSLog(@">>>>>used:%lf", elapsedNanoSeconds/1000000000.0);
    
}

- (void)createArray {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:10000];
    for (NSInteger i = 0; i < 1000; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, i/3, i/3)];
        [array addObject:view];
    }
}

@end
