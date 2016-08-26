//
//  CategoryTestViewController.m
//  DemoCollectOC
//
//  Created by ShawnDu on 16/8/26.
//  Copyright © 2016年 Shawn.Du. All rights reserved.
//

#import "CategoryTestViewController.h"

@interface ClassA : NSObject
- (void)test;
@end

@implementation ClassA
- (void)test {
    NSLog(@"ClassA,root");
}

@end

@interface ClassA (test1)
- (void)test;
@end

@implementation ClassA (test1)
- (void)test {
    NSLog(@"test1,root");
}

@end

@interface ClassA (test2)
- (void)test;
@end

@implementation ClassA (test2)
- (void)test {
    NSLog(@"test2,root");
}

@end
//
//@interface UIView (testView)
//- (instancetype)initWithFrame:(CGRect)frame;
//@end
//
//@implementation UIView (testView)
//
//- (instancetype)initWithFrame:(CGRect)frame {
//    NSLog(@"testview");
//    return nil;
//}

//@end

@interface NSString (testString)
- (unichar)characterAtIndex:(NSUInteger)index;
@end

@implementation NSString (testString)

- (unichar)characterAtIndex:(NSUInteger)index {
    NSLog(@"33");
    return '00';
}

@end

@implementation CategoryTestViewController

- (void)viewDidLoad {
    ClassA *classA = [ClassA new];
    [classA test];
    UIView *view = [[UIView alloc]initWithFrame:self.view.bounds];
    NSString *str = [[NSString alloc] initWithString:@"333"];
    [str characterAtIndex:0];
}

@end



