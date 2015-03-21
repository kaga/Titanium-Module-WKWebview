/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2015 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "ComKagaWebviewHTMLView.h"

@implementation ComKagaWebviewHTMLView

- (void)initializeState
{
    // Creates and keeps a reference to the view upon initialization
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    [userContentController addScriptMessageHandler:self name:@"hostInbox"];
    
    WKPreferences *preference = [[WKPreferences alloc] init];
    preference.javaScriptCanOpenWindowsAutomatically = true;
    preference.javaScriptEnabled = true;

    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.allowsInlineMediaPlayback = true;
    configuration.mediaPlaybackAllowsAirPlay = true;
    configuration.mediaPlaybackRequiresUserAction = false;
    configuration.preferences = preference;
    configuration.userContentController = userContentController;
    
    webview = [[WKWebView alloc] initWithFrame:[self frame] configuration:configuration];
    
    [self addSubview:webview];
    
    [userContentController release];
    [preference release];
    [configuration release];
    [super initializeState];
}

-(void)dealloc
{
    // Deallocates the view
    RELEASE_TO_NIL(webview);
    [super dealloc];
}

-(void)frameSizeChanged:(CGRect)frame bounds:(CGRect)bounds
{
    // Sets the size and position of the view
    [TiUtils setView:webview positionRect:bounds];
}

- (void)setUrl_:(id)value
{
    NSString *urlString = [TiUtils stringValue:value];
    NSLog(@"loadUrl2 - %@", urlString);
    [self loadRequest:urlString];
}

-(void)loadUrl:(id)value
{
    NSString *urlString = [TiUtils stringValue:[value objectAtIndex:0]];
    NSLog(@"loadUrl2 - %@", urlString);
    [self loadRequest:urlString];
}

-(void)loadRequest:(NSString *)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webview loadRequest:request];
}

#pragma mark WKWebview Protocol 
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    NSDictionary *dict = [NSMutableDictionary dictionary];
    NSString *body = [TiUtils stringValue:message.body];
    [dict setValue:message.body forKey:@"message"];
    [self.proxy fireEvent:@"messageFromWebview" withObject:dict];
}

@end
