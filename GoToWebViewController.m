//
//  GoToWebViewController.m
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import "GoToWebViewController.h"
#import "CoreGUIController.h"

@interface GoToWebViewController ()

@end

@implementation GoToWebViewController

@synthesize _WebView, _StringLink, _FlagNews, _FlagVideos, _FlagDetailVideo;


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Website";
    self.navigationController.title = @"Website";
    _ScreenName = GoToWebScreen;
    self.view.backgroundColor = [UIColor redColor];
    
    _WebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _WebView.delegate = self;
    
    if (!_FlagNews && !_FlagVideos && !_FlagDetailVideo) {
        _StringLink = @"http://www.vietgolfvn.com";
    }
    NSURL *url = [NSURL URLWithString:_StringLink];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [_WebView loadRequest:urlRequest];
    [self.view addSubview:_WebView];
    // Dispose of any resources that can be recreated.
    viewProcessC = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    viewProcessC.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:0.6f];
    spinnerC = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinnerC.center = CGPointMake((self.view.frame.size.width)/2.0f, (self.view.frame.size.height)/2.0f);
    spinnerC.transform = CGAffineTransformMakeScale(2.0f, 2.0f);
    [viewProcessC addSubview:spinnerC];
    [self.view addSubview:viewProcessC];
    [spinnerC startAnimating];
    
    [self performSelector:@selector(delayDownloadInfo) withObject:nil afterDelay:2.0f];
    // Back
    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    btnBack.frame = CGRectMake(0, 0, 75.0f, 25.0f);
    [btnBack setImage:[UIImage imageNamed:@"BackButtonBarItem.png"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnBack];
}

-(void)delayDownloadInfo
{
    [spinnerC stopAnimating];
    [spinnerC removeFromSuperview];
    [viewProcessC removeFromSuperview];
}

-(void)popBack
{
    [_CoreGUI finishedScreen:self withCode:132];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationItem.hidesBackButton = NO;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
