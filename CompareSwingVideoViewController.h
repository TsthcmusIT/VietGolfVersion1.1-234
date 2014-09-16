//
//  CompareSwingVideoViewController.h
//  VietGolfVersion1.1
//
//  Created by admin on 8/12/14.
//  Copyright (c) 2014 NguyenDuyThanh. All rights reserved.
//

#import "AbstractViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <MediaPlayer/MediaPlayer.h>

#import "SVideoInfo.h"
#import "Draw2D.h"

@interface CompareSwingVideoViewController : AbstractViewController<MPMediaPickerControllerDelegate, UIScrollViewDelegate, UIGestureRecognizerDelegate, UIPageViewControllerDelegate>
{
    BOOL _IsMixed;
    BOOL isMaster;
    BOOL allowMoving;
    BOOL isOrient;
    BOOL isTranparancy;
    BOOL allowOrient;
    BOOL isBothPause;
    BOOL isSetPosition;
    
    
    UILabel *lblTitle;
    UIButton *btnExit;
    
    // Toolbox top view
    UIView *viewTopTool;
    UIButton *btnBackToList;
    UIButton *btnModeView;
    UIButton *btnSaveCompare;
    
    // Toolbox draw view
    UIView *viewToolSpeed;
    UIButton *btnAsc;
    UIButton *btnDecs;
    UISlider *speedSlider;
    UISlider *transparentSlider;
    // Draw
    Draw2D *_DrawView;
    UIView *viewDrawTool;
    UIButton *btnLine;
    UIButton *btnCurve;
    UIButton *btnCircle;
    UIButton *btnRectangle;
    UIButton *btnDelete;

    
    // -- Host
    AVPlayer *_PlayerHost;
    AVPlayerLayer *layerHost;
    SVideoInfo *_SVideoHost;
    UIImageView *imaVFrameHost;
    BOOL isHostPlaying;
    BOOL flagEndTime;
    BOOL statusHostEndTime;
    float currentPointerHost;
    UIPanGestureRecognizer *panHost;
    CMTime durationTimeHost;
    // --
    UIProgressView *progressPlayingHost;
    NSTimer *playingTimerHost;
    UILabel *lblcurrentTimeHost;
    float durationTHost;
    float lenghtTHost;
     UIImageView *iviewLabelTimeHost;
    UIView *viewGestureHost;
    CMTime durationTime;

    // -- Client
    AVPlayer *_PlayerCompare;
    AVPlayerLayer *layerCompare;
    NSMutableArray *listVideoCompare;
    NSString *stringPathCompare;
    BOOL isComparePlaying;
    BOOL statusCompareEndTime;
    float currentPointerCompare;
    UIPanGestureRecognizer *pan;
    // --
    UIButton *btnControl;
    UIProgressView *progressPlaying;
    NSTimer *playingTimer;
    UILabel *lblcurrentTime;
    float durationT;
    float lenghtT;
    UIImageView *iviewLabelTime;
    UIView *viewGestureCompare;
    
    // -- Scroll view
    UITapGestureRecognizer *tapGes;
    UIButton *btnMaster;
    UIButton *btnUser;
    UIView *viewBackground;
    float previousTouchPoint;
    BOOL didEndAnimate;
    UIPageControl *pageControl;
    UIScrollView *scrollview;
    UIButton *btnPrev;
    UIButton *btnNext;
    NSMutableArray *itemArr;
}

@property (nonatomic) BOOL _IsMixed;
@property (nonatomic, retain) SVideoInfo *_SVideoHost;
@property (nonatomic, retain) AVPlayer *_PlayerHost;
@property (nonatomic, retain) AVPlayer *_PlayerCompare;

-(void)showCompareScreen:(SVideoInfo*)hostSVideo withCompareStringPath:(NSString*)compareStrPath;
-(NSString *)secondsToMMSS:(double)seconds;
-(void)modeViewSVideo;
- (void)layoutOfScreenForOrientStatus:(BOOL)portrait;

@end











