//
//  GifDisplayViewController.m
//  DemoCollectOC
//
//  Created by Shawn.Du on 16/4/5.
//  Copyright © 2016年 Shawn.Du. All rights reserved.
//

#import "GifDisplayViewController.h"

@interface GifDisplayViewController ()

@end

@implementation GifDisplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self displayGifView];
    NSLog(@"***********************");
}

- (void)displayGifView {
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webView.backgroundColor = [UIColor clearColor];
    webView.scalesPageToFit = YES;
    NSData *gifData = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"anim" ofType:@"gif"]];
    [webView loadData: gifData  MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    [self.view addSubview:webView];
}
@end
