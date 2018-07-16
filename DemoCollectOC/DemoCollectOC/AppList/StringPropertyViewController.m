//
//  StringPropertyViewController.m
//  DemoCollectOC
//
//  Created by ShawnDu on 2016/11/9.
//  Copyright © 2016年 Shawn.Du. All rights reserved.
//

#import "StringPropertyViewController.h"
#import <CommonCrypto/CommonCrypto.h>

@interface StringPropertyViewController ()
  @property (nonatomic, strong) NSString *myStrongString;
  @property (nonatomic, copy) NSString *myCopyString;
  @property (nonatomic, strong) UITextView *textView;
  @end

@implementation StringPropertyViewController
  
- (void)viewDidLoad {
  [super viewDidLoad];
  [[[UIApplication sharedApplication] valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"];
  
  [self stringTest];
  _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 200, 400)];
  [self.view addSubview:_textView];
  for (NSInteger i = 0; i < 10000; i++) {
    if (i%3 == 0) {
      self.textView.attributedText = nil;
      sleep(0.1);
    } else {
      [self test];
    }
  }
  [self test];
  [self testStr];
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
  
- (void)test {
  NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"love中国人，这是多少的东西啊轼国国国"];
  NSRange textRange = NSMakeRange(0, text.length);
  //  [self addStyle:text];
  //  [text addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:10] range:textRange];
  self.textView.attributedText = [self addStyle:text];
  
}
  
- (NSMutableAttributedString *)addStyle:(NSMutableAttributedString *)text {
  NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
  style.minimumLineHeight = 2;
  style.maximumLineHeight = 8;
  style.lineSpacing = 2;
  NSRange textRange = NSMakeRange(0, text.length);
  [text addAttribute:NSParagraphStyleAttributeName
               value:style
               range:textRange];
  return [text copy];
}
  
- (void)testStr {
  double v13;
  int64_t v14 = (int64_t)v13 + 900;
  NSString *str = [NSString stringWithFormat:@"%ld", v14];
  str = @"sjdf723k&1531382936&/dalu.mp4";
  NSLog(@"str: %@", [self md5:str]);
}

-(NSString *)md5:(NSString *)str
{
  const char *cStr = [str UTF8String];
  unsigned char digest[CC_MD5_DIGEST_LENGTH];
  CC_MD5( cStr, strlen(cStr), digest );
  
  NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
  
  for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    [output appendFormat:@"%02x", digest[i]];
  
  return output;
}

@end
