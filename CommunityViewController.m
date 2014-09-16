//
//  CommunityViewController.m
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import "CommunityViewController.h"
#import "CoreGUIController.h"

@interface CommunityViewController ()

@end

@implementation CommunityViewController

@synthesize _ReceivedData, _Connection, bannerIsVisible;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _ScreenName = CommunityScreen;
    self.title = @"Cộng đồng";
    
    arrSVideo = [[NSMutableArray alloc] init];
    arrItems = [[NSMutableArray alloc] init];
    arrSVideo = [_CoreGUI loadSwingVideoInCommunity];
    if ([arrSVideo count] > 15) {
        numItemsDisplay = 15;
    } else {
        numItemsDisplay = [arrSVideo count];
    }
    self._ReceivedData = [[NSMutableData alloc] initWithCapacity:2048];
    
    pointPad = CGPointMake(self.view.frame.size.width/2.0f, self.view.frame.size.width/2.0f + 40.0f);
    
    _ScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _ScrollView.contentSize = CGSizeMake(self.view.frame.size.width, numItemsDisplay*(self.view.frame.size.width + 80.0f) + 100.0f);
    _ScrollView.minimumZoomScale = 0.5f;
    _ScrollView.maximumZoomScale = 2.0f;
    _ScrollView.delegate = self;
    [self.view addSubview:_ScrollView];
    
    btnMore = [UIButton buttonWithType:UIButtonTypeCustom];
    btnMore.frame = CGRectMake(0, 0, self.view.frame.size.width, 100.0f);
    [btnMore setTitle:@"Xem thêm" forState:UIControlStateNormal];
    [btnMore setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnMore setBackgroundColor:[UIColor redColor]];
    [btnMore.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:50.0f]];
    [btnMore addTarget:self action:@selector(moreItems) forControlEvents:UIControlEventTouchUpInside];
    
    [_ScrollView addSubview:btnMore];
    [self loadItemViewFromIndex:0 toIndex:numItemsDisplay];
    
    // iAd
    adView = [[ADBannerView alloc] initWithFrame:CGRectZero];
    adView.frame = CGRectMake(0, 0.9f*self.view.frame.size.height, self.view.frame.size.width, 0.1f*self.view.frame.size.height);
    
    [self.view addSubview:adView];
    adView.delegate = self;
    self.bannerIsVisible = NO;

}


//if ([[self.window.rootViewController presentedViewController]
    // isKindOfClass:[UIViewController class]]) {
   // NSLog(@"%u", ((AbstractViewController*)(self.window.rootViewController.presentedViewController))._ScreenName);
  //  return UIInterfaceOrientationMaskLandscapeLeft;

-(void)loadItemViewFromIndex:(int)indexA toIndex:(int)indexB
{
    for (int i = indexA; i < indexB; i++) {
        SVideoInCommunity *sVideos = [[SVideoInCommunity alloc] init];
        sVideos = [arrSVideo objectAtIndex:i];
        ItemSVideoView *itemV = [[ItemSVideoView alloc] initWithInfo:sVideos withFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width + 80.0f)];
        
        itemV._BtnViewInWeb.tag = i*4;
        [itemV._BtnViewInWeb addTarget:self action:@selector(viewSVideoInWeb:) forControlEvents:UIControlEventTouchDown];
        
        itemV._BtnLike.tag = i*4 + 1;
        [itemV._BtnLike addTarget:self action:@selector(likeSVideo:) forControlEvents:UIControlEventTouchDown];
        
        itemV._BtnComment.tag = i*4 + 2;
        [itemV._BtnComment addTarget:self action:@selector(commentSVideo:) forControlEvents:UIControlEventTouchDown];
        
        itemV._BtnDownload.tag = i*4 + 3;
        [itemV._BtnDownload addTarget:self action:@selector(downloadSVideo:) forControlEvents:UIControlEventTouchDown];
        
        
        [_ScrollView addSubview:itemV];
        itemV.center = pointPad;
        [arrItems addObject:itemV];
        pointPad.y += self.view.frame.size.width + 80.0f;
    }
    
    btnMore.center = CGPointMake(self.view.frame.size.width/2.0f, pointPad.y -  150.0f);
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    
    if (!self.bannerIsVisible)
        
    {
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        
        
        // banner is invisible now and moved out of the screen on 50 px
        
        banner.frame = CGRectOffset(banner.frame, 0, -banner.frame.size.height);
        [UIView commitAnimations];
        
        self.bannerIsVisible = YES;
    }
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    
    if (self.bannerIsVisible)
        
    {
        [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
        
        // banner is visible and we move it out of the screen, due to connection issue
        
        banner.frame = CGRectOffset(banner.frame, 0, banner.frame.size.height);
        banner.alpha = 0;
        [UIView commitAnimations];
        banner.hidden = YES;
        self.bannerIsVisible = NO;
    }
}

-(void)moreItems
{
    viewProcess = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    viewProcess.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:0.5f];
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.center = CGPointMake((self.view.frame.size.width)/2.0f, (self.view.frame.size.height)/1.25f);
    spinner.transform = CGAffineTransformMakeScale(2.0f, 2.0f);
    [viewProcess addSubview:spinner];
    [self.view addSubview:viewProcess];
    [spinner startAnimating];

    int subNum = [arrSVideo count] - numItemsDisplay;
    if (subNum > 0) {
        int count = 0;
        while (subNum > 0 && count < 3) {
            numItemsDisplay++;
            count++;
            [self loadItemViewFromIndex:numItemsDisplay toIndex:numItemsDisplay + 1];
            _ScrollView.contentSize = CGSizeMake(self.view.frame.size.width, numItemsDisplay*(self.view.frame.size.width + 80.0f) + 100.0f);
        }
    }
    [self performSelector:@selector(delayLoadingMoreSVideo) withObject:nil afterDelay:1.0f];
    
}

-(void)delayLoadingMoreSVideo
{
    [spinner stopAnimating];
    [spinner removeFromSuperview];
    [viewProcess removeFromSuperview];
}

-(void)viewSVideoInWeb:(UIButton*)sender
{
    recordSelected = sender.tag/4;
    GoToWebViewController *goToWebVC = [[GoToWebViewController alloc] initWithCoreGUI:_CoreGUI];
    goToWebVC._FlagDetailVideo = YES;
    goToWebVC._FlagNews = NO;
    goToWebVC._FlagVideos = NO;
    goToWebVC._StringLink = ((SVideoInCommunity*)[arrSVideo objectAtIndex:recordSelected])._Link;
    [_CoreGUI._Navi02 pushViewController:goToWebVC animated:YES];
}

-(void)likeSVideo:(UIButton*)sender
{
    recordSelected = sender.tag/4;
    int video_id = ((SVideoInCommunity*)[arrSVideo objectAtIndex:recordSelected])._Id;

    int checkLike;
    checkLike = [_CoreGUI sendNumLikeOfVideo:video_id];
    if (checkLike == 1) {
        SVideoInCommunity *sVideo = [[SVideoInCommunity alloc] init];
        sVideo = [arrSVideo objectAtIndex:recordSelected];
        int numLike = sVideo._Like;
        numLike++;
        ItemSVideoView *item = [arrItems objectAtIndex:recordSelected];
        item._LblLike.text = [NSString stringWithFormat:@"%d Thích", numLike];
        [item._BtnLike setEnabled:NO];
        item._LblLike.alpha = 0.5f;
        item._BtnLike.alpha = 0.5f;
    } else {
        [self showMessView];
    }
}

-(void)showMessView
{
    UIView *viewBackg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    viewBackg.backgroundColor = [UIColor colorWithWhite:1.0f alpha:1.0f];
    
    UIView *viewTit = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewBackg.frame.size.width - 20.0f, viewBackg.frame.size.width - 20.0f)];
    viewTit.backgroundColor = [UIColor colorWithWhite:0.6f alpha:0.8f];
    viewTit.layer.cornerRadius = 10.0f;
    viewTit.center = CGPointMake(viewBackg.frame.size.width/2.0f, viewBackg.frame.size.height/2.0f);
    UILabel *lblMessage = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, viewTit.frame.size.width - 40.0f, self.view.frame.size.height/3.0f)];
    lblMessage.center = CGPointMake(viewTit.frame.size.width/2.0f, viewTit.frame.size.height/2.0f);
    lblMessage.backgroundColor = [UIColor clearColor];
    lblMessage.textAlignment = NSTextAlignmentCenter;
    [lblMessage setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:30.0f]];
    lblMessage.numberOfLines = 2;
    [lblMessage setTextColor:[UIColor whiteColor]];
    lblMessage.text = @"Kết nối thất bại!";
    
    [viewTit addSubview:lblMessage];
    [viewBackg addSubview:viewTit];
    [self.view addSubview:viewBackg];
    
    [UIView animateWithDuration:2.0f delay:0.5f options:UIViewAnimationOptionCurveEaseIn animations:^{
        [viewBackg setAlpha:1.0f];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:2.0f delay:0.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [viewBackg setAlpha:0.0f];
        } completion:nil];
    }];
}

-(void)commentSVideo:(UIButton*)sender
{
    recordSelected = sender.tag/4;
    id_videocomment = ((SVideoInCommunity*)[arrSVideo objectAtIndex:recordSelected])._Id;
    
    viewBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0.52f*self.view.frame.size.height)];
    viewBackground.backgroundColor = [UIColor colorWithWhite:0.8f alpha:1.0f];
    
    viewTitle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0.09f*self.view.frame.size.height)];
    viewTitle.backgroundColor = [UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:0.95f];
    
    btnCancle = [UIButton buttonWithType:UIButtonTypeCustom];
    btnCancle.frame = CGRectMake(0, 0, 70.0f, 0.09f*self.view.frame.size.height);
    btnCancle.backgroundColor = [UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f];
    [btnCancle setTitle:@"Hoàn tác" forState:UIControlStateNormal];
    [btnCancle addTarget:self action:@selector(cancleCommentToServer) forControlEvents:UIControlEventTouchUpInside];
    
    btnDone = [UIButton buttonWithType:UIButtonTypeCustom];
    btnDone.frame = CGRectMake(self.view.frame.size.width - 70.0f, 0, 70.0f, 0.09f*self.view.frame.size.height);
    btnDone.backgroundColor = [UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f];
    [btnDone setTitle:@"Gửi" forState:UIControlStateNormal];
    [btnDone addTarget:self action:@selector(sendCommentToServer) forControlEvents:UIControlEventTouchUpInside];
    
    txtVContent = [[UITextView alloc] initWithFrame:CGRectMake(10.0f, 0.1f*self.view.frame.size.height, self.view.frame.size.width - 20.0f, viewBackground.frame.size.height - (viewTitle.frame.size.height + 20.0f))];
    txtVContent.delegate = self;
    txtVContent.layer.cornerRadius = 4.0f;
    [txtVContent setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14.0f]];
    
    [viewTitle addSubview:btnDone];
    [viewTitle addSubview:btnCancle];
    [viewBackground addSubview:txtVContent];
    [viewBackground addSubview:viewTitle];
    [self.view addSubview:viewBackground];
    
    viewBackground.alpha = 0;
    viewBackground.center = CGPointMake(self.view.frame.size.width/2.0f, self.view.frame.size.height);
    [UIView beginAnimations:NULL context:nil];
    [UIView setAnimationDuration:1.0f];
    
    viewBackground.alpha = 0.98f;
    viewBackground.center = CGPointMake(self.view.frame.size.width/2.0f, viewBackground.frame.size.height/2.0f + 64.0f);
    [txtVContent becomeFirstResponder];
    [UIView commitAnimations];
    
    
}

-(void)sendCommentToServer
{
    [btnDone removeFromSuperview];
    [txtVContent removeFromSuperview];
    [viewTitle removeFromSuperview];
    [viewBackground removeFromSuperview];
    int checkComment;
    checkComment = [_CoreGUI sendCommentVideo:id_videocomment withContent:txtVContent.text];
    
    if (checkComment == -1) {
        [self showMessView];
    }
}

-(void)cancleCommentToServer
{
    [btnDone removeFromSuperview];
    [txtVContent removeFromSuperview];
    [viewTitle removeFromSuperview];
    [viewBackground removeFromSuperview];
}

-(void)downloadSVideo:(UIButton*)sender
{
    recordSelected = sender.tag/4;
    id_videodownload = ((SVideoInCommunity*)[arrSVideo objectAtIndex:recordSelected])._Id;
    [self downloadVideoAndWriteToVideoWithInfo];
}

-(void)downloadVideoAndWriteToVideoWithInfo
{
    viewProcess = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    viewProcess.backgroundColor = [UIColor colorWithRed:250.0f/255.0f green:250.0f/255.0f blue:255.0f/255.0f alpha:0.8f];
    [self.view addSubview:viewProcess];
    
    progressOverlayView = [[DAProgressOverlayView alloc] initWithFrame:CGRectMake(0, 0, viewProcess.frame.size.width/2.0f, viewProcess.frame.size.width/2.0f)];
    progressOverlayView.center = CGPointMake(viewProcess.frame.size.width/2.0f, viewProcess.frame.size.height/2.0f);
    [viewProcess addSubview:progressOverlayView];
    
    [progressOverlayView displayOperationWillTriggerAnimation];
    
    sVPosted = [[SVideoInCommunity alloc] init];
    sVPosted = ((SVideoInCommunity*)[arrSVideo objectAtIndex:recordSelected]);
    // download
    
    NSString *stringPath = sVPosted._PathVideo;
    
    //initialize new mutable data
    NSMutableData *data = [[NSMutableData alloc] init];
    self._ReceivedData = data;
    
    //initialize url that is going to be fetched.
    NSURL *url = [NSURL URLWithString:stringPath];
    
    //initialize a request from url
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    
    //initialize a connection from request
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    self._Connection = connection;
    
    //start the connection
    [connection start];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    fileSize = [NSNumber numberWithUnsignedInteger:[response expectedContentLength]];
}

/*
 this method might be calling more than one times according to incoming data size
 */
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [self._ReceivedData appendData:data];
    NSNumber *resourceLength = [NSNumber numberWithUnsignedInteger:[data length]]; //MAGIC
    float progressAppend = [resourceLength floatValue] / [fileSize floatValue];
    
    CGFloat progress = progressOverlayView.progress + progressAppend;
    if (progress >= 1) {
        [progressOverlayView displayOperationDidFinishAnimation];
        double delayInSeconds = progressOverlayView.stateChangeAnimationDuration;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            progressOverlayView.progress = 0.;
            progressOverlayView.hidden = YES;
        });
    } else {
        progressOverlayView.progress = progress;
    }
}
/*
 if there is an error occured, this method will be called by connection
 */
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    UIAlertView *alertS = [[UIAlertView alloc] initWithTitle:@"Lỗi kết nối!" message:@"Hiện tại bạn không thể tải video này! Hãy kiểm tra kết nối hoặc thử lại vào thời điểm khác!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertS show];
    [viewProcess removeFromSuperview];
}

/*
 if data is successfully received, this method will be called by connection
 */
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSString *stringPath = sVPosted._PathVideo;
    int lenghtPath = stringPath.length;
    NSString *formatVideo = [stringPath substringWithRange:NSMakeRange(lenghtPath - 3, 3)];
    
    if (self._ReceivedData == nil) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Lỗi!" message:@"Rất tiếc! Mất kết nối mạng hoặc video bị lỗi!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
    } else {
        
        ItemSVideoView *item = [arrItems objectAtIndex:recordSelected];
        [item._BtnDownload setEnabled:NO];
        item._BtnDownload.alpha = 0.5f;
        item._LblDownload.alpha = 0.5f;
        
        // get the documents directory
        NSArray* pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                 NSUserDomainMask, YES);
        NSString* documentsDir  = [pathArray objectAtIndex:0];
        
        NSString* localFile;
        if ([formatVideo isEqualToString:@"m4v"]) {
            localFile = [documentsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"SVideoPosted%fs.m4v", [[NSDate date] timeIntervalSince1970]]];
        } else {
            if ([formatVideo isEqualToString:@"mov"]) {
                localFile = [documentsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"SVideoPosted%fs.mov", [[NSDate date] timeIntervalSince1970]]];
            } else {
                localFile = [documentsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"SVideoPosted%fs.mp4", [[NSDate date] timeIntervalSince1970]]];
            }
        }
        
        // write the downloaded file to documents dir
        [self._ReceivedData writeToFile:localFile atomically:YES];
        
        // write database
        
        NSMutableArray *arrTemp = [[NSMutableArray alloc] init];
        arrTemp = [_CoreGUI loadVideoWithType:1];
        int current_idvideo = 0;
        
        current_idvideo = ((SVideoInCommunity*)[arrSVideo objectAtIndex:recordSelected])._Id;
        
        NSMutableDictionary *arrVideo = [[NSMutableDictionary alloc] init];
        
        [arrVideo setObject:[NSNumber numberWithInt:current_idvideo] forKey:@"id"];
        [arrVideo setObject:localFile forKey:@"path"];
        
        NSString *stringDBName;
        if ([sVPosted._Owner isEqualToString:@"Master"])
        {
            [arrVideo setObject:@"Master" forKey:@"videotype"];
            stringDBName = @"SVideosMaster";
            ((SwingVideoTableViewController*)[_CoreGUI._Navi.viewControllers objectAtIndex:0])._IsMaster = YES;
        } else {
            [arrVideo setObject:@"User" forKey:@"videotype"];
            stringDBName = @"SVideosUser";
            ((SwingVideoTableViewController*)[_CoreGUI._Navi.viewControllers objectAtIndex:0])._IsMaster = NO;
        }
        [arrVideo setObject:@"nothing" forKey:@"pathcompare"];
        [arrVideo setObject:sVPosted._Owner forKey:@"owner"];
        [arrVideo setObject:sVPosted._GolfTree forKey:@"golftree"];
        [arrVideo setObject:[[NSDate alloc] init] forKey:@"time"];
        [arrVideo setObject:[NSNumber numberWithBool:NO] forKey:@"voice"];
        [arrVideo setObject:[NSNumber numberWithBool:NO] forKey:@"favorited"];
        [arrVideo setObject:sVPosted._PathThumnail forKey:@"thumnail"];
        [arrVideo setObject:[NSNumber numberWithBool:NO] forKey:@"posted"];
        [arrVideo setObject:[NSNumber numberWithBool:NO] forKey:@"prepare"];
        
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
        
        [mountainsArray insertObject:arrVideo atIndex:0];
        [mountainsArray writeToFile:path atomically:YES];
    }
    
    [viewProcess removeFromSuperview];
    
    [_CoreGUI._TabBar setSelectedIndex:0];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.hidesBackButton = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end


