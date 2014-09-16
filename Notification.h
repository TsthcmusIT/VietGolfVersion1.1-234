//
//  Notification.h
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Notification : NSObject
{
    int _Id;
    NSString *_Title;
    NSString *_Link;
    BOOL _Checked;
    NSDate *_Time;
}

@property (nonatomic) int _Id;
@property (nonatomic, retain) NSString *_Title;
@property (nonatomic, retain) NSString *_Link;
@property (nonatomic) BOOL _Checked;
@property (nonatomic, retain) NSDate *_Time;

@end
