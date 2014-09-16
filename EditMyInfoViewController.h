//
//  EditMyInfoViewController.h
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/UTCoreTypes.h>

#import "AbstractViewController.h"
#import "UserProfile.h"

@interface EditMyInfoViewController : AbstractViewController <UIScrollViewDelegate, UIPickerViewDataSource,UIPickerViewDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate>
{
    UIScrollView *_ScrollView;
    UITextField *_TxtFFullName;
    UITextField *_TxtFPassword;
    UIPickerView *_PicVGioiTinh;
    UIPickerView *_PicVCountry;
    UIDatePicker *_PicVBirth;
    UITextField *_TxtFCityName;
    NSMutableArray *genderArray;
    NSMutableArray *countryArray;
    UserProfile *_UserProE;
    
    UILabel *lblEditMyInfo;
    UILabel *lblFullName;
    UILabel *lblPassword;
    UILabel *lblEmail;
    UILabel *lblAccountEmail;
    UILabel *lblGioiTinh;
    UIButton *btnGender;
    UILabel *lblBirth;
    UIButton *btnBirth;
    UILabel *lblCountry;
    UIButton *btnCountry;
    UILabel *lblCity;
    UILabel *lblEditNotifications;
    UILabel *lblMess;
    UISwitch *swiMess;
    UILabel *lblUpdate;
    UISwitch *swiUpdate;
    
    UIView *viewBackground;
    UIView *viewTitle;
    UIButton *btnDone;
    
    int count;
}


@property (nonatomic, retain) UserProfile *_UserProE;
@property (nonatomic, retain) UIScrollView *_ScrollView;
@property (nonatomic, retain) UIPickerView *_PicVGioiTinh;
@property (nonatomic, retain) UIDatePicker *_PicVBirth;
@property (nonatomic, retain) UIPickerView *_PicVCountry;
@property (nonatomic, retain) UITextField *_TxtFPassword;



@end
