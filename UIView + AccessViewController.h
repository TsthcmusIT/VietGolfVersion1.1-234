//
//  UIView + AccessViewController.h
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AccessViewController)

- (UIViewController *)viewController DEPRECATED_ATTRIBUTE;
- (UIViewController *)firstAvailableUIViewController;
- (id) traverseResponderChainForUIViewController;

@end
