//
//  LoginViewController.h
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import "AbstractViewController.h"
#import "UserProfile.h"

@interface LoginViewController : AbstractViewController <UITextFieldDelegate>
{
    UIImageView *backgroundV;
    UITextField *_TxtFEmail;
    UITextField *_TxtFPassword;
    UIButton *btnLogin;
    UIButton *btnRegister;
    
    NSMutableArray *listUserProL;
    UserProfile *userProL;
    
    UIView *viewProcess;
    UIActivityIndicatorView *spinner;
}

@property (nonatomic, retain) UITextField *_TxtFEmail;
@property (nonatomic, retain) UITextField *_TxtFPassword;

@end
