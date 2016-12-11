//
//  WebpImageViewController.m
//  DemoCollectOC
//
//  Created by ShawnDu on 16/6/21.
//  Copyright © 2016年 Shawn.Du. All rights reserved.
//

#import "WebpImageViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "DCGlobalDef.h"
#import "UIControl+SSEventTime.h"

@interface WebpImageViewController ()
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation WebpImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth - 300)/2, 0, 300, 300)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:@"http://www.devthinking.com/test1.webp"]];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageView];
    [self addWebView];
    [self testFont];
    [self createUrl];
    [self testDict];
    [self testTextView];
    [self addTestButton];
}

- (void)testButtonPressed:(UIButton *)sender {
    self.view.backgroundColor = [UIColor blueColor];
    NSLog(@">>>>>pressed");
}

- (void)addWebView {
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 300, ScreenWidth, ScreenHeight - 300)];
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.devthinking.com/test.html"]];
    // 3.加载网页
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
}

- (void)testFont {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 200, 60)];
    label.text = @"60s后再次攻取";
    label.font = [UIFont systemFontOfSize:11];
    [label sizeToFit];
    [self.view addSubview:label];
    
    NSMutableAttributedString *placeHolderString = [[NSMutableAttributedString alloc] initWithString:@"验证码"];
    [placeHolderString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14], NSForegroundColorAttributeName: [UIColor redColor]} range:NSMakeRange(0, placeHolderString.length)];
    label.attributedText = placeHolderString;
    if ([@"https://" hasPrefix:@"http"]) {
        NSLog(@"222");
    }
}

- (void)testTextView {
    UITextView *bottomTextView = [[UITextView alloc] initWithFrame:CGRectMake(25, 100, 50, 23.5)];
    bottomTextView.textColor = [UIColor redColor];
    bottomTextView.text = @"线下超市注册过";
    bottomTextView.textContainerInset = UIEdgeInsetsMake(0, 0, 10, 0);
    bottomTextView.font = [UIFont systemFontOfSize:11];
    [self.view addSubview:bottomTextView];
}

#define SobotUrl @"https://www.sobot.com/chat/h5/index.html"

- (NSString *)createUrl {
    NSURLComponents *components = [NSURLComponents componentsWithString:SobotUrl];
    NSURLQueryItem *search = [NSURLQueryItem queryItemWithName:@"q" value:@"ios"];
    NSURLQueryItem *count = [NSURLQueryItem queryItemWithName:@"count" value:@"10"];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"24334343", @"orderId", nil];
    NSData *json = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    NSString *string = [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
    NSURLQueryItem *param = [NSURLQueryItem queryItemWithName:@"params" value:string];
    components.queryItems = @[ search, count, param ];
    NSURL *url = components.URL;
    NSLog(@"%@", url.absoluteString);
    return url.absoluteString;
}

- (void)testDict {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    NSDictionary *tmpDict = [NSDictionary dictionaryWithObjectsAndKeys:@"true",@"show1",@(1), @"show2", @(0), @"show3",  nil];
    BOOL boolValue = NO;
    id value = [tmpDict objectForKey:@"show3"];
    if ([value isKindOfClass:[NSString class]]) {
        if ([value isEqualToString:@"true"]) {
            boolValue = YES;
        }
    } else if([value isKindOfClass:[NSNumber class]]) {
        if ([value integerValue] == 1) {
            boolValue = YES;
        }
    }
    [dict setObject:[NSNumber numberWithBool:boolValue] forKey:@"test"];
}

- (void)addTestButton {
    UIButton *testButton = [UIButton buttonWithType:UIButtonTypeSystem];
    testButton.frame = CGRectMake(20, 130, 200, 40);
    [testButton setTitle:@"test" forState:UIControlStateNormal];
    [testButton addTarget:self action:@selector(testButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    testButton.eventInterval = 1;
    [self.view addSubview:testButton];
}
@end
