//
//  ImportVideoViewController.h
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import "AbstractViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import <MediaPlayer/MediaPlayer.h>
#import "SVideoInfo.h"

@interface ImportVideoViewController : AbstractViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    SVideoInfo *videoInfo;
}

-(BOOL)startMediaBrowserFromViewController:(UIViewController*)controller usingDelegate:(id )delegate;
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;
-(void)myMovieFinishedCallback:(NSNotification*)aNotification;
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker;

@end
