//
//  ImportVideoViewController.m
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import "ImportVideoViewController.h"
#import "CoreGUIController.h"
#import "SVideoInfo.h"

@interface ImportVideoViewController ()

@end

@implementation ImportVideoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _ScreenName = ImportScreen;
    self.navigationItem.hidesBackButton = YES;
    videoInfo = [[SVideoInfo alloc] init];
    if ([[UIScreen mainScreen] bounds].size.height >= 568.0f)
    {
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.height);
    }
    else
    {
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.height);
    }
    [self startMediaBrowserFromViewController:self usingDelegate:self];
}

-(BOOL)startMediaBrowserFromViewController:(UIViewController*)controller usingDelegate:(id )delegate
{
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f]];
    
    // 1 - Validations
    if (([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary] == NO)
        || (delegate == nil)
        || (controller == nil))
    {
        return NO;
    }
    // 2 - Get image picker
    UIImagePickerController *mediaUI = [[UIImagePickerController alloc] init];
    mediaUI.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    mediaUI.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    mediaUI.allowsEditing = YES;
    mediaUI.navigationBarHidden = YES;
    mediaUI.toolbarHidden = YES;
    
    mediaUI.delegate = delegate;
    // 3 - Display image picker
    [controller presentViewController:mediaUI animated:YES completion:nil];
    return YES;
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
   
    // 1 - Get media type
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    // 2 - Dismiss image picker
    [self dismissViewControllerAnimated:NO completion:nil];
    // Handle a movie capture
    if (CFStringCompare ((__bridge_retained CFStringRef)mediaType, kUTTypeMovie, 0) == kCFCompareEqualTo)
    {
        // 3 - Play the video
        NSString *moviePath = (NSString*)[[info objectForKey:UIImagePickerControllerMediaURL] path];
        videoInfo._PathVideo = moviePath;
        //MPMoviePlayerViewController *theMovie = [[MPMoviePlayerViewController alloc]
        //initWithContentURL:[info objectForKey:UIImagePickerControllerMediaURL]];
        
        //[self presentMoviePlayerViewControllerAnimated:theMovie];
        // 4 - Register for the playback finished notification
        //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(myMovieFinishedCallback:)
        // name:MPMoviePlayerPlaybackDidFinishNotification object:theMovie];
        [_CoreGUI finishedCreateVideoVC:self withVideoInfo:videoInfo];
        [_CoreGUI finishedScreen:self withCode:22];
    }
}

// When the movie is done, release the controller.
-(void)myMovieFinishedCallback:(NSNotification*)aNotification
{
    [self dismissMoviePlayerViewControllerAnimated];
    MPMoviePlayerController* theMovie = [aNotification object];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification object:theMovie];
}

// For responding to the user tapping Cancel.
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [_CoreGUI finishedScreen:self withCode:120];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationItem.hidesBackButton = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
