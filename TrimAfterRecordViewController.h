//
//  TrimAfterRecordViewController.h
//  VietGolfVersion1.1
//
//  Created by admin on 9/12/14.
//  Copyright (c) 2014 NguyenDuyThanh. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>

#import "AbstractViewController.h"
#import "SVideoInfo.h"

@interface TrimAfterRecordViewController : AbstractViewController <UIScrollViewDelegate>
{
    SVideoInfo *_SVideoTAR;
    NSMutableArray *arrFrames;
    NSMutableArray *arrFramesSelected;
    AVAsset *assetSV;
    UIScrollView *scrollVBackg;
    UIImageView *imaVBackgScreen;
    UIButton *btnTrim;
    UIButton *btnSkip;
    UIImageView *imaViewTouch;
    UIView *viewBanner;
    UILabel *lblTitle;
    UILabel *lblSuggest;
    
    CGSize frameSize;
    int startFrame;
    int endFrame;
    int numframes;
    float videoStartTime; // Define start time of video
    float videoEndTime; // Define end time of video
    float durationSV;
    
    NSTimer *playingTimer;
}

@property (nonatomic, retain) SVideoInfo *_SVideoTAR;

-(UIImage*)getThumnailAtFrameIndex:(int)index;

@end


