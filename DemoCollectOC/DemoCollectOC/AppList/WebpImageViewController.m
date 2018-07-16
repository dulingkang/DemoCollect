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
#import <lottie-ios/Lottie/Lottie.h>

@interface WebpImageViewController ()
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation WebpImageViewController

- (void)viewDidAppear:(BOOL)animated {
    
}

static NSString *constString1 = @"66666";

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"constString1:%@", constString1);
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth - 300)/2, 0, 300, 300)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:@"http://www.devthinking.com/images/test1.webp"]];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
//    [self.view addSubview:imageView];
    LOTAnimationView *animationView = [LOTAnimationView animationNamed:@"PinJump"];
    [self.view addSubview:animationView];
    animationView.frame = CGRectMake((ScreenWidth - 300)/2, 0, 300, 300);
    [animationView setLoopAnimation:YES];
    [animationView playWithCompletion:^(BOOL animationFinished) {
        
    }];
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
    NSLog(@"call: %@", [NSThread callStackSymbols]);
}

- (void)addWebView {
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 300, ScreenWidth, ScreenHeight - 300)];
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://devthinking.com/testWebp.html"]];
    // 3.加载网页
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
}

- (void)testFont {
    NSURL *url = [NSURL URLWithString:@"alipayfreedmall://DMAlipayFreePayPage?agreement_no=20170106682568206338&alipay_user_id=2088422478441387&external_user_id=2110&invalid_time=2115-02-01+00%3A00%3A00&is_success=T&product_code=GENERAL_WITHHOLDING_P&scene=DEFAULT%7CDEFAULT&sign_modify_time=2017-01-06+17%3A35%3A48&sign_time=2017-01-06+17%3A35%3A48&status=NORMAL&valid_time=2017-01-06+17%3A35%3A48&sign=JbaOTtUETDRJff9Te4LPtXezgxfyXXm%2FsWQ7C%2F9gsTtqxnTzZQKVqwORLemXd%2FXhCFtk5ek8aohOyyxhJznctcP4eZ%2FVQomxQTfG4HVCplUtGW%2BMweR1HLfEkcWJhNSgfsHavrjrgINUI2ktNf52gpu11tyfdAf0KpisUcfGp0c%3D&sign_type=RSA"];
    NSURLComponents *components = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:NO];
    NSArray *queryItems = [components queryItems];
    NSMutableDictionary *dict = [NSMutableDictionary new];
    for (NSURLQueryItem *item in queryItems) {
        [dict setObject:[item value] forKey:[item name]];
    }
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 200, 60)];
    label.text = @"今送(2)";
    label.font = [UIFont systemFontOfSize:12];
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
