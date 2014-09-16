//
//  ChooseCommunityViewController.m
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import "ChooseCommunityViewController.h"
#import "CoreGUIController.h"

@interface ChooseCommunityViewController ()

@end

@implementation ChooseCommunityViewController

@synthesize isViewShowing;
@synthesize shareCircleView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _ScreenName = ChooseCommunity;
    self.navigationItem.title = @"Chia sẻ ứng dụng";
    self.view.backgroundColor = [UIColor blackColor];
    
    self.shareCircleView = [[CFShareCircleView alloc] init];
    self.shareCircleView.delegate = self;
    
    UIButton *btnCommunity = [[UIButton alloc] initWithFrame:CGRectMake(50.0f, 150.0f, 220.0f, 220.0f)];
    [btnCommunity setBackgroundImage:[UIImage imageNamed:@"CommunityIcon.png"] forState:UIControlStateNormal];
    btnCommunity.backgroundColor = [UIColor clearColor];
    [btnCommunity addTarget:self action:@selector(shareWithCommunity) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btnCommunity];
}




#pragma mark - MFMailComposeViewControllerDelegate methods
-(void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            break;
        case MFMailComposeResultSaved:
            break;
        case MFMailComposeResultSent:
            break;
        case MFMailComposeResultFailed:
            if (1 == 1) {
                UIAlertView *alertInvalidEmail = [[UIAlertView alloc] initWithTitle:@"Lỗi" message:@"Không thể gửi mail!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertInvalidEmail show];
            }
            break;
        default:
            break;
    }
    
    // close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}


- (void)shareCircleView:(CFShareCircleView *)shareCircleView didSelectSharer:(CFSharer *)sharer {
    if ([sharer._Name isEqualToString:@"Facebook"]) {
        if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
        {
            // Good to go! Create a compose view controller and set it's parameters. Note that the compose view controller is different from the
            // viewController passed into the function, the latter acting as the container parent of the former.
            SLComposeViewController *compose = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
            // Add the image to the view controller.
            [compose addImage:[UIImage imageNamed:@"VietGolfLogo.png"]];
            
            [compose setInitialText:@"Viet Golf - Ứng dụng dành cho nền tảng iOS - Giúp người dùng tạo các swing video bằng cách record, import hoặc có thể tải những swing video được chia sẽ trên trang cộng đồng . Khi đó, người dùng có thể xem lại, phân tích và thảo luận! Để có tài khoản Viet Golf, sử dụng email để tiến hành đăng ký!"];
            
            [self presentViewController:compose animated:YES completion:nil];
            
        }
        else
        {
            // You should probably display an alert to the user here.
            UIAlertView *alertS = [[UIAlertView alloc] initWithTitle:@"Lỗi" message:@"Lỗi kết nối hoặc server hiện tại không hoạt động!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertS show];

        }
        
    }
    else
    {
        if ([sharer._Name isEqualToString:@"Twitter"]) {
            if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
            {
                SLComposeViewController *tweetSheet = [SLComposeViewController
                                                       composeViewControllerForServiceType:SLServiceTypeTwitter];
                [tweetSheet setInitialText:@"Viet Golf - Ứng dụng dành cho nền tảng iOS - Giúp người dùng tạo các swing video bằng cách record, import hoặc có thể tải những swing video được chia sẽ trên trang cộng đồng . Khi đó, người dùng có thể xem lại, phân tích và thảo luận! Để có tài khoản Viet Golf, sử dụng email để tiến hành đăng ký!"];
                [tweetSheet addImage:[UIImage imageNamed:@"VietGolfLogo.png"]];
                [self presentViewController:tweetSheet animated:YES completion:nil];
            }
            else
            {
                // You should probably display an alert to the user here.
                UIAlertView *alertS = [[UIAlertView alloc] initWithTitle:@"Lỗi" message:@"Lỗi kết nối hoặc server hiện tại không hoạt động!"  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertS show];
            }
        }
        else
        {
            //email subject
            NSString * subject = @"VietGolf - App for iOS ";
            //email body
            NSString * body = @"Viet Golf - Ứng dụng dành cho nền tảng iOS - Giúp người dùng tạo các swing video bằng cách record, import hoặc có thể tải những swing video được chia sẽ trên trang cộng đồng . Khi đó, người dùng có thể xem lại, phân tích và thảo luận! Để có tài khoản Viet Golf, sử dụng email để tiến hành đăng ký!";
            //recipient(s)
            NSArray * recipients = [NSArray arrayWithObjects:@"anonymous@mail.com", nil];
            
            //create the MFMailComposeViewController
            MFMailComposeViewController * composer = [[MFMailComposeViewController alloc] init];
            composer.mailComposeDelegate = self;
            [composer setSubject:subject];
            [composer setMessageBody:body isHTML:NO];
            [composer setToRecipients:recipients];
            
            //get the filepath from resources
            NSString *filePath = [[NSBundle mainBundle] pathForResource:@"VietGolfLogo" ofType:@"png"];
            
            //read the file using NSData
            NSData * fileData = [NSData dataWithContentsOfFile:filePath];
            // Set the MIME type
            /*you can use :
             - @"application/msword" for MS Word
             - @"application/vnd.ms-powerpoint" for PowerPoint
             - @"text/html" for HTML file
             - @"application/pdf" for PDF document
             - @"image/jpeg" for JPEG/JPG images
             */
            NSString *mimeType = @"image/png";
            
            //add attachement
            [composer addAttachmentData:fileData mimeType:mimeType fileName:filePath];
            
            //present it on the screen
            [self presentViewController:composer animated:YES completion:NULL];
            
        }
        
    }
}


- (void)shareCircleCanceled:(NSNotification *)notification{
}


-(void)shareWithCommunity
{
    [self.shareCircleView showAnimated:YES];
}


- (void)viewDidAppear:(BOOL)animated {
    self.isViewShowing = YES;
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
}


- (void)viewWillDisappear:(BOOL)animated {
    self.isViewShowing = NO;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [super viewWillDisappear:animated];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
