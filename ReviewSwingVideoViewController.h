//
//  ReviewSwingVideoViewController.h
//  VietGolfVersion1.1
//
//  Created by admin on 8/19/14.
//  Copyright (c) 2014 NguyenDuyThanh. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

#import "AbstractViewController.h"
#import "SVideoInfo.h"

@interface ReviewSwingVideoViewController : AbstractViewController <MPMediaPickerControllerDelegate>
{
    SVideoInfo *_ReSVideo;
    AVPlayer *playerSVideo;
    AVPlayerLayer *layerSVideo;
    
    MPMoviePlayerController *playerMP;
    BOOL isNormalMode;
}

@property (nonatomic, retain) SVideoInfo *_ReSVideo;

@end
