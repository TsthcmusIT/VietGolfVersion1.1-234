//
//  DetailNotificationViewController.m
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import "DetailNotificationViewController.h"
#import "CoreGUIController.h"

@interface DetailNotificationViewController ()

@end

@implementation DetailNotificationViewController

@synthesize _NotificationD, _CurrentRow;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Chi tiết";
    self.navigationController.title = @"Chi tiết";
    _ScreenName = DetailNotificationScreen;
    self.view.backgroundColor = [UIColor whiteColor];
    
    lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 70.0f, self.view.frame.size.width - 20.0f, 45.0f)];
    lblTitle.backgroundColor = [UIColor clearColor];
    lblTitle.text = _NotificationD._Title;
    lblTitle.numberOfLines = 2;
    [lblTitle setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:20]];
    lblTitle.textColor = [UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f];
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM, dd-yyyy"];
    
    //Optionally for time zone converstions
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    lblDate = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 120.0f, lblTitle.frame.origin.y + lblTitle.frame.size.height, 120.0f, 30.0f)];
    [lblDate setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f]];
    lblDate.backgroundColor = [UIColor whiteColor];
    lblDate.textAlignment = NSTextAlignmentNatural;
    lblDate.text = [formatter stringFromDate:_NotificationD._Time];
    lblDate.textColor = [UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f];
    
    btnLink = [[UIButton alloc] initWithFrame:CGRectMake(0, lblDate.frame.origin.y + lblDate.frame.size.height + 20.0f, self.view.frame.size.width, self.view.frame.size.height/10.0f)];
    [btnLink.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:30.0f]];
    btnLink.backgroundColor = [UIColor colorWithWhite:0.95f alpha:0.8f];
    [btnLink setTitle:@"Đi đến..." forState:UIControlStateNormal];
    btnLink.titleLabel.textColor = [UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f];
    [btnLink addTarget:self action:@selector(goToLink) forControlEvents:UIControlEventTouchUpInside];
    
    lblPS = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, btnLink.frame.origin.y + btnLink.frame.size.height + 20.0f, self.view.frame.size.width - 2.0f*10.0f, 60.0f)];
    [lblPS setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f]];
    lblPS.backgroundColor = [UIColor whiteColor];
    lblPS.textAlignment = NSTextAlignmentNatural;
    lblPS.numberOfLines = 3;
    lblPS.text = @"Bạn cần ấn nút Refresh ở màn hình Thông tin tài khoản để cập nhật những thông báo mới nhất!";
    lblPS.textColor = [UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f];
    
    
    [self.view addSubview:lblTitle];
    [self.view addSubview:lblDate];
    [self.view addSubview:btnLink];
    [self.view addSubview:lblPS];
    
    // Back
    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    btnBack.frame = CGRectMake(0, 0, 75.0f, 25.0f);
    [btnBack setImage:[UIImage imageNamed:@"BackButtonBarItem.png"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnBack];
    
}

-(void)popBack
{
    if (!_NotificationD._Checked) {
        [self updateIntoNotificationDB];
    }
    
    [_CoreGUI finishedScreen:self withCode:143];
}

-(void)goToLink
{
    [_CoreGUI._TabBar.tabBar setHidden:YES];
    GoToWebViewController *goToWebVC = [[GoToWebViewController alloc] initWithCoreGUI:_CoreGUI];
    goToWebVC._FlagNews = YES;
    goToWebVC._FlagDetailVideo = NO;
    goToWebVC._FlagVideos = NO;
    goToWebVC._StringLink = _NotificationD._Link;
    [_CoreGUI._Navi05 pushViewController:goToWebVC animated:YES];
}

-(void)updateIntoNotificationDB
{
    
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"Notification.plist"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath: path])
    {
        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"Notification" ofType: @"plist"];
        
        [fileManager copyItemAtPath:bundle toPath: path error:&error];
    }
    
    NSMutableArray *mountainsArray = [[[NSMutableArray alloc] initWithContentsOfFile:path]mutableCopy];
    int i = 0;
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *object in mountainsArray) {
        [tempArray insertObject:object atIndex:i];
        i++;
    }
    
    for (int j = 0; j < [tempArray count]; j++)
    {
        NSMutableDictionary *dict = [tempArray objectAtIndex:j];
        
        if (j == _CurrentRow)
        {
            [dict setObject:[NSNumber numberWithBool:YES] forKey:@"checked"];
        }
    }
    
    [mountainsArray writeToFile:path atomically:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
