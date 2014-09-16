//
//  CompletedCreateVideoViewController.h
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>

#import "AbstractViewController.h"
#import "RecordVideoViewController.h"
#import "SwingVideoTableViewController.h"
#import "SVideoInfo.h"

@interface CompletedCreateVideoViewController : AbstractViewController <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, UIAlertViewDelegate, MPMediaPickerControllerDelegate>
{
    NSMutableArray *golferArray;
    NSMutableArray *arrayOfVideo;
    SVideoInfo *_VideoInfoC;
    
    UIButton *btnPlay;
    UIView *viewUserName;
    UIButton *btnUserName;
    UITextField *txtFUserName;
    UIView *viewGolfTree;
    UIButton *btnGolfTree;
    UIButton *btnValueGolfTree;
    UIPickerView *picVGolfTree;
    UIView *viewPost;
    UIButton *btnPost;
    UISwitch *switchPost;
    
    UILabel *lblSuggest;
    
    UIView *viewBackground;
    UIView *viewTitle;
    UIButton *btnDone;
    
    BOOL isShowSuggest;
    
}

@property (nonatomic, retain) SVideoInfo *_VideoInfoC;

-(NSString*)getThumnailAndWriteToNSDocumentDictionary;

@end
