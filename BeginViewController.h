//
//  BeginViewController.h
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import "AbstractViewController.h"

@interface BeginViewController : AbstractViewController <UIScrollViewDelegate>
{
    UIScrollView *_ScrollView;
    UIImageView *imageView;
        
    UIView *viewProcessC;
    UIActivityIndicatorView *spinnerC;
}

@property (nonatomic, retain) UIScrollView *_ScrollView;

@end
