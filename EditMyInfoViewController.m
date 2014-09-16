//
//  EditMyInfoViewController.m
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import "EditMyInfoViewController.h"
#import "CoreGUIController.h"

@interface EditMyInfoViewController ()

@end

@implementation EditMyInfoViewController

@synthesize _UserProE, _ScrollView;
@synthesize _PicVGioiTinh, _PicVCountry, _TxtFPassword, _PicVBirth;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Chi tiết";
    self.navigationController.title = @"Chi tiết";
    _ScreenName = EditMyInfoScreen;
    count  = 0;
    
    genderArray  = [[NSMutableArray alloc] initWithObjects:@"Nữ", @"Nam", @"Khác", nil];
    countryArray = [[NSMutableArray alloc] init];
    NSLocale *locale = [NSLocale currentLocale];
    NSArray *tempArray = [NSLocale ISOCountryCodes];
    for (NSString *countryCode in tempArray)
    {
        NSString *displayNameString = [locale displayNameForKey:NSLocaleCountryCode value:countryCode];
        [countryArray addObject:displayNameString];
        
    }
    
    int paddingX = 10;
    float widthLab = 80.0f;
    float padding_LBot = 2.0f;
    float padding_TBot = 5.0f;
    self.view.backgroundColor = [UIColor whiteColor];
    
    _ScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _ScrollView.contentSize = CGSizeMake(self.view.frame.size.width, 550.0f);
    _ScrollView.minimumZoomScale = 0.5f;
    _ScrollView.maximumZoomScale = 2.0f;
    _ScrollView.delegate = self;
    
    /////////// Your Information
    
    lblEditMyInfo = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 35.0f)];
    lblEditMyInfo.backgroundColor = [UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f];
    lblEditMyInfo.text = @" Hồ Sơ Tài Khoản ";
    [lblEditMyInfo setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0f]];
    lblEditMyInfo.textColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    
    // Account
    
    lblFullName = [[UILabel alloc] initWithFrame:CGRectMake(paddingX, lblEditMyInfo.frame.origin.y + lblEditMyInfo.frame.size.height + padding_LBot, widthLab, 30.0f)];
    [lblFullName setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f]];
    lblFullName.backgroundColor = [UIColor whiteColor];
    lblFullName.textAlignment = NSTextAlignmentNatural;
    lblFullName.text = @"Họ & tên ";
    lblFullName.textColor = [UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f];
    
    _TxtFFullName = [[UITextField alloc] initWithFrame:CGRectMake(lblFullName.frame.origin.x + lblFullName.frame.size.width, lblFullName.frame.origin.y, self.view.frame.size.width -(lblFullName.frame.origin.x + lblFullName.frame.size.width), 30.0f)];
    [_TxtFFullName setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f]];
    _TxtFFullName.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0f];
    _TxtFFullName.delegate = self;
    _TxtFFullName.text = _UserProE._FullName;
    _TxtFFullName.textAlignment = NSTextAlignmentLeft;
    
    
    
    // Email
    lblEmail = [[UILabel alloc] initWithFrame:CGRectMake(paddingX, lblFullName.frame.origin.y + lblFullName.frame.size.height + padding_TBot, widthLab, 30.0f)];
    lblEmail.backgroundColor = [UIColor whiteColor];
    [lblEmail setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f]];
    lblEmail.text = @"Email ";
    lblEmail.textColor = [UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f];
    
    lblAccountEmail = [[UILabel alloc] initWithFrame:CGRectMake(lblEmail.frame.origin.x + lblEmail.frame.size.width, lblEmail.frame.origin.y, self.view.frame.size.width -(lblEmail.frame.origin.x + lblEmail.frame.size.width), 30.0f)];
    lblAccountEmail.text = _UserProE._Email;
    [lblAccountEmail setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f]];
    lblAccountEmail.textColor = [UIColor colorWithRed:140.0f/255.0f green:140.0f/255.0f blue:140.0f/255.0f alpha:1.0f];
    lblAccountEmail.textAlignment = NSTextAlignmentLeft;
    
    // Password
    lblPassword = [[UILabel alloc] initWithFrame:CGRectMake(paddingX, lblEmail.frame.origin.y + lblEmail.frame.size.height + padding_TBot, widthLab, 30.0f)];
    lblPassword.backgroundColor = [UIColor whiteColor];
    [lblPassword setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f]];
    lblPassword.text = @"Mật khẩu ";
    lblPassword.textColor = [UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f];
    
    _TxtFPassword = [[UITextField alloc] initWithFrame:CGRectMake(lblPassword.frame.origin.x + lblPassword.frame.size.width, lblPassword.frame.origin.y, self.view.frame.size.width -(lblPassword.frame.origin.x + lblPassword.frame.size.width), 30.0f)];
    _TxtFPassword.text = _UserProE._Password;
    [_TxtFPassword setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f]];
    _TxtFPassword.textColor = [UIColor colorWithRed:140.0f/255.0f green:140.0f/255.0f blue:140.0f/255.0f alpha:1.0f];
    _TxtFPassword.delegate = self;
    _TxtFPassword.secureTextEntry = YES;
    [_TxtFPassword setEnabled:NO];
    _TxtFPassword.textAlignment = NSTextAlignmentLeft;
    
    // Gioi tinh
    lblGioiTinh = [[UILabel alloc] initWithFrame:CGRectMake(paddingX, lblPassword.frame.origin.y + lblPassword.frame.size.height + padding_TBot, widthLab, 30.0f)];
    lblGioiTinh.backgroundColor = [UIColor whiteColor];
    [lblGioiTinh setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f]];
    lblGioiTinh.textColor = [UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f];
    lblGioiTinh.text = @"Giới tính ";
    
    btnGender = [UIButton buttonWithType:UIButtonTypeCustom];
    btnGender.frame = CGRectMake(lblGioiTinh.frame.origin.x + lblGioiTinh.frame.size.width, lblGioiTinh.frame.origin.y, widthLab, 30.0f);
    btnGender.backgroundColor = [UIColor whiteColor];
    btnGender.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [btnGender.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f]];
    [btnGender setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0f] forState:UIControlStateNormal];
    
    [btnGender setTitle: _UserProE._Gender forState:UIControlStateNormal];
    [btnGender addTarget:self action:@selector(updateGender) forControlEvents:UIControlEventTouchUpInside];
    
    // Ngay sinh
    lblBirth = [[UILabel alloc] initWithFrame:CGRectMake(paddingX, lblGioiTinh.frame.origin.y + lblGioiTinh.frame.size.height + padding_TBot, widthLab, 30.0f)];
    lblBirth.backgroundColor = [UIColor whiteColor];
    [lblBirth setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f]];
    lblBirth.textColor = [UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f];
    lblBirth.text = @"Ngày sinh ";
    
    btnBirth = [UIButton buttonWithType:UIButtonTypeCustom];
    btnBirth.frame = CGRectMake(lblBirth.frame.origin.x + lblBirth.frame.size.width, lblBirth.frame.origin.y, 2.0f*widthLab, 30.0f);
    btnBirth.backgroundColor = [UIColor whiteColor];
    btnBirth.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [btnBirth.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f]];
    [btnBirth setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0f] forState:UIControlStateNormal];
    
    [btnBirth setTitle: _UserProE._Birthday forState:UIControlStateNormal];
    [btnBirth addTarget:self action:@selector(updateBirthday) forControlEvents:UIControlEventTouchUpInside];
    
    // Country
    lblCountry = [[UILabel alloc] initWithFrame:CGRectMake(paddingX, btnBirth.frame.origin.y + btnBirth.frame.size.height + padding_TBot, widthLab, 30.0f)];
    lblCountry.backgroundColor = [UIColor whiteColor];
    [lblCountry setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f]];
    lblCountry.textColor = [UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f];
    lblCountry.text = @"Quốc gia ";
    
    btnCountry = [UIButton buttonWithType:UIButtonTypeCustom];
    btnCountry.frame = CGRectMake(lblCountry.frame.origin.x + lblCountry.frame.size.width, lblCountry.frame.origin.y, 2.0f*widthLab, 30.0f);
    btnCountry.backgroundColor = [UIColor whiteColor];
    [btnCountry setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0f] forState:UIControlStateNormal];
    [btnCountry setTitle: _UserProE._Country forState:UIControlStateNormal];
    btnCountry.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btnCountry.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f]];
    
    [btnCountry addTarget:self action:@selector(updateCountry) forControlEvents:UIControlEventTouchUpInside];
    
    // City
    lblCity = [[UILabel alloc] initWithFrame:CGRectMake(paddingX, lblCountry.frame.origin.y + lblCountry.frame.size.height + padding_TBot, widthLab, 30.0f)];
    lblCity.backgroundColor = [UIColor whiteColor];
    [lblCity setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f]];
    lblCity.textColor = [UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f];
    lblCity.text = @"Thành phố ";
    
    _TxtFCityName = [[UITextField alloc] initWithFrame:CGRectMake(lblCity.frame.origin.x + lblCity.frame.size.width, lblCity.frame.origin.y, self.view.frame.size.width -(lblCity.frame.origin.x + lblCity.frame.size.width), 30.0f)];
    _TxtFCityName.text = _UserProE._City;
    [_TxtFCityName setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f]];
    _TxtFCityName.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0f];
    _TxtFCityName.delegate = self;
    _TxtFCityName.tag = 2000;
    _TxtFCityName.backgroundColor = [UIColor whiteColor];
    _TxtFCityName.textAlignment = NSTextAlignmentLeft;
    
    ////////////////// Notifications
    
    lblEditNotifications = [[UILabel alloc] initWithFrame:CGRectMake(0, lblCity.frame.origin.y + lblCity.frame.size.height + 20.0f, self.view.frame.size.width, 35.0f)];
    lblEditNotifications.backgroundColor = [UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f];
    lblEditNotifications.text = @" Thông Báo ";
    lblEditNotifications.textColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    [lblEditNotifications setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0f]];
    
    lblMess = [[UILabel alloc] initWithFrame:CGRectMake(paddingX, lblEditNotifications.frame.origin.y + lblEditNotifications.frame.size.height + padding_LBot, 2*widthLab + 60.0f, 30.0f)];
    lblMess.backgroundColor = [UIColor whiteColor];
    [lblMess setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14.0f]];
    lblMess.text = @"Cho phép nhận thông báo từ server";
    lblMess.textColor = [UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f];
    
    swiMess = [[UISwitch alloc]init];
    swiMess.frame = CGRectMake(255.0f, lblMess.frame.origin.y, 65.0f, 30.0f);
    if (_UserProE._AllowNotification) {
        [swiMess setOn:YES];
    }
    [swiMess addTarget:self action:@selector(changeSwitchNotification:) forControlEvents:UIControlEventValueChanged];
    
    // Update label
    lblUpdate = [[UILabel alloc] initWithFrame:CGRectMake(paddingX, lblMess.frame.origin.y + lblMess.frame.size.height + padding_LBot, 2 * widthLab + 60.0f, 30.0f)];
    lblUpdate.backgroundColor = [UIColor whiteColor];
    lblUpdate.text = @"Tự động đồng bộ dữ liệu đến server";
    lblUpdate.textColor = [UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f];
    [lblUpdate setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14.0f]];
    
    swiUpdate = [[UISwitch alloc]init];
    swiUpdate.frame = CGRectMake(255.0f, lblUpdate.frame.origin.y, 65.0f, 30.0f);
    if (_UserProE._AllowUpdate) {
        [swiUpdate setOn:YES];
    }
    [swiUpdate addTarget:self action:@selector(changeSwitchUpdate:) forControlEvents:UIControlEventValueChanged];
    
    // Back
    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    btnBack.frame = CGRectMake(0, 0, 75.0f, 25.0f);
    [btnBack setImage:[UIImage imageNamed:@"BackButtonBarItem.png"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnBack];
    
    
    // Save
    UIButton *btnSave = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 60.0f, 30.0f)];
    [btnSave setTitle:@"Lưu" forState:UIControlStateNormal];
    [btnSave addTarget:self action:@selector(saveProfile) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *saveButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnSave];
    self.navigationItem.rightBarButtonItem = saveButtonItem;
    
    UITapGestureRecognizer *tapGR =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTapped:)];
    [_ScrollView addGestureRecognizer: tapGR];
    /*
     */
    
    _PicVGioiTinh = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.width/8.0f, self.view.frame.size.width, 150.0f)];
    _PicVGioiTinh.dataSource = self;
    _PicVGioiTinh.delegate = self;
    _PicVGioiTinh.tag = 1000;
    
    _PicVCountry = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.width/8.0f, self.view.frame.size.width, 216.0f)];
    _PicVCountry.dataSource = self;
    _PicVCountry.delegate = self;
    _PicVCountry.tag = 1001;
    
    // Birthday
    _PicVBirth = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, self.view.frame.size.width/8.0f, self.view.frame.size.width, 150.0f)];
    _PicVBirth.datePickerMode = UIDatePickerModeDate;
    _PicVBirth.tag = 1002;
    
    
    
    // Add subView
    [_ScrollView addSubview:lblEditMyInfo];
    [_ScrollView addSubview:lblFullName];
    [_ScrollView addSubview:_TxtFFullName];
    [_ScrollView addSubview:lblPassword];
    [_ScrollView addSubview:_TxtFPassword];
    [_ScrollView addSubview:lblEmail];
    [_ScrollView addSubview:lblAccountEmail];
    [_ScrollView addSubview:lblGioiTinh];
    [_ScrollView addSubview:btnGender];
    [_ScrollView addSubview:lblBirth];
    [_ScrollView addSubview:btnBirth];
    [_ScrollView addSubview:lblCountry];
    [_ScrollView addSubview:btnCountry];
    [_ScrollView addSubview:lblCity];
    [_ScrollView addSubview:_TxtFCityName];
    [_ScrollView addSubview:lblEditNotifications];
    [_ScrollView addSubview:lblMess];
    [_ScrollView addSubview:lblUpdate];
    [_ScrollView addSubview:swiMess];
    [_ScrollView addSubview:swiUpdate];
    
    
    [self.view addSubview:_ScrollView];
    
}

-(void) popBack {
    [_CoreGUI._TabBar.tabBar setHidden:NO];
    [_CoreGUI._Navi05 popToRootViewControllerAnimated:YES];
}

-(void)saveProfile
{
    [_CoreGUI._TabBar.tabBar setHidden:NO];
    
    _CoreGUI._UserProfile._Gender = btnGender.titleLabel.text;
    _CoreGUI._UserProfile._Country = btnCountry.titleLabel.text;
    _CoreGUI._UserProfile._AllowNotification = [swiMess isOn];
    _CoreGUI._UserProfile._AllowUpdate = [swiUpdate isOn];
    _CoreGUI._UserProfile._FullName = _TxtFFullName.text;
    _CoreGUI._UserProfile._City = _TxtFCityName.text;
    _CoreGUI._UserProfile._Birthday = btnBirth.titleLabel.text;
    ((MyInfoViewController*)[_CoreGUI._Navi05.viewControllers objectAtIndex:0])._FlagUpdateInfo = YES;
    ((MyInfoViewController*)[_CoreGUI._Navi05.viewControllers objectAtIndex:0])._UserProM._FullName = _TxtFFullName.text;
    ((MyInfoViewController*)[_CoreGUI._Navi05.viewControllers objectAtIndex:0])._UserProM._City = _TxtFCityName.text;
    ((MyInfoViewController*)[_CoreGUI._Navi05.viewControllers objectAtIndex:0])._UserProM._Country = btnCountry.titleLabel.text;
    
    [_CoreGUI updateUserProfileWithCode:3];
    
    if ([swiUpdate isOn]) {
        [_CoreGUI updateProfileToServer];
        [_CoreGUI finishedScreen:self withCode:140];

    } else {
        UIView *viewBackg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        viewBackg.backgroundColor = [UIColor colorWithWhite:0.5f alpha:1.0f];
        
        UIView *viewTit = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewBackg.frame.size.width - 20.0f, viewBackg.frame.size.width - 20.0f)];
        viewTit.backgroundColor = [UIColor colorWithWhite:0.2f alpha:0.8f];
        viewTit.layer.cornerRadius = 10.0f;
        viewTit.center = CGPointMake(viewBackg.frame.size.width/2.0f, (viewBackg.frame.size.height + 10.0f)/2.0f);
        UILabel *lblMessage = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, viewTit.frame.size.width - 40.0f, self.view.frame.size.height/3.0f)];
        lblMessage.center = CGPointMake(viewTit.frame.size.width/2.0f, viewTit.frame.size.height/2.0f);
        lblMessage.backgroundColor = [UIColor clearColor];
        lblMessage.textAlignment = NSTextAlignmentCenter;
        [lblMessage setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:18.0f]];
        lblMessage.numberOfLines = 3;
        [lblMessage setTextColor:[UIColor whiteColor]];
        
        
        lblMessage.text = @"Bật chế độ đồng bộ để cập nhật dữ liệu đến server khi có thay đổi!";
        
        [viewTit addSubview:lblMessage];
        [viewBackg addSubview:viewTit];
        [self.view addSubview:viewBackg];
        
        [UIView animateWithDuration:3.0f delay:0.5f options:UIViewAnimationOptionCurveEaseIn animations:^{
            [viewBackg setAlpha:1.0f];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:3.0f delay:0.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [viewBackg setAlpha:0.0f];
                [self performSelector:@selector(delayShowMess) withObject:nil afterDelay:3.2f];
            } completion:nil];
        }];

    }
}

-(void)delayShowMess
{
    [_CoreGUI finishedScreen:self withCode:140];
}

-(void)updateBirthday
{
    viewBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0.8f*self.view.frame.size.height)];
    viewBackground.backgroundColor = [UIColor colorWithWhite:0.8f alpha:1.0f];
    
    viewTitle = [[UIView alloc] initWithFrame:CGRectMake(0, 0.0f, self.view.frame.size.width, 40.0f)];
    viewTitle.backgroundColor = [UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:0.95f];
    
    
    btnDone = [UIButton buttonWithType:UIButtonTypeCustom];
    btnDone.frame = CGRectMake(10.0f, 0, 70.0f, 40.0f);
    btnDone.backgroundColor = [UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f];
    [btnDone setTitle:@"Hoàn tất" forState:UIControlStateNormal];
    [btnDone addTarget:self action:@selector(selectedCountry) forControlEvents:UIControlEventTouchUpInside];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSDate *date = [dateFormatter dateFromString:_UserProE._Birthday];
    
	_PicVBirth.hidden = NO;
	_PicVBirth.date = date;
	[_PicVBirth addTarget:self
                   action:@selector(changeDateInTextLabel)
         forControlEvents:UIControlEventValueChanged];
	[self.view addSubview:_PicVBirth];
    
    
    [_PicVBirth setDate:date animated:NO];
    
    [viewTitle addSubview:btnDone];
    [viewBackground addSubview:viewTitle];
    [viewBackground addSubview:_PicVBirth];
    [self.view addSubview:viewBackground];
    
    viewBackground.alpha = 0;
    viewBackground.center = CGPointMake(self.view.frame.size.width/2.0f, self.view.frame.size.height);
    [UIView beginAnimations:NULL context:nil];
    [UIView setAnimationDuration:1.0f];
    
    viewBackground.center = CGPointMake(self.view.frame.size.width/2.0f, self.view.frame.size.height - 100.0f);
    viewBackground.alpha = 0.98f;
    [_ScrollView setContentOffset:CGPointMake(0, 10.0f) animated:YES];
    [UIView commitAnimations];
    
    [_TxtFFullName resignFirstResponder];
    [_TxtFCityName resignFirstResponder];
}

-(void)changeDateInTextLabel
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat:@"dd/MM/yyyy"];
	btnBirth.titleLabel.text = [NSString stringWithFormat:@"%@",
                  [dateFormat stringFromDate:_PicVBirth.date]];
}

-(void)updateGender
{
    viewBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0.8f*self.view.frame.size.height)];
    viewBackground.backgroundColor = [UIColor colorWithWhite:0.8f alpha:1.0f];
    
    viewTitle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40.0f)];
    viewTitle.backgroundColor = [UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:0.95f];
    btnDone = [UIButton buttonWithType:UIButtonTypeCustom];
    btnDone.frame = CGRectMake(0, 0, 70.0f, 40.0f);
    btnDone.backgroundColor = [UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f];
    [btnDone setTitle:@"Hoàn tất" forState:UIControlStateNormal];
    [btnDone addTarget:self action:@selector(selectedGender) forControlEvents:UIControlEventTouchUpInside];
    
    
    /* Initialize a UIPickerView with 100px space above it, for the button of the UIActionSheet. */
    
    
    for (int i = 0; i < [genderArray count]; i++) {
        if ([_UserProE._Gender isEqualToString:(NSString*)[genderArray objectAtIndex:i]]) {
            [_PicVGioiTinh selectRow:i inComponent:0 animated:YES];
        }
    }
    
    /* another unique tag for this UIPicker */
    
    
    [viewTitle addSubview:btnDone];
    [viewBackground addSubview:viewTitle];
    [viewBackground addSubview:_PicVGioiTinh];
    [self.view addSubview:viewBackground];
    
    viewBackground.alpha = 0;
    viewBackground.center = CGPointMake(self.view.frame.size.width/2.0f, self.view.frame.size.height);
    [UIView beginAnimations:NULL context:nil];
    [UIView setAnimationDuration:1.0f];
    
    viewBackground.alpha = 0.98f;
    viewBackground.center = CGPointMake(self.view.frame.size.width/2.0f, self.view.frame.size.height - 100.0f);
    [_ScrollView setContentOffset:CGPointMake(0, 10.0f) animated:YES];
    [UIView commitAnimations];
    [_TxtFFullName resignFirstResponder];
    [_TxtFCityName resignFirstResponder];
    
}

-(void)updateCountry
{
    
    viewBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0.8f*self.view.frame.size.height)];
    viewBackground.backgroundColor = [UIColor colorWithWhite:0.8f alpha:1.0f];
    
    viewTitle = [[UIView alloc] initWithFrame:CGRectMake(0, 0.0f, self.view.frame.size.width, 40.0f)];
    viewTitle.backgroundColor = [UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:0.95f];
    
    
    btnDone = [UIButton buttonWithType:UIButtonTypeCustom];
    btnDone.frame = CGRectMake(0, 0, 70.0f, 40.0f);
    btnDone.backgroundColor = [UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f];
    [btnDone setTitle:@"Hoàn tất" forState:UIControlStateNormal];
    [btnDone addTarget:self action:@selector(selectedCountry) forControlEvents:UIControlEventTouchUpInside];
    
    
    /* Initialize a UIPickerView with 100px space above it, for the button of the UIActionSheet. */
    
    for (int i = 0; i < [countryArray count]; i++) {
        if ([_UserProE._Country isEqualToString:(NSString*)[countryArray objectAtIndex:i]]) {
            [_PicVCountry selectRow:i inComponent:0 animated:YES];
        }
    }
    
    /* another unique tag for this UIPicker */
    
    
    [viewTitle addSubview:btnDone];
    [viewBackground addSubview:viewTitle];
    [viewBackground addSubview:_PicVCountry];
    [self.view addSubview:viewBackground];
    
    viewBackground.alpha = 0;
    viewBackground.center = CGPointMake(self.view.frame.size.width/2.0f, self.view.frame.size.height);
    [UIView beginAnimations:NULL context:nil];
    [UIView setAnimationDuration:1.0f];
    
    viewBackground.center = CGPointMake(self.view.frame.size.width/2.0f, self.view.frame.size.height - 100.0f);
    viewBackground.alpha = 0.98f;
    [_ScrollView setContentOffset:CGPointMake(0, 10.0f) animated:YES];
    [UIView commitAnimations];
    
    [_TxtFFullName resignFirstResponder];
    [_TxtFCityName resignFirstResponder];
}

-(void)selectedGender
{
    [btnDone removeFromSuperview];
    [_PicVGioiTinh removeFromSuperview];
    [viewBackground removeFromSuperview];
    viewBackground = nil;
}

-(void)selectedCountry
{
    [btnDone removeFromSuperview];
    [_PicVCountry removeFromSuperview];
    [viewBackground removeFromSuperview];
    viewBackground = nil;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag == 2000)
    {
        [_ScrollView setContentOffset:CGPointMake(0, 10.0f) animated:YES];
    }
    return YES;
}


- (void)changeSwitchNotification:(id)sender{
    if([sender isOn]){
        // Execute any code when the switch is ON
    } else{
        // Execute any code when the switch is OFF
    }
}

- (void)changeSwitchUpdate:(id)sender{
    if([sender isOn]){
        // Execute any code when the switch is ON

    } else{
        // Execute any code when the switch is OFF
    }
}

-(void)labelTapped:(UITapGestureRecognizer *)gestureRecognizer
{
    [viewBackground removeFromSuperview];
    [_TxtFFullName resignFirstResponder];
    [_TxtFCityName resignFirstResponder];
}


// returns the number of 'columns' to display.

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component
{
    if (pickerView.tag == 1000) {
        return [genderArray count];
    }
    else
    {
        return [countryArray count];
    }
    
    
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row  forComponent:(NSInteger)component
{
    
    if (pickerView.tag == 1000) {
        return [genderArray objectAtIndex:row];
    }
    else
    {
        return [countryArray objectAtIndex:row];
    }
    
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    if (pickerView.tag == 1000) {
        return 30.0f;
    }
    else
    {
        return 30.0f;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView.tag == 1000) {
        [btnGender setTitle:[genderArray objectAtIndex:row] forState:UIControlStateNormal];
    }
    else
    {
        [btnCountry setTitle:[countryArray objectAtIndex:row] forState:UIControlStateNormal];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (pickerView.tag == 1000) {
        return 250.0f;
    }
    else
    {
        return 150.0f;
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    
    UILabel *pickerLabel = (UILabel*)view;
    if (pickerLabel == nil) {
        
        
        if (pickerView.tag == 1000) {
            //label size
            [pickerLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:30.0f]];
            CGRect frame = CGRectMake(0, 0, 0, 0);
            pickerLabel = [[UILabel alloc] initWithFrame:frame];
            [pickerLabel setTextAlignment:NSTextAlignmentCenter];
            [pickerLabel setBackgroundColor:[UIColor clearColor]];
            
            [pickerLabel setText:[genderArray objectAtIndex:row]];
        }
        
        else
        {
            //label size
            [pickerLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:25.0f]];
            CGRect frame = CGRectMake(0, 0, 0, 0);
            pickerLabel = [[UILabel alloc] initWithFrame:frame];
            [pickerLabel setTextAlignment:NSTextAlignmentCenter];
            [pickerLabel setBackgroundColor:[UIColor clearColor]];
            
            [pickerLabel setText:[countryArray objectAtIndex:row]];
        }
    }
    //picker view array is the datasource
    
    
    return pickerLabel;
}


-(void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.backBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[UIBarButtonItem appearance] setTintColor:[UIColor whiteColor]];
    [_CoreGUI._TabBar.tabBar setHidden:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (textField.tag == 2000)
    {
        [_ScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
