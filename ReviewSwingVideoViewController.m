//
//  ReviewSwingVideoViewController.m
//  VietGolfVersion1.1
//
//  Created by admin on 8/19/14.
//  Copyright (c) 2014 NguyenDuyThanh. All rights reserved.
//

#import "ReviewSwingVideoViewController.h"
#import "CoreGUIController.h"

@interface ReviewSwingVideoViewController ()

@end

@implementation ReviewSwingVideoViewController

@synthesize _ReSVideo;


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    self.title = @"Xem lại"; 
    self._ScreenName = ReviewSwingVideo;
    
    isNormalMode = NO;
    // AVPlayer host
    /*if ([_ReSVideo._PathVideo isEqualToString:@""] || _ReSVideo._PathVideo == nil) {
        NSString *filepath = [[NSBundle mainBundle] pathForResource:@"Master0005" ofType:@"mp4"];
        playerSVideo = [AVPlayer playerWithURL:[[NSURL alloc] initFileURLWithPath:filepath]];
    } else {
        playerSVideo = [AVPlayer playerWithURL:[[NSURL alloc] initFileURLWithPath:_ReSVideo._PathVideo]];
    }
    
    playerSVideo.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    playerSVideo.allowsExternalPlayback = YES;
    layerSVideo = [AVPlayerLayer playerLayerWithPlayer:playerSVideo];
    layerSVideo.frame = CGRectMake(0, 64.0f, self.view.frame.size.width, self.view.frame.size.height - 64.0f);
    [layerSVideo setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    ;
    
    [self.view.layer addSublayer:layerSVideo];
    [playerSVideo play];*/
    
    
    UIButton *btnAddMusic = [UIButton buttonWithType:UIButtonTypeCustom];
    btnAddMusic.frame = CGRectMake(0, 0, 33.0f, 20.0f);
    [btnAddMusic setImage:[UIImage imageNamed:@"ModeView.png"] forState:UIControlStateNormal];
    [btnAddMusic addTarget:self action:@selector(controlModeView) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnAddMusic];
    
    
    if ([_ReSVideo._PathVideo isEqualToString:@""] || _ReSVideo._PathVideo == nil) {
        NSString *filepath = [[NSBundle mainBundle] pathForResource:@"Master0005" ofType:@"mp4"];
        playerMP = [[MPMoviePlayerController alloc] initWithContentURL:[[NSURL alloc] initFileURLWithPath:filepath]];
    } else {
        playerMP = [[MPMoviePlayerController alloc] initWithContentURL:[[NSURL alloc] initFileURLWithPath:_ReSVideo._PathVideo]];
    }
    playerMP.view.backgroundColor = [UIColor clearColor];
    [playerMP setControlStyle:MPMovieControlStyleDefault];
    [playerMP setMovieSourceType:MPMovieSourceTypeFile];
    [playerMP setScalingMode:MPMovieScalingModeAspectFill];
    
    // Add Draw, Movie
    [playerMP.view setFrame:CGRectMake(0, 64.0f, self.view.frame.size.width, self.view.frame.size.height - 64.0f)];
    [self.view addSubview:playerMP.view];
    
    [playerMP prepareToPlay];
    [playerMP play];
    [playerMP pause];
    
}

-(void)controlModeView
{
    if (isNormalMode) {
        [playerMP setScalingMode:MPMovieScalingModeFill];
    } else {
        [playerMP setScalingMode:MPMovieScalingModeAspectFill];
    }
    isNormalMode = !isNormalMode;
}

-(void)viewWillAppear:(BOOL)animated
{
    [_CoreGUI._TabBar.tabBar setHidden:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemDidReachEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:playerSVideo];
}

-(void)playerItemDidReachEnd:(NSNotification*)notification
{
    if (CMTimeGetSeconds(playerSVideo.currentItem.currentTime) >= CMTimeGetSeconds(playerSVideo.currentItem.duration)) {
        [playerSVideo seekToTime:kCMTimeZero];
        [playerSVideo play];
    }
}

-(void)viewDidDisappear:(BOOL)animated
{
    [_CoreGUI._TabBar.tabBar setHidden:NO];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
