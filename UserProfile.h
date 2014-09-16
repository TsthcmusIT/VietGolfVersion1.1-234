//
//  UserProfile.h
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserProfile : NSObject
{
    int _Id;
    NSString *_Gender;
    NSString *_City;
    NSString *_Country;
    NSString *_Email;
    NSString *_Password;
    NSString *_Image;
    NSString *_FullName;
    NSString *_UserType;
    NSString *_Birthday;
    BOOL _AllowNotification;
    BOOL _AllowUpdate;
    BOOL _Status;
    int _NumLike;
    int _NumFavorited;
    int _NumPublic;
}

@property (nonatomic) int _Id;
@property (nonatomic, retain) NSString *_Image;
@property (nonatomic, retain) NSString *_Gender;
@property (nonatomic, retain) NSString *_City;
@property (nonatomic, retain) NSString *_Country;
@property (nonatomic, retain) NSString *_Email;
@property (nonatomic, retain) NSString *_Password;
@property (nonatomic, retain) NSString *_FullName;
@property (nonatomic, retain) NSString *_UserType;
@property (nonatomic, retain) NSString *_Birthday;
@property (nonatomic) BOOL _AllowNotification;
@property (nonatomic) BOOL _AllowUpdate;
@property (nonatomic) BOOL _Status;
@property (nonatomic) int _NumLike;
@property (nonatomic) int _NumFavorited;
@property (nonatomic) int _NumPublic;


@end
