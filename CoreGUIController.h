//
//  CoreGUIController.h
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import <Foundation/Foundation.h>

// -------- ViewController
// - SwingTabBar
#import "SwingVideoTableViewController.h"
#import "DisplaySwingVideoViewController.h"
#import "CompareSwingVideoViewController.h"
#import "ReviewSwingVideoViewController.h"
#import "TrimVideoViewController.h"
// - CommunityTabBar
#import "CommunityViewController.h"
// - CreateVideoTabBar
#import "CreateVideoViewController.h"
#import "RecordVideoViewController.h"
#import "ImportVideoViewController.h"
#import "TrimAfterRecordViewController.h"
#import "CompletedCreateVideoViewController.h"
// - OptionTabBar
#import "OptionViewController.h"
#import "ChooseCommunityViewController.h"
#import "GoToWebViewController.h"
#import "AboutGolfViewController.h"
#import "AboutAppViewController.h"
// - MyInfoTabBar
#import "MyInfoViewController.h"
#import "EditMyInfoViewController.h"
#import "FeedbackViewController.h"
#import "NotificationTableViewController.h"
#import "DetailNotificationViewController.h"
#import "HowToUseViewController.h"
// - StartAppViewController
#import "BeginViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"

#import "SVideoInfo.h"
#import "SVideoInCommunity.h"
#import "UserProfile.h"
#import "Notification.h"

@interface CoreGUIController : NSObject <NSURLConnectionDataDelegate>
{
    UIWindow *_Window;
    UITabBarController *_TabBar;
    UINavigationController *_Navi;
    UINavigationController *_Navi02;
    UINavigationController *_Navi03;
    UINavigationController *_Navi04;
    UINavigationController *_Navi05;
    
    NSMutableArray *_ArrViewControl;
    NSMutableArray *_ArrayOfVideo;
    NSMutableArray *_ArrUserProfile;
    NSMutableArray *_ArrVideosPosted;
    SVideoInfo *_SVideoInfoGUI;
    UserProfile *_UserProfile;
    SVideoInCommunity *_SVideoPosted;
    int _IdSVideoPosted;
    
    NSMutableArray *arrMasrterVideo;
    NSMutableArray *arrPath;
    NSMutableArray *arrThumnail;
    NSMutableArray *arrThumnailC;
    NSMutableArray *arrSVideoBefore;
    
    // Download
    NSMutableData *_ReceivedData;
    NSURLConnection *_Connection;
    NSMutableArray *arrSVideoDownloaded;
    int countRecords;
    int _CheckStatus;

}

@property (nonatomic, retain) UIWindow *_Window;
@property (nonatomic, retain) UITabBarController *_TabBar;
@property (nonatomic, retain) UINavigationController *_Navi;
@property (nonatomic, retain) UINavigationController *_Navi02;
@property (nonatomic, retain) UINavigationController *_Navi03;
@property (nonatomic, retain) UINavigationController *_Navi04;
@property (nonatomic, retain) UINavigationController *_Navi05;
@property (nonatomic, retain) NSMutableArray *_ArrViewControl;
@property (nonatomic, retain) NSMutableArray *_ArrayOfVideo;
@property (nonatomic, retain) NSMutableArray *_ArrUserProfile;
@property (nonatomic, retain) NSMutableArray *_ArrVideosPosted;
@property (nonatomic, retain) SVideoInfo *_SVideoInfoGUI;
@property (nonatomic, retain) UserProfile *_UserProfile;
@property (nonatomic, retain) SVideoInCommunity *_SVideoPosted;
@property (nonatomic) int _IdSVideoPosted;
@property (nonatomic) int _CheckStatus;


// -- Download
@property (retain, nonatomic) NSURLConnection *_Connection;
@property (retain, nonatomic) NSMutableData *_ReceivedData;


// ----------------- Methods
// -- Init
-(id)initWithWindow:(UIWindow*)window;
-(void)stratUp;
-(void)showMainScreen;
-(void)showBeginScreen;
-(void)checkUserStatus;
// -- Finish
-(void)finishedScreen:(AbstractViewController*)sender withCode:(int)code;
-(void)finishedCreateVideoVC:(AbstractViewController*)sender withVideoInfo:(SVideoInfo*)video;
-(void)passingFromSwingToDisplay:(SwingVideoTableViewController*)sender withData:(SVideoInfo*)data withCurrentRow:(int)row withType:(BOOL)type;
-(void)finishedFromSwingToOtherVC:(SwingVideoTableViewController*)sender withCode:(int)code;
-(void)passingNotificationToDetailNo:(Notification*)notifi withCurrentRow:(int)curr;
-(void)goToCompareScreen:(SwingVideoTableViewController*)sender withData:(SVideoInfo*)svideoHost withCode:(int)code;
-(void)goToReviewSVideo:(SwingVideoTableViewController*)sender withData:(SVideoInfo*)data;
-(void)goToTrimScreen:(SwingVideoTableViewController*)sender withData:(SVideoInfo*)data;
// -- Load
-(NSMutableArray*)loadVideoWithType:(int)type;
-(NSMutableArray*)loadUserProfile;
-(NSMutableArray*)loadSwingVideoInCommunity;
-(NSMutableArray*)loadNotication;
// -- Save
-(void)commitSwingVideo:(SVideoInfo*)video withType:(int)type;
-(void)writeToVideosCommunityDB;
-(void)cleanSVideosOfUserDB;
-(void)cleanSVideosOfMasterDB;
-(void)updateRecords;
-(void)updateUserProfileWithCode:(int)code;
-(void)updateProfileToServer;
// -- API
-(int)updateRecentSVideoOfSystem;
-(int)requireStatusRegister;
-(void)downloadRecords;
-(void)downloadThumnailsWithCode:(int)code;
-(void)reponseDownloadedToServer:(NSString*)JSON;
-(int)uploadVideoToServerWithStringPath:(NSString*)stringPath andGolfClub:(NSString*)golfclub;
-(void)downloadSwingVideoPosted:(int)videoid;
-(int)sendNumLikeOfVideo:(int)videoid;
-(int)sendCommentVideo:(int)videoid withContent:(NSString*)content;
// -- Orientrotate Landscape
-(BOOL)stringClassName;

@end


