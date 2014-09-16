//
//  SVideoInCommunity.h
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SVideoInCommunity : NSObject
{
    int _Id;
    NSString *_PathVideo;
    NSString *_PathThumnail;
    NSString *_Link;
    NSString *_Owner;
    NSString *_GolfTree;
    NSDate *_Date;
    int _Like;
    BOOL _Liked;
}

@property (nonatomic) int _Id;
@property (nonatomic, retain) NSString *_PathVideo;
@property (nonatomic, retain) NSString *_PathThumnail;
@property (nonatomic, retain) NSString *_Link;
@property (nonatomic, retain) NSString *_Owner;
@property (nonatomic, retain) NSString *_GolfTree;
@property (nonatomic, retain) NSDate *_Date;
@property (nonatomic) int _Like;
@property (nonatomic) BOOL _Liked;

@end
