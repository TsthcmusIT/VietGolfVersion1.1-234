//
//  DetailNotificationViewController.h
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import "AbstractViewController.h"
#import "GoToWebViewController.h"
#import "Notification.h"

@class CoreGUIViewController;

@interface DetailNotificationViewController : AbstractViewController
{
    Notification *_NotificationD;
    
    UILabel *lblTitle;
    UILabel *lblDate;
    UIButton *btnLink;
    UILabel *lblPS;
    
    int _CurrentRow;
}

@property (nonatomic, retain) Notification *_NotificationD;
@property (nonatomic) int _CurrentRow;

-(void)updateIntoNotificationDB;
@end
