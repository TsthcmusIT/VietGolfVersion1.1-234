//
//  AboutGolfViewController.m
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import "AboutGolfViewController.h"
#import "CoreGUIController.h"

@interface AboutGolfViewController ()

@end

@implementation AboutGolfViewController

@synthesize _ScrollView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _ScreenName = AboutGolfScreen;
    self.navigationController.title = @"Golf";
    numPages = 16;
    btnSize = CGSizeMake(81.0f, 27.0f);
    
    _ScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height + 20.0f)];
    _ScrollView.contentSize = CGSizeMake(_ScrollView.frame.size.width * numPages, self.view.frame.size.height - 100.0f);
    _ScrollView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_ScrollView];
    arrImage = [[NSArray alloc]initWithObjects:[UIImage imageNamed:@"AboutGolfPage1.png"], [UIImage imageNamed:@"AboutGolfPage2.png"], [UIImage imageNamed:@"AboutGolfPage3.png"], [UIImage imageNamed:@"AboutGolfPage4.png"], [UIImage imageNamed:@"AboutGolfPage5.png"], [UIImage imageNamed:@"AboutGolfPage6.png"], [UIImage imageNamed:@"AboutGolfPage7.png"], [UIImage imageNamed:@"AboutGolfPage8.png"], [UIImage imageNamed:@"AboutGolfPage9.png"], [UIImage imageNamed:@"AboutGolfPage10.png"], [UIImage imageNamed:@"AboutGolfPage11.png"], [UIImage imageNamed:@"AboutGolfPage12.png"], [UIImage imageNamed:@"AboutGolfPage13.png"], [UIImage imageNamed:@"AboutGolfPage14.png"], [UIImage imageNamed:@"AboutGolfPage15.png"], [UIImage imageNamed:@"AboutGolfPage16.png"], nil];
    for (int i = 0; i < numPages; i++) {
        UIImageView *vPageContent = [[UIImageView alloc]initWithFrame:CGRectMake(i * _ScrollView.frame.size.width, 0, _ScrollView.frame.size.width, _ScrollView.frame.size.height)];
        [vPageContent setImage: [arrImage objectAtIndex:i]];
        [_ScrollView addSubview:vPageContent];
    }
    _ScrollView.pagingEnabled = YES;
    
    
    pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40.0f)];
    pageControl.numberOfPages = numPages;
    pageControl.currentPage = 0;
    pageControl.hidesForSinglePage = YES;
    pageControl.userInteractionEnabled =YES;
    [pageControl addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventTouchUpInside];
    pageControl.center = CGPointMake(self.view.frame.size.width/2.0f, self.view.frame.size.height - 40.0f);
    [self.view addSubview:pageControl];
    _ScrollView.delegate = self;
    _ScrollView.showsHorizontalScrollIndicator = NO;
    //
    
    btnExit = [UIButton buttonWithType:UIButtonTypeCustom];
    btnExit.frame = CGRectMake(239.0f, self.view.frame.size.height - 27.0f, btnSize.width, btnSize.height);
    [btnExit setImage:[UIImage imageNamed:@"Exit.png"] forState:UIControlStateNormal];
    [btnExit addTarget:self action:@selector(exitForm) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:btnExit];
    
}

- (void) pageTurn: (UIPageControl *) aPageControl
{
    int whichPage = (int)aPageControl.currentPage;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    _ScrollView.contentOffset = CGPointMake(self.view.frame.size.width * whichPage, 0.0f);
    [UIView commitAnimations];
}

-(void)exitForm
{
    [_CoreGUI finishedScreen:self withCode:130];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int currentPpage = _ScrollView.contentOffset.x/self.view.frame.size.width;
    pageControl.currentPage = currentPpage;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
