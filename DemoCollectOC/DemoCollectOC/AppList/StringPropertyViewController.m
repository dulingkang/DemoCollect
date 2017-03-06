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
static NSString *constString1 = @"11111";
NSString *constString2 = @"3333";

- (void)stringTest {
    static NSString *constString = @"22222";
    Byte data[8];
    Byte data2[] = {};
    NSLog(@"dataAddress:%p", data);
    NSLog(@"data2Address:%p", data2);
    for (NSInteger i = 0; i < 8; i++) {
        data[i] = i;
        data2[i] = i;
    }
    NSMutableString *mutableStr = [NSMutableString stringWithFormat:@"https://"];
//    NSString *mutableStr = @"a";
    self.myStrongString = mutableStr;
    self.myCopyString = mutableStr;
    NSLog(@"mutableStr:%p,%p",  mutableStr,&mutableStr);
    NSLog(@"strongString:%p,%p", _myStrongString, &_myStrongString);
    NSLog(@"copyString:%p,%p",   _myCopyString, &_myCopyString);
    
    [mutableStr appendString:@"devthinking.com"];
    NSLog(@"strongString:%p,%p", _myStrongString, &_myStrongString);
    NSLog(@"copyString:%p,%p",   _myCopyString, &_myCopyString);
    
    
    NSString *astr0 = @"0";
    NSString * allocStr = [[NSString alloc]initWithFormat:@"1"];
    NSString * formatStr = [NSString stringWithFormat:@"3"];
    NSString * aStr = @"12";
    NSString *astr2 = @"2";
    
    
    NSLog(@"alloc : %@, forStr : %@,  aStr : %@",allocStr,formatStr,aStr);
}

@end
