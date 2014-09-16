//
//  CoreGUIController.m
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import "CoreGUIController.h"

@implementation CoreGUIController

@synthesize _Window, _TabBar, _Navi, _Navi02, _Navi03, _Navi04, _Navi05;
@synthesize _ArrayOfVideo, _ArrViewControl, _ArrUserProfile, _ArrVideosPosted, _SVideoInfoGUI, _UserProfile, _SVideoPosted;
@synthesize _IdSVideoPosted;
@synthesize _Connection, _ReceivedData, _CheckStatus;

// ----------------------------------------- Methods
// ----- Init
-(id)initWithWindow:(UIWindow*)window
{
    self = [super init];
    _Window = window;
    return  self;
}

-(void)stratUp
{
    _ArrayOfVideo = [[NSMutableArray alloc] init];
    _ArrUserProfile = [[NSMutableArray alloc] init];
    _ArrVideosPosted = [[NSMutableArray alloc] init];
    _SVideoInfoGUI = [[SVideoInfo alloc] init];
    _UserProfile = [[UserProfile alloc] init];
    _SVideoPosted = [[SVideoInCommunity alloc] init];
    arrMasrterVideo = [[NSMutableArray alloc] init];
    
    arrSVideoBefore = [[NSMutableArray alloc] init];
    arrSVideoBefore = [self loadSwingVideoInCommunity];
    _IdSVideoPosted = 0;
    if ([arrSVideoBefore count] != 0) {
        _IdSVideoPosted = ((SVideoInCommunity*)[arrSVideoBefore objectAtIndex:0])._Id;
    }
    
    _ArrUserProfile = [self loadUserProfile];
    _UserProfile = [_ArrUserProfile objectAtIndex:0];
    
    [self showMainScreen];
    [self checkUserStatus];
}

-(void)showMainScreen
{
    _TabBar = [[UITabBarController alloc]init];
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f]];
    [[UITabBar appearance] setBarTintColor:[UIColor colorWithWhite:0.3f alpha:0.7f]];
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"BackgroundTabBar.png"]];
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIColor whiteColor],NSForegroundColorAttributeName,
                                nil];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:attributes
                                                forState:UIControlStateNormal];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    SwingVideoTableViewController *swingVC = [[SwingVideoTableViewController alloc] initWithCoreGUI:self style:UITableViewStylePlain];
    swingVC.title = @"Swing";
    
    CommunityViewController *comVC = [[CommunityViewController alloc]initWithCoreGUI:self];
    comVC.title = @"Cộng Đồng";
    
    CreateVideoViewController *createVC = [[CreateVideoViewController alloc]initWithCoreGUI:self];
    
    OptionViewController *optionVC = [[OptionViewController alloc] initWithCoreGUI:self];
    optionVC.title = @"Tuỳ Chọn";
    
    MyInfoViewController *myInfoVC = [[MyInfoViewController alloc]initWithCoreGUI:self];
    myInfoVC._UserProM = [[UserProfile alloc] init];
    myInfoVC._UserProM = _UserProfile;
    myInfoVC.title = @"Thông Tin";
    
    swingVC.tabBarItem.image = [UIImage imageNamed:@"SwingTabBarItem.png"];
    comVC.tabBarItem.image = [UIImage imageNamed:@"CommunityTabBarItem.png"];
    optionVC.tabBarItem.image = [UIImage imageNamed:@"OptionTabBarItem.png"];
    myInfoVC.tabBarItem.image = [UIImage imageNamed:@"MyInfoTabBarItem.png"];
    
    self._Navi = [[UINavigationController alloc]initWithRootViewController:swingVC];
    self._Navi.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    self._Navi.navigationBar.barTintColor = [UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f];
    
    self._Navi02 = [[UINavigationController alloc]initWithRootViewController:comVC];
    self._Navi02.navigationBar.barTintColor = [UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f];
    self._Navi02.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    self._Navi03 = [[UINavigationController alloc]initWithRootViewController:createVC];
    self._Navi03.navigationBar.barTintColor = [UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f];
    self._Navi03.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    self._Navi04 = [[UINavigationController alloc]initWithRootViewController:optionVC];
    self._Navi04.navigationBar.barTintColor = [UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f];
    self._Navi04.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    self._Navi05 = [[UINavigationController alloc]initWithRootViewController:myInfoVC];
    self._Navi05.navigationBar.barTintColor = [UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f];
    self._Navi05.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    _ArrViewControl = [[NSMutableArray alloc]init];
    [_ArrViewControl addObject: self._Navi];
    [_ArrViewControl addObject: self._Navi02];
    [_ArrViewControl addObject: self._Navi03];
    [_ArrViewControl addObject: self._Navi04];
    [_ArrViewControl addObject: self._Navi05];
    
    self._TabBar.viewControllers = self._ArrViewControl;
    [_Window setRootViewController:self._TabBar];
}

-(void)showBeginScreen
{
    BeginViewController *beginVC = [[BeginViewController alloc]initWithCoreGUI:self];
    [self._Navi pushViewController:beginVC animated:YES];
    [_TabBar setSelectedIndex:0];
    [_TabBar.tabBar setHidden:YES];
}

-(void)checkUserStatus
{
    if (!_UserProfile._Status) {
        LoginViewController *loginVC = [[LoginViewController alloc] initWithCoreGUI:self];
        [self._Navi pushViewController:loginVC animated:YES];
        [_TabBar.tabBar setHidden:YES];
    }
    else
    {
        int check = [self updateRecentSVideoOfSystem];
        if (check > 0) {
            [self downloadRecords];
            [self downloadThumnailsWithCode:0];
        }
        
        [self downloadSwingVideoPosted:_IdSVideoPosted];
        [self showBeginScreen];
    }
}


// ----- Finish
-(void)finishedScreen:(AbstractViewController*)sender withCode:(int)code
{
    switch (code)
    {
        case 0:
            if (sender._ScreenName == LoginScreen) {
                RegisterViewController *registerVC = [[RegisterViewController alloc] initWithCoreGUI:self];
                [self._Navi pushViewController:registerVC animated:YES];
            }
            break;
        case 1:
            if (sender._ScreenName == RegisterScreen || sender._ScreenName == LoginScreen) {
                BeginViewController *beginVC = [[BeginViewController alloc]initWithCoreGUI:self];
                [self._Navi pushViewController:beginVC animated:YES];
                [_TabBar setSelectedIndex:0];
                [_TabBar.tabBar setHidden:YES];
            }
            break;
        case 2:
            if (sender._ScreenName == BeginScreen)
            {
                [UIView beginAnimations:@"View Flip" context:nil];
                [UIView setAnimationDuration:1.0f];
                [UIView setAnimationTransition:UIViewAnimationTransitionNone
                                       forView:self._Navi.view cache:NO];
                
                [self._Navi popToRootViewControllerAnimated:YES];
                
                [_TabBar.tabBar setHidden:NO];
                
                [UIView commitAnimations];
            }
            break;
        case 3:
            if (sender._ScreenName == RegisterScreen) {
                LoginViewController *loginVC = [[LoginViewController alloc] initWithCoreGUI:self];
                [self._Navi pushViewController:loginVC animated:YES];
            }
            break;
            
        case 20:
            if (sender._ScreenName == CreateVideoSwing) {
                RecordVideoViewController *recordVC = [[RecordVideoViewController alloc] initWithCoreGUI:self];
                [_Navi03 pushViewController:recordVC animated:NO];
            }
            break;
        case 21:
            if (sender._ScreenName == CreateVideoSwing) {
                ImportVideoViewController *importVC = [[ImportVideoViewController alloc] initWithCoreGUI:self];
                [_Navi03 pushViewController:importVC animated:NO];
            }
            break;
        case 22:
            if (sender._ScreenName == RecordScreen) {
                TrimAfterRecordViewController *trimAfterVC = [[TrimAfterRecordViewController alloc]initWithCoreGUI:self];
                trimAfterVC._SVideoTAR = [[SVideoInfo alloc] init];
                trimAfterVC._SVideoTAR._PathVideo = _SVideoInfoGUI._PathVideo;
                
                [_Navi03 pushViewController:trimAfterVC animated:NO];
                [_TabBar.tabBar setHidden:YES];
            }
            break;
        case 23:
            if (sender._ScreenName == TrimAfterRecordScreen || sender._ScreenName == ImportScreen) {
                CompletedCreateVideoViewController *completeCreateVC = [[CompletedCreateVideoViewController alloc]initWithCoreGUI:self];
                completeCreateVC._VideoInfoC = [[SVideoInfo alloc] init];
                completeCreateVC._VideoInfoC._PathVideo = _SVideoInfoGUI._PathVideo;
                
                [_Navi03 pushViewController:completeCreateVC animated:NO];
                [_TabBar.tabBar setHidden:YES];
            }
            break;
        case 30:
            if (sender._ScreenName == OptionScreen)
            {
                ChooseCommunityViewController *chooseCommunityVC = [[ChooseCommunityViewController alloc] initWithCoreGUI:self];
                [_Navi04 pushViewController:chooseCommunityVC animated:YES];
            }
            break;
        case 31:
            if (sender._ScreenName == OptionScreen)
            {
                _TabBar.tabBar.hidden = YES;
                GoToWebViewController *webVietGolfVC = [[GoToWebViewController alloc] initWithCoreGUI:self];
                webVietGolfVC._FlagNews = NO;
                [_Navi04 pushViewController:webVietGolfVC animated:YES];
            }
            break;
        case 32:
            if (sender._ScreenName == OptionScreen || sender._ScreenName == MyInfoScreen)
            {
                _TabBar.tabBar.hidden = YES;
                HowToUseViewController *howToUseVC = [[HowToUseViewController alloc] initWithCoreGUI:self];
                if (sender._ScreenName == MyInfoScreen) {
                    [_Navi05 pushViewController:howToUseVC animated:YES];
                } else {
                    [_Navi04 pushViewController:howToUseVC animated:YES];
                }
                
            }
            break;
        case 33:
            if (sender._ScreenName == OptionScreen)
            {
                _TabBar.tabBar.hidden = YES;
                AboutAppViewController *aboutVietGolfVC = [[AboutAppViewController alloc] initWithCoreGUI:self];
                [_Navi04 pushViewController:aboutVietGolfVC animated:YES];
            }
            break;
        case 34:
            if (sender._ScreenName == OptionScreen)
            {
                _TabBar.tabBar.hidden = YES;
                AboutGolfViewController *aboutGolfVC = [[AboutGolfViewController alloc] initWithCoreGUI:self];
                [_Navi04 pushViewController:aboutGolfVC animated:YES];
            }
            break;
            
        case 40:
            if (sender._ScreenName == MyInfoScreen)
            {
                EditMyInfoViewController *editMyInfoVC = [[EditMyInfoViewController alloc] initWithCoreGUI:self];
                editMyInfoVC._UserProE = [[UserProfile alloc] init];
                
                editMyInfoVC._UserProE = _UserProfile;
                [_Navi05 pushViewController:editMyInfoVC animated:YES];
            }
            break;
        case 41:
            if (sender._ScreenName == MyInfoScreen) {
                FeedbackViewController *feedbackVC = [[FeedbackViewController alloc] initWithCoreGUI:self];
                feedbackVC._IdUser = _UserProfile._Id;
                [_Navi05 pushViewController:feedbackVC animated:YES];
            }
            break;
        case 42:
            if (sender._ScreenName == MyInfoScreen) {
                NotificationTableViewController *notificationVC = [[NotificationTableViewController alloc] initWithCoreGUI:self style:UITableViewStylePlain];
                [_Navi05 pushViewController:notificationVC animated:YES];
                break;
            }
            
            // Pop ViewController
            
        case 100:
            if (sender._ScreenName == DisplaySwingVideoScreen) {
                [_Navi popToRootViewControllerAnimated:NO];
                ((SwingVideoTableViewController*)[_Navi.viewControllers objectAtIndex:0])._FlagUpdate = YES;
            }
        case 101:
            if (sender._ScreenName == DisplaySwingVideoScreen) {
                [_Navi popToRootViewControllerAnimated:NO];
                ((SwingVideoTableViewController*)[_Navi.viewControllers objectAtIndex:0])._FlagUpdate = NO;
            }
        case 102:
            if (sender._ScreenName == RegisterScreen) {
                [_Navi popViewControllerAnimated:YES];
            }
        case 103:
            if (sender._ScreenName == CompareSwingVideo) {
                [_Navi popViewControllerAnimated:YES];
            }
            
        case 120:
            if (sender._ScreenName == RecordScreen || sender._ScreenName ==  ImportScreen) {
                [_Navi03 popToRootViewControllerAnimated:YES];
            }
            break;
        case 121:
            if (sender._ScreenName == CreateVideoSwing) {
                [_TabBar setSelectedIndex:0];
            }
            break;
        case 130:
            if (sender._ScreenName == AboutGolfScreen) {
                [_Navi04 popViewControllerAnimated:YES];
                _TabBar.tabBar.hidden = NO;
            }
            break;
        case 131:
            if (sender._ScreenName == AboutVietGolfScreen) {
                [_Navi04 popViewControllerAnimated:YES];
                _TabBar.tabBar.hidden = NO;
            }
            break;
        case 132:
            if (sender._ScreenName == GoToWebScreen) {
                if (((GoToWebViewController*)sender)._FlagNews) {
                    [self._Navi05 popViewControllerAnimated:YES];
                } else {
                    if (((GoToWebViewController*)sender)._FlagVideos) {
                        [self._Navi popViewControllerAnimated:YES];
                    } else {
                        if (((GoToWebViewController*)sender)._FlagDetailVideo)
                        {
                            [self._Navi02 popViewControllerAnimated:YES];
                        } else {
                            [self._Navi04 popViewControllerAnimated:YES];
                        }
                    }
                }
                [self._TabBar.tabBar setHidden:NO];
            }
            break;
        case 133:
            if (sender._ScreenName == HowToUseScreen) {
                [_Navi04 popViewControllerAnimated:YES];
                [_Navi05 popViewControllerAnimated:YES];
                _TabBar.tabBar.hidden = NO;
            }
            break;
            
            
        case 140:
            if (sender._ScreenName == EditMyInfoScreen || sender._ScreenName == FeedbackScreen) {
                [_Navi05 popViewControllerAnimated:YES];
            }
            break;
        case 141:
            if (sender._ScreenName == EditMyInfoScreen) {
                [_Navi05 popViewControllerAnimated:YES];
            }
            break;
        case 142:
            if (sender._ScreenName == EditMyInfoScreen) {
                [_Navi05 popViewControllerAnimated:YES];
            }
            break;
        case 143:
            if (sender._ScreenName == DetailNotificationScreen) {
                [_Navi05 popViewControllerAnimated:YES];
            }
            break;
            
        default:
            break;
    }
}

-(void)finishedCreateVideoVC:(AbstractViewController*)sender withVideoInfo:(SVideoInfo*)video
{
    if (sender._ScreenName == RecordScreen || sender._ScreenName == ImportScreen || sender._ScreenName == TrimAfterRecordScreen)
    {
        _SVideoInfoGUI._PathVideo = video._PathVideo;
    }
}

-(void)passingFromSwingToDisplay:(SwingVideoTableViewController*)sender withData:(SVideoInfo*)data withCurrentRow:(int)row withType:(BOOL)type
{
    DisplaySwingVideoViewController *displayVC = [[DisplaySwingVideoViewController alloc] initWithCoreGUI:self];
    [_Navi pushViewController:displayVC animated:YES];
    [self._TabBar.tabBar setHidden:YES];
    displayVC._IsMaster = type;
    [displayVC setCurrentRow:row];
    [displayVC playVideoWithData:data];

}

-(void)finishedFromSwingToOtherVC:(SwingVideoTableViewController*)sender withCode:(int)code
{
    if (code == 0) {
        ChooseCommunityViewController *chooseCommunityVC = [[ChooseCommunityViewController alloc] initWithCoreGUI:self];
        [_Navi04 pushViewController:chooseCommunityVC animated:YES];
        [_TabBar setSelectedIndex: 3];
    }
}

-(void)passingNotificationToDetailNo:(Notification*)notifi withCurrentRow:(int)curr
{
    DetailNotificationViewController *detailNoVC = [[DetailNotificationViewController alloc] initWithCoreGUI:self];
    detailNoVC._NotificationD = [[Notification alloc] init];
    detailNoVC._NotificationD = notifi;
    detailNoVC._CurrentRow = curr;
    [_Navi05 pushViewController:detailNoVC animated:YES];

}

-(void)goToCompareScreen:(SwingVideoTableViewController*)sender withData:(SVideoInfo*)svideoHost withCode:(int)code
{
    CompareSwingVideoViewController *compareVC = [[CompareSwingVideoViewController alloc] initWithCoreGUI:self];
    compareVC._SVideoHost = [[SVideoInfo alloc] init];
    compareVC._SVideoHost = svideoHost;
    if (code == 1) {
        compareVC._IsMixed = YES;
    } else {
        compareVC._IsMixed = NO;
    }
    [_Navi pushViewController:compareVC animated:YES];
    [_TabBar.tabBar setHidden:YES];
}

-(void)goToReviewSVideo:(SwingVideoTableViewController*)sender withData:(SVideoInfo*)data
{
    ReviewSwingVideoViewController *reviewVC = [[ReviewSwingVideoViewController alloc] initWithCoreGUI:self];
    reviewVC._ReSVideo = [[SVideoInfo alloc] init];
    reviewVC._ReSVideo = data;
    
    [_Navi pushViewController:reviewVC animated:YES];
}

-(void)goToTrimScreen:(SwingVideoTableViewController*)sender withData:(SVideoInfo*)data
{
    TrimVideoViewController *trimVC = [[TrimVideoViewController alloc] initWithCoreGUI:self];
    trimVC._TSVideo = [[SVideoInfo alloc] init];
    trimVC._TSVideo = data;
    
    [_Navi pushViewController:trimVC animated:YES];
}

// ----- Load
-(NSMutableArray*)loadVideoWithType:(int)type
{
    NSMutableArray *tempArrSVideo = [[NSMutableArray alloc] init];
    
    NSString *stringDBName;
    if (type == 1) {
        stringDBName = @"SVideosUser";
    }
    else
    {
        stringDBName = @"SVideosMaster";
    }
    
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", stringDBName]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath: path])
    {
        NSString *bundle = [[NSBundle mainBundle] pathForResource: stringDBName ofType: @"plist"];
        [fileManager copyItemAtPath:bundle toPath: path error:&error];
    }
    
    NSMutableArray *mountainsArray = [[[NSMutableArray alloc] initWithContentsOfFile:path]mutableCopy];
    
    int limit = (int)[mountainsArray count];
    
    for (int i = 0; i < limit; i++) {
        NSDictionary *item = [mountainsArray objectAtIndex:i];
        SVideoInfo *tempVideo = [[SVideoInfo alloc] init];
        if (type == 1) {
            tempVideo._Id = [[item valueForKey:@"id"] integerValue];
            tempVideo._PathVideo = [item valueForKey:@"path"];
            tempVideo._PathCompare = [item valueForKey:@"pathcompare"];
            tempVideo._VideoType = [item valueForKey:@"videotype"];
            tempVideo._Owner = [item valueForKey:@"owner"];
            tempVideo._Thumnail = [item valueForKey:@"thumnail"];
            tempVideo._GolfTree = [item valueForKey:@"golftree"];
            tempVideo._Time = [item valueForKey:@"time"];
            tempVideo._Voice = [[item valueForKey:@"voice"] boolValue];
            tempVideo._IsFavorited = [[item valueForKey:@"favorited"] boolValue];
            tempVideo._Prepare = [[item valueForKey:@"prepare"] boolValue];
            tempVideo._IsPosted = [[item valueForKey:@"posted"] boolValue];
        }
        else
        {
            if (type == 0) {
                tempVideo._Id = [[item valueForKey:@"id"] integerValue];
                tempVideo._PathVideo = [item valueForKey:@"path"];
                tempVideo._PathCompare = [item valueForKey:@"pathcompare"];
                tempVideo._VideoType = [item valueForKey:@"videotype"];
                tempVideo._Thumnail = [item valueForKey:@"thumnail"];
                tempVideo._Owner = [item valueForKey:@"owner"];
                tempVideo._GolfTree = [item valueForKey:@"golftree"];
                tempVideo._Time = [item valueForKey:@"time"];
                tempVideo._Voice = [[item valueForKey:@"voice"] boolValue];
                tempVideo._IsFavorited = [[item valueForKey:@"favorited"] boolValue];
            }
        }
        
        [tempArrSVideo addObject:tempVideo];
    }
    
    return tempArrSVideo;

}

-(NSMutableArray*)loadUserProfile
{
    NSMutableArray *tempArrUP = [[NSMutableArray alloc] init];
    
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"UserProfile.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath: path])
    {
        NSString *bundle = [[NSBundle mainBundle] pathForResource: @"UserProfile" ofType: @"plist"];
        [fileManager copyItemAtPath:bundle toPath: path error:&error];
    }
    NSMutableArray *mountainsArray = [[[NSMutableArray alloc] initWithContentsOfFile:path]mutableCopy];
    
    int i = 0;
    int limit = (int)[mountainsArray count];
    while (i < limit)
    {
        NSDictionary *item = [mountainsArray objectAtIndex:i];
        
        _UserProfile._Id = [[item valueForKey:@"id"] integerValue];
        _UserProfile._Email = [item valueForKey:@"email"];
        _UserProfile._Password = [item valueForKey:@"password"];
        _UserProfile._FullName = [item valueForKey:@"fullname"];
        _UserProfile._Gender = [item valueForKey:@"gender"];
        _UserProfile._City = [item valueForKey:@"city"];
        _UserProfile._Country = [item valueForKey:@"country"];
        _UserProfile._NumLike = (int)[[item valueForKey:@"numoflike"] integerValue];
        _UserProfile._NumPublic = (int)[[item valueForKey:@"numofpublic"] integerValue];
        _UserProfile._NumFavorited = (int)[[item valueForKey:@"numoffavorted"] integerValue];
        _UserProfile._AllowNotification = [[item valueForKey:@"allownotification"] boolValue];
        _UserProfile._AllowUpdate = [[item valueForKey:@"allowupdate"] boolValue];
        _UserProfile._Image = [item valueForKey:@"image"];
        _UserProfile._Status = [[item valueForKey:@"status"] boolValue];
        _UserProfile._UserType = [item valueForKey:@"usertype"];
        _UserProfile._Birthday = [item valueForKey:@"birthday"];
        
        [tempArrUP addObject:_UserProfile];
        i++;
    }
    
    return tempArrUP;
}

-(NSMutableArray*)loadSwingVideoInCommunity
{
    NSMutableArray *tempArrSVCommunity = [[NSMutableArray alloc] init];
    
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"SVideosCommunity.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath: path])
    {
        NSString *bundle = [[NSBundle mainBundle] pathForResource: @"SVideosCommunity" ofType: @"plist"];
        [fileManager copyItemAtPath:bundle toPath: path error:&error];
    }
    NSMutableArray *mountainsArray = [[[NSMutableArray alloc] initWithContentsOfFile:path] mutableCopy];
    
    int i = 0;
    int limit = (int)[mountainsArray count];
    while (i < limit)
    {
        NSDictionary *item = [mountainsArray objectAtIndex:i];
        
        SVideoInCommunity *tempSVideo = [[SVideoInCommunity alloc] init];
        tempSVideo._Id = [[item valueForKey:@"id"] integerValue];
        tempSVideo._PathVideo = [item valueForKey:@"path"];
        tempSVideo._PathThumnail = [item valueForKey:@"thumnail"];
        tempSVideo._Link = [item valueForKey:@"link"];
        tempSVideo._GolfTree = [item valueForKey:@"golftree"];
        tempSVideo._Owner = [item valueForKey:@"owner"];
        tempSVideo._Date = [item valueForKey:@"date"];
        tempSVideo._Like = [[item valueForKey:@"like"] integerValue];
        tempSVideo._Liked = [[item valueForKey:@"liked"] boolValue];
        
        [tempArrSVCommunity addObject:tempSVideo];
        i++;
    }
    
    return tempArrSVCommunity;
}

-(NSMutableArray*)loadNotication
{
    NSMutableArray *tempArr = [[NSMutableArray alloc] init];
    
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"Notification.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath: path])
    {
        NSString *bundle = [[NSBundle mainBundle] pathForResource: @"Notification" ofType: @"plist"];
        [fileManager copyItemAtPath:bundle toPath: path error:&error];
    }
    NSMutableArray *mountainsArray = [[[NSMutableArray alloc] initWithContentsOfFile:path]mutableCopy];
    
    int i = 0;
    int limit = (int)[mountainsArray count];
    while (i < limit)
    {
        NSDictionary *item = [mountainsArray objectAtIndex:i];
        
        Notification *notification = [[Notification alloc] init];
        
        notification._Id = [[item valueForKey:@"id"] integerValue];
        notification._Title = [item valueForKey:@"title"];
        notification._Link = [item valueForKey:@"link"];
        notification._Checked = [[item valueForKey:@"checked"] boolValue];
        notification._Time = [item valueForKey:@"time"];
        
        [tempArr addObject:notification];
        i++;
    }
    
    return tempArr;
}

// ----- Save
-(void)commitSwingVideo:(SVideoInfo*)video withType:(int)type
{
    _ArrayOfVideo = [self loadVideoWithType:1];
    if ([_ArrayOfVideo count] == 0) {
        _SVideoInfoGUI._Id = 10000;
    } else {
        _SVideoInfoGUI = [_ArrayOfVideo objectAtIndex:0];
    }
    
    NSMutableDictionary *arrSVideo = [[NSMutableDictionary alloc] init];
    
    if (_SVideoInfoGUI._Id < 0) {
        _SVideoInfoGUI._Id--;
    } else {
        _SVideoInfoGUI._Id = -_SVideoInfoGUI._Id;
    }
    
    [arrSVideo setObject:[NSNumber numberWithInt:-(_SVideoInfoGUI._Id)] forKey:@"id"];
    [arrSVideo setObject:video._PathVideo forKey:@"path"];
    [arrSVideo setObject:@"nothing" forKey:@"pathcompare"];
    [arrSVideo setObject:video._VideoType forKey:@"videotype"];
    [arrSVideo setObject:video._Owner forKey:@"owner"];
    if (type == 1)
    {
        [arrSVideo setObject:video._GolfTree forKey:@"golftree"];
    } else {
        [arrSVideo setObject:[NSString stringWithFormat:@"Updated: %@", video._GolfTree] forKey:@"golftree"];
    }
    [arrSVideo setObject:video._GolfTree forKey:@"golftree"];
    [arrSVideo setObject:[[NSDate alloc] init] forKey:@"time"];
    [arrSVideo setObject:[NSNumber numberWithBool:video._Voice] forKey:@"voice"];
    [arrSVideo setObject:[NSNumber numberWithBool:video._IsFavorited] forKey:@"favorited"];
    [arrSVideo setObject:video._Thumnail forKey:@"thumnail"];
    
    NSString *stringDBName;
    if (type == 1) {
        [arrSVideo setObject:[NSNumber numberWithBool:video._IsPosted] forKey:@"posted"];
        [arrSVideo setObject:[NSNumber numberWithBool:video._Prepare] forKey:@"prepare"];
        stringDBName = @"SVideosUser";
    }
    else
    {
        stringDBName = @"SVideosMaster";
    }
    
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", stringDBName]];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath: path])
    {
        NSString *bundle = [[NSBundle mainBundle] pathForResource: stringDBName ofType: @"plist"];
        [fileManager copyItemAtPath:bundle toPath: path error:&error];
    }
    
    
    NSMutableArray *mountainsArray = [[[NSMutableArray alloc] initWithContentsOfFile:path]mutableCopy];
    
    [mountainsArray insertObject:arrSVideo atIndex:0];
    [mountainsArray writeToFile:path atomically:YES];
}

-(void)writeToVideosCommunityDB
{
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"SVideosCommunity.plist"]];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath: path])
    {
        NSString *bundle = [[NSBundle mainBundle] pathForResource: @"SVideosCommunity" ofType: @"plist"];
        [fileManager copyItemAtPath:bundle toPath: path error:&error];
    }
    
    NSMutableArray *mountainsArray = [[[NSMutableArray alloc] initWithContentsOfFile:path]mutableCopy];
    
    NSMutableDictionary *tempAtIndex0 = [[NSMutableDictionary alloc] initWithDictionary:[mountainsArray objectAtIndex:0]];
    int idAtIndex0 = [[tempAtIndex0 valueForKey:@"id"] integerValue];
    if (idAtIndex0 <= -1) {
        [mountainsArray removeAllObjects];
    }
    
    int currentZ = [mountainsArray count];
    if (currentZ > 30) {
        for (int z = 29; z < currentZ; z++) {
            NSMutableDictionary *lastObject = [mountainsArray lastObject];
            
            [[NSFileManager defaultManager] removeItemAtPath:[lastObject valueForKey:@"thumnail"] error: nil];
            [mountainsArray removeLastObject];
        }
    }
    
    for (int i = 0; i < [_ArrVideosPosted count]; i++) {
        NSMutableDictionary *arrPosted = [[NSMutableDictionary alloc] init];
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        dict = [_ArrVideosPosted objectAtIndex:i];
        
        int id_svposted = [[[_ArrVideosPosted objectAtIndex:i] valueForKey:@"video_id"] integerValue];
        if (id_svposted > _IdSVideoPosted) {
            [arrPosted setObject:[NSNumber numberWithInt:id_svposted] forKey:@"id"];
            [arrPosted setObject:[dict valueForKey:@"video"] forKey:@"path"];
            [arrPosted setObject:[arrThumnailC objectAtIndex:i] forKey:@"thumnail"];
            [arrPosted setObject:[dict valueForKey:@"url"] forKey:@"link"];
            [arrPosted setObject:[dict valueForKey:@"owner"] forKey:@"owner"];
            [arrPosted setObject:[dict valueForKey:@"golftree"] forKey:@"golftree"];
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"dd/MM/yyyy HH:mm"];
            NSDate *date = [dateFormat dateFromString:[dict valueForKey:@"date"]];
            [arrPosted setObject:date forKey:@"time"];
            [arrPosted setObject:[NSNumber numberWithInt:[[dict valueForKey:@"like"] integerValue]] forKey:@"like"];
            
            [mountainsArray insertObject:arrPosted atIndex:0];
        }
    }
    
    [mountainsArray writeToFile:path atomically:YES];
}

-(void)cleanSVideosOfUserDB
{
    // Clean SVideosOfUser DB
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"SVideosUser.plist"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath: path])
    {
        NSString *bundle = [[NSBundle mainBundle] pathForResource: @"SVideosUser" ofType: @"plist"];
        
        [fileManager copyItemAtPath:bundle toPath: path error:&error];
    }
    
    //
    
    
    NSMutableArray *mountainsArray = [[[NSMutableArray alloc] initWithContentsOfFile:path]mutableCopy];
    
    [mountainsArray removeAllObjects];
    [mountainsArray writeToFile:path atomically:YES];
}

-(void)cleanSVideosOfMasterDB
{
    // Clean SVideosOfUser DB
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"SVideosMaster.plist"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath: path])
    {
        NSString *bundle = [[NSBundle mainBundle] pathForResource: @"SVideosMaster" ofType: @"plist"];
        
        [fileManager copyItemAtPath:bundle toPath: path error:&error];
    }
    
    NSMutableArray *mountainsArray = [[[NSMutableArray alloc] initWithContentsOfFile:path]mutableCopy];
    
    [mountainsArray removeAllObjects];
    [mountainsArray writeToFile:path atomically:YES];
    
}

-(void)updateRecords
{
    // Update SVideosOfMaster DB
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"SVideosMaster.plist"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath: path])
    {
        NSString *bundle = [[NSBundle mainBundle] pathForResource: @"SVideosMaster" ofType: @"plist"];
        
        [fileManager copyItemAtPath:bundle toPath: path error:&error];
    }
    
    NSMutableArray *mountainsArray = [[[NSMutableArray alloc] initWithContentsOfFile:path]mutableCopy];
    
    if (_UserProfile._AllowUpdate)
    {
        if ([arrMasrterVideo count] != 0 && [mountainsArray count] != 0)
        {
            NSMutableDictionary *temp = [arrMasrterVideo objectAtIndex:0];
            
            if ([[temp valueForKey:@"video_id"] integerValue] > [[[mountainsArray objectAtIndex:0] valueForKey:@"id"] integerValue])
            {
                int checkExists = [mountainsArray count];
                for (int k = 0; k < [mountainsArray count]; k++) {
                    
                    if ([[temp valueForKey:@"video_id"] integerValue] == [[[mountainsArray objectAtIndex:k] valueForKey:@"id"] integerValue]) {
                        checkExists++;
                        break;
                    }
                }
                
                if (checkExists == [mountainsArray count])
                {
                    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                    
                    [dict setObject:[NSNumber numberWithInt:[[temp valueForKey:@"video_id"] integerValue]] forKey:@"id"];
                    [dict setObject:[temp valueForKey:@"golftree"] forKey:@"golftree"];
                    [dict setObject:@"Master" forKey:@"owner"];
                    [dict setObject:[arrPath objectAtIndex:0] forKey:@"path"];
                    [dict setObject:@"nothing" forKey:@"pathcompare"];
                    [dict setObject:@"Master" forKey:@"videotype"];
                    [dict setObject:[[NSDate alloc] init] forKey:@"time"];
                    [dict setObject:[NSNumber numberWithBool:NO] forKey:@"voice"];
                    [dict setObject:[NSNumber numberWithBool:NO] forKey:@"favorited"];
                    [dict setObject:[arrThumnail objectAtIndex:0] forKey:@"thumnail"];
                    
                    [mountainsArray insertObject:dict atIndex:0];
                }
            }
        } else {
            if ([arrMasrterVideo count] != 0) {
            NSMutableDictionary *temp = [arrMasrterVideo objectAtIndex:0];
        
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            
            [dict setObject:[NSNumber numberWithInt:[[temp valueForKey:@"video_id"] integerValue]] forKey:@"id"];
            [dict setObject:[temp valueForKey:@"golftree"] forKey:@"golftree"];
            [dict setObject:@"Master" forKey:@"owner"];
            [dict setObject:[arrPath objectAtIndex:0] forKey:@"path"];
            [dict setObject:@"nothing" forKey:@"pathcompare"];
            [dict setObject:@"Master" forKey:@"videotype"];
            [dict setObject:[[NSDate alloc] init] forKey:@"time"];
            [dict setObject:[NSNumber numberWithBool:NO] forKey:@"voice"];
            [dict setObject:[NSNumber numberWithBool:NO] forKey:@"favorited"];
            [dict setObject:[arrThumnail objectAtIndex:0] forKey:@"thumnail"];
            
            [mountainsArray insertObject:dict atIndex:0];
        }
    }
    
    [mountainsArray writeToFile:path atomically:YES];
    }
}

-(void)updateUserProfileWithCode:(int)code
{
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"UserProfile.plist"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath: path])
    {
        NSString *bundle = [[NSBundle mainBundle] pathForResource: @"UserProfile" ofType: @"plist"];
        
        [fileManager copyItemAtPath:bundle toPath: path error:&error];
    }
    
    NSMutableArray *mountainsArray = [[[NSMutableArray alloc] initWithContentsOfFile:path]mutableCopy];
    
    for (int i = 0; i < [mountainsArray count]; i++) {
        NSMutableDictionary *dict = [mountainsArray objectAtIndex:i];
        
        if (code == 0) {
            [dict setObject:[NSNumber numberWithInt:_UserProfile._Id] forKey:@"id"];
            [dict setObject: _UserProfile._Email forKey:@"email"];
            [dict setObject: _UserProfile._Password forKey:@"password"];
            [dict setObject: _UserProfile._FullName forKey:@"fullname"];
            [dict setObject: @"24/11/1991" forKey:@"birthday"];
            [dict setObject: @"Ho Chi Minh City" forKey:@"city"];
            [dict setObject: @"Male" forKey:@"gender"];
            [dict setObject: @"Vietnam" forKey:@"country"];
            [dict setObject: @"IconUserDefault.png" forKey:@"image"];
            [dict setObject: [NSNumber numberWithBool:YES] forKey:@"status"];
            [dict setObject:[NSNumber numberWithInt:0] forKey:@"numoffavorited"];
            [dict setObject:[NSNumber numberWithInt:0] forKey:@"numofpublic"];
            [dict setObject:[NSNumber numberWithInt:0] forKey:@"numoflike"];
            [dict setObject: [NSNumber numberWithBool:YES] forKey:@"allowupdate"];
            [dict setObject: [NSNumber numberWithBool:YES] forKey:@"allownotification"];
        }
        else {
            if (code == 4)
            {
                _UserProfile._NumPublic++;
                [dict setObject:[NSNumber numberWithInt:_UserProfile._NumPublic] forKey:@"numofpublic"];
            } else{
                if (code == 3)
                {
                    [dict setObject: _UserProfile._FullName forKey:@"fullname"];
                    [dict setObject: _UserProfile._City forKey:@"city"];
                    [dict setObject: _UserProfile._Gender forKey:@"gender"];
                    [dict setObject: _UserProfile._Country forKey:@"country"];
                    [dict setObject: _UserProfile._Birthday forKey:@"birthday"];
                    [dict setObject: [NSNumber numberWithBool:_UserProfile._AllowUpdate] forKey:@"allowupdate"];
                    [dict setObject: [NSNumber numberWithBool:_UserProfile._AllowNotification] forKey:@"allownotification"];
                }
                else
                {
                    if (code == 2) {
                        _UserProfile._NumFavorited++;
                    }
                    else {
                        if (code == 1) {
                            _UserProfile._NumFavorited--;
                        }
                    }
                    [dict setObject:[NSNumber numberWithInt:_UserProfile._NumFavorited] forKey:@"numoffavorited"];
                }

            }
            
        }
        
        [mountainsArray replaceObjectAtIndex:i withObject:dict];
    }
    [mountainsArray writeToFile:path atomically:YES];
}

-(void)updateProfileToServer
{
    // Nho xu ly khong ket noi duoc
    int gender = 0;
    if ([_UserProfile._Gender isEqualToString:@"Male"]) {
        gender = 0;
    } else {
        if ([_UserProfile._Gender isEqualToString:@"Female"]) {
            gender = 1;
        } else {
            gender = 2;
        }
        
    }
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd hh:mm:ss a"];
    NSDate *myDate = [df dateFromString: _UserProfile._Birthday];
    
    NSTimeInterval inter = [myDate timeIntervalSince1970];
    NSString *intervalString = [NSString stringWithFormat:@"%f", inter];
    
    NSString *rawStr = [NSString stringWithFormat:@"id=%d&fullname=%@&gender=%d&city=%@&country=%@&notification=%d&update=%d&birthday=%@", _UserProfile._Id,  _UserProfile._FullName, gender, _UserProfile._City, _UserProfile._Country, _UserProfile._AllowNotification, _UserProfile._AllowUpdate, intervalString];
    NSData *data = [rawStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *stringURL = [[NSString stringWithFormat:@"http://vietgolfvn.com/admincp/api/index/syncaccount?id=%d&fullname=%@&gender=%d&city=%@&country=%@&notification=%d&update=%d&birthday=%@", _UserProfile._Id, _UserProfile._FullName, gender, _UserProfile._City, _UserProfile._Country, _UserProfile._AllowNotification, _UserProfile._AllowUpdate, intervalString] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *link = [NSURL URLWithString:stringURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:link];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data];
    
    NSURLResponse *response;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    if (!responseData) {
        UIAlertView *alertS = [[UIAlertView alloc] initWithTitle:@"Cảnh báo" message:@"Lỗi khi đồng bộ dữ liệu đến server! Hiện tại server không có sẵn hoặc lỗi kết nối internet!" delegate:nil cancelButtonTitle:@"Thử lại" otherButtonTitles:nil];
        [alertS show];
    }
}

// ----- API

-(int)updateRecentSVideoOfSystem
{
    // Nho xu ly khong ket noi duoc
    NSString *rawStr = [NSString stringWithFormat:@"id=%d", _UserProfile._Id];
    NSData *data = [rawStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *stringURL = [[NSString stringWithFormat:@"http://vietgolfvn.com/admincp/api/index/videosystem?id=%d", _UserProfile._Id] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:stringURL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data];
    
    NSURLResponse *response;
    NSError *err;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    int statusR;
    if (responseData == nil) {
        statusR = -2;
    } else {
        
        NSDictionary *jsonObject=[NSJSONSerialization
                                  JSONObjectWithData:responseData
                                  options:NSJSONReadingMutableLeaves
                                  error:nil];
        
        statusR = [[jsonObject valueForKey:@"msg"] integerValue];
        if (statusR != 0) {
            arrMasrterVideo = [NSMutableArray arrayWithArray:[jsonObject valueForKey:@"data"]];
        }

    }
    return statusR;
}


-(int)requireStatusRegister
{
    // Nho xu ly khong ket noi duoc
    NSString *rawStr = [NSString stringWithFormat:@"fullname=%@&username=%@&email=%@&password=%@", _UserProfile._FullName, @"Unknown", _UserProfile._Email, _UserProfile._Password];
    NSData *data = [rawStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *stringURL = [[NSString stringWithFormat:@"http://vietgolfvn.com/admincp/api/index/register?fullname=%@&username=%@&email=%@&password=%@", _UserProfile._FullName,  @"Unknown", _UserProfile._Email, _UserProfile._Password] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:stringURL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data];
    
    NSURLResponse *response;
    NSError *err;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    if (responseData == nil) {
        return -2;
    }
    
    NSDictionary *jsonObject=[NSJSONSerialization
                              JSONObjectWithData:responseData
                              options:NSJSONReadingMutableLeaves
                              error:nil];
    _CheckStatus = [[jsonObject valueForKey:@"msg"] integerValue];
    if (_CheckStatus != 0) {
        arrMasrterVideo = [NSMutableArray arrayWithArray:[jsonObject valueForKey:@"data"]];
        _UserProfile._Id = [[jsonObject valueForKey:@"id"] integerValue];
    }
    
    return _CheckStatus;
}

-(void)downloadRecords
{
        
    if (arrMasrterVideo == nil) {
        return;
    }
    
    arrSVideoDownloaded = [[NSMutableArray alloc] init];
    arrPath = [[NSMutableArray alloc] init];
    countRecords = 0;
    
    
    NSString *stringPath = [[arrMasrterVideo objectAtIndex:0] valueForKey:@"path"];
    //initialize new mutable data
    NSMutableData *data = [[NSMutableData alloc] init];
    self._ReceivedData = data;

    //initialize url that is going to be fetched.
    NSURL *url = [NSURL URLWithString:stringPath];
        
    //initialize a request from url
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:12];
    
    //initialize a connection from request
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    self._Connection = connection;
        
    //start the connection
    [connection start];
    
}


/*
 this method might be calling more than one times according to incoming data size
 */
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [self._ReceivedData appendData:data];
}
/*
 if there is an error occured, this method will be called by connection
 */
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    UIAlertView *alertS = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Kết nối đến server thất bại!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertS show];
}

/*
 if data is successfully received, this method will be called by connection
 */
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSMutableDictionary *dictResult = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *dictItem = [[NSMutableDictionary alloc] init];
    NSString *stringPath = [[arrMasrterVideo objectAtIndex:0] valueForKey:@"path"];
    int lenghtPath = stringPath.length;
    NSString *currentFormatSVideo = [stringPath substringWithRange:NSMakeRange(lenghtPath - 3, 3)];
    
    if (self._ReceivedData == nil) {
        [arrMasrterVideo removeAllObjects];
    } else {
        
        [arrSVideoDownloaded addObject:[NSNumber numberWithInt: [[[arrMasrterVideo objectAtIndex:0] valueForKey:@"video_id"] integerValue]]];
        countRecords++;
        // get the documents directory
        NSArray* pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                 NSUserDomainMask, YES);
        NSString* documentsDir  = [pathArray objectAtIndex:0];
        
        NSString* localFile = [[NSString alloc] init];
        if ([currentFormatSVideo isEqualToString:@"m4v"]) {
            localFile = [documentsDir stringByAppendingString:[NSString stringWithFormat:@"/Video%fs.m4v", [[NSDate date] timeIntervalSince1970]]];
        } else {
            if ([currentFormatSVideo isEqualToString:@"mov"]) {
                localFile = [documentsDir stringByAppendingString:[NSString stringWithFormat:@"/Video%fs.mov", [[NSDate date] timeIntervalSince1970]]];
            } else {
                localFile = [documentsDir stringByAppendingString:[NSString stringWithFormat:@"/Video%fs.mp4", [[NSDate date] timeIntervalSince1970]]];
            }
        }
        
        
        // write the downloaded file to documents dir
        [self._ReceivedData writeToFile:localFile atomically:YES];
        
        [arrPath addObject:localFile];
    }
    
    if (countRecords == 0) {
        [dictItem setObject:[NSNumber numberWithInt:0] forKey:@"params"];
    } else {
        [dictItem setObject:[NSNumber numberWithInt:1] forKey:@"params"];
    }
    
    [dictItem setObject:arrSVideoDownloaded forKey:@"video_id"];
    [dictResult setObject:dictItem forKey:@"data"];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictResult
                                                       options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
   
    jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    [self reponseDownloadedToServer: jsonString];
    [self updateRecords];
    
    
}


-(void)downloadThumnailsWithCode:(int)code
{
    
    arrThumnail = [[NSMutableArray alloc] init];
    if (code == 0) {
        NSString *stringPath = [[arrMasrterVideo objectAtIndex:0] valueForKey:@"image"];
        int lenghtPath = stringPath.length;
        NSString *formatVideo = [stringPath substringWithRange:NSMakeRange(lenghtPath - 3, 3)];
        
        NSURL* url = [NSURL URLWithString: stringPath];
        NSData* data = [NSData dataWithContentsOfURL:url];
        if (data == nil) {
            [arrMasrterVideo removeAllObjects];
        } else {
            
            // get the documents directory
            NSArray* pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                     NSUserDomainMask, YES);
            NSString* documentsDir  = [pathArray objectAtIndex:0];
            
            NSString *localFile = [[NSString alloc] init];
            if ([formatVideo isEqualToString:@"gif"]) {
                localFile = [documentsDir stringByAppendingString:[NSString stringWithFormat:@"/Images%fs.gif", [[NSDate date] timeIntervalSince1970]]];
            } else {
                if ([formatVideo isEqualToString:@"jpg"]) {
                    localFile = [documentsDir stringByAppendingString:[NSString stringWithFormat:@"/Images%fs.jpg", [[NSDate date] timeIntervalSince1970]]];
                } else {
                    localFile = [documentsDir stringByAppendingString:[NSString stringWithFormat:@"/Images%fs.png", [[NSDate date] timeIntervalSince1970]]];
                }
            }
            
            
            // write the downloaded file to documents dir
            [data writeToFile:localFile atomically:YES];
            
            [arrThumnail addObject:localFile];
            
        }
        
    }
}

-(void)reponseDownloadedToServer:(NSString*)JSON
{
    // Nho xu ly khong ket noi duoc
    NSString *rawStr = [NSString stringWithFormat:@"data=%@", JSON];
    NSData *data = [rawStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *stringURL = [NSString stringWithFormat:@"http://vietgolfvn.com/admincp/api/index/countdownload?data=%@", JSON];
    NSURL *url = [NSURL URLWithString:stringURL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data];
    
    NSURLResponse *response;
    NSError *err;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    if (responseData != nil) {
    }
}

-(int)uploadVideoToServerWithStringPath:(NSString*)stringPath andGolfClub:(NSString*)golfclub
{
    NSString *escapedUrlString = [stringPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSData *newdata = [NSData dataWithContentsOfFile:escapedUrlString];
    NSData *webdata= [NSData dataWithData:newdata];
    
    NSString *urlString = [NSString stringWithFormat:@"http://vietgolfvn.com/admincp/api/index/upload?id=%d&golftree=%@", _UserProfile._Id, golfclub];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"userfile\"; filename=\"Post%fs.mov\"\r\n", [[NSDate date] timeIntervalSince1970]] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:webdata]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:body];
    
    NSURLResponse *response;
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    int returnR;
    if (returnData == nil) {
        returnR = -1;
    } else {
        returnR = 1;
    }
    return returnR;
}

-(void)downloadSwingVideoPosted:(int)videoid
{
    // Nho xu ly khong ket noi duoc
    NSString *rawStr = [NSString stringWithFormat:@""];
    NSData *data = [rawStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *stringURL = [NSString stringWithFormat:@"http://vietgolfvn.com/admincp/api/index/linkvideo?id=%d", videoid];
    NSURL *url = [NSURL URLWithString:stringURL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data];
    
    NSURLResponse *response;
    NSError *err;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    if (responseData != nil) {
        
        NSDictionary *jsonObject=[NSJSONSerialization
                                  JSONObjectWithData:responseData
                                  options:NSJSONReadingMutableLeaves
                                  error:nil];
        
        int check = [[jsonObject valueForKey:@"msg"] integerValue];
        
        if (check != 0) {
            _ArrVideosPosted = [NSMutableArray arrayWithArray:[jsonObject valueForKey:@"data"]];
            arrThumnailC = [[NSMutableArray alloc] init];
            
            for (int i = 0; i < [_ArrVideosPosted count]; i++) {
                
                if ([[_ArrVideosPosted objectAtIndex:i] valueForKey:@"owner"] == nil) {
                    [_ArrVideosPosted removeObjectAtIndex:i];
                } else {
                    NSString *stringPath = [[_ArrVideosPosted objectAtIndex:i] valueForKey:@"image"];
                    int lenghtPath = stringPath.length;
                    NSString *formatVideo = [stringPath substringWithRange:NSMakeRange(lenghtPath - 3, 3)];
                    
                    NSURL* url = [NSURL URLWithString: stringPath];
                    NSData* data = [NSData dataWithContentsOfURL:url];
                    if (data != nil) {
                        // Get the documents directory
                        NSArray* pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                                 NSUserDomainMask, YES);
                        NSString* documentsDir  = [pathArray objectAtIndex:0];
                        
                        NSString *localFile;
                        if ([formatVideo isEqualToString:@"gif"]) {
                            localFile = [documentsDir stringByAppendingString:[NSString stringWithFormat:@"/ThumnailPosted%fs.gif", [[NSDate date] timeIntervalSince1970]]];
                        } else {
                            if ([formatVideo isEqualToString:@"jpg"]) {
                                localFile = [documentsDir stringByAppendingString:[NSString stringWithFormat:@"/ThumnailPosted%fs.jpg", [[NSDate date] timeIntervalSince1970]]];
                            } else {
                                localFile = [documentsDir stringByAppendingString:[NSString stringWithFormat:@"/ThumnailPosted%fs.png", [[NSDate date] timeIntervalSince1970]]];
                            }
                        }
                        
                        // write the downloaded file to documents dir
                        [data writeToFile:localFile atomically:YES];
                        
                        [arrThumnailC addObject:localFile];
                    } else {
                        [_ArrVideosPosted removeObjectAtIndex:i];
                    }
                }
            }
            [self writeToVideosCommunityDB];
        }
    }
}

-(int)sendNumLikeOfVideo:(int)videoid
{
    // Nho xu ly khong ket noi duoc
    NSString *rawStr = [NSString stringWithFormat:@"id=%d", videoid];
    NSData *data = [rawStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *stringURL = [NSString stringWithFormat:@"http://vietgolfvn.com/admincp/api/index/like?id=%d", videoid];
    NSURL *url = [NSURL URLWithString:stringURL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data];
    
    NSURLResponse *response;
    NSError *err;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    int checkSuccessLike;
    if (responseData == nil) {
        checkSuccessLike = -1;
    } else {
        checkSuccessLike = 1;
        
        NSDictionary *jsonObject=[NSJSONSerialization
                                  JSONObjectWithData:responseData
                                  options:NSJSONReadingMutableLeaves
                                  error:nil];
        
        int numLike = [[jsonObject valueForKey:@"msg"] integerValue];
        
        NSError *error;
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", @"SVideosCommunity"]];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        if (![fileManager fileExistsAtPath: path])
        {
            NSString *bundle = [[NSBundle mainBundle] pathForResource:@"SVideosCommunity" ofType: @"plist"];
            
            [fileManager copyItemAtPath:bundle toPath: path error:&error];
        }
        
        NSMutableArray *mountainsArray = [[[NSMutableArray alloc] initWithContentsOfFile:path]mutableCopy];
        
        for (int j = 0; j < [mountainsArray count]; j++)
        {
            NSMutableDictionary *dict = [mountainsArray objectAtIndex:j];
            int videoDB = [[dict valueForKey:@"id"] integerValue];
            int likeDB = [[dict valueForKey:@"like"] integerValue];
            if (videoDB == videoid)
            {
                if (numLike > 0) {
                    [dict setObject:[NSNumber numberWithBool:++numLike] forKey:@"like"];
                } else {
                    [dict setObject:[NSNumber numberWithBool:++likeDB] forKey:@"like"];
                }
                [dict setObject:[NSNumber numberWithBool:YES] forKey:@"liked"];
                [mountainsArray replaceObjectAtIndex:j withObject:dict];
                break;
            }
        }
        
        [mountainsArray writeToFile:path atomically:YES];
    }
    return checkSuccessLike;
}

-(int)sendCommentVideo:(int)videoid withContent:(NSString*)content
{
    // Nho xu ly khong ket noi duoc
    NSString *rawStr = [NSString stringWithFormat:@"account_id=%d&video_id=%d&content=%@", _UserProfile._Id, videoid, content];
    NSData *data = [rawStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *stringURL = [[NSString stringWithFormat:@"http://vietgolfvn.com/admincp/api/index/comment?account_id=%d&video_id=%d&content=%@", _UserProfile._Id, videoid, content] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:stringURL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data];
    
    NSURLResponse *response;
    NSError *err;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    int statusComment;
    if (responseData == nil) {
        statusComment = -1;
    } else {
        statusComment = 1;
    }
    return statusComment;
}


// -- Orientrotate & landscape
-(BOOL)stringClassName
{
    NSLog(@"%@", ((UIViewController*)[(UINavigationController*)self._TabBar.selectedViewController visibleViewController]).title);
    if ([((UIViewController*)[(UINavigationController*)self._TabBar.selectedViewController visibleViewController]).title isEqualToString:@"Xem"] | [((UIViewController*)[(UINavigationController*)self._TabBar.selectedViewController visibleViewController]).title isEqualToString:@"So sánh"]) {
        return YES;
    } else {
        return NO;
    }
}


@end



