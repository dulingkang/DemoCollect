//
//  UIViewController+SSReport.m
//  DemoCollectOC
//
//  Created by ShawnDu on 2017/3/11.
//  Copyright © 2017年 Shawn.Du. All rights reserved.
//

#import "UIViewController+SSReport.h"
#import "Aspects.h"

@implementation UIViewController (SSReport)

+ (void)load {
    [UIViewController aspect_hookSelector:@selector(viewDidLoad) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo){
        NSString *className = NSStringFromClass([[aspectInfo instance] class]);
        NSLog(@"%@viewDidLoad", className);
    } error:NULL];
}

@end
