//
//  BeginViewController.m
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import "BeginViewController.h"
#import "CoreGUIController.h"

@interface BeginViewController ()

@end

@implementation BeginViewController

@synthesize _ScrollView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    _ScreenName = BeginScreen;
    // Do any additional setup after loading the view.
    
    _ScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _ScrollView.backgroundColor = [UIColor whiteColor];
    
    imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    if ([[UIScreen mainScreen] bounds].size.height >= 568.0f)
    {
        [imageView setImage:[UIImage imageNamed:@"BeginApp4Inches.png"]];
    } else {
        [imageView setImage:[UIImage imageNamed:@"BeginApp.png"]];
    }
    
    [_ScrollView addSubview:imageView];
    
    // ScrollView
    [self.view addSubview:_ScrollView];
    
    viewProcessC = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    viewProcessC.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:0.6f];
    spinnerC = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinnerC.center = CGPointMake((self.view.frame.size.width)/2.0f, (self.view.frame.size.height)/2.0f);
    spinnerC.transform = CGAffineTransformMakeScale(2.0f, 2.0f);
    
    [viewProcessC addSubview:spinnerC];
    [self.view addSubview:viewProcessC];
    [spinnerC startAnimating];

    [self performSelector:@selector(delayDownloadInfo) withObject:nil afterDelay:1.5f];
    [self performSelector:@selector(delayDisplayScreen) withObject:nil afterDelay:4.0f];
    
}

-(void)delayDownloadInfo
{
    [spinnerC stopAnimating];
    [spinnerC removeFromSuperview];
    [viewProcessC removeFromSuperview];
}

-(void)delayDisplayScreen
{
    [_CoreGUI finishedScreen:self withCode:2];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
