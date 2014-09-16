//
//  TrimAfterRecordViewController.m
//  VietGolfVersion1.1
//
//  Created by admin on 9/12/14.
//  Copyright (c) 2014 NguyenDuyThanh. All rights reserved.
//

#import "TrimAfterRecordViewController.h"
#import "CoreGUIController.h"

@interface TrimAfterRecordViewController ()

@end

@implementation TrimAfterRecordViewController

@synthesize _SVideoTAR;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Chia đoạn";
    self._ScreenName = TrimAfterRecordScreen;
    arrFrames = [[NSMutableArray alloc] init];
    arrFramesSelected = [[NSMutableArray alloc] init];
    self.view.backgroundColor = [UIColor clearColor];
    
    btnSkip = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnSkip setFrame:CGRectMake(0, 0, 80.0f, 40.0f)];
    [btnSkip setTitle:@"Bỏ qua" forState:UIControlStateNormal];
    [btnSkip addTarget:self action:@selector(skipTrimVideo) forControlEvents:UIControlEventTouchDown];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnSkip];
    
    btnTrim = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnTrim setFrame:CGRectMake(0, 0, 80.0f, 40.0f)];
    [btnTrim setTitle:@"Chọn" forState:UIControlStateNormal];
    [btnTrim addTarget:self action:@selector(trimVideo) forControlEvents:UIControlEventTouchDown];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnTrim];
    [self.navigationItem.rightBarButtonItem setEnabled:NO];
    
    assetSV = [AVAsset assetWithURL:[[NSURL alloc] initFileURLWithPath:_SVideoTAR._PathVideo]];
    durationSV =  CMTimeGetSeconds(assetSV.duration);
    if (durationSV < 5.0f) {
        numframes = (durationSV + 0.5f)/0.5f;
    } else {
        numframes = (durationSV + 0.5f)/0.8f;
    }
    frameSize = CGSizeMake((self.view.frame.size.width - 45.0f)/4.0f, (self.view.frame.size.width - 45.0f)/4.0f);
    
    imaVBackgScreen = [[UIImageView alloc] init];
    imaVBackgScreen.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    imaVBackgScreen.image = [UIImage imageNamed:@"BackgRecordScreen.png"];
    [self.view addSubview:imaVBackgScreen];
    
    // -- Banner
    viewBanner = [[UIView alloc] init];
    viewBanner.frame = CGRectMake(0, self.navigationController.navigationBar.frame.size.height + 20.0f, self.view.frame.size.width, 40.0f);
    viewBanner.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:viewBanner];
    
    imaViewTouch = [[UIImageView alloc] init];
    imaViewTouch.frame = CGRectMake(0, 0, viewBanner.frame.size.height, viewBanner.frame.size.height);
    imaViewTouch.image = [UIImage imageNamed:@""];
    [viewBanner addSubview:imaViewTouch];
    
    lblTitle = [[UILabel alloc] init];
    lblTitle.frame = CGRectMake(imaViewTouch.frame.origin.x + imaViewTouch.frame.size.width, 0, viewBanner.frame.size.width - imaViewTouch.frame.size.width, viewBanner.frame.size.height);
    lblTitle.text = @"Chọn khung video bắt đầu";
    lblTitle.textAlignment = NSTextAlignmentCenter;
    [lblTitle setTextColor:[UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f]];
    [lblTitle setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f]];
    [viewBanner addSubview:lblTitle];
    
    lblSuggest = [[UILabel alloc] init];
    lblSuggest.frame = CGRectMake(0, self.view.frame.size.height - 30.0f, self.view.frame.size.width, 30.0f);
    lblSuggest.text = @"CHỌN BẤT KỲ KHUNG VIDEO NÀO";
    lblSuggest.backgroundColor = [UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f];
    lblSuggest.textAlignment = NSTextAlignmentCenter;
    [lblSuggest setTextColor:[UIColor whiteColor]];
    [lblSuggest setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15.0f]];
    [self.view addSubview:lblSuggest];
    
    scrollVBackg = [[UIScrollView alloc] init];
    scrollVBackg.frame = CGRectMake(0, viewBanner.frame.origin.y + viewBanner.frame.size.height, self.view.frame.size.width, lblSuggest.frame.origin.y - (viewBanner.frame.origin.y + viewBanner.frame.size.height));
    scrollVBackg.contentSize = CGSizeMake(self.view.frame.size.width, (numframes/4.0f + 1)*(frameSize.height + 5.0f));
    scrollVBackg.backgroundColor = [UIColor clearColor];
    [self.view addSubview:scrollVBackg];
    
    int numRows = numframes/4 + 1;
    CGPoint pointPad = CGPointMake(15.0f, 0);
    for (int i = 0; i < numRows; i++) {
        for (int j = 0; j < 4; j++) {
            UIButton *btnItem = [UIButton buttonWithType:UIButtonTypeCustom];
            btnItem.frame = CGRectMake(pointPad.x, pointPad.y, frameSize.width, frameSize.height);
            [btnItem setBackgroundImage:[self getThumnailAtFrameIndex:i*4 + j] forState:UIControlStateNormal];
            [btnItem addTarget:self action:@selector(chooseFrame:) forControlEvents:UIControlEventTouchUpInside];
            btnItem.tag = i*4 + j;
            [scrollVBackg addSubview:btnItem];
            [arrFrames addObject:btnItem];
            
            UIView *lineTop = [[UIView alloc] init];
            lineTop.frame = CGRectMake(0, 0, frameSize.width, 3.0f);
            lineTop.backgroundColor = [UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f];
            [btnItem addSubview:lineTop];
            
            UIView *lineBot = [[UIView alloc] init];
            lineBot.frame = CGRectMake(0, frameSize.height - 3.0f, frameSize.width, 3.0f);
            lineBot.backgroundColor = [UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f];
            [btnItem addSubview:lineBot];
            
            pointPad.x += frameSize.width + 5.0f;
            if (i*4 + j > numframes - 1) {
                break;
            }
        }
        
        
        pointPad.x = 15.0f;
        pointPad.y += frameSize.height + 5.0f;
    }
}

-(void)chooseFrame:(UIButton*)sender
{
    if ([arrFramesSelected count] >= 2) {
        if (sender.tag == [[arrFramesSelected objectAtIndex:0] integerValue]) {
            for (int z = sender.tag; z <= [[arrFramesSelected objectAtIndex:1] integerValue]; z++) {
                [((UIButton*)[arrFrames objectAtIndex:z]) setImage:nil forState:UIControlStateNormal];
            }
            [arrFramesSelected removeAllObjects];
            self.navigationItem.rightBarButtonItem.enabled = NO;
        }
    } else {
        if ([arrFramesSelected count] == 0) {
            [arrFramesSelected addObject:[NSNumber numberWithInteger:sender.tag]];
            [sender setImage:[UIImage imageNamed:@"FrameSelected.png"] forState:UIControlStateNormal];
        } else {
            if ([arrFramesSelected count] == 1) {
                if (sender.tag == [[arrFramesSelected objectAtIndex:0] integerValue]) {
                    [sender setImage:nil forState:UIControlStateNormal];
                    [arrFramesSelected removeAllObjects];
                } else {
                    if (sender.tag < [[arrFramesSelected objectAtIndex:0] integerValue]) {
                        [sender setImage:[UIImage imageNamed:@"StartFrameDelete.png"] forState:UIControlStateNormal];
                        [((UIButton*)[arrFrames objectAtIndex:[[arrFramesSelected objectAtIndex:0] integerValue]]) setImage:[UIImage imageNamed:@"EndFrameSelected.png"] forState:UIControlStateNormal];
                        startFrame = sender.tag;
                        endFrame = ((UIButton*)[arrFrames objectAtIndex:[[arrFramesSelected objectAtIndex:0] integerValue]]).tag;
                        
                        for (int i = sender.tag + 1; i < [[arrFramesSelected objectAtIndex:0] integerValue]; i++) {
                            [((UIButton*)[arrFrames objectAtIndex:i]) setImage:[UIImage imageNamed:@"FrameSelected.png"] forState:UIControlStateNormal];
                        }
                        [arrFramesSelected insertObject:[NSNumber numberWithInteger:sender.tag] atIndex:0];
                    } else {
                        [sender setImage:[UIImage imageNamed:@"EndFrameSelected.png"] forState:UIControlStateNormal];
                        [((UIButton*)[arrFrames objectAtIndex:[[arrFramesSelected objectAtIndex:0] integerValue]]) setImage:[UIImage imageNamed:@"StartFrameDelete.png"] forState:UIControlStateNormal];
                        startFrame = ((UIButton*)[arrFrames objectAtIndex:[[arrFramesSelected objectAtIndex:0] integerValue]]).tag;
                        endFrame = sender.tag;
                        for (int i = [[arrFramesSelected objectAtIndex:0] integerValue] + 1; i < sender.tag; i++) {
                            [((UIButton*)[arrFrames objectAtIndex:i]) setImage:[UIImage imageNamed:@"FrameSelected.png"] forState:UIControlStateNormal];
                            
                        }
                        [arrFramesSelected addObject:[NSNumber numberWithInteger:sender.tag]];
                    }
                }
                self.navigationItem.rightBarButtonItem.enabled = YES;
                
            }
        }
    }
}

-(void)skipTrimVideo
{
    [_CoreGUI finishedScreen:self withCode:23];
}


-(UIImage*)getThumnailAtFrameIndex:(int)index
{
    AVAssetImageGenerator *generateImg = [[AVAssetImageGenerator alloc] initWithAsset:assetSV];
    generateImg.appliesPreferredTrackTransform = YES;
    NSError *error = NULL;
    CMTime time = CMTimeMake(index*(durationSV/numframes), 1);
    CGImageRef refImg = [generateImg copyCGImageAtTime:time actualTime:NULL error:&error];
    UIImage *FrameImage= [[UIImage alloc] initWithCGImage:refImg];
    return FrameImage;
}

-(void)trimVideo
{
    videoStartTime = (startFrame*durationSV)/numframes;
    videoEndTime = ((endFrame + 1)*durationSV)/numframes;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd_HH-mm-ss"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *libraryCachesDirectory = [paths objectAtIndex:0];
    NSString *stringAppend = [NSString stringWithFormat:@"/Trim_%@s.mov", [dateFormatter stringFromDate:[NSDate date]]];
    NSString *OutputFilePath = [libraryCachesDirectory stringByAppendingPathComponent:stringAppend];
    NSURL *videoFileOutput = [NSURL fileURLWithPath:OutputFilePath];
    
    AVAssetExportSession *exportSession = [AVAssetExportSession exportSessionWithAsset:assetSV
                                                                            presetName:AVAssetExportPresetHighestQuality];
    if (exportSession == nil)
    {
        UIAlertView *alertInvalidEmail = [[UIAlertView alloc] initWithTitle:@"Lỗi" message:@"Rất tiếc! Thực hiện chia đoạn thất bại!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertInvalidEmail show];
    } else {
        CMTime startTime = CMTimeMake((int)(floor(videoStartTime * 100)), 100);
        CMTime stopTime = CMTimeMake((int)(ceil(videoEndTime * 100)), 100);
        CMTimeRange exportTimeRange = CMTimeRangeFromTimeToTime(startTime, stopTime);
        
        exportSession.outputURL = videoFileOutput;
        exportSession.timeRange = exportTimeRange;
        exportSession.outputFileType = AVFileTypeQuickTimeMovie;
        
        [exportSession exportAsynchronouslyWithCompletionHandler:^
         {
             if (AVAssetExportSessionStatusCompleted == exportSession.status)
             {
                 NSURL *videoFileInput = [[NSURL alloc] initFileURLWithPath:_SVideoTAR._PathVideo];
                 NSFileManager *fileManager = [NSFileManager defaultManager];
                 NSError *error;
                 BOOL isRemove = [fileManager removeItemAtURL:videoFileInput error:&error];
                 NSLog(@"Success: %d", isRemove);
                 if (error == nil) {
                     [[NSFileManager defaultManager] removeItemAtURL:videoFileInput error:NULL];
                 }
                 _SVideoTAR._PathVideo = OutputFilePath;
                 [_CoreGUI finishedCreateVideoVC:self withVideoInfo:_SVideoTAR];
                 [_CoreGUI finishedScreen:self withCode:23];
             }
             else if (AVAssetExportSessionStatusFailed == exportSession.status)
             {
                 UIAlertView *alertInvalidEmail = [[UIAlertView alloc] initWithTitle:@"Lỗi" message:@"Rất tiếc! Thực hiện chia đoạn thất bại!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                 [alertInvalidEmail show];
                 [_CoreGUI finishedScreen:self withCode:23];
             }
         }];
        while(exportSession.progress != 1.0){
            NSLog(@"loading... : %f",exportSession.progress);
            //sleep(1);
        }
        
    }
}


-(void)viewWillAppear:(BOOL)animated
{
    _CoreGUI._TabBar.tabBar.hidden = YES;
    self.navigationController.navigationBarHidden = NO;
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
