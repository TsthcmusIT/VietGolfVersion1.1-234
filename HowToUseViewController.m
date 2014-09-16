//
//  HowToUseViewController.m
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import "HowToUseViewController.h"
#import "CoreGUIController.h"

@interface HowToUseViewController ()

@end

@implementation HowToUseViewController

@synthesize _ScrollView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _ScreenName = HowToUseScreen;
    self.navigationController.title = @"Viet Golf";
    numPages = 6;
    btnSize = CGSizeMake(40.0f, 20.0f);
    
    _ScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height + 20.0f)];
    _ScrollView.contentSize = CGSizeMake(_ScrollView.frame.size.width * numPages, self.view.frame.size.height - 100.0f);
    _ScrollView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_ScrollView];
    arrImage = [[NSArray alloc]initWithObjects:[UIImage imageNamed:@"GuiForRecordScreen.png"], [UIImage imageNamed:@"GuideForSwingScreen.png"], [UIImage imageNamed:@"GuideForDisplayScreen.png"], [UIImage imageNamed:@"GuideCommunityScreen.png"], [UIImage imageNamed:@"GuideForOptionScreen.png"], [UIImage imageNamed:@"GuideForMyInfoScreen.png"], nil];
    for (int i = 0; i < numPages; i++) {
        UIImageView *vPageContent = [[UIImageView alloc]initWithFrame:CGRectMake(i * _ScrollView.frame.size.width, 0, _ScrollView.frame.size.width, _ScrollView.frame.size.height)];
        [vPageContent setImage: [arrImage objectAtIndex:i]];
        [_ScrollView addSubview:vPageContent];
    }
    _ScrollView.pagingEnabled = YES;
    
    
    
    pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 50.0f, self.view.frame.size.width, 40.0f)];
    pageControl.numberOfPages = numPages;
    pageControl.currentPage = 0;
    pageControl.hidesForSinglePage = YES;
    pageControl.userInteractionEnabled =YES;
    
    [pageControl addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventTouchUpInside];
    pageControl.center = CGPointMake(160.0f, self.view.frame.size.height - 60.0f);
    [self.view addSubview:pageControl];
    _ScrollView.delegate = self;
    _ScrollView.showsHorizontalScrollIndicator = NO;
    //
    
    btnExit = [UIButton buttonWithType:UIButtonTypeCustom];
    btnExit.frame = CGRectMake(280.0f, self.view.frame.size.height - 20.0f, btnSize.width, btnSize.height);
    [btnExit setImage:[UIImage imageNamed:@"Exit"] forState:UIControlStateNormal];
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
    [_CoreGUI finishedScreen:self withCode:133];
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
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    self.navigationController.navigationBarHidden = NO;
    [super viewWillDisappear:animated];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
