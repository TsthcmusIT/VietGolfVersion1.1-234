//
//  OptionViewController.h
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import "AbstractViewController.h"
#import <MessageUI/MessageUI.h>

@interface OptionViewController : AbstractViewController <MFMailComposeViewControllerDelegate>
{
    UIImageView *imaViewHead;
    UIImageView *imaViewHead2;
    UIImageView *imaViewHead3;
    UIImageView *imaViewMiddle;
    UIImageView *imaViewBottom;
    UIButton *btnShareApp;
    UIButton *btnAboutApp;
    UIButton *btnAboutGolf;
    UIButton *btnHowToUse;
    UIButton *btnGoToWeb;
    
    MFMailComposeViewController *composer;
}

@end
