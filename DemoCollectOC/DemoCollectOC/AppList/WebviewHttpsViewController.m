//
//  WebviewHttpsViewController.m
//  DemoCollectOC
//
//  Created by dulingkang on 16/8/31.
//  Copyright © 2016年 Shawn.Du. All rights reserved.
//

#import "WebviewHttpsViewController.h"

@interface WebviewHttpsViewController()<UIWebViewDelegate, NSURLConnectionDelegate, NSURLSessionDelegate>
@property (nonatomic, strong) UIWebView *webview;

@end
@implementation WebviewHttpsViewController {
    NSURLSession *_urlSession;
    BOOL _authenticated;
    NSURLRequest *_request;
    NSString *url;
    
}

- (void)viewDidLoad {
    _webview = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _webview.delegate = self;
    [self.view addSubview:_webview];
    url = @"https://www.baidu.com";
    _request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [_webview loadRequest:_request];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
//    [contentData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Bad: %@", [error description]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
//    NSString *loadedContent = [[NSString alloc] initWithData:
//                               contentData encoding:NSUTF8StringEncoding];
//    NSLog(@"Loaded content: %@",loadedContent);
    
}

// ------------ ByPass ssl starts ----------
-(BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:
(NSURLProtectionSpace *)protectionSpace {
    return [protectionSpace.authenticationMethod
            isEqualToString:NSURLAuthenticationMethodServerTrust];
}

-(void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:
(NSURLAuthenticationChallenge *)challenge {
    NSLog(@"WebController Got auth challange via NSURLConnection");
    
    if ([challenge previousFailureCount] ==0)
        
    {
        
        _authenticated =YES;
        
        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        
        [challenge.sender useCredential:credential forAuthenticationChallenge:challenge];
        
    } else
        
    {
        
        [[challenge sender]cancelAuthenticationChallenge:challenge];
        
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response

{
    
    NSLog(@"WebController received response via NSURLConnection");
    
    // remake a webview call now that authentication has passed ok.
    
    _authenticated =YES;
    
    [_webview loadRequest:_request];
    
    // Cancel the URL connection otherwise we double up (webview + url connection, same url = no good!)
    
//    [_urlConnection cancel];
    
}

#pragma mark - webview delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"Did start loading: %@ auth:%d", [[request URL]absoluteString],_authenticated);
    
    if (!_authenticated) {
        
        _authenticated =NO;
        
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:_request];
        [task resume];
        return NO;
        
    }
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error {
    NSLog(@"***********error:%@,errorcode=%ld,errormessage:%@",error.domain,error.code,error.description);
    
    if (!([error.domain isEqualToString:@"WebKitErrorDomain"] && error.code ==102)) {
        
        //当请求出错了会做什么事情
    }
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * __nullable credential))completionHandler
{
    NSLog(@"challenge = %@",challenge.protectionSpace.serverTrust);
    //判断是否是信任服务器证书
    if (challenge.protectionSpace.authenticationMethod ==NSURLAuthenticationMethodServerTrust)
    {
        //创建一个凭据对象
        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        //告诉服务器客户端信任证书
        [challenge.sender useCredential:credential forAuthenticationChallenge:challenge];
    }
}

-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    [_webview loadRequest:_request];
}

@end
