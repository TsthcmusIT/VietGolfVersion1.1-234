//
//  GoToWebViewController.h
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import "AbstractViewController.h"

@interface GoToWebViewController : AbstractViewController <UIWebViewDelegate>
{
    UIWebView *_WebView;
    NSString *_StringLink;
    BOOL _FlagNews;
    BOOL _FlagVideos;
    BOOL _FlagDetailVideo;
    
    UIView *viewProcessC;
    UIActivityIndicatorView *spinnerC;
}

@property (nonatomic, retain) UIWebView *_WebView;
@property (nonatomic, retain) NSString *_StringLink;
@property (nonatomic) BOOL _FlagNews;
@property (nonatomic) BOOL _FlagVideos;
@property (nonatomic) BOOL _FlagDetailVideo;


@end
