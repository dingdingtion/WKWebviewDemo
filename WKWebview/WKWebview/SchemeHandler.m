//
//  SchemeHandler.m
//  WKWebview
//
//  Created by DingDing on 17/9/82.
//  Copyright © 2017年 BeidouLife. All rights reserved.
//

#import "SchemeHandler.h"

@implementation SchemeHandler

- (void)webView:(WKWebView *)webView startURLSchemeTask:(id <WKURLSchemeTask>)urlSchemeTask
{
    UIImage *image = [UIImage imageNamed:@"photo"];
    NSData *data =  UIImageJPEGRepresentation(image, 1.0);
    
    [urlSchemeTask didReceiveResponse:[[NSURLResponse alloc] initWithURL:urlSchemeTask.request.URL MIMEType:@"image/jpg" expectedContentLength:data.length textEncodingName:nil]];

    [urlSchemeTask didReceiveData:data];

    [urlSchemeTask didFinish];
}

- (void)webView:(WKWebView *)webView stopURLSchemeTask:(id <WKURLSchemeTask>)urlSchemeTask;
{
    urlSchemeTask = nil;
}

@end
