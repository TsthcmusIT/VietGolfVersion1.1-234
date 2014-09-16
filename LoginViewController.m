//
//  LoginViewController.m
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import "LoginViewController.h"
#import "CoreGUIController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize _TxtFEmail, _TxtFPassword;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Đăng nhập";
    self.title = @"Đăng nhập";
    _ScreenName = LoginScreen;
    self.navigationItem.hidesBackButton = YES;
    
    if ([[UIScreen mainScreen] bounds].size.height >= 568.0f) {
        backgroundV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Login4InchesScreen.png"]];
        backgroundV.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        
        _TxtFEmail = [[UITextField alloc] initWithFrame:CGRectMake(40.0f, 185.0f, self.view.frame.size.width - 80.0f, 40.0f)];
        _TxtFEmail.delegate = self;
        _TxtFEmail.keyboardType = UIKeyboardTypeEmailAddress;
        _TxtFEmail.placeholder = @"Email";
        _TxtFEmail.autocapitalizationType = UITextAutocapitalizationTypeNone;
        [_TxtFEmail setBorderStyle:UITextBorderStyleRoundedRect];
        
        _TxtFPassword = [[UITextField alloc] initWithFrame:CGRectMake(40.0f, _TxtFEmail.frame.origin.y + _TxtFEmail.frame.size.height + 15.0f, self.view.frame.size.width - 80.0f, 40.0f)];
        _TxtFPassword.delegate = self;
        _TxtFPassword.placeholder = @"Mật khẩu";
        _TxtFPassword.secureTextEntry = YES;
        [_TxtFPassword setBorderStyle:UITextBorderStyleRoundedRect];
        
        btnLogin = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btnLogin.frame = CGRectMake(85.0f, _TxtFPassword.frame.origin.y + _TxtFPassword.frame.size.height + 30.0f, 150.0f, 40.0f);
        btnLogin.layer.cornerRadius = 5.0f;
        btnLogin.clipsToBounds = YES;
        [btnLogin setBackgroundImage:[UIImage imageNamed:@"Login.png"] forState:UIControlStateNormal];
        [btnLogin addTarget:self action:@selector(login_VietGolfAccount) forControlEvents:UIControlEventTouchUpInside];
        
        btnRegister = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btnRegister.frame = CGRectMake(40.0f, 410.0f, self.view.frame.size.width - 80.0f, 40.0f);
        [btnRegister setBackgroundImage:[UIImage imageNamed:@"Register.png"] forState:UIControlStateNormal];
        btnRegister.layer.cornerRadius = 7.0f;
        btnRegister.clipsToBounds = YES;
        [btnRegister addTarget:self action:@selector(register_VietGolfAccount) forControlEvents:UIControlEventTouchUpInside];
        
    }
    else
    {
        backgroundV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LoginScreen.png"]];
        backgroundV.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        
        _TxtFEmail = [[UITextField alloc] initWithFrame:CGRectMake(40.0f, 160.0f, self.view.frame.size.width - 80.0f, 34.0f)];
        _TxtFEmail.delegate = self;
        _TxtFEmail.keyboardType = UIKeyboardTypeEmailAddress;
        _TxtFEmail.placeholder = @"Email";
        _TxtFEmail.autocapitalizationType = UITextAutocapitalizationTypeNone;
        [_TxtFEmail setBorderStyle:UITextBorderStyleRoundedRect];
        
        _TxtFPassword = [[UITextField alloc] initWithFrame:CGRectMake(40.0f, _TxtFEmail.frame.origin.y + _TxtFEmail.frame.size.height + 10.0f, self.view.frame.size.width - 80.0f, 34.0f)];
        _TxtFPassword.delegate = self;
        _TxtFPassword.placeholder = @"Mật khẩu";
        _TxtFPassword.secureTextEntry = YES;
        [_TxtFPassword setBorderStyle:UITextBorderStyleRoundedRect];
        
        btnLogin = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btnLogin.frame = CGRectMake(85.0f, _TxtFPassword.frame.origin.y + _TxtFPassword.frame.size.height + 23.0f,  150.0f, 35.0f);
        btnLogin.layer.cornerRadius = 4.0f;
        btnLogin.clipsToBounds = YES;
        [btnLogin setBackgroundImage:[UIImage imageNamed:@"Login35.png"] forState:UIControlStateNormal];
        [btnLogin addTarget:self action:@selector(login_VietGolfAccount) forControlEvents:UIControlEventTouchUpInside];
        
        btnRegister = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btnRegister.frame = CGRectMake(40.0f, 346.0f, self.view.frame.size.width - 80.0f, 35.0f);
        [btnRegister setBackgroundImage:[UIImage imageNamed:@"Register35.png"] forState:UIControlStateNormal];
        btnRegister.layer.cornerRadius = 6.0f;
        btnRegister.clipsToBounds = YES;
        [btnRegister addTarget:self action:@selector(register_VietGolfAccount) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    listUserProL = [[NSMutableArray alloc] init];
    userProL = [[UserProfile alloc] init];
    
    [self.view addSubview:backgroundV];
    [self.view addSubview:_TxtFEmail];
    [self.view addSubview:_TxtFPassword];
    [self.view addSubview:btnLogin];
    [self.view addSubview:btnRegister];
}

-(void)login_VietGolfAccount
{
    if (([userProL._Email isEqualToString:_TxtFEmail.text] || [[userProL._Email lowercaseString] isEqualToString:[_TxtFEmail.text lowercaseString]]) && [userProL._Password isEqualToString:_TxtFPassword.text]) {
        if (_CoreGUI._CheckStatus == 1) {
            viewProcess = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
            viewProcess.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:0.6f];
            spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            spinner.center = CGPointMake((self.view.frame.size.width)/2.0f, (self.view.frame.size.height)/2.0f);
            spinner.transform = CGAffineTransformMakeScale(2.0f, 2.0f);
            [viewProcess addSubview:spinner];
            [self.view addSubview:viewProcess];
            [spinner startAnimating];
            [_CoreGUI downloadThumnailsWithCode:0];
            [_CoreGUI downloadRecords];
            
            [_CoreGUI downloadSwingVideoPosted:_CoreGUI._IdSVideoPosted];
            
            [self performSelector:@selector(delayDownloadInfo) withObject:nil afterDelay:2.0f];
        } else {
            UIAlertView *alertInvalidEmail = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Email (tài khoản) chưa tồn tại! Bạn hãy đăng ký tài khoản để bắt đầu sử dụng ứng dụng Viet Golf!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertInvalidEmail show];
        }
        
    }
    else
    {
        if (!userProL._Status)
        {
            UIAlertView *alertInvalidEmail = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Email (tài khoản) chưa tồn tại! Bạn hãy đăng ký tài khoản để bắt đầu sử dụng ứng dụng Viet Golf!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertInvalidEmail show];
        } else {
            UIAlertView *alertInvalidEmail = [[UIAlertView alloc] initWithTitle:@"Cảnh báo" message:@"Email hoặc mật khẩu không đúng! Bạn vui lòng thử lại hoặc đăng ký mới!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertInvalidEmail show];
        }
    }
}

-(void)delayDownloadInfo
{
    [spinner stopAnimating];
    [spinner removeFromSuperview];
    [viewProcess removeFromSuperview];
    [_CoreGUI finishedScreen:self withCode:1];
}

-(void)register_VietGolfAccount
{
    [_CoreGUI finishedScreen:self withCode:0];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
    [listUserProL addObjectsFromArray:[[_CoreGUI loadUserProfile] mutableCopy]];
    userProL = (UserProfile*)[listUserProL objectAtIndex: 0];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
