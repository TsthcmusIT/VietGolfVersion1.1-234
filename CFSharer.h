//
//  CFSharer.h
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface CFSharer : NSObject

@property (nonatomic, retain) NSString *_Name;
@property (nonatomic, retain) UIImage *_Image;

/**
 Initialize a custom sharer with the name that will be presented when hovering over and the name of the image.
 */
- (id)initWithName:(NSString *)name imageName:(NSString *)imageName;

+ (CFSharer *)mail;
+ (CFSharer *)cameraRoll;
+ (CFSharer *)dropbox;
+ (CFSharer *)evernote;
+ (CFSharer *)facebook;
+ (CFSharer *)googleDrive;
+ (CFSharer *)pinterest;
+ (CFSharer *)twitter;
+ (CFSharer *)airPrint;

@end
