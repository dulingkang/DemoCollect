//
//  StringPropertyViewController.m
//  DemoCollectOC
//
//  Created by ShawnDu on 2016/11/9.
//  Copyright © 2016年 Shawn.Du. All rights reserved.
//

#import "StringPropertyViewController.h"

@interface StringPropertyViewController ()
@property (nonatomic, strong) NSString *myStrongString;
@property (nonatomic, copy) NSString *myCopyString;
@end

@implementation StringPropertyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self stringTest];
}

- (void)stringTest {
    NSMutableString *mutableStr = [NSMutableString stringWithFormat:@"https://"];
    self.myStrongString = mutableStr;
    self.myCopyString = mutableStr;
    NSLog(@"mutableStr:%p,%p",  mutableStr,&mutableStr);
    NSLog(@"strongString:%p,%p", _myStrongString, &_myStrongString);
    NSLog(@"copyString:%p,%p",   _myCopyString, &_myCopyString);
    
    [mutableStr appendString:@"devthinking.com"];
    NSLog(@"strongString:%p,%p", _myStrongString, &_myStrongString);
    NSLog(@"copyString:%p,%p",   _myCopyString, &_myCopyString);
}

@end
