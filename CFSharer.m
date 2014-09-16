//
//  CFSharer.m
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import "CFSharer.h"

@implementation CFSharer

@synthesize _Name;
@synthesize _Image;

- (id)initWithName:(NSString *)name imageName:(NSString *)imageName {
    self = [super init];
    if (self) {
        _Name = name;
        _Image = [UIImage imageNamed:imageName];
    }
    return self;
}

+ (CFSharer *)mail {
    return [[CFSharer alloc] initWithName:@"Mail" imageName:@"ShareAppWithEmail.png"];
}

+ (CFSharer *)cameraRoll {
    return [[CFSharer alloc] initWithName:@"Camera Roll" imageName:@"ShareAppWithEmail.png"];
}

+ (CFSharer *)dropbox {
    return [[CFSharer alloc] initWithName:@"Dropbox" imageName:@"dropbox.png"];
}

+ (CFSharer *)evernote {
    return [[CFSharer alloc] initWithName:@"Evernote" imageName:@"ShareAppWithEmail.png"];
}

+ (CFSharer *)facebook {
    return [[CFSharer alloc] initWithName:@"Facebook" imageName:@"ButtonFacebook.png"];
}

+ (CFSharer *)googleDrive {
    return [[CFSharer alloc] initWithName:@"Google Drive" imageName:@"ShareAppWithEmail.png"];
}

+ (CFSharer *)pinterest {
    return [[CFSharer alloc] initWithName:@"Pinterest" imageName:@"ShareAppWithEmail.png"];
}

+ (CFSharer *)twitter {
    return [[CFSharer alloc] initWithName:@"Twitter" imageName:@"ButtonTwitter.png"];
}

+ (CFSharer *)airPrint {
    return [[CFSharer alloc] initWithName:@"AirPrint" imageName:@"ShareAppWithEmail.png"];
}


@end
