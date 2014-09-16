//
//  SVideoInfo.h
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SVideoInfo : NSObject
{
    int _Id;
    NSString *_PathVideo;
    NSString *_PathCompare;
    NSString *_Thumnail;
    NSString *_VideoType;
    NSDate *_Time;
    NSString *_GolfTree;
    NSString *_Owner;
    BOOL _Voice;
    BOOL _IsFavorited;
    BOOL _IsPosted;
    BOOL _Prepare;
}

@property (nonatomic, retain) NSString *_PathVideo;
@property (nonatomic, retain) NSString *_PathCompare;
@property (nonatomic, retain) NSString *_Thumnail;
@property (nonatomic, retain) NSString *_VideoType;
@property (nonatomic, retain) NSDate *_Time;
@property (nonatomic, retain) NSString *_GolfTree;
@property (nonatomic, retain) NSString *_Owner;
@property (nonatomic) int _Id;
@property (nonatomic) BOOL _Voice;
@property (nonatomic) BOOL _IsFavorited;
@property (nonatomic) BOOL _IsPosted;
@property (nonatomic) BOOL _Prepare;

@end
