//
//  ChooseCommunityViewController.h
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <Social/Social.h>
#import <MessageUI/MessageUI.h>
#import <CoreGraphics/CoreGraphics.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

#import "AbstractViewController.h"
#import "CFShareCircleView.h"
#define SET_SHADOW_PATHS YES


@interface ChooseCommunityViewController : AbstractViewController <CFShareCircleViewDelegate, MFMailComposeViewControllerDelegate>
{
    BOOL _IsViewShowing;
    UIAlertView *alert;
    MFMailComposeViewController *mailComposer;
    CFShareCircleView *_ShareCircleView;
}

@property (nonatomic,assign) BOOL isViewShowing;
@property (nonatomic, strong) CFShareCircleView *shareCircleView;

@end
