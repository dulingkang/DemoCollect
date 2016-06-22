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
    // Do any additional setup after loading the view.
}

- (void)addWebView {
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 300, ScreenWidth, ScreenHeight - 300)];
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.devthinking.com/test.html"]];
    // 3.加载网页
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
