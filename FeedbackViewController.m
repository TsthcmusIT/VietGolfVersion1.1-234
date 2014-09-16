//
//  FeedbackViewController.m
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import "FeedbackViewController.h"
#import "CoreGUIController.h"

@interface FeedbackViewController ()

@end

@implementation FeedbackViewController

@synthesize _TxtVContent, _TxtFEmail, _TxtFTitle;
@synthesize _IdUser;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"Phản Hồi";
    self.title = @"Phản Hồi";
    _ScreenName = FeedbackScreen;
    
    _ScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _ScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height + 200.0f);
    _ScrollView.minimumZoomScale = 0.5f;
    _ScrollView.maximumZoomScale = 2.0f;
    _ScrollView.backgroundColor = [UIColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f];
    _ScrollView.delegate = self;
    
    float paddingX = 10.0f;
    
    imaVBanner = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"FeedbackBackground.png"]];
    imaVBanner.frame = CGRectMake(0, 0, self.view.frame.size.width, 100.0f);
    
    lblFeedback = [[UILabel alloc] initWithFrame:CGRectMake(0, imaVBanner.frame.origin.y + imaVBanner.frame.size.height + 5.0f, self.view.frame.size.width, 60.0f)];
    lblFeedback.backgroundColor = [UIColor clearColor];
    [lblFeedback setTextColor:[UIColor whiteColor]];
    lblFeedback.numberOfLines = 2;
    [lblFeedback setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:23.0f]];
    lblFeedback.text = @"Phản Hồi Của Bạn Mang Giá Trị Cho Chúng Tôi";
    lblFeedback.textAlignment = NSTextAlignmentCenter;
    
    lblRating = [[UILabel alloc] initWithFrame:CGRectMake(paddingX, lblFeedback.frame.origin.y + lblFeedback.frame.size.height + 10.0f, self.view.frame.size.width - 2.0f*paddingX, 20.0f)];
    lblRating.backgroundColor = [UIColor clearColor];
    [lblRating setTextColor:[UIColor whiteColor]];
    [lblRating setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f]];
    lblRating.text = @"Đánh giá";
    lblRating.textAlignment = NSTextAlignmentLeft;
    
    CGSize btnSize = CGSizeMake(lblRating.frame.size.width/5.0f, 20.0f);
    
    btnLevel1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btnLevel1.frame = CGRectMake(paddingX, lblRating.frame.origin.y + lblRating.frame.size.height + 2.5f, btnSize.width, btnSize.height);
    btnLevel1.tag = 111;
    btnLevel1.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
    [btnLevel1 addTarget:self action:@selector(updateRating:) forControlEvents:UIControlEventTouchUpInside];
    
    
    btnLevel2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btnLevel2.frame = CGRectMake(btnLevel1.frame.origin.x + btnSize.width, lblRating.frame.origin.y + lblRating.frame.size.height + 2.5f, btnSize.width, btnSize.height);
    btnLevel2.tag = 112;
    btnLevel2.backgroundColor = [UIColor colorWithWhite:0.8f alpha:1.0f];
    [btnLevel2 addTarget:self action:@selector(updateRating:) forControlEvents:UIControlEventTouchUpInside];
    
    btnLevel3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btnLevel3.frame = CGRectMake(btnLevel2.frame.origin.x + btnSize.width, lblRating.frame.origin.y + lblRating.frame.size.height + 2.5f, btnSize.width, btnSize.height);
    btnLevel3.tag = 113;
    btnLevel3.backgroundColor = [UIColor colorWithWhite:0.7f alpha:1.0f];
    [btnLevel3 addTarget:self action:@selector(updateRating:) forControlEvents:UIControlEventTouchUpInside];
    
    btnLevel4 = [UIButton buttonWithType:UIButtonTypeCustom];
    btnLevel4.frame = CGRectMake(btnLevel3.frame.origin.x + btnSize.width, lblRating.frame.origin.y + lblRating.frame.size.height + 2.5f, btnSize.width, btnSize.height);
    btnLevel4.backgroundColor = [UIColor colorWithWhite:0.6f alpha:1.0f];
    btnLevel4.tag = 114;
    [btnLevel4 addTarget:self action:@selector(updateRating:) forControlEvents:UIControlEventTouchUpInside];
    
    btnLevel5 = [UIButton buttonWithType:UIButtonTypeCustom];
    btnLevel5.frame = CGRectMake(btnLevel4.frame.origin.x + btnSize.width, lblRating.frame.origin.y + lblRating.frame.size.height + 2.5f, btnSize.width, btnSize.height);
    btnLevel5.backgroundColor = [UIColor colorWithWhite:0.5f alpha:1.0f];
    btnLevel5.tag = 115;
    [btnLevel5 addTarget:self action:@selector(updateRating:) forControlEvents:UIControlEventTouchUpInside];
    
    lblEmail = [[UILabel alloc] initWithFrame:CGRectMake(paddingX, btnLevel1.frame.origin.y + btnLevel1.frame.size.height + 5.0f, self.view.frame.size.width - 2.0f*paddingX, 20.0f)];
    lblEmail.backgroundColor = [UIColor clearColor];
    [lblEmail setTextColor:[UIColor whiteColor]];
    [lblEmail setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f]];
    lblEmail.text = @"Email";
    lblEmail.textAlignment = NSTextAlignmentLeft;
    
    _TxtFEmail = [[UITextField alloc] initWithFrame:CGRectMake(paddingX, lblEmail.frame.origin.y + lblEmail.frame.size.height + 2.5f, self.view.frame.size.width - 2.0f*paddingX, 30.0f)];
    _TxtFEmail.delegate = self;
    _TxtFEmail.placeholder = @"Email";
    [_TxtFEmail setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f]];
    _TxtFEmail.tag = 30;
    [_TxtFEmail setBorderStyle:UITextBorderStyleRoundedRect];
    
    lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(paddingX, _TxtFEmail.frame.origin.y + _TxtFEmail.frame.size.height + 5.0f, self.view.frame.size.width - 2.0f*paddingX, 20.0f)];
    lblTitle.backgroundColor = [UIColor clearColor];
    [lblTitle setTextColor:[UIColor whiteColor]];
    [lblTitle setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f]];
    lblTitle.text = @"Tiêu đề";
    lblTitle.textAlignment = NSTextAlignmentLeft;
    
    _TxtFTitle = [[UITextField alloc] initWithFrame:CGRectMake(paddingX, lblTitle.frame.origin.y + lblTitle.frame.size.height + 2.5f, self.view.frame.size.width - 2.0f*paddingX, 30.0f)];
    _TxtFTitle.delegate = self;
    [_TxtFTitle setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f]];
    _TxtFTitle.placeholder = @"Góp ý";
    _TxtFTitle.tag = 31;
    [_TxtFTitle setBorderStyle:UITextBorderStyleRoundedRect];
    
    lblContent = [[UILabel alloc] initWithFrame:CGRectMake(paddingX, _TxtFTitle.frame.origin.y + _TxtFTitle.frame.size.height + 5.0f, self.view.frame.size.width - 2.0f*paddingX, 20.0f)];
    lblContent.backgroundColor = [UIColor clearColor];
    [lblContent setTextColor:[UIColor whiteColor]];
    [lblContent setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f]];
    lblContent.text = @"Nội dung (~ 10 dòng)";
    lblContent.textAlignment = NSTextAlignmentLeft;
    
    _TxtVContent = [[UITextView alloc] initWithFrame:CGRectMake(paddingX, lblContent.frame.origin.y + lblContent.frame.size.height + 2.5f, self.view.frame.size.width - 2.0f*paddingX, 200.0f)];
    _TxtVContent.delegate = self;
    _TxtVContent.layer.cornerRadius = 10.0f;
    [_TxtVContent setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14.0f]];
    _TxtVContent.tag = 40;
    
    
    btnSend = [UIButton buttonWithType:UIButtonTypeCustom];
    btnSend.frame = CGRectMake(0, 0, 100.0f, 40.0f);
    btnSend.center = CGPointMake(self.view.frame.size.width/2.0f, _TxtVContent.frame.origin.y + _TxtVContent.frame.size.height + 40.0f);
    [btnSend setTitle:@"Gửi" forState:UIControlStateNormal];
    [btnSend.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0f]];
    btnSend.backgroundColor = [UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f];
    btnSend.layer.cornerRadius = 8.0f;
    [btnSend addTarget:self action:@selector(sendFeedback) forControlEvents:UIControlEventTouchUpInside];
    
    btnReset = [UIButton buttonWithType:UIButtonTypeCustom];
    btnReset.frame = CGRectMake(self.view.frame.size.width - 90.0f, btnSend.frame.origin.y + btnSend.frame.size.height - 30.0f, 70.0f, 30.0f);
    btnReset.layer.cornerRadius = 5.0f;
    [btnReset setTitle:@"Hoàn tác" forState:UIControlStateNormal];
    [btnReset.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15.0f]];
    btnReset.backgroundColor = [UIColor grayColor];
    [btnReset addTarget:self action:@selector(resetForm) forControlEvents:UIControlEventTouchUpInside];
    
    
    lblPS = [[UILabel alloc] initWithFrame:CGRectMake(paddingX, btnSend.frame.origin.y + btnSend.frame.size.height + 5.0f, self.view.frame.size.width - 2.0f*paddingX, 40.0f)];
    lblPS.backgroundColor = [UIColor clearColor];
    [lblPS setTextColor:[UIColor whiteColor]];
    [lblPS setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18.0f]];
    lblPS.text = @"Cảm Ơn Phản Hồi Từ Bạn!";
    lblPS.textAlignment = NSTextAlignmentLeft;
    
    
    
    // Back
    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    btnBack.frame = CGRectMake(0, 0, 75.0f, 25.0f);
    [btnBack setImage:[UIImage imageNamed:@"BackButtonBarItem.png"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnBack];
    
    // Save
    btnSave = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnSave.frame = CGRectMake(0, 0, 70.0f, 30.0f);
    [btnSave setTitle:@"Hoàn tất" forState:UIControlStateNormal];
    btnSave.layer.cornerRadius = 5.0f;
    [btnSave addTarget:self action:@selector(commitEdit) forControlEvents:UIControlEventTouchUpInside];
    saveButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnSave];
    
    
    [_ScrollView addSubview:imaVBanner];
    [_ScrollView addSubview:lblFeedback];
    [_ScrollView addSubview:lblRating];
    [_ScrollView addSubview:btnLevel1];
    [_ScrollView addSubview:btnLevel2];
    [_ScrollView addSubview:btnLevel3];
    [_ScrollView addSubview:btnLevel4];
    [_ScrollView addSubview:btnLevel5];
    [_ScrollView addSubview:lblEmail];
    [_ScrollView addSubview:_TxtFEmail];
    [_ScrollView addSubview:lblTitle];
    [_ScrollView addSubview:_TxtFTitle];
    [_ScrollView addSubview:lblContent];
    [_ScrollView addSubview:_TxtVContent];
    [_ScrollView addSubview:btnSend];
    [_ScrollView addSubview:btnReset];
    [_ScrollView addSubview:lblPS];
    [self.view addSubview:_ScrollView];
    
}

-(void)updateRating:(UIButton*)sender
{
    switch (sender.tag) {
        case 111:
            [btnLevel1 setBackgroundColor:[UIColor colorWithRed:1.0f green:0.8f blue:0.8f alpha:1.0f]];
            [btnLevel2 setBackgroundColor:[UIColor colorWithRed:0.8f green:0.8f blue:0.8f alpha:1.0f]];
            [btnLevel3 setBackgroundColor:[UIColor colorWithRed:0.7f green:0.7f blue:0.7f alpha:1.0f]];
            [btnLevel4 setBackgroundColor:[UIColor colorWithRed:0.6f green:0.6f blue:0.6f alpha:1.0f]];
            [btnLevel5 setBackgroundColor:[UIColor colorWithRed:0.5f green:0.5f blue:0.5f alpha:1.0f]];
            break;
        case 112:
            [btnLevel1 setBackgroundColor:[UIColor colorWithRed:1.0f green:0.8f blue:0.8f alpha:1.0f]];
            [btnLevel2 setBackgroundColor:[UIColor colorWithRed:1.0f green:0.7f blue:0.7f alpha:1.0f]];
            [btnLevel3 setBackgroundColor:[UIColor colorWithRed:0.7f green:0.7f blue:0.7f alpha:1.0f]];
            [btnLevel4 setBackgroundColor:[UIColor colorWithRed:0.6f green:0.6f blue:0.6f alpha:1.0f]];
            [btnLevel5 setBackgroundColor:[UIColor colorWithRed:0.5f green:0.5f blue:0.5f alpha:1.0f]];
            break;
        case 113:
            [btnLevel1 setBackgroundColor:[UIColor colorWithRed:1.0f green:0.8f blue:0.8f alpha:1.0f]];
            [btnLevel2 setBackgroundColor:[UIColor colorWithRed:1.0f green:0.7f blue:0.7f alpha:1.0f]];
            [btnLevel3 setBackgroundColor:[UIColor colorWithRed:1.0f green:0.6f blue:0.6f alpha:1.0f]];
            [btnLevel4 setBackgroundColor:[UIColor colorWithRed:0.6f green:0.6f blue:0.6f alpha:1.0f]];
            [btnLevel5 setBackgroundColor:[UIColor colorWithRed:0.5f green:0.5f blue:0.5f alpha:1.0f]];
            break;
        case 114:
            [btnLevel1 setBackgroundColor:[UIColor colorWithRed:1.0f green:0.8f blue:0.8f alpha:1.0f]];
            [btnLevel2 setBackgroundColor:[UIColor colorWithRed:1.0f green:0.7f blue:0.7f alpha:1.0f]];
            [btnLevel3 setBackgroundColor:[UIColor colorWithRed:1.0f green:0.6f blue:0.6f alpha:1.0f]];
            [btnLevel4 setBackgroundColor:[UIColor colorWithRed:1.0f green:0.5f blue:0.5f alpha:1.0f]];
            [btnLevel5 setBackgroundColor:[UIColor colorWithRed:0.5f green:0.5f blue:0.5f alpha:1.0f]];
            break;
        case 115:
            [btnLevel1 setBackgroundColor:[UIColor colorWithRed:1.0f green:0.8f blue:0.8f alpha:1.0f]];
            [btnLevel2 setBackgroundColor:[UIColor colorWithRed:1.0f green:0.7f blue:0.7f alpha:1.0f]];
            [btnLevel3 setBackgroundColor:[UIColor colorWithRed:1.0f green:0.6f blue:0.6f alpha:1.0f]];
            [btnLevel4 setBackgroundColor:[UIColor colorWithRed:1.0f green:0.5f blue:0.5f alpha:1.0f]];
            [btnLevel5 setBackgroundColor:[UIColor colorWithRed:1.0f green:0.4f blue:0.4f alpha:1.0f]];
            break;
            
        default:
            break;
    }
}

-(void)sendFeedback
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    self.navigationItem.rightBarButtonItem = nil;
    [self sendFeedbackToServer];
    [_CoreGUI finishedScreen:self withCode:140];
}

-(void)sendFeedbackToServer
{
    // Nho xu ly khong ket noi duoc
    NSString *rawStr = [NSString stringWithFormat:@"id=%d&title=%@&content=%@&rating=%d&emailoption=%@", _IdUser, _TxtFTitle.text, _TxtVContent.text, rating, _TxtFEmail.text];
    NSData *data = [rawStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *stringURL = [[NSString stringWithFormat:@"http://vietgolfvn.com/admincp/api/index/feedback?id=%d&title=%@&content=%@&rating=%d&emailoption=%@", _IdUser, _TxtFTitle.text, _TxtVContent.text, rating, _TxtFEmail.text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:stringURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data];
    
    NSURLResponse *response;
    NSError *err;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    if (responseData != nil) {
    }
}


-(void)resetForm
{
    _TxtFEmail.text = @"";
    _TxtFTitle.text = @"";
    _TxtVContent.text = @"";
    [btnLevel1 setBackgroundColor:[UIColor colorWithRed:0.9f green:0.9f blue:0.9f alpha:1.0f]];
    [btnLevel2 setBackgroundColor:[UIColor colorWithRed:0.8f green:0.8f blue:0.8f alpha:1.0f]];
    [btnLevel3 setBackgroundColor:[UIColor colorWithRed:0.7f green:0.7f blue:0.7f alpha:1.0f]];
    [btnLevel4 setBackgroundColor:[UIColor colorWithRed:0.6f green:0.6f blue:0.6f alpha:1.0f]];
    [btnLevel5 setBackgroundColor:[UIColor colorWithRed:0.5f green:0.5f blue:0.5f alpha:1.0f]];
    [_ScrollView setContentOffset:CGPointMake(0, -60.0f) animated:YES];
}

-(void) popBack {
    [_CoreGUI._TabBar.tabBar setHidden:NO];
    self.navigationItem.rightBarButtonItem = nil;
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    [_CoreGUI finishedScreen:self withCode:140];
}

-(void)commitEdit
{
    [_TxtVContent resignFirstResponder];
    [_ScrollView setContentOffset:CGPointMake(0, 250.0f) animated:YES];
    [btnSave becomeFirstResponder];
    self.navigationItem.rightBarButtonItem = nil;
}


- (void)changeSwitchUpdate:(id)sender{
    if([sender isOn]){
        // Execute any code when the switch is ON
    } else{
        // Execute any code when the switch is OFF
    }
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag == 30)
    {
        [_ScrollView setContentOffset:CGPointMake(0, 70.0f) animated:YES];
    }
    else {
        if (textField.tag == 31) {
            [_ScrollView setContentOffset:CGPointMake(0, 100.0f) animated:YES];
        } else {
            [_ScrollView setContentOffset:CGPointMake(0, 64.0f) animated:YES];
        }
    }
    
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (textField.tag == 30)
    {
        [_ScrollView setContentOffset:CGPointMake(0, 90.0f) animated:YES];
        [_TxtFTitle becomeFirstResponder];
    }
    else {
        if (textField.tag == 31) {
            [_ScrollView setContentOffset:CGPointMake(0, 120.0f) animated:YES];
            [_TxtVContent becomeFirstResponder];
        } else {
            [_ScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
            
        }
    }
    
    return YES;
}

// TextView
-(BOOL)textView:(UITextView *)textView
shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    static const NSUInteger MAX_NUMBER_OF_LINES_ALLOWED = 11;
    
    NSMutableString *t = [NSMutableString stringWithString:textView.text];
    [t replaceCharactersInRange: range withString: text];
    
    NSUInteger numberOfLines = 0;
    for (NSUInteger i = 0; i < t.length; i++) {
        if ([[NSCharacterSet newlineCharacterSet]
             characterIsMember: [t characterAtIndex: i]]) {
            numberOfLines++;
        }
    }
    
    return (numberOfLines < MAX_NUMBER_OF_LINES_ALLOWED);
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [btnSave setBackgroundColor:[UIColor redColor]];
    [self.navigationItem.rightBarButtonItem setEnabled:YES];
    [_ScrollView setContentOffset:CGPointMake(0, 223.0f) animated:YES];
    self.navigationItem.rightBarButtonItem = saveButtonItem;
    return YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.backBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[UIBarButtonItem appearance] setTintColor:[UIColor whiteColor]];
    [_CoreGUI._TabBar.tabBar setHidden:YES];
    self.navigationItem.hidesBackButton = NO;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
