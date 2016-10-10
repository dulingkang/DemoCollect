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
    label.text = @"Hello，你好你好";
    label.font = [UIFont systemFontOfSize:17];
    [label sizeToFit];
    [self.view addSubview:label];
}


@end
