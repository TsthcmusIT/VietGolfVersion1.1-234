//
//  RecordVideoViewController.m
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import "RecordVideoViewController.h"
#import "CoreGUIController.h"

@interface RecordVideoViewController ()

@end

@implementation RecordVideoViewController

@synthesize _CameraUI;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _ScreenName = RecordScreen;
    video = [[SVideoInfo alloc] init];
    arrRecordSetting = [[NSMutableArray alloc] init];
    recordSetting = [[RecordSetting alloc] init];
    
    [self loadRecordSetting];
    if ([arrRecordSetting count] > 0) {
        recordSetting = [arrRecordSetting objectAtIndex:0];
    } else {
        recordSetting._Delay = @"5s";
        recordSetting._AutoStop = NO;
        recordSetting._AutoTrim = YES;
    }
    
    currentHand = 0;
    
    NSString *str = recordSetting._Delay;
    NSString *truncatedString = [str substringToIndex:[str length] - 1];
    countDown = [truncatedString integerValue];
    self.navigationItem.hidesBackButton = YES;
    arrDelay = [[NSArray alloc] initWithObjects:@"10s", @"9s", @"8s", @"7s", @"6s", @"5s", @"4s", @"3s", @"2s", @"1s", @"0s", nil];
    
    openingTimer = [NSTimer scheduledTimerWithTimeInterval:0.0015f
                                                    target:self
                                                  selector:@selector(scaleTimer)
                                                  userInfo:nil
                                                   repeats:YES];
    drawCus = [[DrawCustomShape alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    drawCus.backgroundColor = [UIColor clearColor];
    [self.view addSubview:drawCus];
}

-(void)scaleTimer
{
    drawCus._MyEndPoint = CGPointMake(drawCus._MyEndPoint.x - 3.0f, drawCus._MyEndPoint.y - 3.0f);
    if ( drawCus._MyEndPoint.x <= drawCus._MyStartPoint.x + 6.0f ||  drawCus._MyEndPoint.y <= drawCus._MyStartPoint.y + 6.0f) {
        [openingTimer invalidate];
        openingTimer = nil;
        [drawCus removeFromSuperview];
        [self startCameraControllerFromViewController:self usingDelegate:self];
    }
    [drawCus setNeedsDisplay];
}

- (void)setupCameraSession
{
    // Session
    AVCaptureSession *session = [AVCaptureSession new];
    [session setSessionPreset:AVCaptureSessionPresetLow];
    
    // Capture device
    AVCaptureDevice *inputDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error;
    
    // Device input
    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:inputDevice error:&error];
	if ( [session canAddInput:deviceInput] )
		[session addInput:deviceInput];
    
    // Preview
	AVCaptureVideoPreviewLayer *previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
    [previewLayer setBackgroundColor:[[UIColor greenColor] CGColor]];
    [previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    CALayer *rootLayer = [[self view] layer];
	[rootLayer setMasksToBounds:YES];
	[previewLayer setFrame:CGRectMake(-70.0f, 0, rootLayer.bounds.size.height, rootLayer.bounds.size.height)];
    [rootLayer insertSublayer:previewLayer atIndex:0];
    
    [previewLayer addAnimation:[self animationForRotationX:0.5f Y:0.5f andZ:0.5f] forKey:@"rotation"];
    [session startRunning];
}


- (CAAnimation *)animationForRotationX:(float)x Y:(float)y andZ:(float)z
{
    CATransform3D transform;
    transform = CATransform3DMakeRotation(M_PI, x, y, z);
    
    CABasicAnimation* animation;
    animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.toValue = [NSValue valueWithCATransform3D:transform];
    animation.duration = 2;
    animation.cumulative = YES;
    animation.repeatCount = 10000;
    return animation;
}

- (BOOL)startCameraControllerFromViewController:(UIViewController*)controller
                                 usingDelegate:(id )delegate
{
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f]];
    // 1 - Validattions
    if (([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == NO)
        || (delegate == nil)
        || (controller == nil)) {
        return NO;
    }
    //OverPlayRecordView *overRec = [[OverPlayRecordView alloc]initWithMainView:self];
    
    // 2 - Get image picker
    _CameraUI = [[UIImagePickerController alloc] init];
    _CameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    // Displays a control that allows the user to choose movie capture
    _CameraUI.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeMovie, nil];
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    
    // Hide the controls:
    _CameraUI.showsCameraControls = NO;
    _CameraUI.navigationBarHidden = YES;
    _CameraUI.toolbarHidden = YES;
    
    // Make camera view full screen:
    _CameraUI.extendedLayoutIncludesOpaqueBars = YES;
    _CameraUI.cameraViewTransform = CGAffineTransformScale(_CameraUI.cameraViewTransform, CAMERA_TRANSFORM_X, CAMERA_TRANSFORM_Y);
    
    // Insert the overlay:
    _CameraUI.allowsEditing = YES;
    
    viewCamera = [[UIView alloc] init];
    viewCamera.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    viewCamera.backgroundColor = [UIColor clearColor];
    [self.view addSubview:viewCamera];
    
    btnLeftHand = [UIButton buttonWithType:UIButtonTypeCustom];
    btnLeftHand.frame = CGRectMake(0, 0, 20.0f, 30.0f);
    btnLeftHand.center = CGPointMake(20.0f, 25.0f);
    [btnLeftHand setImage:[UIImage imageNamed:@"LeftDirect.png"] forState:UIControlStateNormal];
    [btnLeftHand addTarget:self action:@selector(convertLeftHand) forControlEvents:UIControlEventTouchUpInside];
    [viewCamera addSubview:btnLeftHand];
    
    btnStraightHand = [UIButton buttonWithType:UIButtonTypeCustom];
    btnStraightHand.frame = CGRectMake(0, 0, 20.0f, 30.0f);
    btnStraightHand.center = CGPointMake(self.view.frame.size.width - 20.0f, 25.0f);
    [btnStraightHand setImage:[UIImage imageNamed:@"StraightDirect.png"] forState:UIControlStateNormal];
    [btnLeftHand addTarget:self action:@selector(convertStraightHand) forControlEvents:UIControlEventTouchUpInside];
    [viewCamera addSubview:btnStraightHand];

    btnSetting = [UIButton buttonWithType:UIButtonTypeCustom];
    btnSetting.frame = CGRectMake(0, 0, 30.0f, 30.0f);
    btnSetting.center = CGPointMake(self.view.frame.size.width/2.0f, 25.0f);
    [btnSetting setImage:[UIImage imageNamed:@"SettingRecordPressed.png"] forState:UIControlStateNormal];
    [btnSetting addTarget:self action:@selector(controlSettingToolbox) forControlEvents:UIControlEventTouchUpInside];
    [viewCamera addSubview:btnSetting];
    
    imaVBackgHand = [[UIImageView alloc] init];
    imaVBackgHand.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width);
    imaVBackgHand.center = CGPointMake(self.view.frame.size.width/2.0f, self.view.frame.size.height/2.0f);
    
    viewTool = [[UIView alloc] init];
    viewTool.frame = CGRectMake(10.0f, btnSetting.frame.origin.y + btnSetting.frame.size.height + 20.0f, self.view.frame.size.width - 20.0f, 120.0f);
    viewTool.backgroundColor = [UIColor colorWithWhite:1.0f alpha:1.0f];
    viewTool.clipsToBounds = YES;
    viewTool.layer.cornerRadius = 8.0f;
    viewTool.hidden = YES;
    [viewCamera addSubview:viewTool];
    
    lblDelay = [[UILabel alloc] init];
    lblDelay.frame = CGRectMake(10.0f, 0, viewTool.frame.size.width - 100.0f, 40.0f);
    [lblDelay setTextColor:[UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f]];
    [lblDelay setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f]];
    lblDelay.textAlignment = NSTextAlignmentLeft;
    lblDelay.text = @"Đếm ngược";
    [viewTool addSubview:lblDelay];
    
    lblAllowTrim = [[UILabel alloc] init];
    lblAllowTrim.frame = CGRectMake(10.0f, lblDelay.frame.origin.y + lblDelay.frame.size.height, viewTool.frame.size.width - 100.0f, 40.0f);
    [lblAllowTrim setTextColor:[UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f]];
    [lblAllowTrim setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f]];
    lblAllowTrim.textAlignment = NSTextAlignmentLeft;
    lblAllowTrim.text = @"Tự động chia đoạn";
    [viewTool addSubview:lblAllowTrim];
    
    lblAutoStop = [[UILabel alloc] init];
    lblAutoStop.frame = CGRectMake(10.0f, lblAllowTrim.frame.origin.y + lblAllowTrim.frame.size.height, viewTool.frame.size.width - 80.0f, 40.0f);
    [lblAutoStop setTextColor:[UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f]];
    [lblAutoStop setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f]];
    lblAutoStop.textAlignment = NSTextAlignmentLeft;
    lblAutoStop.text = @"Kết thúc quay sau 5s";
    [viewTool addSubview:lblAutoStop];
    
    viewLineDS = [[UIView alloc] init];
    viewLineDS.frame = CGRectMake(0, 0, viewTool.frame.size.width - 20.0f, 1.0f);
    viewLineDS.center = CGPointMake(viewTool.frame.size.width/2.0f, 40.0f);
    viewLineDS.backgroundColor = [UIColor colorWithWhite:0.9f alpha:0.8f];
    [viewTool addSubview: viewLineDS];
    
    viewLineST = [[UIView alloc] init];
    viewLineST.frame = CGRectMake(0, 0, viewTool.frame.size.width - 20.0f, 1.0f);
    viewLineST.center = CGPointMake(viewTool.frame.size.width/2.0f, 80.0f);
    viewLineST.backgroundColor = [UIColor colorWithWhite:0.9f alpha:0.8f];
    [viewTool addSubview: viewLineST];
    
    btnDelay = [UIButton buttonWithType:UIButtonTypeCustom];
    btnDelay.frame = CGRectMake(0, 0, 60.0f, 30.0f);
    btnDelay.center = CGPointMake(viewTool.frame.size.width - 40.0f, 20.0f);
    [btnDelay setTitle:[NSString stringWithFormat:@"%@", recordSetting._Delay] forState:UIControlStateNormal];
    [btnDelay.titleLabel setTextAlignment:NSTextAlignmentRight];
    [btnDelay setTitleColor:[UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [btnDelay addTarget:self action:@selector(chooseDelayTime) forControlEvents:UIControlEventTouchUpInside];
    [btnDelay.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f]];
    [viewTool addSubview:btnDelay];
    
    switchAllowTrim = [[UISwitch alloc] init];
    switchAllowTrim.frame = CGRectMake(0, 0, 60.0f, 30.0f);
    switchAllowTrim.center = CGPointMake(viewTool.frame.size.width - 40.0f, 60.0f);
    switchAllowTrim.tag = 501;
    [switchAllowTrim setOn:recordSetting._AutoTrim];
    [switchAllowTrim addTarget:self action:@selector(changeSwitch:) forControlEvents:UIControlEventValueChanged];
    [viewTool addSubview:switchAllowTrim];
    
    switchAutoStop = [[UISwitch alloc] init];
    switchAutoStop.frame = CGRectMake(0, 0, 60.0f, 30.0f);
    switchAutoStop.center = CGPointMake(viewTool.frame.size.width - 40.0f, 100.0f);
    switchAutoStop.backgroundColor = [UIColor clearColor];
    switchAutoStop.tag = 500;
    [switchAutoStop setOn:recordSetting._AutoStop];
    [switchAutoStop addTarget:self action:@selector(changeSwitch:) forControlEvents:UIControlEventValueChanged];
    [viewTool addSubview:switchAutoStop];
    
    
    
    pickerDelay = [[UIPickerView alloc] init];
    pickerDelay.frame = CGRectMake(0, 0, self.view.frame.size.width, 200.0f);
    pickerDelay.delegate = self;
    pickerDelay.dataSource = self;
    
    btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    btnBack.frame = CGRectMake(0, 0, 30.0f, 30.0f);
    btnBack.center = CGPointMake(30.0f, self.view.frame.size.height - 50.0f);
    [btnBack setImage:[UIImage imageNamed:@"BackToLibrary.png"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(backToCreateScreen) forControlEvents:UIControlEventTouchUpInside];
    [viewCamera addSubview:btnBack];
    
    btnCamera = [UIButton buttonWithType:UIButtonTypeCustom];
    btnCamera.frame = CGRectMake(0, 0, 70.0f, 70.0f);
    btnCamera.center = CGPointMake(self.view.frame.size.width/2.0f, self.view.frame.size.height - 50.0f);
    [btnCamera setImage:[UIImage imageNamed:@"Record.png"] forState:UIControlStateNormal];
    [btnCamera addTarget:self action:@selector(controlCamera) forControlEvents:UIControlEventTouchUpInside];
    [viewCamera addSubview:btnCamera];
    
    lblTimer = [[UILabel alloc] init];
    lblTimer.frame = CGRectMake(0, 0, 120.0f, 30.0f);
    lblTimer.center = CGPointMake(self.view.frame.size.width - 65.0f, self.view.frame.size.height - 50.0f);
    [lblTimer setTextColor:[UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f]];
    [lblTimer setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f]];
    lblTimer.textAlignment = NSTextAlignmentCenter;
    lblTimer.text = @"00:00:00";
    [viewCamera addSubview:lblTimer];

    drawCus = [[DrawCustomShape alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2.0f - 10.0f, self.view.frame.size.height/2.0f - 10.0f, 25.0f, 25.0f)];
    drawCus.backgroundColor = [UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f];
    drawCus.clipsToBounds = YES;
    drawCus.layer.cornerRadius = 12.0f;
    [viewCamera addSubview:drawCus];
    
    _CameraUI.cameraOverlayView = viewCamera;
    _CameraUI.delegate = delegate;
    // 3 - Display image picker
    [controller presentViewController:_CameraUI animated:NO completion:nil];
    
    [UIView animateWithDuration:0.6f delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
        drawCus.center = CGPointMake(self.view.frame.size.width/2.0f, btnSetting.frame.origin.y + btnSetting.frame.size.height/2.0f);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.01f delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
            drawCus.alpha = 0;
            [drawCus removeFromSuperview];
            [btnSetting setImage:[UIImage imageNamed:@"SettingRecord.png"] forState:UIControlStateNormal];
        } completion:nil];
    }];
    
    isShowToolbox = NO;
    return YES;
}


-(void)convertStraightHand
{
    if (currentHand != 1 || currentHand != 2) {
        imaVBackgHand.image = [UIImage imageNamed:@"LeftLeftHand.png"];
        [viewCamera addSubview:imaVBackgHand];
        currentHand = 1;
    } else {
        if (currentHand == 1) {
            imaVBackgHand.image = [UIImage imageNamed:@"RightLeftHand.png"];
            [viewCamera addSubview:imaVBackgHand];
            currentHand = 2;
        } else {
            imaVBackgHand.image = [UIImage imageNamed:nil];
            [imaVBackgHand removeFromSuperview];
            currentHand = 0;
        }
    }
}

-(void)convertLeftHand
{
    if (currentHand != 3 || currentHand != 4) {
        imaVBackgHand.image = [UIImage imageNamed:@"LeftStraightHand.png"];
        [viewCamera addSubview:imaVBackgHand];
        currentHand = 3;
    } else {
        if (currentHand == 3) {
            imaVBackgHand.image = [UIImage imageNamed:@"RightStraightHand.png"];
            [viewCamera addSubview:imaVBackgHand];
            currentHand = 4;
        } else {
            imaVBackgHand.image = [UIImage imageNamed:nil];
            [imaVBackgHand removeFromSuperview];
            currentHand = 0;
        }
    }
}

-(void)controlCamera
{
    if (!isRecord) {
        [btnCamera setImage:[UIImage imageNamed:@"RecordPressed.png"] forState:UIControlStateNormal];
        viewTool.hidden = YES;
        isShowToolbox = NO;
        NSString *str = btnDelay.titleLabel.text;
        NSString *truncatedString = [str substringToIndex:[str length] - 1];
        countDown = [truncatedString integerValue];
        
        viewBlur = [[UIView alloc] init];
        viewBlur.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        viewBlur.backgroundColor = [UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f];
        [viewCamera addSubview:viewBlur];
        if (countDown > 0) {
            imaVCountDown = [[UIImageView alloc] init];
            imaVCountDown.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            [viewCamera addSubview:imaVCountDown];
            currentCountDown = countDown;
            countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                     target:self
                                                   selector:@selector(countDownDuration:)
                                                   userInfo:nil
                                                    repeats:YES];
        } else {
            [UIView animateWithDuration:0.9f delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                viewBlur.alpha = 0.8f;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.1f delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                    viewBlur.alpha = 0.0f;
                } completion:nil];
            }];
            [_CameraUI startVideoCapture];
            [self performSelector:@selector(delayDownloadInfo) withObject:nil afterDelay:1.0f];
        }
        
        
    } else {
        [btnCamera setImage:[UIImage imageNamed:@"Record.png"] forState:UIControlStateNormal];
        [recordTimer invalidate];
        recordTimer = nil;
        [_CameraUI stopVideoCapture];
        [lblTimer setTextColor:[UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f]];
        
        drawCus = [[DrawCustomShape alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        drawCus.backgroundColor = [UIColor clearColor];
        drawCus._MyStartPoint = CGPointMake(self.view.frame.size.width/2.0f, self.view.frame.size.height/2.0f);
        drawCus._MyEndPoint = CGPointMake(self.view.frame.size.width/2.0f, self.view.frame.size.height/2.0f);
        [self.view addSubview:drawCus];
        openingTimer = [NSTimer scheduledTimerWithTimeInterval:0.05f
                                                        target:self
                                                      selector:@selector(showTimer)
                                                      userInfo:nil
                                                       repeats:YES];
    }
    isRecord = !isRecord;
}

-(void)showTimer
{
    drawCus._MyEndPoint = CGPointMake(drawCus._MyEndPoint.x + 10.0f, drawCus._MyEndPoint.y + 10.0f);
    if (isSuccess) {
        [openingTimer invalidate];
        openingTimer = nil;
        [drawCus removeFromSuperview];
        isSuccess = NO;
    }
    [drawCus setNeedsDisplay];
}

-(void)countDownDuration:(NSTimer *)timer {
    switch (currentCountDown)
    {
        case 10:
        {
            if (imaVCountDown) {
                [imaVCountDown setImage:[UIImage imageNamed:@"10.png"]];
                imaVCountDown.alpha = 0;
                [UIView animateWithDuration:0.4f delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                    imaVCountDown.alpha = 1.0f;
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.4f delay:0.15f options:UIViewAnimationOptionTransitionNone animations:^{
                        imaVCountDown.alpha = 0.0f;
                    } completion:nil];
                }];

            }
        }
            break;
        case 9:
        {
            if (imaVCountDown != nil) {
                [imaVCountDown setImage:[UIImage imageNamed:@"09.png"]];
                imaVCountDown.alpha = 0;
                [UIView animateWithDuration:0.4f delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                    imaVCountDown.alpha = 1.0f;
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.4f delay:0.15f options:UIViewAnimationOptionTransitionNone animations:^{
                        imaVCountDown.alpha = 0.0f;
                    } completion:nil];
                }];

            }
        }
            break;
        case 8:
        {
            if (imaVCountDown) {
                [imaVCountDown setImage:[UIImage imageNamed:@"08.png"]];
                imaVCountDown.alpha = 0;
                [UIView animateWithDuration:0.4f delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                    imaVCountDown.alpha = 1.0f;
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.4f delay:0.15f options:UIViewAnimationOptionTransitionNone animations:^{
                        imaVCountDown.alpha = 0.0f;
                    } completion:nil];
                }];
            }
        }
            break;
        case 7:
        {
            if (imaVCountDown) {
                [imaVCountDown setImage:[UIImage imageNamed:@"07.png"]];
                imaVCountDown.alpha = 0;
                [UIView animateWithDuration:0.4f delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                    imaVCountDown.alpha = 1.0f;
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.4f delay:0.15f options:UIViewAnimationOptionTransitionNone animations:^{
                        imaVCountDown.alpha = 0.0f;
                    } completion:nil];
                }];

            }
        }
            break;
        case 6:
        {
            if (imaVCountDown) {
                [imaVCountDown setImage:[UIImage imageNamed:@"06.png"]];
                imaVCountDown.alpha = 0;
                [UIView animateWithDuration:0.4f delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                    imaVCountDown.alpha = 1.0f;
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.4f delay:0.15f options:UIViewAnimationOptionTransitionNone animations:^{
                        imaVCountDown.alpha = 0.0f;
                    } completion:nil];
                }];
            }
        }
            break;
        case 5:
        {
            if (imaVCountDown) {
                [imaVCountDown setImage:[UIImage imageNamed:@"05.png"]];
                imaVCountDown.alpha = 0;
                [UIView animateWithDuration:0.4f delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                    imaVCountDown.alpha = 1.0f;
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.4f delay:0.15f options:UIViewAnimationOptionTransitionNone animations:^{
                        imaVCountDown.alpha = 0.0f;
                    } completion:nil];
                }];
            }
        }
            break;
        case 4:
        {
            if (imaVCountDown) {
                [imaVCountDown setImage:[UIImage imageNamed:@"04.png"]];
                imaVCountDown.alpha = 0;
                [UIView animateWithDuration:0.4f delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                    imaVCountDown.alpha = 1.0f;
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.4f delay:0.15f options:UIViewAnimationOptionTransitionNone animations:^{
                        imaVCountDown.alpha = 0.0f;
                    } completion:nil];
                }];
            }
        }
            break;
        case 3:
        {
            if (imaVCountDown) {
                viewBlur.alpha = 0.9f;
                [imaVCountDown setImage:[UIImage imageNamed:@"03.png"]];
                imaVCountDown.alpha = 0;
                [UIView animateWithDuration:0.4f delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                    imaVCountDown.alpha = 1.0f;
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.4f delay:0.15f options:UIViewAnimationOptionTransitionNone animations:^{
                        imaVCountDown.alpha = 0.0f;
                    } completion:nil];
                }];
            }
        }
            break;
        case 2:
        {
            if (imaVCountDown) {
                viewBlur.alpha = 0.9f;
                [imaVCountDown setImage:[UIImage imageNamed:@"02.png"]];
                imaVCountDown.alpha = 0;
                [UIView animateWithDuration:0.4f delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                    imaVCountDown.alpha = 1.0f;
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.4f delay:0.15f options:UIViewAnimationOptionTransitionNone animations:^{
                        imaVCountDown.alpha = 0.0f;
                    } completion:nil];
                }];
            }
        }
            break;
        case 1:
        {
            if (imaVCountDown) {
                viewBlur.alpha = 0.9f;
                [UIView animateWithDuration:0.9f delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                    viewBlur.alpha = 0.8f;
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.1f delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                        viewBlur.alpha = 0.0f;
                    } completion:nil];
                }];
                
                [imaVCountDown setImage:[UIImage imageNamed:@"01.png"]];
                imaVCountDown.alpha = 0;
                [UIView animateWithDuration:0.4f delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                    imaVCountDown.alpha = 1.0f;
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.5f delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                        imaVCountDown.alpha = 0.0f;
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:0.1f delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                            [imaVCountDown setImage:nil];
                            [imaVCountDown removeFromSuperview];
                        } completion:nil];
                    }];
                }];
                
                
                [countDownTimer invalidate];
                countDownTimer = nil;
                [_CameraUI startVideoCapture];
                [self performSelector:@selector(delayDownloadInfo) withObject:nil afterDelay:1.0f];
                
            }
        }
            break;
        default:
        {
            if (imaVCountDown) {
                viewBlur.alpha = 0.9f;
                [UIView animateWithDuration:0.9f delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                    viewBlur.alpha = 0.8f;
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.1f delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                        viewBlur.alpha = 0.0f;
                    } completion:nil];
                }];
                [imaVCountDown setImage:[UIImage imageNamed:@"01.png"]];
                imaVCountDown.alpha = 0;
                [UIView animateWithDuration:0.4f delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                    imaVCountDown.alpha = 1.0f;
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.5f delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                        imaVCountDown.alpha = 0.0f;
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:0.1f delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                            [imaVCountDown setImage:nil];
                            [imaVCountDown removeFromSuperview];
                        } completion:nil];
                    }];
                }];
                
                
                [countDownTimer invalidate];
                countDownTimer = nil;
                [_CameraUI startVideoCapture];
                [self performSelector:@selector(delayDownloadInfo) withObject:nil afterDelay:1.0f];
            }
        }
            break;
    }
    currentCountDown--;
}

-(void)delayDownloadInfo
{
    startDate = [NSDate date];
    [lblTimer setTextColor:[UIColor redColor]];
    recordTimer = [[NSTimer alloc] init];
    recordTimer = [NSTimer scheduledTimerWithTimeInterval:0.05f
                                                   target:self
                                                 selector:@selector(updateTimer)
                                                 userInfo:nil
                                                  repeats:YES];
}

- (void)updateTimer
{
    // Create date from the elapsed time
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:startDate];
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    // Create a date formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"mm:ss.SS"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0f]];
    
    // Format the elapsed time and set it to the label
    NSString *timeString = [dateFormatter stringFromDate:timerDate];
    lblTimer.text = timeString;
    if ([switchAutoStop isOn]) {
        if ([timeString isEqualToString:@"00:05"]) {
            [_CameraUI stopVideoCapture];
            [lblTimer setTextColor:[UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f]];
            [recordTimer invalidate];
            recordTimer = nil;
        }
    }
}


-(void)backToCreateScreen
{
    if (!([recordSetting._Delay isEqualToString:[NSString stringWithFormat:@"%@", btnDelay.titleLabel.text]] && recordSetting._AutoStop == [switchAutoStop isOn] && recordSetting._AutoTrim == [switchAllowTrim isOn])) {
        [self updateInfoToRecordSetting];
    }
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [self dismissViewControllerAnimated:NO completion:nil];
    [_CoreGUI._Navi03 popViewControllerAnimated:YES];
}

- (void)controlSettingToolbox
{
    if (!isShowToolbox) {
        viewTool.frame = CGRectMake(10.0f, btnSetting.frame.origin.y + btnSetting.frame.size.height + 20.0f, self.view.frame.size.width - 20.0f, 120.0f);
        viewTool.alpha = 1.0f;
        viewTool.hidden = NO;
    } else {
        viewTool.hidden = YES;
    }
    isShowToolbox = !isShowToolbox;
}

- (void)chooseDelayTime
{
    viewBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0.8f*self.view.frame.size.height)];
    viewBackground.backgroundColor = [UIColor colorWithWhite:0.8f alpha:1.0f];
    
    viewTitle = [[UIView alloc] initWithFrame:CGRectMake(0, 0.0f, self.view.frame.size.width, 40.0f)];
    viewTitle.backgroundColor = [UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:0.95f];
    
    btnDone = [UIButton buttonWithType:UIButtonTypeCustom];
    btnDone.frame = CGRectMake(10.0f, 0, 70.0f, 40.0f);
    btnDone.backgroundColor = [UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f];
    [btnDone setTitle:@"Hoàn tất" forState:UIControlStateNormal];
    [btnDone addTarget:self action:@selector(selectedDelayTime) forControlEvents:UIControlEventTouchUpInside];
    
    for (int i = 0; i < [arrDelay count]; i++) {
        if ([recordSetting._Delay isEqualToString:(NSString*)[arrDelay objectAtIndex:i]]) {
            [pickerDelay selectRow:i inComponent:0 animated:YES];
        }
    }
    
    [pickerDelay setFrame:CGRectMake(viewBackground.frame.size.width/2.0f, viewBackground.frame.size.height/2.0f, 200.0f, 150.0f)];
    
    [viewTitle addSubview:btnDone];
    [viewBackground addSubview:viewTitle];
    [viewBackground addSubview:pickerDelay];
    [viewCamera addSubview:viewBackground];
    
    viewBackground.alpha = 0;
    viewBackground.center = CGPointMake(self.view.frame.size.width/2.0f, self.view.frame.size.height);
    [UIView beginAnimations:NULL context:nil];
    [UIView setAnimationDuration:1.0f];
    
    viewBackground.center = CGPointMake(self.view.frame.size.width/2.0f, self.view.frame.size.height - 100.0f);
    viewBackground.alpha = 0.98f;
    [UIView commitAnimations];
}

-(void)changeSwitch:(UISwitch*)sender
{
    if (sender.tag == 500) {
        if ([switchAutoStop isOn]) {
        } else {
            
        }
    } else {
        if ([switchAllowTrim isOn]) {
            
            
        } else {
            
        }
    }
}

-(void)selectedDelayTime
{
    [self updateInfoToRecordSetting];
    [btnDone removeFromSuperview];
    [pickerDelay removeFromSuperview];
    [viewBackground removeFromSuperview];
    viewBackground = nil;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
// ------Returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component
{
    return [arrDelay count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row  forComponent:(NSInteger)component
{
    return [arrDelay objectAtIndex:row];
    
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30.0f;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [btnDelay setTitle:[arrDelay objectAtIndex:row] forState:UIControlStateNormal];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 150.0f;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    
    UILabel *pickerLabel = (UILabel*)view;
    if (pickerLabel == nil) {
        [pickerLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:30.0f]];
        CGRect frame = CGRectMake(0, 0, 0, 0);
        pickerLabel = [[UILabel alloc] initWithFrame:frame];
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        
        [pickerLabel setText:[arrDelay objectAtIndex:row]];

    }
    //picker view array is the datasource
    
    return pickerLabel;
}

- (void)loadRecordSetting
{
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"RecordSetting.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath: path])
    {
        NSString *bundle = [[NSBundle mainBundle] pathForResource: @"RecordSetting" ofType: @"plist"];
        [fileManager copyItemAtPath:bundle toPath: path error:&error];
    }
    NSMutableArray *mountainsArray = [[[NSMutableArray alloc] initWithContentsOfFile:path] mutableCopy];
    
    int i = 0;
    int limit = (int)[mountainsArray count];
    while (i < limit)
    {
        NSDictionary *item = [mountainsArray objectAtIndex:i];
        
        RecordSetting *temp = [[RecordSetting alloc] init];
        temp._Delay = [item valueForKey:@"delay"];
        temp._AutoStop = [[item valueForKey:@"autostop"] boolValue];
        temp._AutoTrim = [[item valueForKey:@"autotrim"] boolValue];
        
        [arrRecordSetting addObject:temp];
        i++;
    }
}

- (void)updateInfoToRecordSetting
{
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"RecordSetting.plist"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath: path])
    {
        NSString *bundle = [[NSBundle mainBundle] pathForResource: @"RecordSetting" ofType: @"plist"];
        
        [fileManager copyItemAtPath:bundle toPath: path error:&error];
    }
    
    NSMutableArray *mountainsArray = [[[NSMutableArray alloc] initWithContentsOfFile:path]mutableCopy];
    
    for (int i = 0; i < [mountainsArray count]; i++) {
        NSMutableDictionary *dict = [mountainsArray objectAtIndex:i];
        
        if (btnDelay == nil || switchAllowTrim == nil || switchAutoStop == nil) {
            [dict setObject:recordSetting._Delay forKey:@"delay"];
            [dict setObject:[NSNumber numberWithBool:recordSetting._AutoStop] forKey:@"autostop"];
            [dict setObject:[NSNumber numberWithBool:recordSetting._AutoTrim] forKey:@"autotrim"];
        } else {
            [dict setObject:btnDelay.titleLabel.text forKey:@"delay"];
            [dict setObject:[NSNumber numberWithBool:[switchAutoStop isOn]] forKey:@"autostop"];
            [dict setObject:[NSNumber numberWithBool:[switchAllowTrim isOn]] forKey:@"autotrim"];
        }
        
        
        [mountainsArray replaceObjectAtIndex:i withObject:dict];
    }
    [mountainsArray writeToFile:path atomically:YES];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    [self dismissViewControllerAnimated:NO completion:nil];
    // Handle a movie capture
    if (CFStringCompare ((__bridge_retained CFStringRef) mediaType, kUTTypeMovie, 0) == kCFCompareEqualTo) {
        NSString *moviePath = (NSString*)[[info objectForKey:UIImagePickerControllerMediaURL] path];
        
        video._PathVideo = moviePath;
                
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(moviePath)) {
            UISaveVideoAtPathToSavedPhotosAlbum(moviePath, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
        }
        if (!([recordSetting._Delay isEqualToString:[NSString stringWithFormat:@"%@", btnDelay.titleLabel.text]] && recordSetting._AutoStop == [switchAutoStop isOn] && recordSetting._AutoTrim == [switchAllowTrim isOn])) {
            [self updateInfoToRecordSetting];
        }
        [_CoreGUI finishedCreateVideoVC:self withVideoInfo:video];
    }
}



-(void)video:(NSString*)videoPath didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo {
    isSuccess = YES;
    if (error)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Lỗi" message:@"Video không thể lưu!"
                                                       delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    if (!([recordSetting._Delay isEqualToString:[NSString stringWithFormat:@"%@", btnDelay.titleLabel.text]] && recordSetting._AutoStop == [switchAutoStop isOn] && recordSetting._AutoTrim == [switchAllowTrim isOn])) {
        [self updateInfoToRecordSetting];
    }
    [_CoreGUI finishedScreen:self withCode:22];
}


// For responding to the user tapping Cancel.
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    if (!([recordSetting._Delay isEqualToString:[NSString stringWithFormat:@"%@", btnDelay.titleLabel.text]] && recordSetting._AutoStop == [switchAutoStop isOn] && recordSetting._AutoTrim == [switchAllowTrim isOn])) {
        [self updateInfoToRecordSetting];
    }
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [self dismissViewControllerAnimated:YES completion:nil];
    [_CoreGUI finishedScreen:self withCode:120];
}

-(void)viewWillAppear:(BOOL)animated
{
    _CoreGUI._TabBar.tabBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    _CoreGUI._TabBar.tabBar.hidden = NO;
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
