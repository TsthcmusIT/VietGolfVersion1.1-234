//
//  TrimVideoViewController.m
//  VietGolfVersion1.1
//
//  Created by admin on 9/10/14.
//  Copyright (c) 2014 NguyenDuyThanh. All rights reserved.
//

#import "TrimVideoViewController.h"
#import "CoreGUIController.h"


@interface TrimVideoViewController ()

@end

@implementation TrimVideoViewController
@synthesize video;
@synthesize playerSVideo, _MovieURL;
@synthesize _DrawView;
@synthesize audioPlayer, audioRecorder, firstAsset, audioAsset;
@synthesize ActivityView, pullLeftView, currentRow, _IsMaster, _TSVideo;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Xem";
    self.navigationController.title = @"Xem";
    _ScreenName = TrimVideoScreen;
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:1.0f];
    
    heightNavi = self.navigationController.navigationBar.frame.size.height;
    heightStatusBar = 20.0f;
    itemSize = CGSizeMake(40.0f, 40.0f);
    isEdit = NO;
    isModeFill = NO;
    showToolBox = NO;
    isOrient = YES;
    isPlaying = NO;
    isSetPosition = NO;
    
    btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    btnBack.frame = CGRectMake(0, 0, 70.0f, 25.0f);
    [btnBack setImage:[UIImage imageNamed:@"BackButtonBarItem.png"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(backToList) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnBack];
    
    viewAddVoice = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44.0f, 44.0f)];
    viewAddVoice.backgroundColor = [UIColor clearColor];
    btnAddVoice = [UIButton buttonWithType:UIButtonTypeCustom];
    btnAddVoice.frame = CGRectMake(7.0f, 7.0f, 30.0f, 30.0f);
    [btnAddVoice setImage:[UIImage imageNamed:@"Voice.png"] forState:UIControlStateNormal];
    [btnAddVoice addTarget:self action:@selector(recordAudio:) forControlEvents:UIControlEventTouchUpInside];
    [btnAddVoice setShowsTouchWhenHighlighted:YES];
    [viewAddVoice addSubview:btnAddVoice];
    
    self.navigationItem.titleView = viewAddVoice;
    
    btnToolBox = [UIButton buttonWithType:UIButtonTypeCustom];
    btnToolBox.frame = CGRectMake(0, 0, 50.0f, 30.0f);
    [btnToolBox setImage:[UIImage imageNamed:@"ToolBoxItem.png"] forState:UIControlStateNormal];
    [btnToolBox addTarget:self action:@selector(showToolBox) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnToolBox];
    
    [self playVideo];

}

-(void)showToolBox
{
    heightNavi = self.navigationController.navigationBar.frame.size.height;
    
    if (showToolBox) {
        [btnToolBox setImage:[UIImage imageNamed:@"ToolBoxItem.png"] forState:UIControlStateNormal];
    } else {
        [btnToolBox setImage:[UIImage imageNamed:@"ToolBoxOpened.png"] forState:UIControlStateNormal];
    }
    
    if (isOrient) {
        if (!showToolBox) {
            viewBackToolBox.alpha = 1.0f;
            viewBackToolBox.frame = CGRectMake(0, -self.view.frame.size.height/10.0f, self.view.frame.size.width, self.view.frame.size.height/10.0f);
            btnLine.center = CGPointMake((1/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
            btnCurve.center = CGPointMake((3/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
            btnCircle.center = CGPointMake((5/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
            btnRectangle.center = CGPointMake((7/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
            btnDelete.center = CGPointMake((9/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
            btnMode.center = CGPointMake((13/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
            btnAddMusic.center = CGPointMake((15/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
            
            [UIView animateWithDuration:0.4f delay:0.1f options:UIViewAnimationOptionTransitionNone animations:^{
                viewBackToolBox.frame = CGRectMake(0, heightNavi + heightStatusBar, self.view.frame.size.width, self.view.frame.size.height/10.0f);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.05f delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                    viewBackToolBox.frame = CGRectMake(0, heightNavi + heightStatusBar - 5.0f, self.view.frame.size.width, self.view.frame.size.height/10.0f);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.07f delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                        viewBackToolBox.frame = CGRectMake(0, heightNavi + heightStatusBar, self.view.frame.size.width, self.view.frame.size.height/10.0f);
                    } completion:nil];
                }];
            }];
        } else {
            viewBackToolBox.alpha = 1.0f;
            viewBackToolBox.frame = CGRectMake(0, heightNavi + heightStatusBar, self.view.frame.size.width, self.view.frame.size.height/10.0f);
            btnLine.center = CGPointMake((1/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
            btnCurve.center = CGPointMake((3/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
            btnCircle.center = CGPointMake((5/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
            btnRectangle.center = CGPointMake((7/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
            btnDelete.center = CGPointMake((9/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
            btnMode.center = CGPointMake((13/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
            btnAddMusic.center = CGPointMake((15/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
            
            [UIView animateWithDuration:0.5f delay:0.1f options:UIViewAnimationOptionTransitionCurlUp animations:^{
                [viewBackToolBox setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:1.0f delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                    viewBackToolBox.frame = CGRectMake(0, -self.view.frame.size.height/10.0f, self.view.frame.size.width, self.view.frame.size.height/10.0f);
                } completion:nil];
            }];
            
        }
    } else {
        if (!showToolBox) {
            viewBackToolBox.alpha = 1.0f;
            viewBackToolBox.frame = CGRectMake(0, -self.view.frame.size.height/10.0f, self.view.frame.size.width, self.view.frame.size.width/10.0f);
            btnLine.center = CGPointMake((1/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
            btnCurve.center = CGPointMake((3/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
            btnCircle.center = CGPointMake((5/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
            btnRectangle.center = CGPointMake((7/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
            btnDelete.center = CGPointMake((9/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
            btnMode.center = CGPointMake((13/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
            btnAddMusic.center = CGPointMake((15/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
            
            [UIView animateWithDuration:0.4f delay:0.1f options:UIViewAnimationOptionTransitionNone animations:^{
                viewBackToolBox.frame = CGRectMake(0, heightNavi + heightStatusBar, self.view.frame.size.width, self.view.frame.size.width/10.0f);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.05f delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                    viewBackToolBox.frame = CGRectMake(0, heightNavi + heightStatusBar - 5.0f, self.view.frame.size.width, self.view.frame.size.width/10.0f);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.07f delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                        viewBackToolBox.frame = CGRectMake(0, heightNavi + heightStatusBar, self.view.frame.size.width, self.view.frame.size.width/10.0f);
                    } completion:nil];
                }];
            }];
        } else {
            viewBackToolBox.alpha = 1.0f;
            viewBackToolBox.frame = CGRectMake(0, heightNavi + heightStatusBar, self.view.frame.size.width, self.view.frame.size.width/10.0f);
            btnLine.center = CGPointMake((1/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
            btnCurve.center = CGPointMake((3/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
            btnCircle.center = CGPointMake((5/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
            btnRectangle.center = CGPointMake((7/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
            btnDelete.center = CGPointMake((9/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
            btnMode.center = CGPointMake((13/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
            btnAddMusic.center = CGPointMake((15/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
            
            [UIView animateWithDuration:0.5f delay:0.1f options:UIViewAnimationOptionTransitionCurlUp animations:^{
                [viewBackToolBox setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:1.0f delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                    viewBackToolBox.frame = CGRectMake(0, -self.view.frame.size.height/10.0f, self.view.frame.size.width, self.view.frame.size.height/10.0f);
                } completion:nil];
            }];
        }
    }
    showToolBox = !showToolBox;
}


- (void)playVideo{
    
    heightNavi = self.navigationController.navigationBar.frame.size.height;
    heightStatusBar = 20.0f;
    
    playerSVideo = [AVPlayer playerWithURL:[[NSURL alloc] initFileURLWithPath:_TSVideo._PathVideo]];
    playerSVideo.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    playerSVideo.allowsExternalPlayback = YES;
    
    layerSVideo = [AVPlayerLayer playerLayerWithPlayer:playerSVideo];
    layerSVideo.frame = CGRectMake(0, heightNavi + heightStatusBar, self.view.frame.size.width, self.view.frame.size.height - (heightNavi + heightStatusBar));
    [layerSVideo setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    
    [self.view.layer addSublayer:layerSVideo];
    
    // Add Draw
    _DrawView = [[Draw2D alloc] init];
    _DrawView.frame = CGRectMake(0, heightNavi + heightStatusBar, self.view.frame.size.width, self.view.frame.size.height - (heightNavi + heightStatusBar));
    _DrawView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_DrawView];
    
    
    // Add Tool Draw
    viewBackToolBox = [[UIView alloc] init];
    viewBackToolBox.frame = CGRectMake(0, -self.view.frame.size.height/10.0f, self.view.frame.size.width, self.view.frame.size.height/10.0f);
    viewBackToolBox.backgroundColor = [UIColor colorWithWhite:0.8f alpha:0.85f];
    [self.view addSubview:viewBackToolBox];
    
    // Add Gesture
    doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    doubleTap.delegate = self;
    [doubleTap setNumberOfTapsRequired:2];
    [self.view addGestureRecognizer:doubleTap];
    
    longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    longPress.delegate = self;
    [self.view addGestureRecognizer:longPress];
    
    
    // Add option to tool bar
    btnLine = [[UIButton alloc] init];
    btnLine.frame = CGRectMake(0, 0, itemSize.width, itemSize.height);
    btnLine.tag = 100;
    [btnLine setTitle:@"Line" forState:UIControlStateNormal];
    [btnLine addTarget:self action:@selector(drawForVideo:) forControlEvents:UIControlEventTouchUpInside];
    [btnLine setImage:[UIImage imageNamed:@"Line.png"] forState:UIControlStateNormal];
    
    btnCurve = [[UIButton alloc] init];
    btnCurve.frame = CGRectMake(0, 0, itemSize.width, itemSize.height);
    btnCurve.tag = 101;
    [btnCurve setTitle:@"Curve" forState:UIControlStateNormal];
    [btnCurve addTarget:self action:@selector(drawForVideo:) forControlEvents:UIControlEventTouchUpInside];
    [btnCurve setImage:[UIImage imageNamed:@"Curve.png"] forState:UIControlStateNormal];
    
    btnCircle = [[UIButton alloc] init];
    btnCircle.frame = CGRectMake(0, 0, itemSize.width, itemSize.height);
    btnCircle.tag = 102;
    [btnCircle setTitle:@"Circle" forState:UIControlStateNormal];
    [btnCircle addTarget:self action:@selector(drawForVideo:) forControlEvents:UIControlEventTouchUpInside];
    [btnCircle setImage:[UIImage imageNamed:@"Circle.png"] forState:UIControlStateNormal];
    
    btnRectangle = [[UIButton alloc] init];
    btnRectangle.frame = CGRectMake(0, 0, itemSize.width, itemSize.height);
    btnRectangle.tag = 103;
    [btnRectangle setTitle:@"Rectangle" forState:UIControlStateNormal];
    [btnRectangle addTarget:self action:@selector(drawForVideo:) forControlEvents:UIControlEventTouchUpInside];
    [btnRectangle setImage:[UIImage imageNamed:@"Rectangle.png"] forState:UIControlStateNormal];
    
    btnDelete = [[UIButton alloc] init];
    btnDelete.frame = CGRectMake(0, 0, itemSize.width, itemSize.height);
    btnDelete.tag = 104;
    [btnDelete setTitle:@"Delete" forState:UIControlStateNormal];
    [btnDelete addTarget:self action:@selector(drawForVideo:) forControlEvents:UIControlEventTouchUpInside];
    [btnDelete setImage:[UIImage imageNamed:@"Trash.png"] forState:UIControlStateNormal];
    
    btnMode = [[UIButton alloc] init];
    btnMode.frame = CGRectMake(0, 0, itemSize.width, itemSize.height);
    btnMode.tag = 105;
    [btnMode addTarget:self action:@selector(controlModeView) forControlEvents:UIControlEventTouchUpInside];
    [btnMode setImage:[UIImage imageNamed:@"ModeScreen.png"] forState:UIControlStateNormal];
    
    btnAddMusic = [[UIButton alloc] init];
    btnAddMusic.frame = CGRectMake(0, 0, itemSize.width, itemSize.height);
    btnAddMusic.tag = 106;
    [btnAddMusic addTarget:self action:@selector(addMusicToSwingVideo) forControlEvents:UIControlEventTouchUpInside];
    [btnAddMusic setImage:[UIImage imageNamed:@"AddMusic.png"] forState:UIControlStateNormal];
    
    [viewBackToolBox addSubview:btnLine];
    [viewBackToolBox addSubview:btnCurve];
    [viewBackToolBox addSubview:btnCircle];
    [viewBackToolBox addSubview:btnRectangle];
    [viewBackToolBox addSubview:btnDelete];
    [viewBackToolBox addSubview:btnMode];
    [viewBackToolBox addSubview:btnAddMusic];
    
    // Add tool speed
    pullLeftView = [[PullableView alloc] init];
    pullLeftView.frame = CGRectMake(self.view.frame.size.width - 100.0f, self.view.frame.size.height - 230.0f, 120.0f, 180.0f);
    pullLeftView.backgroundColor = [UIColor clearColor];
    pullLeftView._OpenedCenter = CGPointMake(self.view.frame.size.width, self.view.frame.size.height - 50.0f - pullLeftView.frame.size.height/2.0f);
    pullLeftView._ClosedCenter = CGPointMake(self.view.frame.size.width + 40.0f, self.view.frame.size.height - 50.0f - pullLeftView.frame.size.height/2.0f);
    pullLeftView.center = pullLeftView._OpenedCenter;
    [pullLeftView setOpened:YES animated:YES];
    pullLeftView._Animate = NO;
    pullLeftView._HandleView.frame = CGRectMake(0, 2.0f*pullLeftView.frame.size.height/5.0f, 30.0f, pullLeftView.frame.size.height/5.0f);
    pullLeftView._HandleView.backgroundColor = [UIColor clearColor];
    pullLeftView._ImageHandle.frame = CGRectMake(0, 2.0f*pullLeftView.frame.size.height/5.0f, 30.0f, pullLeftView.frame.size.height/5.0f);
    [pullLeftView._ImageHandle setImage:[UIImage imageNamed:@"HandleLeftView.png"]];
    
    [self.view addSubview:pullLeftView];
    
    speedSlider = [[UISlider alloc] init];
    speedSlider.frame = CGRectMake(0, 0, 100.0f, 25.0f);
    speedSlider.center = CGPointMake(pullLeftView.frame.size.width/3.5f, (pullLeftView.frame.size.height)/2.0f);
    speedSlider.minimumValue = 0.03f;
    speedSlider.maximumValue = 1.0f;
    speedSlider.value = 1.0f;
    speedSlider.continuous = NO;
    speedSlider.backgroundColor = [UIColor clearColor];
    speedSlider.tintColor = [UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f];
    [speedSlider addTarget:self action:@selector(valueChangeSpeed) forControlEvents:UIControlEventValueChanged];
    CGAffineTransform trans = CGAffineTransformMakeRotation(-M_PI_2);
    speedSlider.transform = trans;
    [pullLeftView addSubview:speedSlider];
    
    btnAcs = [UIButton buttonWithType:UIButtonTypeCustom];
    btnAcs.frame = CGRectMake(0, 0, 40.0f, 26.0f);
    btnAcs.center = CGPointMake(pullLeftView.frame.size.width/3.5f, 13.0f);
    btnAcs.tag = 106;
    [btnAcs setImage:[UIImage imageNamed:@"AcsSpeedVideo.png"] forState:UIControlStateNormal];
    [btnAcs addTarget:self action:@selector(changeSpeed:) forControlEvents:UIControlEventTouchUpInside];
    [pullLeftView addSubview:btnAcs];
    
    btnDecs = [UIButton buttonWithType:UIButtonTypeCustom];
    btnDecs.frame = CGRectMake(0, pullLeftView.frame.size.height - 26.0f, 40.0f, 26.0f);
    btnDecs.center = CGPointMake(pullLeftView.frame.size.width/3.5f, pullLeftView.frame.size.height - 13.0f);
    btnDecs.tag = 107;
    [btnDecs setImage:[UIImage imageNamed:@"DecsSpeedVideo.png"] forState:UIControlStateNormal];
    [btnDecs addTarget:self action:@selector(changeSpeed:) forControlEvents:UIControlEventTouchUpInside];
    [pullLeftView addSubview:btnDecs];
    
    // Control Movie
    btnControl = [UIButton buttonWithType:UIButtonTypeCustom];
    btnControl.frame = CGRectMake(0, self.view.frame.size.height - 40.0f, 40.0f, 40.0f);
    [btnControl setBackgroundImage:[UIImage imageNamed:@"Play.png"] forState:UIControlStateNormal];
    [btnControl addTarget:self action:@selector(controlMovie) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnControl];
    
    lblDuration = [[UILabel alloc] init];
    lblDuration.frame = CGRectMake(self.view.frame.size.width - 40.0f, self.view.frame.size.height - 30.0f, 40.0f, 20.0f);
    lblDuration.text = [self secondsToMMSS:CMTimeGetSeconds(playerSVideo.currentItem.asset.duration)];
    lblDuration.textColor = [UIColor whiteColor];
    [lblDuration setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:12.0f]];
    lblDuration.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lblDuration];
    
    progressPlaying = [[UIProgressView alloc] init];
    progressPlaying.frame = CGRectMake(btnControl.frame.size.width + 13.0f, btnControl.frame.origin.y + 19.0f, self.view.frame.size.width - 106.0f, 2.0f);
    [progressPlaying setProgressTintColor:[UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f]];
    [progressPlaying setUserInteractionEnabled:NO];
    progressPlaying.progress = 1.0f;
    [progressPlaying setProgressViewStyle:UIProgressViewStyleBar];
    [progressPlaying setTrackTintColor:[UIColor whiteColor]];
    [self.view addSubview:progressPlaying];
    
    float value = CMTimeGetSeconds(self.playerSVideo.currentItem.currentTime)/CMTimeGetSeconds(self.playerSVideo.currentItem.duration);
    progressPlaying.progress = value;
    if (_TSVideo._PathVideo != nil) {
        asset = [AVAsset assetWithURL:[[NSURL alloc] initFileURLWithPath:_TSVideo._PathVideo]];
    } else {
        NSString *filepath = [[NSBundle mainBundle] pathForResource:@"Master0005" ofType:@"mp4"];
        asset = [AVAsset assetWithURL:[[NSURL alloc] initFileURLWithPath:filepath]];
    }
    
    // Total time
    viewGesture = [[UIView alloc] init];
    viewGesture.frame = CGRectMake(40.0f, progressPlaying.frame.origin.y - 23.0f, progressPlaying.frame.size.width + 26.0f, 26.0f);
    viewGesture.backgroundColor = [UIColor clearColor];
    [self.view addSubview:viewGesture];
    
    pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    pan.delegate = self;
    [viewGesture addGestureRecognizer:pan];
    
    CMTime durationTime = asset.duration;
    durationT = (float)CMTimeGetSeconds(durationTime);
    
    iviewLabelTime = [[UIImageView alloc] init];
    iviewLabelTime.frame = CGRectMake(0, 0, 26.0f, 26.0f);
    iviewLabelTime.backgroundColor = [UIColor clearColor];
    iviewLabelTime.image = [UIImage imageNamed:@"SignLabelTimeVideo.png"];
    [viewGesture addSubview:iviewLabelTime];
    
    lenghtT = progressPlaying.frame.size.width;
    lblcurrentTime = [[UILabel alloc] init];
    lblcurrentTime.frame = CGRectMake(0, 0, 26.0f, 16.0f);
    lblcurrentTime.text = [self secondsToMMSS:CMTimeGetSeconds(self.playerSVideo.currentItem.currentTime)];
    [lblcurrentTime setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:9.0f]];
    lblcurrentTime.backgroundColor = [UIColor colorWithWhite:1.0f alpha:1.0f];
    lblcurrentTime.textAlignment = NSTextAlignmentCenter;
    [iviewLabelTime addSubview:lblcurrentTime];
    
}

- (void)handleDoubleTap:(UITapGestureRecognizer *)gestureRecognizer {
    if (!isModeFill) {
        [layerSVideo setVideoGravity:AVLayerVideoGravityResizeAspect];
    } else {
        [layerSVideo setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    }
    
    isModeFill = !isModeFill;
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        if (showToolBox) {
            if (pullLeftView._Opened) {
                pullLeftView.center = pullLeftView._ClosedCenter;
                [pullLeftView setOpened:NO animated:YES];
            }
        } else {
            if (!pullLeftView._Opened) {
                pullLeftView.center = pullLeftView._OpenedCenter;
                [pullLeftView setOpened:YES animated:YES];
            }
        }
        [self showToolBox];
        
    }
}


-(void)handlePan:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint location = [gestureRecognizer locationInView:viewGesture];
    if(gestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        if ([viewGesture pointInside:location withEvent:nil]) {
            [playerSVideo pause];
            [playingTimer invalidate];
            playingTimer = nil;
            [btnControl setBackgroundImage:[UIImage imageNamed:@"Play.png"] forState:UIControlStateNormal];
            isSetPosition = YES;
        }
    } else {
        if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
            if (location.x <= 13.0f) {
                location.x = 13.0f;
            }
            if (location.x >= viewGesture.frame.size.width - 13.0f) {
                location.x = viewGesture.frame.size.width - 13.0f;
            }
            
            if (location.x <= 13.0f) {
                currentPointer = 0;
            } else {
                if (location.x >= viewGesture.frame.size.width - 13.0f) {
                    currentPointer = progressPlaying.frame.size.width;
                } else {
                    currentPointer = location.x - 13.0f;
                }
            }
            
            iviewLabelTime.center = CGPointMake(location.x, 13.0f);
            double ratio = currentPointer/progressPlaying.frame.size.width;
            lblcurrentTime.text = [self secondsToMMSS:ratio*durationT];
            [playerSVideo seekToTime:CMTimeMakeWithSeconds((float)ratio*durationT, NSEC_PER_SEC)];
            [progressPlaying setProgress:(float)ratio];
            
            if (playingTimer == nil) {
                playingTimer = [[NSTimer alloc] init];
                playingTimer = [NSTimer scheduledTimerWithTimeInterval:0.03f
                                                                target:self
                                                              selector:@selector(updatePlayingTimer)
                                                              userInfo:nil
                                                               repeats:YES];
            }
            
        } else {
            if (location.x <= 13.0f) {
                location.x = 13.0f;
            }
            if (location.x >= viewGesture.frame.size.width - 13.0f) {
                location.x = viewGesture.frame.size.width - 13.0f;
            }
            
            if (location.x <= 13.0f) {
                currentPointer = 0;
            } else {
                if (location.x >= viewGesture.frame.size.width - 13.0f) {
                    currentPointer = progressPlaying.frame.size.width;
                } else {
                    currentPointer = location.x - 13.0f;
                }
            }
            
            iviewLabelTime.center = CGPointMake(location.x, 13.0f);
            double ratio = currentPointer/progressPlaying.frame.size.width;
            NSLog(@"%lf", ratio);
            lblcurrentTime.text = [self secondsToMMSS:ratio*durationT];
            [playerSVideo seekToTime:CMTimeMakeWithSeconds((float)ratio*durationT, NSEC_PER_SEC)];
            [progressPlaying setProgress:(float)ratio];
        }
    }
}

- (void)changeSpeed:(UIButton*)sender
{
    if (sender.tag == 107) {
        if (speedSlider.value < 0.2f) {
            speedSlider.value = 0.03f;
            NSLog(@"Speed: %f", speedSlider.value);
        } else {
            speedSlider.value -= 0.2f;
        }
    } else {
        if (speedSlider.value > 0.8f) {
            speedSlider.value = 1.0f;
        } else {
            speedSlider.value += 0.2f;
        }
    }
    
    
    NSLog(@"Speed: %f", speedSlider.value);
    CMClockRef syncTime = CMClockGetHostTimeClock();
    CMTime hostTime = CMClockGetTime(syncTime);
    [playerSVideo setRate:speedSlider.value time:kCMTimeInvalid atHostTime:hostTime];
    isPlaying = YES;
    [btnControl setBackgroundImage:[UIImage imageNamed:@"Pause.png"] forState:UIControlStateNormal];
    if (playingTimer == nil) {
        playingTimer = [[NSTimer alloc] init];
        playingTimer = [NSTimer scheduledTimerWithTimeInterval:0.03f
                                                        target:self
                                                      selector:@selector(updatePlayingTimer)
                                                      userInfo:nil
                                                       repeats:YES];
        
    }
    
}


-(void)drawForVideo:(UIButton*)sender
{
    if (sender.tag == 100) {
        _DrawView._Line = YES;
        _DrawView._Curve = NO;
        _DrawView._Circle = NO;
        _DrawView._Rect = NO;
        [btnLine setImage:[UIImage imageNamed:@"LineSelected.png"] forState:UIControlStateNormal];
        [btnCurve setImage:[UIImage imageNamed:@"Curve.png"] forState:UIControlStateNormal];
        [btnCircle setImage:[UIImage imageNamed:@"Circle.png"] forState:UIControlStateNormal];
        [btnRectangle setImage:[UIImage imageNamed:@"Rectangle.png"] forState:UIControlStateNormal];
        [btnDelete setImage:[UIImage imageNamed:@"Trash.png"] forState:UIControlStateNormal];
        [btnAddMusic setImage:[UIImage imageNamed:@"AddMusic.png"] forState:UIControlStateNormal];
    }
    else {
        if (sender.tag == 101) {
            _DrawView._Line = NO;
            _DrawView._Curve = YES;
            _DrawView._Circle = NO;
            _DrawView._Rect = NO;
            [btnLine setImage:[UIImage imageNamed:@"Line.png"] forState:UIControlStateNormal];
            [btnCurve setImage:[UIImage imageNamed:@"CurveSelected.png"] forState:UIControlStateNormal];
            [btnCircle setImage:[UIImage imageNamed:@"Circle.png"] forState:UIControlStateNormal];
            [btnRectangle setImage:[UIImage imageNamed:@"Rectangle.png"] forState:UIControlStateNormal];
            [btnDelete setImage:[UIImage imageNamed:@"Trash.png"] forState:UIControlStateNormal];
            [btnAddMusic setImage:[UIImage imageNamed:@"AddMusic.png"] forState:UIControlStateNormal];
        } else {
            if (sender.tag == 102) {
                _DrawView._Curve = NO;
                _DrawView._Line = NO;
                _DrawView._Circle = YES;
                _DrawView._Rect = NO;
                [btnLine setImage:[UIImage imageNamed:@"Line.png"] forState:UIControlStateNormal];
                [btnCurve setImage:[UIImage imageNamed:@"Curve.png"] forState:UIControlStateNormal];
                [btnCircle setImage:[UIImage imageNamed:@"CircleSelected.png"] forState:UIControlStateNormal];
                [btnRectangle setImage:[UIImage imageNamed:@"Rectangle.png"] forState:UIControlStateNormal];
                [btnDelete setImage:[UIImage imageNamed:@"Trash.png"] forState:UIControlStateNormal];
                [btnAddMusic setImage:[UIImage imageNamed:@"AddMusic.png"] forState:UIControlStateNormal];
            } else {
                if (sender.tag == 103) {
                    _DrawView._Curve = NO;
                    _DrawView._Line = NO;
                    _DrawView._Circle = NO;
                    _DrawView._Rect = YES;
                    [btnLine setImage:[UIImage imageNamed:@"Line.png"] forState:UIControlStateNormal];
                    [btnCurve setImage:[UIImage imageNamed:@"Curve.png"] forState:UIControlStateNormal];
                    [btnCircle setImage:[UIImage imageNamed:@"Circle.png"] forState:UIControlStateNormal];
                    [btnRectangle setImage:[UIImage imageNamed:@"RectangleSelected.png"] forState:UIControlStateNormal];
                    [btnDelete setImage:[UIImage imageNamed:@"Trash.png"] forState:UIControlStateNormal];
                    [btnAddMusic setImage:[UIImage imageNamed:@"AddMusic.png"] forState:UIControlStateNormal];
                } else {
                    if (sender.tag == 104) {
                        [_DrawView clear];
                        _DrawView._Curve = NO;
                        _DrawView._Line = NO;
                        _DrawView._Circle = NO;
                        _DrawView._Rect = NO;
                        [btnLine setImage:[UIImage imageNamed:@"Line.png"] forState:UIControlStateNormal];
                        [btnCurve setImage:[UIImage imageNamed:@"Curve.png"] forState:UIControlStateNormal];
                        [btnCircle setImage:[UIImage imageNamed:@"Circle.png"] forState:UIControlStateNormal];
                        [btnRectangle setImage:[UIImage imageNamed:@"Rectangle.png"] forState:UIControlStateNormal];
                        [btnDelete setImage:[UIImage imageNamed:@"TrashSelected.png"] forState:UIControlStateNormal];
                        [btnAddMusic setImage:[UIImage imageNamed:@"AddMusic.png"] forState:UIControlStateNormal];
                    }
                }
                
            }
        }
    }
}

-(void)controlModeView
{
    _DrawView._Line = NO;
    _DrawView._Curve = NO;
    _DrawView._Circle = NO;
    _DrawView._Rect = NO;
    if (!isModeFill) {
        [layerSVideo setVideoGravity:AVLayerVideoGravityResizeAspect];
        [btnLine setImage:[UIImage imageNamed:@"Line.png"] forState:UIControlStateNormal];
        [btnCurve setImage:[UIImage imageNamed:@"Curve.png"] forState:UIControlStateNormal];
        [btnCircle setImage:[UIImage imageNamed:@"Circle.png"] forState:UIControlStateNormal];
        [btnRectangle setImage:[UIImage imageNamed:@"Rectangle.png"] forState:UIControlStateNormal];
        [btnDelete setImage:[UIImage imageNamed:@"Trash.png"] forState:UIControlStateNormal];
        [btnMode setImage:[UIImage imageNamed:@"ModeScreenSelected.png"] forState:UIControlStateNormal];
    } else {
        [layerSVideo setVideoGravity:AVLayerVideoGravityResizeAspectFill];
        [btnLine setImage:[UIImage imageNamed:@"Line.png"] forState:UIControlStateNormal];
        [btnCurve setImage:[UIImage imageNamed:@"Curve.png"] forState:UIControlStateNormal];
        [btnCircle setImage:[UIImage imageNamed:@"Circle.png"] forState:UIControlStateNormal];
        [btnRectangle setImage:[UIImage imageNamed:@"Rectangle.png"] forState:UIControlStateNormal];
        [btnDelete setImage:[UIImage imageNamed:@"Trash.png"] forState:UIControlStateNormal];
        [btnMode setImage:[UIImage imageNamed:@"ModeScreen.png"] forState:UIControlStateNormal];
    }
    isModeFill = !isModeFill;
}

-(void)valueChangeSpeed
{
    CMClockRef syncTime = CMClockGetHostTimeClock();
    CMTime hostTime = CMClockGetTime(syncTime);
    [playerSVideo setRate:speedSlider.value time:kCMTimeInvalid atHostTime:hostTime];
    NSLog(@"Speed: %f", speedSlider.value);
    isPlaying = YES;
    [btnControl setBackgroundImage:[UIImage imageNamed:@"Pause.png"] forState:UIControlStateNormal];
    if (playingTimer == nil) {
        playingTimer = [[NSTimer alloc] init];
        playingTimer = [NSTimer scheduledTimerWithTimeInterval:0.03f
                                                        target:self
                                                      selector:@selector(updatePlayingTimer)
                                                      userInfo:nil
                                                       repeats:YES];
    }
}

-(void)hiddenMovieView
{
    [viewMovie removeFromSuperview];
}

-(NSString *)secondsToMMSS:(double)seconds
{
    NSInteger time = floor(seconds);
    NSInteger hh = time / 3600;
    NSInteger mm = (time / 60) % 60;
    NSInteger ss = time % 60;
    float dtick = seconds - time;
    NSInteger itick = 100*dtick;
    
    if(hh > 0)
    {
        return  [NSString stringWithFormat:@"%02i:%02i:%02i", hh, mm, ss];
    }
    else
    {
        if (mm > 0) {
            return  [NSString stringWithFormat:@"%02i:%02i", mm, ss];
        }
        else
        {
            return  [NSString stringWithFormat:@"%02i:%02i", ss, itick];
        }
    }
}
///

-(void)controlMovie
{
    if ([playerSVideo rate] != 0)
    {
        if (!isPlaying) {
            //[playerSVideo play];
            CMClockRef syncTime = CMClockGetHostTimeClock();
            CMTime hostTime = CMClockGetTime(syncTime);
            [playerSVideo setRate:speedSlider.value time:kCMTimeInvalid atHostTime:hostTime];
            isPlaying = YES;
            [btnControl setBackgroundImage:[UIImage imageNamed:@"Pause.png"] forState:UIControlStateNormal];
        } else {
            [playerSVideo pause];
            isPlaying = NO;
            [btnControl setBackgroundImage:[UIImage imageNamed:@"Play.png"] forState:UIControlStateNormal];
        }
    } else {
        
        if (playingTimer == nil) {
            playingTimer = [[NSTimer alloc] init];
            playingTimer = [NSTimer scheduledTimerWithTimeInterval:0.03f
                                                            target:self
                                                          selector:@selector(updatePlayingTimer)
                                                          userInfo:nil
                                                           repeats:YES];
            
        }
        //[playerSVideo play];
        CMClockRef syncTime = CMClockGetHostTimeClock();
        CMTime hostTime = CMClockGetTime(syncTime);
        [playerSVideo setRate:speedSlider.value time:kCMTimeInvalid atHostTime:hostTime];
        [btnControl setBackgroundImage:[UIImage imageNamed:@"Pause.png"] forState:UIControlStateNormal];
        isPlaying = YES;
    }
}

-(void)updatePlayingTimer
{
    double temp = CMTimeGetSeconds(playerSVideo.currentItem.currentTime);
    float value = (float)temp/durationT;
    float xPoint = 13.0f + value*lenghtT;
    
    if (temp <= 0 && isSetPosition) {
        temp = (durationT*currentPointer)/progressPlaying.frame.size.width;
        value = (float)temp/durationT;
        xPoint = 13.0f + value*progressPlaying.frame.size.width;;
        iviewLabelTime.center = CGPointMake(xPoint, 13.0f);
        lblcurrentTime.text = [self secondsToMMSS:temp];
        [progressPlaying setProgress:value animated:NO];
    } else {
        if (temp <= durationT) {
            iviewLabelTime.center = CGPointMake(xPoint, 13.0f);
            lblcurrentTime.text = [self secondsToMMSS:temp];
            [progressPlaying setProgress:value animated:NO];
        } else {
            iviewLabelTime.center = CGPointMake(13.0f, 13.0f);
            lblcurrentTime.text = @"00:00";
            [progressPlaying setProgress:0 animated:NO];
            [btnControl setBackgroundImage:[UIImage imageNamed:@"Play.png"] forState:UIControlStateNormal];
            [playerSVideo seekToTime:kCMTimeZero];
            [playerSVideo pause];
        }
        
        if (fabsf(CMTimeGetSeconds(playerSVideo.currentItem.asset.duration) - CMTimeGetSeconds(playerSVideo.currentItem.currentTime)) < 0.01f) {
            iviewLabelTime.center = CGPointMake(13.0f, 13.0f);
            lblcurrentTime.text = @"00:00";
            [progressPlaying setProgress:0 animated:NO];
            [btnControl setBackgroundImage:[UIImage imageNamed:@"Play.png"] forState:UIControlStateNormal];
            [playerSVideo seekToTime:kCMTimeZero];
            [playerSVideo pause];
        }
    }
    
    if (isSetPosition) {
        [playingTimer invalidate];
        playingTimer = nil;
        isSetPosition = NO;
    }
}

-(void)mediaPicker:(MPMediaPickerController *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection {
    NSArray *selectedSong = [mediaItemCollection items];
    if ([selectedSong count] > 0) {
        MPMediaItem *songItem = [selectedSong objectAtIndex:0];
        NSURL *songURL = [songItem valueForProperty:MPMediaItemPropertyAssetURL];
        audioAsset = [AVAsset assetWithURL:songURL];
    }
    
    
    videoURL = [[NSURL alloc] initFileURLWithPath:video._PathVideo];
    firstAsset = [AVAsset assetWithURL:videoURL];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Đoạn đầu bài hát này sẽ được thêm vào video! Bạn thật sự muốn?" delegate:self cancelButtonTitle:@"Huỷ" otherButtonTitles: @"OK", nil];
    [alertView show];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [self dismissViewControllerAnimated:YES completion:nil];
    self.navigationItem.leftBarButtonItem = nil;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [btnAddMusic setImage:[UIImage imageNamed:@"AddMusic.png"] forState:UIControlStateNormal];
    if (buttonIndex == 0) {
        [self backToList];
    } else {
        [self mergeSwingVideo];
    }
}

-(void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker {
    
    [btnAddMusic setImage:[UIImage imageNamed:@"AddMusic.png"] forState:UIControlStateNormal];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    layerSVideo.frame = CGRectMake(0, heightNavi + heightStatusBar, self.view.frame.size.width, self.view.frame.size.height - (heightNavi + heightStatusBar));
    // Add Draw
    
    _DrawView.frame = CGRectMake(0, heightNavi + heightStatusBar, self.view.frame.size.width, self.view.frame.size.height - (heightNavi + heightStatusBar));
    
    if (!showToolBox) {
        viewBackToolBox.frame = CGRectMake(0, -self.view.frame.size.height/10.0f, self.view.frame.size.width, self.view.frame.size.height/10.0f);
    } else {
        viewBackToolBox.frame = CGRectMake(0, heightNavi + heightStatusBar, self.view.frame.size.width, self.view.frame.size.height/10.0f);
    }
    btnLine.center = CGPointMake((1/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
    btnCurve.center = CGPointMake((3/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
    btnCircle.center = CGPointMake((5/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
    btnRectangle.center = CGPointMake((7/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
    btnDelete.center = CGPointMake((9/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
    btnMode.center = CGPointMake((13/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
    btnAddMusic.center = CGPointMake((15/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
    
    pullLeftView.frame = CGRectMake(self.view.frame.size.width - 100.0f, self.view.frame.size.height - 170.0f, 120.0f, 180.0f);
    pullLeftView._OpenedCenter = CGPointMake(self.view.frame.size.width, self.view.frame.size.height - 50.0f - pullLeftView.frame.size.height/2.0f);
    pullLeftView._ClosedCenter = CGPointMake(self.view.frame.size.width + 40.0f, self.view.frame.size.height - 50.0f - pullLeftView.frame.size.height/2.0f);
    if (pullLeftView._Opened) {
        pullLeftView.center = pullLeftView._OpenedCenter;
    } else {
        pullLeftView.center = pullLeftView._ClosedCenter;
    }
    pullLeftView._HandleView.frame = CGRectMake(0, 2.0f*pullLeftView.frame.size.height/5.0f, 30.0f, pullLeftView.frame.size.height/5.0f);
    
    btnAcs.frame = CGRectMake(0, 0, 40.0f, 26.0f);
    btnAcs.center = CGPointMake(pullLeftView.frame.size.width/3.5f, 13.0f);
    
    btnDecs.frame = CGRectMake(0, pullLeftView.frame.size.height - 26.0f, 40.0f, 26.0f);
    btnDecs.center = CGPointMake(pullLeftView.frame.size.width/3.5f, pullLeftView.frame.size.height - 13.0f);
    
    // Control Movie
    btnControl.frame = CGRectMake(0, self.view.frame.size.height - 40.0f, 40.0f, 40.0f);
    lblDuration.frame = CGRectMake(self.view.frame.size.width - 40.0f, self.view.frame.size.height - 30.0f, 40.0f, 20.0f);
    progressPlaying.frame = CGRectMake(btnControl.frame.size.width + 13.0f, btnControl.frame.origin.y + 19.0f, self.view.frame.size.width - 106.0f, 2.0f);
    viewGesture.frame = CGRectMake(40.0f, progressPlaying.frame.origin.y - 23.0f, progressPlaying.frame.size.width + 26.0f, 26.0f);
    
    // Total time
    iviewLabelTime.frame = CGRectMake(0, 0, 26.0f, 26.0f);
    lenghtT = progressPlaying.frame.size.width;
    lblcurrentTime.frame = CGRectMake(0, 0, 26.0f, 16.0f);
    
    if (!isModeFill) {
        [layerSVideo setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    } else {
        [layerSVideo setVideoGravity:AVLayerVideoGravityResizeAspect];
    }
}

-(void)setCurrentRow:(int)row
{
    currentRow = row;
}


- (void)recordAudio:(id)sender
{
    if (video._Voice) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Lưu ý!" message:@"Rất tiếc! Video từng được thêm âm thanh!"  delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil, nil];
        [alert show];
        
    }
    else
    {
        flagRecord = !flagRecord;
        if (flagRecord) {
            self.navigationItem.rightBarButtonItem.enabled = NO;
            [playerSVideo play];
            self.navigationItem.leftBarButtonItem = nil;
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"00:00" style:UIBarButtonItemStyleBordered target:self action:nil];
            [btnAddVoice setImage:[UIImage imageNamed:@"Pause.png"] forState:UIControlStateNormal];
            
            startDate = [NSDate date];
            stopWatchTimer = [[NSTimer alloc] init];
            stopWatchTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                              target:self
                                                            selector:@selector(updateTimer)
                                                            userInfo:nil
                                                             repeats:YES];
            
            
            
            NSArray *pathComponents = [NSArray arrayWithObjects:
                                       [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject],
                                       [NSString stringWithFormat:@"Audio%@", [self dateString]],
                                       nil];
            soundFileURL = [NSURL fileURLWithPathComponents:pathComponents];
            
            // Setup audio session
            audioSession = [AVAudioSession sharedInstance];
            [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
            
            // Define the recorder setting
            NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc] init];
            
            [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
            [recordSetting setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
            [recordSetting setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];
            [recordSetting setValue:[NSNumber numberWithInt:AVAudioQualityMedium] forKey:AVEncoderAudioQualityKey];
            
            // Initiate and prepare the recorder
            audioRecorder = [[AVAudioRecorder alloc] initWithURL:soundFileURL settings:recordSetting error:nil];
            audioRecorder.delegate = self;
            audioRecorder.meteringEnabled = YES;
            [audioRecorder prepareToRecord];
            [audioRecorder record];
            
        } else {
            [audioRecorder stop];
            [stopWatchTimer invalidate];
            stopWatchTimer = nil;
            audioSession = nil;
            [playerSVideo pause];
            
            //[_CoreGUI._TabBar.tabBar setHidden:NO];
            flagRecord = NO;
            
            UIActionSheet *actionSheet;
            actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Huỷ" destructiveButtonTitle:nil otherButtonTitles: @"Thêm", nil];
            
            actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
            [actionSheet showInView:self.view];
        }
    }
}


-(void)addMusicToSwingVideo
{
    isAddMusic = YES;
    [btnLine setImage:[UIImage imageNamed:@"Line.png"] forState:UIControlStateNormal];
    [btnCurve setImage:[UIImage imageNamed:@"Curve.png"] forState:UIControlStateNormal];
    [btnCircle setImage:[UIImage imageNamed:@"Circle.png"] forState:UIControlStateNormal];
    [btnRectangle setImage:[UIImage imageNamed:@"Rectangle.png"] forState:UIControlStateNormal];
    [btnDelete setImage:[UIImage imageNamed:@"Trash.png"] forState:UIControlStateNormal];
    [btnAddMusic setImage:[UIImage imageNamed:@"AddMusicSelected.png"] forState:UIControlStateNormal];
    _DrawView._Line = NO;
    _DrawView._Curve = NO;
    _DrawView._Circle = NO;
    _DrawView._Rect = NO;
    
    if (video._Voice) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Lưu ý!" message:@"Rất tiếc! Video từng được thêm âm thanh!"  delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil, nil];
        [alert show];
        
    }
    else
    {
        [playerSVideo pause];
        [[UITabBar appearance] setBackgroundImage:nil];
        [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f]];
        
        MPMediaPickerController *mediaPicker = [[MPMediaPickerController alloc] initWithMediaTypes:MPMediaTypeAny];
        mediaPicker.delegate = self;
        mediaPicker.prompt = @"CHỌN BÀI HÁT";
        
        mediaPicker.navigationController.toolbar.barStyle = UIBarStyleBlackTranslucent;
        [self presentViewController:mediaPicker animated:YES completion:nil];
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
            if (1==1) {
                
                audioAsset = [AVAsset assetWithURL:soundFileURL];
                NSString *stringPath = video._PathVideo;
                videoURL = [[NSURL alloc] initFileURLWithPath:stringPath];
                firstAsset = [AVAsset assetWithURL:videoURL];
                if (firstAsset != nil) {
                    [self mergeSwingVideo];
                } else {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Lỗi" message:@"Rất tiếc, video này không thể chỉnh sửa được!"  delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil, nil];
                    [alert show];
                }
            }
            break;
        case 1:
            if (1 == 1) {
                //btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
                //btnBack.frame = CGRectMake(0, 0, 45.0f, 33.0f);
                //[btnBack setImage:[UIImage imageNamed:@"UIButtonBarItem.png"] forState:UIControlStateNormal];
                //[btnBack addTarget:self action:@selector(backToList) forControlEvents:UIControlEventTouchUpInside];
                audioRecorder = nil;
            }
            break;
            
    }
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnBack];
    [btnAddVoice setImage:[UIImage imageNamed:@"Voice.png"] forState:UIControlStateNormal];
    //self.navigationItem.titleView = btnAddVoice;
    self.navigationItem.rightBarButtonItem.enabled = YES;
}


-(NSString*)dateString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"ddMMMYY_hhmmssa";
    return [[formatter stringFromDate:[NSDate date]] stringByAppendingString:@".m4a"];
}

-(void)mergeSwingVideo
{
    [playerSVideo pause];
    [btnControl setBackgroundImage:[UIImage imageNamed:@"Play.png"] forState:UIControlStateNormal];
    
    viewProcess = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    viewProcess.backgroundColor = [UIColor colorWithRed:50.0f/255.0f green:50.0f/255.0f blue:60.0f/255.0f alpha:0.9f];
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(self.view.frame.size.width/2.0f, (self.view.frame.size.height - spinner.frame.size.height)/2.0f);
    spinner.transform = CGAffineTransformMakeScale(2.0f, 2.0f);
    [viewProcess addSubview:spinner];
    [spinner startAnimating];
    
    [self.view addSubview:viewProcess];
    
    
    
    if (firstAsset != nil) {
        isEdit = YES;
        //Create AVMutableComposition Object.This object will hold our multiple AVMutableCompositionTrack.
        AVMutableComposition* mixComposition = [[AVMutableComposition alloc] init];
        
        //VIDEO TRACK
        AVMutableCompositionTrack *firstTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
        [firstTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, firstAsset.duration) ofTrack:[[firstAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0] atTime:kCMTimeZero error:nil];
        
        //AUDIO TRACK
        if(audioAsset!=nil){
            AVMutableCompositionTrack *AudioTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
            [AudioTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, firstAsset.duration) ofTrack:[[audioAsset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0] atTime:kCMTimeZero error:nil];
        }
        
        AVMutableVideoCompositionInstruction * MainInstruction = [AVMutableVideoCompositionInstruction videoCompositionInstruction];
        MainInstruction.timeRange = CMTimeRangeMake(kCMTimeZero, firstAsset.duration);
        
        //FIXING ORIENTATION//
        AVMutableVideoCompositionLayerInstruction *FirstlayerInstruction = [AVMutableVideoCompositionLayerInstruction videoCompositionLayerInstructionWithAssetTrack:firstTrack];
        AVAssetTrack *FirstAssetTrack = [[firstAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0];
        UIImageOrientation FirstAssetOrientation_  = UIImageOrientationUp;
        BOOL  isFirstAssetPortrait_  = NO;
        CGAffineTransform firstTransform = FirstAssetTrack.preferredTransform;
        if(firstTransform.a == 0 && firstTransform.b == 1.0f && firstTransform.c == -1.0f && firstTransform.d == 0)  {FirstAssetOrientation_= UIImageOrientationRight; isFirstAssetPortrait_ = YES;}
        if(firstTransform.a == 0 && firstTransform.b == -1.0f && firstTransform.c == 1.0f && firstTransform.d == 0)  {FirstAssetOrientation_ =  UIImageOrientationLeft; isFirstAssetPortrait_ = YES;}
        if(firstTransform.a == 1.0f && firstTransform.b == 0 && firstTransform.c == 0 && firstTransform.d == 1.0f)   {FirstAssetOrientation_ =  UIImageOrientationUp;}
        if(firstTransform.a == -1.0f && firstTransform.b == 0 && firstTransform.c == 0 && firstTransform.d == -1.0f) {FirstAssetOrientation_ = UIImageOrientationDown;}
        CGFloat FirstAssetScaleToFitRatio = self.view.frame.size.width/FirstAssetTrack.naturalSize.width;
        if(isFirstAssetPortrait_){
            FirstAssetScaleToFitRatio = self.view.frame.size.width/FirstAssetTrack.naturalSize.height;
            CGAffineTransform FirstAssetScaleFactor = CGAffineTransformMakeScale(FirstAssetScaleToFitRatio,FirstAssetScaleToFitRatio);
            [FirstlayerInstruction setTransform:CGAffineTransformConcat(FirstAssetTrack.preferredTransform, FirstAssetScaleFactor) atTime:kCMTimeZero];
        }else{
            CGAffineTransform FirstAssetScaleFactor = CGAffineTransformMakeScale(FirstAssetScaleToFitRatio,FirstAssetScaleToFitRatio);
            [FirstlayerInstruction setTransform:CGAffineTransformConcat(CGAffineTransformConcat(FirstAssetTrack.preferredTransform, FirstAssetScaleFactor),CGAffineTransformMakeTranslation(0, 160)) atTime:kCMTimeZero];
        }
        [FirstlayerInstruction setOpacity:0.0f atTime:firstAsset.duration];
        
        
        
        MainInstruction.layerInstructions = [NSArray arrayWithObjects:FirstlayerInstruction,nil];;
        
        AVMutableVideoComposition *MainCompositionInst = [AVMutableVideoComposition videoComposition];
        MainCompositionInst.instructions = [NSArray arrayWithObject:MainInstruction];
        MainCompositionInst.frameDuration = CMTimeMake(1, 30);
        MainCompositionInst.renderSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *myPathDocs =  [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"MergeVideo%ds.mov",arc4random() % 10000]];
        
        NSURL *url = [NSURL fileURLWithPath:myPathDocs];
        
        AVAssetExportSession *exporter = [[AVAssetExportSession alloc] initWithAsset:mixComposition presetName:AVAssetExportPresetHighestQuality];
        exporter.outputURL=url;
        exporter.outputFileType = AVFileTypeQuickTimeMovie;
        exporter.videoComposition = MainCompositionInst;
        exporter.shouldOptimizeForNetworkUse = YES;
        [exporter exportAsynchronouslyWithCompletionHandler:^
         {
             dispatch_async(dispatch_get_main_queue(), ^{
                 [self exportDidFinish:exporter];
                 
             });
         }];
        
        
        [self performSelector:@selector(delayProcessingMergeVideo) withObject:nil afterDelay:4.0f];
    }
}

- (void)exportDidFinish:(AVAssetExportSession*)session
{
    if(session.status == AVAssetExportSessionStatusCompleted){
        NSURL *outputURL = session.outputURL;
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        if ([library videoAtPathIsCompatibleWithSavedPhotosAlbum:outputURL]) {
            [library writeVideoAtPathToSavedPhotosAlbum:outputURL
                                        completionBlock:^(NSURL *assetURL, NSError *error){
                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                if (error) {
                                                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Lỗi" message:@"Cập nhật thất bại!"  delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                                                    [alert show];
                                                }
                                                else
                                                {
                                                    video._Voice = YES;
                                                    video._PathVideo = session.outputURL.path;
                                                    [_CoreGUI commitSwingVideo:video withType:0];
                                                    [self backToList];
                                                }
                                                
                                            });
                                            
                                        }];
        }
    }
	
    audioAsset = nil;
    firstAsset = nil;
}

- (void)delayProcessingMergeVideo
{
    [spinner stopAnimating];
    [spinner removeFromSuperview];
    [viewProcess removeFromSuperview];
}

- (void)updateTimer
{
    // Create date from the elapsed time
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:startDate];
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    // Create a date formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0f]];
    
    // Format the elapsed time and set it to the label
    NSString *timeString = [dateFormatter stringFromDate:timerDate];
    self.navigationItem.leftBarButtonItem.title = timeString;
}


- (void)backToList
{
    [playerSVideo pause];
    if (playingTimer) {
        [playingTimer invalidate];
        playingTimer = nil;
    }
    
    NSArray *viewsToRemoveChild = [self.view subviews];
    for (UIView *view in viewsToRemoveChild) {
        [view removeFromSuperview];
    }
    
    audioRecorder = nil;
    [btnControl setBackgroundImage:[UIImage imageNamed:@"Play.png"] forState:UIControlStateNormal];
    
    [_CoreGUI._TabBar.tabBar setHidden:NO];
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"BackgroundTabBar.png"]];
    if (isEdit) {
        [_CoreGUI finishedScreen:self withCode:100];
        
        isEdit = NO;
    }
    else{
        [_CoreGUI finishedScreen:self withCode:101];
    }
    if (isAddMusic) {
        [_CoreGUI showMainScreen];
        ((SwingVideoTableViewController*)[_CoreGUI._Navi.viewControllers objectAtIndex:0])._FlagEdit = YES;
        ((SwingVideoTableViewController*)[_CoreGUI._Navi.viewControllers objectAtIndex:0])._IsMaster = _IsMaster;
        isAddMusic = NO;
    }
}

- (void)pullableView:(PullableView *)pView didChangeState:(BOOL)opened {
    if (opened) {
    } else {
    }
}

- (void)orientationChanged:(NSNotification *)notification
{
    UIDevice * device = notification.object;
    switch(device.orientation)
    {
        case UIDeviceOrientationPortrait:
            if (1 == 1) {
                [self layoutOfScreenForOrientStatus:YES];
            }
            break;
            
        case UIDeviceOrientationPortraitUpsideDown:
            if (1 == 1) {
                //[self layoutOfScreenForOrientStatus:NO];
            }
            break;
        case UIDeviceOrientationLandscapeLeft:
            if (1 == 1) {
                [self layoutOfScreenForOrientStatus:NO];
            }
            break;
        case UIDeviceOrientationLandscapeRight:
            if (1 == 1) {
                [self layoutOfScreenForOrientStatus:NO];
            }
            break;
        default:
            break;
    };
}


- (void)layoutOfScreenForOrientStatus:(BOOL)portrait
{
    isOrient = portrait;
    heightNavi = self.navigationController.navigationBar.frame.size.height;
    
    if (portrait) {
        if (self.view.frame.size.width <= 320.0f) {
            layerSVideo.frame = CGRectMake(0, heightNavi + heightStatusBar, self.view.frame.size.width, self.view.frame.size.height - (heightNavi + heightStatusBar));
            // Add Draw
            
            _DrawView.frame = CGRectMake(0, heightNavi + heightStatusBar, self.view.frame.size.width, self.view.frame.size.height - (heightNavi + heightStatusBar));
            
            if (!showToolBox) {
                viewBackToolBox.frame = CGRectMake(0, -self.view.frame.size.height/10.0f, self.view.frame.size.width, self.view.frame.size.height/10.0f);
            } else {
                viewBackToolBox.frame = CGRectMake(0, heightNavi + heightStatusBar, self.view.frame.size.width, self.view.frame.size.height/10.0f);
            }
            btnLine.center = CGPointMake((1/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
            btnCurve.center = CGPointMake((3/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
            btnCircle.center = CGPointMake((5/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
            btnRectangle.center = CGPointMake((7/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
            btnDelete.center = CGPointMake((9/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
            btnMode.center = CGPointMake((13/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
            btnAddMusic.center = CGPointMake((15/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
            
            pullLeftView.frame = CGRectMake(self.view.frame.size.width - 100.0f, self.view.frame.size.height - 170.0f, 120.0f, 180.0f);
            pullLeftView._OpenedCenter = CGPointMake(self.view.frame.size.width, self.view.frame.size.height - 50.0f - pullLeftView.frame.size.height/2.0f);
            pullLeftView._ClosedCenter = CGPointMake(self.view.frame.size.width + 40.0f, self.view.frame.size.height - 50.0f - pullLeftView.frame.size.height/2.0f);
            if (pullLeftView._Opened) {
                pullLeftView.center = pullLeftView._OpenedCenter;
            } else {
                pullLeftView.center = pullLeftView._ClosedCenter;
            }
            pullLeftView._HandleView.frame = CGRectMake(0, 2.0f*pullLeftView.frame.size.height/5.0f, 30.0f, pullLeftView.frame.size.height/5.0f);
            
            
            btnAcs.frame = CGRectMake(0, 0, 40.0f, 26.0f);
            btnAcs.center = CGPointMake(pullLeftView.frame.size.width/3.5f, 13.0f);
            
            btnDecs.frame = CGRectMake(0, pullLeftView.frame.size.height - 26.0f, 40.0f, 26.0f);
            btnDecs.center = CGPointMake(pullLeftView.frame.size.width/3.5f, pullLeftView.frame.size.height - 13.0f);
            
            // Control Movie
            btnControl.frame = CGRectMake(0, self.view.frame.size.height - 40.0f, 40.0f, 40.0f);
            lblDuration.frame = CGRectMake(self.view.frame.size.width - 40.0f, self.view.frame.size.height - 30.0f, 40.0f, 20.0f);
            progressPlaying.frame = CGRectMake(btnControl.frame.size.width + 13.0f, btnControl.frame.origin.y + 19.0f, self.view.frame.size.width - 106.0f, 2.0f);
            viewGesture.frame = CGRectMake(40.0f, progressPlaying.frame.origin.y - 23.0f, progressPlaying.frame.size.width + 26.0f, 26.0f);
            
            
            // Total time
            iviewLabelTime.frame = CGRectMake(0, 0, 26.0f, 26.0f);
            lenghtT = progressPlaying.frame.size.width;
            lblcurrentTime.frame = CGRectMake(0, 0, 26.0f, 16.0f);
            
            if (!isModeFill) {
                [layerSVideo setVideoGravity:AVLayerVideoGravityResizeAspectFill];
            } else {
                [layerSVideo setVideoGravity:AVLayerVideoGravityResizeAspect];
            }
        }
        else {
            layerSVideo.frame = CGRectMake(0, heightNavi + heightStatusBar, self.view.frame.size.height, self.view.frame.size.width - (heightNavi + heightStatusBar));
            // Add Draw
            
            _DrawView.frame = CGRectMake(0, heightNavi + heightStatusBar, self.view.frame.size.width, self.view.frame.size.width - (heightNavi + heightStatusBar));
            
            if (!showToolBox) {
                viewBackToolBox.frame = CGRectMake(0, -self.view.frame.size.width/10.0f, self.view.frame.size.height, self.view.frame.size.width/10.0f);
            } else {
                viewBackToolBox.frame = CGRectMake(0, heightNavi + heightStatusBar, self.view.frame.size.height, self.view.frame.size.width/10.0f);
            }
            btnLine.center = CGPointMake((1/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
            btnCurve.center = CGPointMake((3/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
            btnCircle.center = CGPointMake((5/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
            btnRectangle.center = CGPointMake((7/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
            btnDelete.center = CGPointMake((9/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
            btnMode.center = CGPointMake((13/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
            btnAddMusic.center = CGPointMake((15/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
            
            pullLeftView.frame = CGRectMake(self.view.frame.size.height - 100.0f, self.view.frame.size.width - 170.0f, 120.0f, 180.0f);
            pullLeftView._OpenedCenter = CGPointMake(self.view.frame.size.height, self.view.frame.size.width - 50.0f - pullLeftView.frame.size.height/2.0f);
            pullLeftView._ClosedCenter = CGPointMake(self.view.frame.size.height + 40.0f, self.view.frame.size.width - 50.0f - pullLeftView.frame.size.height/2.0f);
            if (pullLeftView._Opened) {
                pullLeftView.center = pullLeftView._OpenedCenter;
            } else {
                pullLeftView.center = pullLeftView._ClosedCenter;
            }
            pullLeftView._HandleView.frame = CGRectMake(0, 2.0f*pullLeftView.frame.size.height/5.0f, 30.0f, pullLeftView.frame.size.height/5.0f);
            
            btnAcs.frame = CGRectMake(0, 0, 40.0f, 26.0f);
            btnAcs.center = CGPointMake(pullLeftView.frame.size.width/3.5f, 13.0f);
            
            btnDecs.frame = CGRectMake(0, pullLeftView.frame.size.height - 26.0f, 40.0f, 26.0f);
            btnDecs.center = CGPointMake(pullLeftView.frame.size.width/3.5f, pullLeftView.frame.size.height - 13.0f);
            
            // Control Movie
            btnControl.frame = CGRectMake(0, self.view.frame.size.width - 40.0f, 40.0f, 40.0f);
            lblDuration.frame = CGRectMake(self.view.frame.size.height - 40.0f, self.view.frame.size.width - 30.0f, 40.0f, 20.0f);
            progressPlaying.frame = CGRectMake(btnControl.frame.size.width + 13.0f, btnControl.frame.origin.y + 19.0f, self.view.frame.size.height - 106.0f, 2.0f);
            viewGesture.frame = CGRectMake(40.0f, progressPlaying.frame.origin.y - 23.0f, progressPlaying.frame.size.width + 26.0f, 26.0f);
            
            
            // Total time
            iviewLabelTime.frame = CGRectMake(0, 0, 26.0f, 26.0f);
            lenghtT = progressPlaying.frame.size.width;
            lblcurrentTime.frame = CGRectMake(0, 0, 26.0f, 16.0f);
            
            if (!isModeFill) {
                [layerSVideo setVideoGravity:AVLayerVideoGravityResizeAspectFill];
            } else {
                [layerSVideo setVideoGravity:AVLayerVideoGravityResizeAspect];
            }
        }
        
    } else {
        if (self.view.frame.size.width <= 320.0f) {
            layerSVideo.frame = CGRectMake(0, heightNavi + heightStatusBar, self.view.frame.size.height, self.view.frame.size.width - (heightNavi + heightStatusBar));
            // Add Draw
            
            _DrawView.frame = CGRectMake(0, heightNavi + heightStatusBar, self.view.frame.size.width, self.view.frame.size.width - (heightNavi + heightStatusBar));
            
            if (!showToolBox) {
                viewBackToolBox.frame = CGRectMake(0, -self.view.frame.size.width/10.0f, self.view.frame.size.height, self.view.frame.size.height/10.0f);
            } else {
                viewBackToolBox.frame = CGRectMake(0, heightNavi + heightStatusBar, self.view.frame.size.height, self.view.frame.size.height/10.0f);
            }
            btnLine.center = CGPointMake((1/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
            btnCurve.center = CGPointMake((3/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
            btnCircle.center = CGPointMake((5/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
            btnRectangle.center = CGPointMake((7/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
            btnDelete.center = CGPointMake((9/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
            btnMode.center = CGPointMake((13/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
            btnAddMusic.center = CGPointMake((15/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
            
            pullLeftView.frame = CGRectMake(self.view.frame.size.height - 100.0f, self.view.frame.size.width - 170.0f, 120.0f, 180.0f);
            pullLeftView._OpenedCenter = CGPointMake(self.view.frame.size.height, self.view.frame.size.width - 50.0f - pullLeftView.frame.size.height/2.0f);
            pullLeftView._ClosedCenter = CGPointMake(self.view.frame.size.height + 40.0f, self.view.frame.size.width - 50.0f - pullLeftView.frame.size.height/2.0f);
            if (pullLeftView._Opened) {
                pullLeftView.center = pullLeftView._OpenedCenter;
            } else {
                pullLeftView.center = pullLeftView._ClosedCenter;
            }
            pullLeftView._HandleView.frame = CGRectMake(0, 2.0f*pullLeftView.frame.size.height/5.0f, 30.0f, pullLeftView.frame.size.height/5.0f);
            
            btnAcs.frame = CGRectMake(0, 0, 40.0f, 26.0f);
            btnAcs.center = CGPointMake(pullLeftView.frame.size.width/3.5f, 13.0f);
            
            btnDecs.frame = CGRectMake(0, pullLeftView.frame.size.height - 26.0f, 40.0f, 26.0f);
            btnDecs.center = CGPointMake(pullLeftView.frame.size.width/3.5f, pullLeftView.frame.size.height - 13.0f);
            
            // Control Movie
            btnControl.frame = CGRectMake(0, self.view.frame.size.width - 40.0f, 40.0f, 40.0f);
            lblDuration.frame = CGRectMake(self.view.frame.size.height - 40.0f, self.view.frame.size.width - 30.0f, 40.0f, 20.0f);
            progressPlaying.frame = CGRectMake(btnControl.frame.size.width + 13.0f, btnControl.frame.origin.y + 19.0f, self.view.frame.size.height - 106.0f, 2.0f);
            viewGesture.frame = CGRectMake(40.0f, progressPlaying.frame.origin.y - 23.0f, progressPlaying.frame.size.width + 26.0f, 26.0f);
            
            
            // Total time
            iviewLabelTime.frame = CGRectMake(0, 0, 26.0f, 26.0f);
            lenghtT = progressPlaying.frame.size.width;
            lblcurrentTime.frame = CGRectMake(0, 0, 26.0f, 16.0f);
            
            if (!isModeFill) {
                [layerSVideo setVideoGravity:AVLayerVideoGravityResizeAspectFill];
            } else {
                [layerSVideo setVideoGravity:AVLayerVideoGravityResizeAspect];
            }
        } else {
            layerSVideo.frame = CGRectMake(0, heightNavi + heightStatusBar, self.view.frame.size.width, self.view.frame.size.height - (heightNavi + heightStatusBar));
            // Add Draw
            
            _DrawView.frame = CGRectMake(0, heightNavi + heightStatusBar, self.view.frame.size.width, self.view.frame.size.height - (heightNavi + heightStatusBar));
            
            if (!showToolBox) {
                viewBackToolBox.frame = CGRectMake(0, -self.view.frame.size.height/10.0f, self.view.frame.size.width, self.view.frame.size.width/10.0f);
            } else {
                viewBackToolBox.frame = CGRectMake(0, heightNavi + heightStatusBar, self.view.frame.size.width, self.view.frame.size.width/10.0f);
            }
            btnLine.center = CGPointMake((1/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
            btnCurve.center = CGPointMake((3/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
            btnCircle.center = CGPointMake((5/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
            btnRectangle.center = CGPointMake((7/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
            btnDelete.center = CGPointMake((9/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
            btnMode.center = CGPointMake((13/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
            btnAddMusic.center = CGPointMake((15/16.0f)*viewBackToolBox.frame.size.width, viewBackToolBox.frame.size.height/2.0f);
            
            pullLeftView.frame = CGRectMake(self.view.frame.size.width - 100.0f, self.view.frame.size.height - 170.0f, 120.0f, 180.0f);
            pullLeftView._OpenedCenter = CGPointMake(self.view.frame.size.width, self.view.frame.size.height - 50.0f - pullLeftView.frame.size.height/2.0f);
            pullLeftView._ClosedCenter = CGPointMake(self.view.frame.size.width + 40.0f, self.view.frame.size.height - 50.0f - pullLeftView.frame.size.height/2.0f);
            if (pullLeftView._Opened) {
                pullLeftView.center = pullLeftView._OpenedCenter;
            } else {
                pullLeftView.center = pullLeftView._ClosedCenter;
            }
            pullLeftView._HandleView.frame = CGRectMake(0, 2.0f*pullLeftView.frame.size.height/5.0f, 30.0f, pullLeftView.frame.size.height/5.0f);
            
            btnAcs.frame = CGRectMake(0, 0, 40.0f, 26.0f);
            btnAcs.center = CGPointMake(pullLeftView.frame.size.width/3.5f, 13.0f);
            
            btnDecs.frame = CGRectMake(0, pullLeftView.frame.size.height - 26.0f, 40.0f, 26.0f);
            btnDecs.center = CGPointMake(pullLeftView.frame.size.width/3.5f, pullLeftView.frame.size.height - 13.0f);
            
            // Control Movie
            btnControl.frame = CGRectMake(0, self.view.frame.size.height - 40.0f, 40.0f, 40.0f);
            
            lblDuration.frame = CGRectMake(self.view.frame.size.width - 40.0f, self.view.frame.size.height - 30.0f, 40.0f, 20.0f);
            progressPlaying.frame = CGRectMake(btnControl.frame.size.width + 13.0f, btnControl.frame.origin.y + 19.0f, self.view.frame.size.width - 106.0f, 2.0f);
            viewGesture.frame = CGRectMake(40.0f, progressPlaying.frame.origin.y - 23.0f, progressPlaying.frame.size.width + 26.0f, 26.0f);
            
            
            
            // Total time
            iviewLabelTime.frame = CGRectMake(0, 0, 26.0f, 26.0f);
            lenghtT = progressPlaying.frame.size.width;
            lblcurrentTime.frame = CGRectMake(0, 0, 26.0f, 16.0f);
            
            if (!isModeFill) {
                [layerSVideo setVideoGravity:AVLayerVideoGravityResizeAspectFill];
            } else {
                [layerSVideo setVideoGravity:AVLayerVideoGravityResizeAspect];
            }
        }
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [_CoreGUI._TabBar.tabBar setHidden:YES];
    isModeFill = NO;
    flagRecord = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(orientationChanged:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
