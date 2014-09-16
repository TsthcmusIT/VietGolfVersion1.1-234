//
//  OptionViewController.m
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import "OptionViewController.h"
#import "CoreGUIController.h"

@interface OptionViewController ()

@end

@implementation OptionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _ScreenName = OptionScreen;
    self.navigationItem.title = @"Tuỳ chọn";
    self.title = @"Tuỳ Chọn";
    
    self.view.backgroundColor = [UIColor colorWithRed:53.0f/255.0f green:53.0f/255.0f blue:53.0f/255.0f alpha:1.0f];
    int paddingX = 20.0f;
    
    CGSize btnSize = CGSizeMake(self.view.frame.size.width - 2*paddingX, self.view.frame.size.height/11.5f);
    
    
    imaViewHead = [[UIImageView alloc]initWithFrame:CGRectMake(0, 65.0f, self.view.frame.size.width, 8.0f)];
    imaViewHead.backgroundColor = [UIColor colorWithRed:23.0f/255.0f green:165.0f/255.0f blue:280.0f/255.0f alpha:1.0f];
    
    imaViewHead2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, imaViewHead.frame.origin.y + imaViewHead.frame.size.height, self.view.frame.size.width, 5.0f)];
    imaViewHead2.backgroundColor = [UIColor colorWithRed:26.0f/255.0f green:175.0f/255.0f blue:300.0f/255.0f alpha:1.0f];
    
    imaViewHead3 = [[UIImageView alloc]initWithFrame:CGRectMake(0, imaViewHead2.frame.origin.y + imaViewHead2.frame.size.height, self.view.frame.size.width, 3.0f)];
    imaViewHead3.backgroundColor = [UIColor colorWithRed:28.0f/255.0f green:185.0f/255.0f blue:320.0f/255.0f alpha:1.0f];
    
    imaViewMiddle = [[UIImageView alloc]initWithFrame:CGRectMake(0, imaViewHead.frame.origin.y + imaViewHead.frame.size.height + self.view.frame.size.height/12.0f, self.view.frame.size.width, 4.0f)];
    imaViewMiddle.backgroundColor = [UIColor colorWithRed:26.0f/255.0f green:175.0f/255.0f blue:300.0f/255.0f alpha:1.0f];
    
    UIImageView *viewLeft = [[UIImageView alloc]initWithFrame:CGRectMake(8.0f, imaViewMiddle.frame.origin.y + imaViewMiddle.frame.size.height, 4.0f, self.view.frame.size.height - (imaViewMiddle.frame.origin.y + imaViewMiddle.frame.size.height + 42.0f))];
    viewLeft.backgroundColor = [UIColor colorWithRed:26.0f/255.0f green:175.0f/255.0f blue:300.0f/255.0f alpha:1.0f];
    
    UIImageView *viewRight = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 12.0f, imaViewMiddle.frame.origin.y + imaViewMiddle.frame.size.height, 4.0f, self.view.frame.size.height - (imaViewMiddle.frame.origin.y + imaViewMiddle.frame.size.height + 42.0f))];
    viewRight.backgroundColor = [UIColor colorWithRed:26.0f/255.0f green:175.0f/255.0f blue:300.0f/255.0f alpha:1.0f];
    
    btnShareApp = [[UIButton alloc] init];
    btnShareApp.frame = CGRectMake(paddingX, imaViewMiddle.frame.origin.y + imaViewMiddle.frame.size.height + self.view.frame.size.height/30.0f, btnSize.width, btnSize.height);
    btnShareApp.backgroundColor = [UIColor clearColor];
    [btnShareApp setImage:[UIImage imageNamed:@"ChooseCommunity.png"] forState:UIControlStateNormal];
    [btnShareApp addTarget:self action:@selector(sharedWithCommunity) forControlEvents:UIControlEventTouchUpInside];
    
    btnGoToWeb = [[UIButton alloc] init];
    btnGoToWeb.frame = CGRectMake(paddingX, btnShareApp.frame.origin.y + btnShareApp.frame.size.height + self.view.frame.size.height/48.0f, btnSize.width, btnSize.height);
    btnGoToWeb.backgroundColor = [UIColor clearColor];
    [btnGoToWeb setImage:[UIImage imageNamed:@"GoToWebsite.png"] forState:UIControlStateNormal];
    [btnGoToWeb addTarget:self action:@selector(goToVietGolfWebsite) forControlEvents:UIControlEventTouchUpInside];
    
    
    btnHowToUse = [[UIButton alloc] init];
    btnHowToUse.frame = CGRectMake(paddingX, btnGoToWeb.frame.origin.y + btnGoToWeb.frame.size.height + self.view.frame.size.height/48.0f, btnSize.width, btnSize.height);
    btnHowToUse.backgroundColor = [UIColor clearColor];
    [btnHowToUse setImage:[UIImage imageNamed:@"HowToUse.png"] forState:UIControlStateNormal];
    [btnHowToUse addTarget:self action:@selector(howToUse) forControlEvents:UIControlEventTouchUpInside];
    
    
    btnAboutApp = [[UIButton alloc] init];
    btnAboutApp.frame = CGRectMake(paddingX, btnHowToUse.frame.origin.y + btnHowToUse.frame.size.height + self.view.frame.size.height/48.0f, btnSize.width, btnSize.height);
    btnAboutApp.backgroundColor = [UIColor clearColor];
    [btnAboutApp setImage:[UIImage imageNamed:@"AboutGolf.png"] forState:UIControlStateNormal];
    [btnAboutApp addTarget:self action:@selector(aboutVietGolf) forControlEvents:UIControlEventTouchUpInside];
    
    
    btnAboutGolf = [[UIButton alloc] init];
    btnAboutGolf.frame = CGRectMake(paddingX, btnAboutApp.frame.origin.y + btnAboutApp.frame.size.height + self.view.frame.size.height/48.0f, btnSize.width, btnSize.height);
    btnAboutGolf.backgroundColor = [UIColor clearColor];
    [btnAboutGolf setImage:[UIImage imageNamed:@"AboutApp.png"] forState:UIControlStateNormal];
    [btnAboutGolf addTarget:self action:@selector(aboutGolf) forControlEvents:UIControlEventTouchUpInside];
    
    
    imaViewBottom = [[UIImageView alloc]initWithFrame:CGRectMake(8.0f, btnAboutGolf.frame.origin.y + btnAboutGolf.frame.size.height + self.view.frame.size.height/30.0f, self.view.frame.size.width - 18.0f, 4.0f)];
    imaViewBottom.backgroundColor = [UIColor colorWithRed:26.0f/255.0f green:175.0f/255.0f blue:300.0f/255.0f alpha:1.0f];
    
    
    [self.view addSubview:imaViewHead];
    [self.view addSubview:imaViewHead2];
    [self.view addSubview:imaViewHead3];
    [self.view addSubview:imaViewMiddle];
    [self.view addSubview:viewLeft];
    [self.view addSubview:viewRight];
    [self.view addSubview:btnShareApp];
    [self.view addSubview:btnGoToWeb];
    [self.view addSubview:btnHowToUse];
    [self.view addSubview:btnAboutApp];
    [self.view addSubview:btnAboutGolf];
    [self.view addSubview:imaViewBottom];
    
}

-(void)sharedWithCommunity
{
    [_CoreGUI finishedScreen:self withCode:30];
}

-(void)goToVietGolfWebsite
{
    [_CoreGUI finishedScreen:self withCode:31];
}

-(void)howToUse
{
    [_CoreGUI finishedScreen:self withCode:32];
}

-(void)aboutGolf
{
    [_CoreGUI finishedScreen:self withCode:33];
}

-(void)aboutVietGolf
{
    [_CoreGUI finishedScreen:self withCode:34];
}

#pragma mark - mail compose delegate
-(void)mailComposeController:(MFMailComposeViewController *)controller
         didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [_CoreGUI._TabBar.tabBar setHidden:NO];
    self.navigationController.navigationBarHidden = NO;
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}



@end

