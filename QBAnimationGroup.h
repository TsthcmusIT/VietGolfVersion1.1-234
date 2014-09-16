//
//  QBAnimationGroup.h
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QBAnimationItem;

@interface QBAnimationGroup : NSObject

@property (nonatomic, copy) NSArray *_Items;
@property (nonatomic, assign) BOOL _WaitUntilDone;

+ (instancetype)group;
+ (instancetype)groupWithItem:(QBAnimationItem *)item;
+ (instancetype)groupWithItems:(NSArray *)items;

- (instancetype)initWithItem:(QBAnimationItem *)item;
- (instancetype)initWithItems:(NSArray *)items;

@end
