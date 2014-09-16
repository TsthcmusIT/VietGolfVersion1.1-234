//
//  MyInfoViewController.m
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import "MyInfoViewController.h"
#import "CoreGUIController.h"

@interface MyInfoViewController ()

@end

@implementation MyInfoViewController

@synthesize _ScrollView, _UserProM;
@synthesize _CameraUI, _CircleCenter, _CircleLayer, _CircleRadius, _MaskLayer;
@synthesize _FlagUpdateInfo;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"Thông tin tài khoản";
    self.title = @"Thông Tin";
    _ScreenName = MyInfoScreen;
    flag = NO;
    _FlagUpdateInfo = NO;
    [[UIBarButtonItem appearance] setTintColor:[UIColor whiteColor]];
    
    self.view.backgroundColor = [UIColor colorWithRed:50.0f/255.0f green:50.0f/255.0f blue:50.0f/255.0f alpha:1.0f];
    
    _ScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _ScrollView.contentSize = CGSizeMake(self.view.frame.size.width, 620.0f);
    _ScrollView.minimumZoomScale = 0.5f;
    _ScrollView.maximumZoomScale = 2.0f;
    _ScrollView.delegate = self;
    _ScrollView.backgroundColor = [UIColor clearColor];
    
    
    lblLineTop = [[UILabel alloc] init];
    lblLineTop.frame = CGRectMake(0, 0, self.view.frame.size.width, 15.0f);
    lblLineTop.backgroundColor = [UIColor colorWithRed:40.0f/255.0f green:40.0f/255.0f blue:40.0f/255.0f alpha:1.0f];
    
    imaVAvatar = [[UIImageView alloc]initWithFrame:CGRectMake(10.0f, lblLineTop.frame.origin.y + lblLineTop.frame.size.height + 5.0f, 120.0f, 120.0f)];
    imaVAvatar.backgroundColor = [UIColor clearColor];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *getImagePath = [documentsDirectory stringByAppendingPathComponent:@"savedImage.png"];
    UIImage *img = [UIImage imageWithContentsOfFile:getImagePath];
    
    imaVAvatar.image = img;
    
    if (imaVAvatar.image == nil)
    {
        imaVAvatar.image = [UIImage imageNamed:@"IconUserDefault.png"];
    }
    
    btnImage = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnImage.frame = CGRectMake(15.0f, 5.0f, 110.0f, 110.0f);
    btnImage.backgroundColor = [UIColor clearColor];
    [btnImage addTarget:self action:@selector(changeImageUser) forControlEvents:UIControlEventTouchUpInside];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    imaVAvatar.layer.mask = maskLayer;
    _MaskLayer = maskLayer;
    
    // create shape layer for circle we'll draw on top of image (the boundary of the circle)
    
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    circleLayer.lineWidth = 3.0f;
    circleLayer.fillColor = [[UIColor clearColor] CGColor];
    circleLayer.strokeColor = [[UIColor grayColor] CGColor];
    [imaVAvatar.layer addSublayer:circleLayer];
    _CircleLayer = circleLayer;
    
    // create circle path
    
    [self updateCirclePathAtLocation:CGPointMake(imaVAvatar.bounds.size.width / 2.0f, imaVAvatar.bounds.size.height / 2.0f) radius:imaVAvatar.bounds.size.width * 0.50f];
    
    viewInfo = [[UILabel alloc]initWithFrame:CGRectMake(imaVAvatar.frame.origin.x + imaVAvatar.frame.size.width + 10.0f, imaVAvatar.frame.origin.y + 10, self.view.frame.size.width - imaVAvatar.frame.size.width, imaVAvatar.frame.size.height)];
    viewInfo.backgroundColor = [UIColor clearColor];
    
    lblTaiKhoan = [[UILabel alloc] init];
    lblTaiKhoan.frame = CGRectMake(15.0f + imaVAvatar.frame.size.width, lblLineTop.frame.origin.y + lblLineTop.frame.size.height + 15.0f, self.view.frame.size.width - viewInfo.frame.origin.x, 40.0f);
    lblTaiKhoan.backgroundColor = [UIColor clearColor];
    lblTaiKhoan.textColor = [UIColor whiteColor];
    [lblTaiKhoan setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:18.0f]];
    lblTaiKhoan.text = _UserProM._FullName;
    
    lblCity = [[UILabel alloc] init];
    lblCity.frame = CGRectMake(20.0f + imaVAvatar.frame.size.width, lblTaiKhoan.frame.origin.y + lblTaiKhoan.frame.size.height, self.view.frame.size.width - viewInfo.frame.origin.x, 18.0f);
    lblCity.backgroundColor = [UIColor clearColor];
    [lblCity setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14.0f]];
    lblCity.textColor = [UIColor whiteColor];
    lblCity.text = _UserProM._City;
    
    lblLoaiKH = [[UILabel alloc] init];
    lblLoaiKH.frame = CGRectMake(15.0f + imaVAvatar.frame.size.width, lblCity.frame.origin.y + lblCity.frame.size.height + 8.0f, self.view.frame.size.width - viewInfo.frame.origin.x, 18.0f);
    [lblLoaiKH setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14.0f]];
    lblLoaiKH.backgroundColor = [UIColor clearColor];
    lblLoaiKH.textColor = [UIColor whiteColor];
    lblLoaiKH.text = [NSString stringWithFormat:@"%@", _UserProM._Country];
    
    
    lblNumLike = [[UILabel alloc] init];
    lblNumLike.frame = CGRectMake(0, imaVAvatar.frame.origin.y + imaVAvatar.frame.size.height + 10.0f, 100.0f, 30.0f);
    lblNumLike.backgroundColor = [UIColor clearColor];
    [lblNumLike setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18.0f]];
    lblNumLike.textColor = [UIColor whiteColor];
    lblNumLike.textAlignment = NSTextAlignmentCenter;
    lblNumLike.text = [NSString stringWithFormat:@"%d", _UserProM._NumLike];
    
    
    lblNumPublicVideo = [[UILabel alloc] init];
    lblNumPublicVideo.frame = CGRectMake(lblNumLike.frame.size.width, imaVAvatar.frame.origin.y + imaVAvatar.frame.size.height + 10.0f, 120.0f, 30.0f);
    lblNumPublicVideo.backgroundColor = [UIColor clearColor];
    lblNumPublicVideo.textColor = [UIColor whiteColor];
    [lblNumPublicVideo setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18.0f]];
    lblNumPublicVideo.textAlignment = NSTextAlignmentCenter;
    lblNumPublicVideo.text = [NSString stringWithFormat:@"%d", _UserProM._NumPublic];
    
    
    lblNumFavorties = [[UILabel alloc] init];
    lblNumFavorties.frame = CGRectMake(lblNumPublicVideo.frame.origin.x + lblNumPublicVideo.frame.size.width, imaVAvatar.frame.origin.y + imaVAvatar.frame.size.height + 10.0f, 100.0f, 30.0f);
    lblNumFavorties.backgroundColor = [UIColor clearColor];
    [lblNumFavorties setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18.0f]];
    lblNumFavorties.textAlignment = NSTextAlignmentCenter;
    lblNumFavorties.textColor = [UIColor whiteColor];
    lblNumFavorties.text = [NSString stringWithFormat:@"%d", _UserProM._NumFavorited];
    
    
    lblLike = [[UILabel alloc] init];
    lblLike.frame = CGRectMake(0, lblNumLike.frame.origin.y + lblNumLike.frame.size.height, lblNumLike.frame.size.width, 20.f);
    lblLike.backgroundColor = [UIColor clearColor];
    lblLike.textColor = [UIColor whiteColor];
    lblLike.textAlignment = NSTextAlignmentCenter;
    [lblLike setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:13.0f]];
    lblLike.text = @"Thích";
    
    
    lblPublicVideo = [[UILabel alloc] init];
    lblPublicVideo.frame = CGRectMake(lblNumPublicVideo.frame.origin.x, lblNumPublicVideo.frame.origin.y + lblNumPublicVideo.frame.size.height, lblNumPublicVideo.frame.size.width, 20.0f);
    lblPublicVideo.backgroundColor = [UIColor clearColor];
    lblPublicVideo.textAlignment = NSTextAlignmentCenter;
    [lblPublicVideo setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:13.0f]];
    lblPublicVideo.textColor = [UIColor whiteColor];
    lblPublicVideo.text = @"Video tải lên";
    
    
    lblFavorties = [[UILabel alloc] init];
    lblFavorties.frame = CGRectMake(lblNumFavorties.frame.origin.x, lblNumFavorties.frame.origin.y + lblNumFavorties.frame.size.height, lblNumFavorties.frame.size.width, 20.0f);
    lblFavorties.backgroundColor = [UIColor clearColor];
    lblFavorties.textAlignment = NSTextAlignmentCenter;
    lblFavorties.textColor = [UIColor whiteColor];
    [lblFavorties setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:13.0f]];
    lblFavorties.text = @"Yêu thích";
    
    
    lblXepHang = [[UILabel alloc] init];
    lblXepHang.frame = CGRectMake(0, lblPublicVideo.frame.origin.y + lblPublicVideo.frame.size.height + 5.0f, self.view.frame.size.width, 15.0f);
    lblXepHang.textAlignment = NSTextAlignmentCenter;
    lblXepHang.backgroundColor = [UIColor colorWithRed:40.0f/255.0f green:40.0f/255.0f blue:40.0f/255.0f alpha:1.0f];
    
    // Helps
    lblTitleHelp = [[UILabel alloc] init];
    lblTitleHelp.frame = CGRectMake(0, lblXepHang.frame.origin.y + lblXepHang.frame.size.height, self.view.frame.size.width, 30.0f);
    lblTitleHelp.backgroundColor = [UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f];
    lblTitleHelp.textColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    [lblTitleHelp setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0f]];
    lblTitleHelp.text = @"  Trợ Giúp";
    lblTitleHelp.textAlignment = NSTextAlignmentLeft;
    
    UILabel *lblHF = [[UILabel alloc] initWithFrame:CGRectMake(0, lblTitleHelp.frame.origin.y + lblTitleHelp.frame.size.height, self.view.frame.size.width, 1.0f)];
    lblHF.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
    
    btnFeedback = [UIButton buttonWithType:UIButtonTypeCustom];
    btnFeedback.frame = CGRectMake(0, lblHF.frame.origin.y + lblHF.frame.size.height, self.view.frame.size.width, 26.0f);
    [btnFeedback setTitle:@" Phản hồi, đánh giá ứng dụng" forState:UIControlStateNormal];
    btnFeedback.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btnFeedback.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14.0f]];
    [btnFeedback addTarget:self action:@selector(feedbackAboutApp) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *lblFG = [[UILabel alloc] initWithFrame:CGRectMake(0, btnFeedback.frame.origin.y + btnFeedback.frame.size.height, self.view.frame.size.width, 1.0f)];
    lblFG.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
    
    btnGuide = [UIButton buttonWithType:UIButtonTypeCustom];
    btnGuide.frame = CGRectMake(0, lblFG.frame.origin.y + lblFG.frame.size.height, self.view.frame.size.width, 26.0f);
    [btnGuide setTitle:@" Hướng dẫn sử dụng" forState:UIControlStateNormal];
    [btnGuide.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14.0f]];
    btnGuide.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btnGuide addTarget:self action:@selector(guideForApp) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *lblGT = [[UILabel alloc] initWithFrame:CGRectMake(0, btnGuide.frame.origin.y + btnGuide.frame.size.height, self.view.frame.size.width, 1.0f)];
    lblGT.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
    
    btnTips = [UIButton buttonWithType:UIButtonTypeCustom];
    btnTips.frame = CGRectMake(0, lblGT.frame.origin.y + lblGT.frame.size.height, self.view.frame.size.width, 26.0f);
    [btnTips setTitle:@" Tin tức về golf" forState:UIControlStateNormal];
    btnTips.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btnTips.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14.0f]];
    [btnTips addTarget:self action:@selector(tipsForGolf) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *lblTP = [[UILabel alloc] initWithFrame:CGRectMake(0, btnTips.frame.origin.y + btnTips.frame.size.height, self.view.frame.size.width, 1.0f)];
    lblTP.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
    
    // Activity
    lblTitlePost = [[UILabel alloc] init];
    lblTitlePost.frame = CGRectMake(0, lblTP.frame.origin.y + lblTP.frame.size.height, self.view.frame.size.width, 30.0f);
    lblTitlePost.backgroundColor = [UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f];
    lblTitlePost.textColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    [lblTitlePost setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0f]];
    lblTitlePost.text = @"  Hoạt Động Gần Đây";
    lblTitlePost.textAlignment = NSTextAlignmentLeft;
    
    btnRefreshNoti = [UIButton buttonWithType:UIButtonTypeCustom];
    btnRefreshNoti.frame = CGRectMake(self.view.frame.size.width - 80.0f, lblTitlePost.frame.origin.y, 30.0f, 30.0f);
    btnRefreshNoti.layer.cornerRadius = 8.0f;
    btnRefreshNoti.backgroundColor = [UIColor clearColor];
    [btnRefreshNoti setBackgroundImage:[UIImage imageNamed:@"RefreshNotification.png"] forState:UIControlStateNormal];
    btnRefreshNoti.titleLabel.textAlignment = NSTextAlignmentCenter;
    btnRefreshNoti.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btnRefreshNoti.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f]];
    [btnRefreshNoti addTarget:self action:@selector(refreshNotificationFromServer) forControlEvents:UIControlEventTouchUpInside];
    
    
    arrNotiBefore = [[NSMutableArray alloc] init];
    arrNotiBefore = [_CoreGUI loadNotication];
    int numSelected = 0;
    for (int i = 0; i < [arrNotiBefore count]; i++) {
        Notification *noti = [[Notification alloc] init];
        noti = [arrNotiBefore objectAtIndex:i];
        if (!noti._Checked) {
            numSelected++;
        }
    }
    lblNumber = [[UILabel alloc] init];
    lblNumber.frame = CGRectMake(btnRefreshNoti.frame.origin.x + btnRefreshNoti.frame.size.width, btnRefreshNoti.frame.origin.y, 30.0f, 30.0f);
    lblNumber.backgroundColor = [UIColor clearColor];
    lblNumber.textColor = [UIColor colorWithWhite:1.0f alpha:1.0f];
    [lblNumber setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0f]];
    lblNumber.text = [NSString stringWithFormat:@"%d", numSelected];
    lblNumber.textAlignment = NSTextAlignmentLeft;
    
    imvThumnail = [[UIImageView alloc] initWithFrame:CGRectMake(20.0f, lblTitlePost.frame.origin.y + lblTitlePost.frame.size.height + 5.0f, self.view.frame.size.width - 40.0f, self.view.frame.size.width - 40.0f)];
    imvThumnail.backgroundColor = [UIColor clearColor];
    
    [_ScrollView addSubview:lblLineTop];
    [_ScrollView addSubview:lblTaiKhoan];
    [_ScrollView addSubview:lblCity];
    [_ScrollView addSubview:lblLoaiKH];
    [_ScrollView addSubview:imaVAvatar];
    [_ScrollView addSubview:viewInfo];
    [_ScrollView addSubview:lblNumLike];
    [_ScrollView addSubview:lblNumPublicVideo];
    [_ScrollView addSubview:lblNumFavorties];
    [_ScrollView addSubview:lblLike];
    [_ScrollView addSubview:lblPublicVideo];
    [_ScrollView addSubview:lblFavorties];
    [_ScrollView addSubview:lblXepHang];
    [_ScrollView addSubview:btnImage];
    [_ScrollView addSubview:lblTitleHelp];
    [_ScrollView addSubview:lblHF];
    [_ScrollView addSubview:btnFeedback];
    [_ScrollView addSubview:lblFG];
    [_ScrollView addSubview:btnGuide];
    [_ScrollView addSubview:lblGT];
    [_ScrollView addSubview:btnTips];
    [_ScrollView addSubview:lblTP];
    [_ScrollView addSubview:lblTitlePost];
    [_ScrollView addSubview:btnRefreshNoti];
    [_ScrollView addSubview:lblNumber];
    [_ScrollView addSubview:imvThumnail];
    
    [self.view addSubview:_ScrollView];
    
    UIButton *btnNotification = [UIButton buttonWithType:UIButtonTypeCustom];
    btnNotification.frame = CGRectMake(0, 15.0f, 30.0f, 30.0f);
    [btnNotification setImage:[UIImage imageNamed:@"Notification.png"] forState:UIControlStateNormal];
    [btnNotification addTarget:self action:@selector(viewMessage) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnNotification];
    
    
    UIButton *btnEditProfile = [UIButton buttonWithType:UIButtonTypeCustom];
    btnEditProfile.frame = CGRectMake(0, 0, 27.0f, 27.0f);
    [btnEditProfile setImage:[UIImage imageNamed:@"EditProfile.png"] forState:UIControlStateNormal];
    [btnEditProfile addTarget:self action:@selector(editMyInfo) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnEditProfile];
    
}

-(void)refreshNotificationFromServer
{
    // Nho xu ly khong ket noi duoc
    NSString *rawStr = [NSString stringWithFormat:@"params=%d&account=%d", 1, _UserProM._Id];
    NSData *data = [rawStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *stringURL = [NSString stringWithFormat:@"http://vietgolfvn.com/admincp/api/index/newscensorship?params=%d&account=%d", 1, _UserProM._Id];
    
    NSURL *url = [NSURL URLWithString:stringURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data];
    
    NSURLResponse *response;
    NSError *err;
    // msg
    // data - (id, url, tittle)
    // video - (id)
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    if (responseData != nil) {
        NSDictionary *jsonObject=[NSJSONSerialization
                                  JSONObjectWithData:responseData
                                  options:NSJSONReadingMutableLeaves
                                  error:nil];
        
        status = [[jsonObject valueForKey:@"msg"] integerValue];
        if (status == 1) {
            NSMutableString *stringData = [jsonObject valueForKey:@"data"];
            
            if (stringData != nil)
            {
                video = [[jsonObject valueForKey:@"video"] integerValue];
                arrNotification = [[NSMutableArray alloc] initWithArray:[jsonObject valueForKey:@"data"]];
                
                if (arrNotification != nil) {
                    if (video != 0) {
                        numUpdate = [arrNotification count] + 1;
                        [_CoreGUI updateUserProfileWithCode:4];
                    } else {
                        numUpdate = [arrNotification count];
                    }
                }
                [self writeToNotificationDB];
            } else {
                UIAlertView *alertInvalidEmail = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Rất tiếc! Không có tin tức mới!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertInvalidEmail show];
            }
        } else {
            if (status == -1) {
                video = [[jsonObject valueForKey:@"video"] integerValue];
                if (video != 0) {
                    [_CoreGUI updateUserProfileWithCode:4];
                    numUpdate = 1;
                    [self writeToNotificationDB];
                } else {
                    numUpdate = 0;
                    lblNumber.text = [NSString stringWithFormat:@"0"];
                    
                    UIAlertView *alertInvalidEmail = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Rất tiếc! Không có tin tức mới!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alertInvalidEmail show];
                }
                
            } else {
                UIAlertView *alertInvalidEmail = [[UIAlertView alloc] initWithTitle:@"Cảnh báo" message:@"Gặp vấn đề về tài khoản! Không thể cập nhật tin tức cho bạn!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertInvalidEmail show];
            }
        }
    } else {
        UIAlertView *alertInvalidEmail = [[UIAlertView alloc] initWithTitle:@"Lỗi kết nối!" message:@"Bạn vui lòng kiểm tra kết nối mạng!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertInvalidEmail show];
    }    
}


-(void)feedbackAboutApp
{
    [_CoreGUI finishedScreen:self withCode:41];
}

-(void)guideForApp
{
    [_CoreGUI finishedScreen:self withCode:32];
}

-(void)tipsForGolf
{
    [_CoreGUI._TabBar.tabBar setHidden:YES];
    GoToWebViewController *goToWebVC = [[GoToWebViewController alloc] initWithCoreGUI:_CoreGUI];
    goToWebVC._FlagNews = YES;
    goToWebVC._FlagDetailVideo = NO;
    goToWebVC._FlagVideos = NO;
    goToWebVC._StringLink = @"http://www.vietgolfvn.com/articles.html";
    [_CoreGUI._Navi05 pushViewController:goToWebVC animated:YES];
}

-(void)viewMessage
{
    [_CoreGUI finishedScreen:self withCode:42];
}

-(void)writeToNotificationDB
{
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
    
    int curentP = [mountainsArray count];
    if (curentP > 20) {
        for (int z = 19; z < curentP; z++) {
            [mountainsArray removeObjectAtIndex:[mountainsArray count] - 3];
        }
    }
    
    arrNotiBefore = [_CoreGUI loadNotication];
    currentId = ((Notification*)[arrNotiBefore objectAtIndex:0])._Id;
    
    NSMutableArray *arrayRecentSVideoPosted = [[NSMutableArray alloc] init];
    arrayRecentSVideoPosted = [_CoreGUI loadVideoWithType:1];

    if (video != 0) {
        NSMutableArray *arrayRecentSVideoPosted = [[NSMutableArray alloc] init];
        arrayRecentSVideoPosted = [_CoreGUI loadVideoWithType:1];
        
        for (int j = 0; j < [arrayRecentSVideoPosted count]; j++) {
            if (((SVideoInfo*)[arrayRecentSVideoPosted objectAtIndex:j])._Prepare == YES) {
                if (((SVideoInfo*)[arrayRecentSVideoPosted objectAtIndex:j])._IsPosted == NO)
                {
                    NSMutableDictionary *videoRecord = [[NSMutableDictionary alloc] init];
                    [videoRecord setObject: [NSNumber numberWithInt: currentId] forKey:@"id"];
                    [videoRecord setObject: @"Video bạn đã được hiển thị trên website!" forKey:@"title"];
                    [videoRecord setObject: @"http://www.vietgolfvn.com/video.html" forKey:@"link"];
                    [videoRecord setObject: [NSNumber numberWithBool:NO] forKey:@"checked"];
                    [videoRecord setObject:[[NSDate alloc] init] forKey:@"time"];
                    
                    [mountainsArray insertObject:videoRecord atIndex:0];
                    
                    NSError *errorU;
                    NSArray *pathsU = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                    NSString *documentsDirectoryU = [pathsU objectAtIndex:0];
                    NSString *pathU = [documentsDirectoryU stringByAppendingPathComponent:@"SVideosUser.plist"];
                    
                    NSFileManager *fileManagerU = [NSFileManager defaultManager];
                    if (![fileManagerU fileExistsAtPath: pathU])
                    {
                        NSString *bundleU = [[NSBundle mainBundle] pathForResource: @"SVideosUser" ofType: @"plist"];
                        
                        [fileManagerU copyItemAtPath:bundleU toPath: pathU error:&errorU];
                    }
                    
                    NSMutableArray *mountainsArrayU = [[[NSMutableArray alloc] initWithContentsOfFile:pathU] mutableCopy];

                    NSMutableDictionary *dict = [mountainsArrayU objectAtIndex:j];
                    [dict setObject:[NSNumber numberWithBool:YES] forKey:@"posted"];
                    
                    [mountainsArrayU replaceObjectAtIndex:j withObject:dict];
                    
                    [mountainsArrayU writeToFile:pathU atomically:YES];
                    [self loadPublicVideoRecent];
                }
                else {
                    numUpdate--;
                }
                break;
            }
        }
    }
    
    
    for (int i = 0; i < [arrNotification count]; i++) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        NSMutableDictionary *temp = [arrNotification objectAtIndex:i];
        
        if ([[temp valueForKey:@"id"] integerValue] > currentId) {
            [dict setObject: [NSNumber numberWithInt:[[temp valueForKey:@"id"] integerValue]] forKey:@"id"];
            [dict setObject: [temp valueForKey:@"title"] forKey:@"title"];
            [dict setObject: [temp valueForKey:@"url"] forKey:@"link"];
            [dict setObject: [NSNumber numberWithBool:NO] forKey:@"checked"];
            NSDateFormatter* myFormatter = [[NSDateFormatter alloc] init];
            [myFormatter setDateFormat:@"dd/MM/yyyy HH:mm"];
            NSDate* myDate = [myFormatter dateFromString:[temp valueForKey:@"date"]];
            [dict setObject: myDate forKey:@"time"];
            
            [mountainsArray insertObject:dict atIndex:0];
        } else {
            numUpdate--;
        }
    }
    [mountainsArray writeToFile:path atomically:YES];
    
    lblNumber.text = [NSString stringWithFormat:@"%d", numUpdate];
}

-(void)changeImageUser
{
    [self startMediaBrowserFromViewController:self usingDelegate:self];
}

-(BOOL)startMediaBrowserFromViewController:(UIViewController*)controller usingDelegate:(id )delegate
{
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f]];
    // 1 - Validations
    if (([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary] == NO)
        || (delegate == nil)
        || (controller == nil))
    {
        return NO;
    }
    // 2 - Get image picker
    UIImagePickerController *mediaUI = [[UIImagePickerController alloc] init];
    mediaUI.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    mediaUI.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:mediaUI.sourceType];
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    mediaUI.allowsEditing = YES;
    mediaUI.delegate = delegate;
    // 3 - Display image picker
    [controller presentViewController:mediaUI animated:YES completion:nil];
    return YES;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	[picker dismissViewControllerAnimated:YES completion:nil];
	imaVAvatar.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:@"savedImage.png"];
    UIImage *image = imaVAvatar.image; // imageView is my image from camera
    NSData *imageData = UIImagePNGRepresentation(image);
    [imageData writeToFile:savedImagePath atomically:NO];
}

// When the movie is done, release the controller.
-(void)myMovieFinishedCallback:(NSNotification*)aNotification
{
    [self dismissMoviePlayerViewControllerAnimated];
    MPMoviePlayerController* theMovie = [aNotification object];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification object:theMovie];
}

// For responding to the user tapping Cancel.
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)editMyInfo
{
    [_CoreGUI finishedScreen:self withCode:40];
}

- (void)updateCirclePathAtLocation:(CGPoint)location radius:(CGFloat)radius
{
    _CircleCenter = location;
    _CircleRadius = radius;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:_CircleCenter
                    radius:_CircleRadius
                startAngle:0.0
                  endAngle:M_PI * 2.0
                 clockwise:YES];
    
    _MaskLayer.path = [path CGPath];
    _CircleLayer.path = [path CGPath];
}

-(UIImage*)getThumnailFromVideoFromPath:(NSString*)path
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:path] options:nil];
    AVAssetImageGenerator *generateImg = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    generateImg.appliesPreferredTrackTransform = YES;
    NSError *error = NULL;
    CMTime time = CMTimeMake(1, 65);
    CGImageRef refImg = [generateImg copyCGImageAtTime:time actualTime:NULL error:&error];
    UIImage *FrameImage= [[UIImage alloc] initWithCGImage:refImg];
    
    // Create a thumbnail version of the image for the event object.
    CGSize size = FrameImage.size;
    CGSize croppedSize;
    
    CGFloat offsetX = 0.0;
    CGFloat offsetY = 0.0;
    
    // check the size of the image, we want to make it
    // a square with sides the size of the smallest dimension.
    // So clip the extra portion from x or y coordinate
    if (size.width > size.height) {
        offsetX = (size.height - size.width) / 2;
        croppedSize = CGSizeMake(size.height, size.height);
    } else {
        offsetY = (size.width - size.height) / 2;
        croppedSize = CGSizeMake(size.width, size.width);
    }
    
    // Crop the image before resize
    CGRect clippedRect = CGRectMake(offsetX * -1, offsetY * -1, croppedSize.width, croppedSize.height);
    CGImageRef imageRef = CGImageCreateWithImageInRect([FrameImage CGImage], clippedRect);
    // Done cropping
    
    // Resize the image
    CGRect rect = CGRectMake(0.0, 0.0, self.view.frame.size.width - 40.0f, self.view.frame.size.width - 40.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    [[UIImage imageWithCGImage:imageRef] drawInRect:rect];
    UIImage *thumbnail = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // Done Resizing
    
    return thumbnail;
    
}

-(void)loadPublicVideoRecent
{
    arrVideoPublic = [[NSMutableArray alloc] initWithArray:[_CoreGUI loadVideoWithType:1]];
    SVideoInfo *recentPublicVideo = [[SVideoInfo alloc] init];
    
    for (int i = 0; i < [arrVideoPublic count]; i++) {
        if (((SVideoInfo*)[arrVideoPublic objectAtIndex:i])._IsPosted || ((SVideoInfo*)[arrVideoPublic objectAtIndex:i])._Prepare) {
            recentPublicVideo = (SVideoInfo*)[arrVideoPublic objectAtIndex:i];
            break;
        }
        else
        {
            continue;
        }
    }
    
    if (recentPublicVideo._PathVideo != nil) {
        imvThumnail.image = [self getThumnailFromVideoFromPath:recentPublicVideo._PathVideo];
        UIButton *btnGoToWeb = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btnGoToWeb.frame = CGRectMake(0, 0, self.view.frame.size.width - 40.0f, 120.0f);
        btnGoToWeb.backgroundColor = [UIColor grayColor];
        btnGoToWeb.titleLabel.numberOfLines = 4;
        btnGoToWeb.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btnGoToWeb setTitle:@"Một trong những video mà bạn post lên website đã được hiển thị! Kiểm tra ngay trên website Viet Golf trước khi bị 'trôi'! Cảm ơn! " forState:UIControlStateNormal];
        btnGoToWeb.center = CGPointMake(imvThumnail.frame.origin.x + imvThumnail.frame.size.width/2.0f, imvThumnail.frame.origin.y + 60.0f);
        [btnGoToWeb addTarget:self action:@selector(goToVietGolfWebsite) forControlEvents:UIControlEventTouchUpInside];
        [btnGoToWeb.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:22.0f]];
        [btnGoToWeb setAlpha:0.7f];
        [_ScrollView addSubview:btnGoToWeb];
    } else {
        imvThumnail.image = [UIImage imageNamed:@"NoSwingVideo.png"];
    }
}

-(void)goToVietGolfWebsite
{
    [_CoreGUI._TabBar.tabBar setHidden:YES];
    GoToWebViewController *goToWebVC = [[GoToWebViewController alloc] initWithCoreGUI:_CoreGUI];
    goToWebVC._FlagNews = YES;
    goToWebVC._FlagDetailVideo = NO;
    goToWebVC._FlagVideos = NO;
    goToWebVC._StringLink = @"http://www.vietgolfvn.com/video.html";
    [_CoreGUI._Navi05 pushViewController:goToWebVC animated:YES];

}

-(void)viewWillAppear:(BOOL)animated
{
    [_CoreGUI._TabBar.tabBar setHidden:NO];
    if (_FlagUpdateInfo) {
        lblTaiKhoan.text = _UserProM._FullName;
        lblCity.text = _UserProM._City;
        lblLoaiKH.text = [NSString stringWithFormat:@"%@", _UserProM._Country];
        _FlagUpdateInfo = NO;
    }
    // Load du lieu
    if (flag) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *getImagePath = [documentsDirectory stringByAppendingPathComponent:@"savedImage.png"];
        UIImage *img = [UIImage imageWithContentsOfFile:getImagePath];
        
        imaVAvatar.image = img;
        if (imaVAvatar.image == nil)
        {
            imaVAvatar.image = [UIImage imageNamed:@"IconUserDefault.png"];
        }
    }
    else
    {
        flag = YES;
    }
    
    mulArr = [[NSMutableArray alloc] initWithArray:[_CoreGUI loadUserProfile]];
    _UserProM = [mulArr objectAtIndex:0];
    
    [self loadPublicVideoRecent];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
