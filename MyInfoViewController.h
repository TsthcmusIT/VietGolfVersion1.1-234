//
//  MyInfoViewController.h
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import <MobileCoreServices/UTCoreTypes.h>
#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>
#import <MobileCoreServices/MobileCoreServices.h>

#import "AbstractViewController.h"
#import "UserProfile.h"


@interface MyInfoViewController : AbstractViewController <UIScrollViewDelegate, UIImagePickerControllerDelegate>
{
    UIScrollView *_ScrollView;
    UILabel *lblLineTop;
    UIImageView *imaVAvatar;
    UIView *viewInfo;
    UILabel *lblTaiKhoan;
    UILabel *lblCity;
    UILabel *lblLoaiKH;
    UILabel *lblNumLike;
    UILabel *lblNumFavorties;
    UILabel *lblNumPublicVideo;
    UILabel *lblLike;
    UILabel *lblFavorties;
    UILabel *lblPublicVideo;
    UILabel *lblXepHang;
    UIButton *btnImage;
    UILabel *lblTitlePost;
    UILabel *lblTitleHelp;
    UIButton *btnTips;
    UIButton *btnGuide;
    UIButton *btnFeedback;
    UIButton *btnRefreshNoti;
    UILabel *lblNumber;
    
    NSMutableArray *mulArr;
    CGFloat _CircleRadius;
    CGPoint _CircleCenter;
    CAShapeLayer *_MaskLayer;
    CAShapeLayer *_CircleLayer;
    UIImagePickerController *_CameraUI;
    
    NSMutableArray *arrVideoPublic;
    UserProfile *_UserProM;
    BOOL flag;
    UIImageView *imvThumnail;
    BOOL _FlagUpdateInfo;
    
    
    // API
    NSMutableArray *arrNotiBefore;
    int currentId;
    NSMutableArray *arrNotification;
    int status;
    int video;
    int numUpdate;
    
}

@property (nonatomic, retain) UserProfile *_UserProM;
@property (nonatomic, retain) UIScrollView *_ScrollView;
@property (nonatomic) CGFloat _CircleRadius;
@property (nonatomic) CGPoint _CircleCenter;
@property (nonatomic, retain) CAShapeLayer *_MaskLayer;
@property (nonatomic, retain) CAShapeLayer *_CircleLayer;
@property (nonatomic, retain) UIImagePickerController *_CameraUI;
@property (nonatomic) BOOL _FlagUpdateInfo;


-(BOOL)startMediaBrowserFromViewController:(UIViewController*)controller usingDelegate:(id)delegate;
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;
-(void)myMovieFinishedCallback:(NSNotification*)aNotification;
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker;
-(void)loadPublicVideoRecent;
-(UIImage*)getThumnailFromVideoFromPath:(NSString*)path;
-(void)writeToNotificationDB;


@end
