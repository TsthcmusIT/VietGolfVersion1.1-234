//
//  AbstractViewController.h
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CoreGUIController;

typedef enum VeTinh
{
    SwingVideoScreen,
    DisplaySwingVideoScreen,
    CompareSwingVideo,
    ReviewSwingVideo,
    BeginScreen,
    LoginScreen,
    RegisterScreen,
    TrimVideoScreen,
    
    CommunityScreen,
    
    CreateVideoSwing,
    RecordScreen,
    ImportScreen,
    TrimAfterRecordScreen,
    CompleteCreateScreen,
    
    OptionScreen,
    ChooseCommunity,
    GoToWebScreen,
    HowToUseScreen,
    AboutGolfScreen,
    AboutVietGolfScreen,
    
    MyInfoScreen,
    EditMyInfoScreen,
    FeedbackScreen,
    NotificationScreen,
    DetailNotificationScreen,
    
} ScreenName;


@interface AbstractViewController : UIViewController
{
    CoreGUIController *_CoreGUI;
    ScreenName _ScreenName;
}

@property (nonatomic, retain) CoreGUIController *_CoreGUI;
@property (nonatomic) ScreenName _ScreenName;

// Methods
-(id)initWithCoreGUI:(CoreGUIController*)coreGUI;


@end
