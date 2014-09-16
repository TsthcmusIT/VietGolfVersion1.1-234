//
//  CommunityViewController.h
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//
#import <iAd/iAd.h>

#import "AbstractViewController.h"
#import "CommunityViewController.h"
#import "ItemSVideoView.h"
#import "SVideoInCommunity.h"
#import "DAProgressOverlayView.h"

@interface CommunityViewController : AbstractViewController <UIScrollViewDelegate, UITextViewDelegate, ADBannerViewDelegate>
{
    NSMutableArray *arrSVideo;
    NSMutableArray *arrItems;
    UIScrollView *_ScrollView;
    NSNumber *fileSize;
    DAProgressOverlayView *progressOverlayView;
    
    UIView *viewBackground;
    UIView *viewTitle;
    UIButton *btnDone;
    UIButton *btnCancle;
    UITextView *txtVContent;
    UIButton *btnMore;
    
    int numItemsDisplay;
    CGPoint pointPad;
    
    int id_videocomment;
    int id_videodownload;
    int recordSelected;
    
    // Download
    NSMutableData *_ReceivedData;
    NSURLConnection *_Connection;
    UIView *viewProcess;
    UIActivityIndicatorView *spinner;
    SVideoInCommunity *sVPosted;
    
    // iAd
    ADBannerView *adView;
    BOOL bannerIsVisible;
}

// -- Download
@property (retain, nonatomic) NSURLConnection *_Connection;
@property (retain, nonatomic) NSMutableData *_ReceivedData;
// -- iAd
@property (nonatomic, assign) BOOL bannerIsVisible;

-(void)loadItemViewFromIndex:(int)indexA toIndex:(int)indexB;
-(void)downloadVideoAndWriteToVideoWithInfo;
-(void)showMessView;

@end


