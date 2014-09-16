//
//  RegisterViewController.h
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import "AbstractViewController.h"

@interface RegisterViewController : AbstractViewController <UITextFieldDelegate, UIScrollViewDelegate, UIAlertViewDelegate>
{
    UIImageView *backgroundV;
    UITextField *txtFEmail;
    UITextField *txtFUserName;
    UITextField *txtFPassword;
    UITextField *txtFRePassword;
    UIButton *btnRegister;
    
    UIScrollView *_ScrollView;
    
    NSCharacterSet *stringTest;
    //
    UIView *viewProcess;
    UIActivityIndicatorView *spinner;
    
}

-(BOOL)validEmail:(NSString*) emailString;
-(BOOL)checkUserName:(NSString*)userName;
-(BOOL)checkPassword:(NSString*)password;
-(BOOL)checkRe_Password:(NSString*)re_password;


@end
