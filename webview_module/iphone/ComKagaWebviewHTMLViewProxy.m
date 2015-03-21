/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2015 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "ComKagaWebviewHTMLViewProxy.h"
#import "TiUtils.h"

@implementation ComKagaWebviewHTMLViewProxy

//TODO: this is not working?
- (void)loadUrl:(id)value
{
    NSLog(@"loadUrl1");
    [[self view] performSelectorOnMainThread:@selector(loadUrl:)
                                  withObject:value
                               waitUntilDone:NO];
}

@end
