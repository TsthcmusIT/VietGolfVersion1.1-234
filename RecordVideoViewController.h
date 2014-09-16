//
//  RecordVideoViewController.h
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import "AbstractViewController.h"

#import <MediaPlayer/MediaPlayer.h>
#import <QuartzCore/CALayer.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreMedia/CoreMedia.h>
#import <AVFoundation/AVFoundation.h>

#import "SVideoInfo.h"
#import "RecordSetting.h"
#import "DrawCustomShape.h"


// Transform values for full screen support:
#define CAMERA_TRANSFORM_X 1
//#define CAMERA_TRANSFORM_Y 1.12412 //use this is for iOS 3.x
#define CAMERA_TRANSFORM_Y 1.24299 // use this is for iOS 4.x

@interface RecordVideoViewController : AbstractViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, AVCaptureVideoDataOutputSampleBufferDelegate, UIPickerViewDelegate, UIPickerViewDataSource>
{
    NSArray *arrDelay;
    NSMutableArray *arrRecordSetting;
    RecordSetting *recordSetting;
    UIImagePickerController *_CameraUI;
    SVideoInfo *video;
    UIView *viewCamera;
    UIButton *btnLeftHand;
    UIButton *btnStraightHand;
    UIButton *btnSetting;
    UIImageView *imaVBackgHand;
    UIView *viewTool;
    UILabel *lblDelay;
    UILabel *lblAutoStop;
    UILabel *lblAllowTrim;
    UIView *viewLineDS;
    UIView *viewLineST;
    UIButton *btnDelay;
    UISwitch *switchAutoStop;
    UISwitch *switchAllowTrim;
    UIPickerView *pickerDelay;
    UIButton *btnBack;
    UIButton *btnCamera;
    UILabel *lblTimer;
    
    UIView *viewBackground;
    UIView *viewTitle;
    UIButton *btnDone;
    
    BOOL isRecord;
    BOOL isShowToolbox;
    int currentHand;
    int countDown;
    int currentCountDown;
    BOOL isSuccess;
    
    DrawCustomShape *drawCus;
    UIImageView *imaVCountDown;
    UIView *viewBlur;
    NSTimer *countDownTimer;
    NSDate *startDate;
    NSTimer *recordTimer;
    NSTimer *openingTimer;

}

@property (nonatomic, retain) UIImagePickerController *_CameraUI;

- (BOOL)startCameraControllerFromViewController:(UIViewController*)controller
                                usingDelegate:(id )delegate;
- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void*)contextInfo;
- (void)setupCameraSession;
- (void)loadRecordSetting;
- (void)updateInfoToRecordSetting;


@end
