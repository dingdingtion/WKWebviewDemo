
//
//  ViewController.m
//  WKWebview
//
//  Created by DingDing on 17/9/82.
//  Copyright © 2017年 BeidouLife. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
#import "SchemeHandler.h"

@interface ViewController ()
{
    
    WKWebView *webView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *customSheme = @"apple-local";

    NSString *jsonString = @"[{\"trigger\": {\"url-filter\": \".*\"}, \"action\": { \"type\":\"make-https\" }}]";
    
    [WKContentRuleListStore.defaultStore compileContentRuleListForIdentifier:@"ContentBlockRules" encodedContentRuleList:jsonString completionHandler:^(WKContentRuleList *ruleList, NSError *error) {
        
        if (error) {
            
            return;
        }
        
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        
        [config setURLSchemeHandler:[[SchemeHandler alloc] init] forURLScheme:customSheme];
        
        [config.userContentController addContentRuleList:ruleList];
        
        
        webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:config];
        
        [self.view addSubview:webView];
  
        NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];

//        NSURL *url = [NSURL URLWithString:@"apple-local://www.baidu.com"];
        
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        
        [webView loadRequest:request];
        
        
        
        WKHTTPCookieStore *cookieStore = config.websiteDataStore.httpCookieStore;
        
        NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:@{
                                                                    NSHTTPCookieDomain:@".baidu.com",
                                                                    NSHTTPCookieName:@"s",
                                                                    NSHTTPCookieValue:@"s1",
                                                                    NSHTTPCookiePath:@"/",
                                                                    NSHTTPCookieSecure:[NSNumber numberWithBool:YES]
                                                                    }];
        
        [cookieStore setCookie:cookie completionHandler:^{
            
        }];
        
    }];

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)getAllCookie
{
    
    WKHTTPCookieStore *cookieStore = webView.configuration.websiteDataStore.httpCookieStore;
    
    [cookieStore getAllCookies:^(NSArray<NSHTTPCookie *> * _Nonnull cookies) {
        
        [cookies enumerateObjectsUsingBlock:^(NSHTTPCookie * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [cookieStore deleteCookie:obj completionHandler:^{
                
            }];
            
        }];
        
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
