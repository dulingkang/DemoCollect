//
//  UIViewController+SSViewConfigure.m
//  DemoCollectOC
//
//  Created by Shawn on 2017/8/7.
//  Copyright © 2017年 Shawn.Du. All rights reserved.
//

#import "UIViewController+SSViewConfigure.h"
#import "Aspects.h"

@implementation UIViewController (SSViewConfigure)

+ (void)load {
    [UIViewController aspect_hookSelector:@selector(viewDidLoad) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo){
        id controller = [aspectInfo instance];
        if ([controller isKindOfClass:[UIViewController class]]) {
            UIViewController *ctl = (UIViewController *)controller;
            ctl.view.backgroundColor = [UIColor whiteColor];
        }
    } error:NULL];
}

@end
