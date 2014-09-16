//
//  TrimVideoViewController.h
//  VietGolfVersion1.1
//
//  Created by admin on 9/10/14.
//  Copyright (c) 2014 NguyenDuyThanh. All rights reserved.
//

#import "AbstractViewController.h"

#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <CoreMedia/CoreMedia.h>
#import "PullableView.h"
#import "SVideoInfo.h"
#import "Draw2D.h"

#define DOCUMENTS_FOLDER [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]


@interface TrimVideoViewController : AbstractViewController <MPMediaPickerControllerDelegate>
{
    UIButton *btnBack;
    UIView *viewAddVoice;
    UIButton *btnToolBox;
    UIButton *btnAddVoice;
    BOOL isModeFill;
    BOOL showToolBox;
    CGSize itemSize;
    BOOL isPlaying;
    float currentPointer;
    float heightNavi;
    float heightStatusBar;
    BOOL isOrient;
    BOOL isSetPosition;
    UITapGestureRecognizer *doubleTap;
    UILongPressGestureRecognizer *longPress;
    
    AVPlayer *playerSVideo;
    AVPlayerLayer *layerSVideo;
    Draw2D *_DrawView;
    BOOL isShowSpeed;
    
	AVAudioRecorder *audioRecorder;
    AVAudioPlayer *audioPlayer;
    AVAsset* firstAsset;
    AVAsset* audioAsset;
    NSURL *soundFileURL;
    NSURL *videoURL;
    AVAudioSession *audioSession;
    
    // Draw tool
    UIView *viewBackToolBox;
    UIButton *btnLine;
    UIButton *btnCurve;
    UIButton *btnCircle;
    UIButton *btnRectangle;
    UIButton *btnDelete;
    UIButton *btnMode;
    UIButton *btnAddMusic;
    
    AVAsset *asset;
    UIProgressView *progressPlaying;
    NSTimer *playingTimer;
    UILabel *lblcurrentTime;
    float durationT;
    float lenghtT;
    UIImageView *iviewLabelTime;
    
    UIButton *btnControl;
    
    BOOL flag;
    BOOL flagRecord;
    BOOL isRefresh;
    BOOL isEdit;
    BOOL _IsMaster;
    BOOL isAddMusic;
    BOOL isSelectingAssetOne;
    int currentRow;
    int countAppear;
    
    UIView *viewProcess;
    UIActivityIndicatorView *spinner;
    NSString *stringPathChange;
    //
    NSDate *startDate;
    NSTimer *stopWatchTimer;
    UIView *viewMovie;
    NSTimer *movieTimer;
    
    // Speed tool
    PullableView *pullLeftView;
    UISlider *speedSlider;
    UIButton *btnAcs;
    UIButton *btnDecs;
    UIView *viewGesture;
    UILabel *lblDuration;
    UIPanGestureRecognizer *pan;
    

}

@property (nonatomic, retain) AVPlayer *playerSVideo;
@property (nonatomic) BOOL _IsMaster;
@property (nonatomic) int currentRow;
@property (nonatomic, retain) AVAsset* firstAsset;
@property (nonatomic, retain) AVAsset* audioAsset;
@property (nonatomic, retain) UIActivityIndicatorView *ActivityView;
@property (copy, nonatomic) NSURL *_MovieURL;
@property (strong, nonatomic) Draw2D *_DrawView;
@property (nonatomic, retain) PullableView *pullLeftView;
@property (strong, nonatomic) AVAudioRecorder *audioRecorder;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
@property (nonatomic, retain) SVideoInfo *video;

// ------ Methods

- (void)exportDidFinish:(AVAssetExportSession*)session;
- (void)recordAudio:(id)sender;
- (void)mergeSwingVideo;
- (void)playVideo;
- (void)setCurrentRow:(int)row;
- (NSString *)secondsToMMSS:(double)seconds;
- (NSString*)dateString;
- (void)backToList;
- (void)layoutOfScreenForOrientStatus:(BOOL)portrait;

@property (nonatomic, retain) SVideoInfo *_TSVideo;

@end
