//
//  FeedbackViewController.h
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import "AbstractViewController.h"

@interface FeedbackViewController : AbstractViewController <UITextFieldDelegate, UIScrollViewDelegate, UITextViewDelegate>
{
    UIScrollView *_ScrollView;
    
    UIImageView *imaVBanner;
    UILabel *lblFeedback;
    
    UILabel *lblEmail;
    UITextField *_TxtFEmail;
    UILabel *lblTitle;
    UITextField *_TxtFTitle;
    UILabel *lblContent;
    UITextView *_TxtVContent;
    
    UILabel *lblRating;
    UIButton *btnLevel1;
    UIButton *btnLevel2;
    UIButton *btnLevel3;
    UIButton *btnLevel4;
    UIButton *btnLevel5;
    UIButton *btnSend;
    UIButton *btnReset;
    
    UILabel *lblPS;
    
    UIButton *btnSave;
    UIBarButtonItem *saveButtonItem;
    int _IdUser;
    int rating;
    
}

@property (nonatomic, retain) UITextField *_TxtFEmail;
@property (nonatomic, retain) UITextField *_TxtFTitle;
@property (nonatomic, retain) UITextView *_TxtVContent;
@property (nonatomic) int _IdUser;

-(void)sendFeedbackToServer;

@end
