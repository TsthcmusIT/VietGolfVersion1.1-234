//
//  HowToUseViewController.h
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import "AbstractViewController.h"

@interface HowToUseViewController : AbstractViewController <UIScrollViewDelegate, UIPageViewControllerDelegate>
{
    UIScrollView *_ScrollView;
    int numPages;
    UIPageControl *pageControl;
    NSArray *arrImage;
    
    UIButton *btnExit;
    CGSize btnSize;
}

@property (nonatomic, retain) UIScrollView *_ScrollView;

@end
