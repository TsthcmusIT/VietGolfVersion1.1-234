//
//  RegisterViewController.m
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import "RegisterViewController.h"
#import "CoreGUIController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"Đăng ký";
    self.title = @"Đăng ký";
    _ScreenName = RegisterScreen;
    
    _ScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _ScrollView.contentSize = CGSizeMake(self.view.frame.size.width, 550.0f);
    _ScrollView.backgroundColor = [UIColor colorWithRed:56.0f/255.0f green:56.0f/255.0f blue:56.0f/255.0f alpha:1.0f];
    [_ScrollView setContentOffset:CGPointMake(0, 10.0f) animated:YES];
    _ScrollView.minimumZoomScale = 0.5f;
    _ScrollView.maximumZoomScale = 2.0f;
    _ScrollView.delegate = self;
    
    if ([[UIScreen mainScreen] bounds].size.height >= 568.0f) {
        backgroundV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Register4InchesScreen.png"]];
        backgroundV.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        
        txtFEmail = [[UITextField alloc] initWithFrame:CGRectMake(40.0f, 140.0f, 240.0f, 45.0f)];
        txtFEmail.delegate = self;
        txtFEmail.tag = 10;
        txtFEmail.keyboardType = UIKeyboardTypeEmailAddress;
        txtFEmail.autocapitalizationType = UITextAutocapitalizationTypeNone;
        txtFEmail.placeholder = @"Email";
        [txtFEmail setBorderStyle:UITextBorderStyleRoundedRect];
        
        txtFUserName = [[UITextField alloc] initWithFrame:CGRectMake(40.0f, txtFEmail.frame.origin.y + txtFEmail.frame.size.height + 15.0f, 240.0f, 45.0f)];
        txtFUserName.delegate = self;
        txtFUserName.tag = 11;
        txtFUserName.placeholder = @"Tên tài khoản";
        [txtFUserName setBorderStyle:UITextBorderStyleRoundedRect];
        
        txtFPassword = [[UITextField alloc] initWithFrame:CGRectMake(40.0f, txtFUserName.frame.origin.y + txtFUserName.frame.size.height + 15.0f, 240.0f, 45.0f)];
        txtFPassword.delegate = self;
        txtFPassword.tag = 12;
        txtFPassword.secureTextEntry = YES;
        txtFPassword.placeholder = @"Mật khẩu";
        [txtFPassword setBorderStyle:UITextBorderStyleRoundedRect];
        
        txtFRePassword = [[UITextField alloc] initWithFrame:CGRectMake(40.0f, txtFPassword.frame.origin.y + txtFPassword.frame.size.height + 15.0f, 240.0f, 45.0f)];
        txtFRePassword.delegate = self;
        txtFRePassword.tag = 13;
        txtFRePassword.secureTextEntry = YES;
        txtFRePassword.placeholder = @"Xác nhận mật khẩu";
        [txtFRePassword setBorderStyle:UITextBorderStyleRoundedRect];
        
        btnRegister = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btnRegister.frame = CGRectMake(85.0f, 410.0f, 150.0f, 40.0f);
        btnRegister.layer.cornerRadius = 8.0f;
        btnRegister.clipsToBounds = YES;
        [btnRegister setBackgroundImage:[UIImage imageNamed:@"CreateAccount.png"] forState:UIControlStateNormal];
        [btnRegister addTarget:self action:@selector(create_VietGolfAccount) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        backgroundV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"RegisterScreen.png"]];
        backgroundV.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        
        txtFEmail = [[UITextField alloc] initWithFrame:CGRectMake(40.0f, 125.0f, 240.0f, 38.0f)];
        txtFEmail.delegate = self;
        txtFEmail.tag = 10;
        txtFEmail.keyboardType = UIKeyboardTypeEmailAddress;
        txtFEmail.autocapitalizationType = UITextAutocapitalizationTypeNone;
        txtFEmail.placeholder = @"Email";
        [txtFEmail setBorderStyle:UITextBorderStyleRoundedRect];
        
        txtFUserName = [[UITextField alloc] initWithFrame:CGRectMake(40.0f, txtFEmail.frame.origin.y + txtFEmail.frame.size.height + 7.0f, 240.0f, 38.0f)];
        txtFUserName.delegate = self;
        txtFUserName.tag = 11;
        txtFUserName.placeholder = @"Tên tài khoản";
        [txtFUserName setBorderStyle:UITextBorderStyleRoundedRect];
        
        txtFPassword = [[UITextField alloc] initWithFrame:CGRectMake(40.0f, txtFUserName.frame.origin.y + txtFUserName.frame.size.height + 7.0f, 240.0f, 38.0f)];
        txtFPassword.delegate = self;
        txtFPassword.tag = 12;
        txtFPassword.secureTextEntry = YES;
        txtFPassword.placeholder = @"Mật khẩu";
        [txtFPassword setBorderStyle:UITextBorderStyleRoundedRect];
        
        txtFRePassword = [[UITextField alloc] initWithFrame:CGRectMake(40.0f, txtFPassword.frame.origin.y + txtFPassword.frame.size.height + 7.0f, 240, 38.0f)];
        txtFRePassword.delegate = self;
        txtFRePassword.tag = 13;
        txtFRePassword.secureTextEntry = YES;
        txtFRePassword.placeholder = @"Xác nhận mật khẩu";
        [txtFRePassword setBorderStyle:UITextBorderStyleRoundedRect];
        
        btnRegister = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btnRegister.frame = CGRectMake(85.0f, 330.0f, 150.0f, 38.0f);
        btnRegister.layer.cornerRadius = 8.0f;
        btnRegister.clipsToBounds = YES;
        [btnRegister setBackgroundImage:[UIImage imageNamed:@"CreateAccount35.png"] forState:UIControlStateNormal];
        [btnRegister addTarget:self action:@selector(create_VietGolfAccount) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [_ScrollView addSubview:backgroundV];
    [_ScrollView addSubview:txtFEmail];
    [_ScrollView addSubview:txtFUserName];
    [_ScrollView addSubview:txtFPassword];
    [_ScrollView addSubview:txtFRePassword];
    [_ScrollView addSubview:btnRegister];
    [self.view addSubview:_ScrollView];
    
    // Back
    UIButton *btnBack = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 75.0f, 25.0f)];
    [btnBack setBackgroundImage:[UIImage imageNamed:@"BackButtonBarItem.png"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnBack];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    
    //
    stringTest = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_"];
    stringTest = [stringTest invertedSet];
    
}

-(void)popBack
{
    [_CoreGUI._Navi popViewControllerAnimated:YES];
}

-(void)create_VietGolfAccount
{
    [txtFEmail resignFirstResponder];
    [txtFUserName resignFirstResponder];
    [txtFPassword resignFirstResponder];
    [txtFRePassword resignFirstResponder];
    
    if ([self checkUserName:txtFUserName.text] && [self checkPassword:txtFPassword.text] && [self checkRe_Password:txtFRePassword.text] && [self validEmail:txtFEmail.text]) {
        
        viewProcess = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        viewProcess.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:0.6f];
        spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        spinner.center = CGPointMake((self.view.frame.size.width)/2.0f, (self.view.frame.size.height)/2.0f);
        spinner.transform = CGAffineTransformMakeScale(2.0f, 2.0f);
        [viewProcess addSubview:spinner];
        [self.view addSubview:viewProcess];
        [spinner startAnimating];
        _CoreGUI._UserProfile._FullName = txtFUserName.text;
        _CoreGUI._UserProfile._Password = txtFPassword.text;
        _CoreGUI._UserProfile._Email = txtFEmail.text;
        _CoreGUI._CheckStatus = [_CoreGUI requireStatusRegister];
        [self performSelector:@selector(delayProcessInfo) withObject:nil afterDelay:2.0f];
        
        if (_CoreGUI._CheckStatus == 0) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Cảnh báo" message:@"Đăng ký thất bại! Email này đã tồn tại!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alertView show];

        }
        else {
            if (_CoreGUI._CheckStatus == -2) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Lỗi" message:@"Bạn cần kết nối Internet!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alertView show];

            } else {
                
                [_ScrollView setContentOffset:CGPointMake(0, 44.0f) animated:YES];
                [_CoreGUI updateUserProfileWithCode:0];
                [_CoreGUI cleanSVideosOfUserDB];
                [_CoreGUI cleanSVideosOfMasterDB];
                
            }
        }
    }
    else
    {
        if ([txtFEmail.text isEqualToString:@""] || ![self validEmail:txtFEmail.text])
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Cảnh báo" message:@"Địa chỉ email không hợp lệ!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alertView show];
        } else {
            if ([txtFUserName.text isEqualToString:@""] || ![self checkUserName:txtFUserName.text]) {
                // Check user name invalid
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Cảnh báo" message:@"Tên tài khoản phải từ 6 - 31 ký tự, không được sử dụng ký tự đặc biệt!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alertView show];
                
            }
            else {
                // Check password invalid
                if ([txtFPassword.text isEqualToString:@""] || ![self checkPassword:txtFPassword.text]) {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Cảnh báo" message:@"Mật khẩu phải từ 6 - 31 ký tự, không được sử dụng dấu Tiếng Việt và ký tự đặc biệt!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    [alertView show];
                    
                }
                else {
                    // Check re-password
                    
                    if ([txtFPassword.text isEqualToString:@""] || [txtFRePassword.text isEqualToString:@""] || ![self checkRe_Password:txtFRePassword.text])
                    {
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Cảnh báo" message:@"Xác nhận mật khẩu không đúng!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                        [alertView show];
                    }
                    
                }
            }
        }
    }
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    // The user clicked OK
    [_CoreGUI._Navi popViewControllerAnimated:YES];

}

-(void)delayProcessInfo
{
    if (_CoreGUI._CheckStatus == 0 || _CoreGUI._CheckStatus == -2) {
        [spinner stopAnimating];
        [spinner removeFromSuperview];
        [viewProcess removeFromSuperview];
    } else {
        [spinner stopAnimating];
        [spinner removeFromSuperview];
        [viewProcess removeFromSuperview];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Đăng ký thành công! Đăng nhập ngay để kết nối ứng dụng ngay bây bây giờ!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
    }
}

-(BOOL)validEmail:(NSString*) emailString
{
    NSString* aliNoTrailingOrLeadingSpaces = [emailString stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
    
    if([aliNoTrailingOrLeadingSpaces length] == 0)
    {
        return NO;
    }
    
    NSString *regExPattern = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:regExPattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger regExMatches = [regEx numberOfMatchesInString:aliNoTrailingOrLeadingSpaces options:0 range:NSMakeRange(0, [aliNoTrailingOrLeadingSpaces length])];
    
    if (regExMatches == 0) {
        return NO;
    } else {
        return YES;
    }
}

-(BOOL)checkUserName:(NSString*)userName
{
    BOOL isTrue = YES;
    NSString *specialCharacterString = @"!~`@#$%^&*-+();:={}[],.<>?\\/\"\'";
    NSCharacterSet *specialCharacterSet = [NSCharacterSet
                                           characterSetWithCharactersInString:specialCharacterString];
    
    if ([txtFUserName.text rangeOfCharacterFromSet:specialCharacterSet].length) {
        isTrue= NO;
    }
    
    NSString* aliNoTrailingOrLeadingSpaces = [txtFUserName.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
    
    if ([aliNoTrailingOrLeadingSpaces length] <= 5 || [aliNoTrailingOrLeadingSpaces length] > 31)
    {
        isTrue = NO;
    }
    
    return isTrue;
}

-(BOOL)checkPassword:(NSString*)password
{
    BOOL isTrue = YES;
    NSRange range = [txtFPassword.text rangeOfCharacterFromSet:stringTest];
    
    if ([txtFPassword.text length] <= 5 || [txtFPassword.text length] > 31)
    {
        isTrue = NO;
    }
    
    if (range.location != NSNotFound) {
        isTrue = NO;
    }
    
    return isTrue;
}

-(BOOL)checkRe_Password:(NSString*)re_password
{
    BOOL isTrue = NO;
    
    if ([txtFPassword.text isEqualToString:txtFRePassword.text])
    {
        isTrue = YES;
    }
    return isTrue;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag == 10)
    {
        [_ScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    } else {
        if (textField.tag == 11)
        {
            [_ScrollView setContentOffset:CGPointMake(0, 40.0f) animated:YES];
        } else {
            if (textField.tag == 12)
            {
                [_ScrollView setContentOffset:CGPointMake(0, 80.0f) animated:YES];
            } else {
                if (textField.tag == 13)
                {
                    [_ScrollView setContentOffset:CGPointMake(0, 140.0f) animated:YES];
                }
            }
        }
    }
    
    self.navigationItem.leftBarButtonItem.enabled = NO;
    
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 13) {
        [_ScrollView setContentOffset:CGPointMake(0, -44.0f) animated:YES];
        if ([txtFEmail.text isEqualToString:@""] || ![self validEmail:txtFEmail.text])
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Cảnh báo" message:@"Địa chỉ email không hợp lệ!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alertView show];
        } else {
            if ([txtFUserName.text isEqualToString:@""] || ![self checkUserName:txtFUserName.text]) {
                // Check user name invalid
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Cảnh báo" message:@"Tên tài khoản phải từ 6 - 31 ký tự, không được sử dụng ký tự đặc biệt!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alertView show];
                
            }
            else {
                // Check password invalid
                if ([txtFPassword.text isEqualToString:@""] || ![self checkPassword:txtFPassword.text]) {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Cảnh báo" message:@"Mật khẩu phải từ 6 - 31 ký tự, không được sử dụng dấu Tiếng Việt và ký tự đặc biệt!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    [alertView show];
                    
                }
                else {
                    // Check re-password
                    if ([txtFPassword.text isEqualToString:@""] || [txtFRePassword.text isEqualToString:@""] || ![self checkRe_Password:txtFRePassword.text])
                    {
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Cảnh báo" message:@"Xác nhận mật khẩu không đúng!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                        [alertView show];
                    }
                    
                }
            }
        }
        
    }
    // Check email invalid
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    self.navigationItem.leftBarButtonItem.enabled = YES;
    return YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
