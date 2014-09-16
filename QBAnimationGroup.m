//
//  QBAnimationGroup.m
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import "QBAnimationGroup.h"
#import "QBAnimationItem.h"

@implementation QBAnimationGroup

@synthesize _Items, _WaitUntilDone;

+ (instancetype)group
{
    return [[self alloc] init];
}

+ (instancetype)groupWithItem:(QBAnimationItem *)item
{
    return [[self alloc] initWithItem:item];
}

+ (instancetype)groupWithItems:(NSArray *)items
{
    return [[self alloc] initWithItems:items];
}

- (instancetype)initWithItem:(QBAnimationItem *)item
{
    return [self initWithItems:[NSArray arrayWithObject:item]];
}

- (instancetype)initWithItems:(NSArray *)items
{
    self = [super init];
    
    if (self) {
        self._Items = items;
        self._WaitUntilDone = YES;
    }
    
    return self;
}

- (instancetype)init
{
    return [self initWithItems:nil];
}


@end
