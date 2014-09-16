//
//  SwingVideoTableViewController.h
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <MediaPlayer/MediaPlayer.h>

#import "CommunityViewController.h"
#import "MSCMoreOptionTableViewCell.h"
#import "SVideoInfo.h"
#import "UserProfile.h"

@class CoreGUIController;

@interface SwingVideoTableViewController : UITableViewController<MSCMoreOptionTableViewCellDelegate, UINavigationControllerDelegate, UIAlertViewDelegate, UIActionSheetDelegate, MPMediaPickerControllerDelegate, UITextFieldDelegate>
{
    CoreGUIController *_CoreGUI;
    
    NSMutableArray *listVideo;
    NSMutableArray *listUser;
    NSMutableArray *listCell;
    NSMutableArray *listView;
    SVideoInfo *_Video;
    UserProfile *userProfile;
    
    CAShapeLayer *_CircleLayer;
    CAShapeLayer *_MaskLayer;
    CGPoint _CircleCenter;
    UIActivityIndicatorView *spinner;
    
    int _CircleRadius;
    int _CurrentRow;
    BOOL _FlagUpdate;
    BOOL _FlagEdit;
    int numRows;
    BOOL _IsMaster;
    BOOL isFavorited;
    int countIndex0;
    
    UIView *viewProcess;
    UIView *viewTags;
    UIButton *btnTagUser;
    UIButton *btnTagSystem;
    
    // Update SVideo
    UILabel *lblOwner;
    UILabel *lblGolfTree;
    UIView *viewBackground;
    UIView *viewTitle;
    UIButton *btnDone;
    UIButton *btnSave;
    UITextField *txtFOwner;
    NSMutableArray *arrGolfTree;
    SVideoInfo *sVideoUpdateInfo;
    
    int checkSuccessUpdate;
    BOOL checkUpdateMaster;
}

@property (nonatomic, retain) CoreGUIController *_CoreGUI;
@property (nonatomic, retain) SVideoInfo *_Video;
@property (nonatomic) int _CurrentRow;
@property (nonatomic) BOOL _FlagUpdate;
@property (nonatomic) BOOL _FlagEdit;
@property (nonatomic) BOOL _IsMaster;


-(id)initWithCoreGUI:(CoreGUIController *)coreGUI style:(UITableViewStyle) style;
-(void)updateInfoToDatabase;
-(UIImage*)getThumnailFromVideoFromPath:(NSString*)path;
-(void)showViewUpload;
-(void)showViewUpdateInfoSVideo;
-(void)updateSVideoToDB;

@end





