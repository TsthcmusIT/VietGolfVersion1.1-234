//
//  RecordSetting.h
//  VietGolfVersion1.1
//
//  Created by admin on 9/11/14.
//  Copyright (c) 2014 NguyenDuyThanh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecordSetting : NSObject
{
    NSString *_Delay;
    BOOL _AutoStop;
    BOOL _AutoTrim;

}

@property (nonatomic, retain) NSString *_Delay;
@property (nonatomic) BOOL _AutoStop;
@property (nonatomic) BOOL _AutoTrim;

@end
