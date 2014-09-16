//
//  QBAnimationItem.m
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import "QBAnimationItem.h"

@implementation QBAnimationItem

@synthesize _Animations, _Delay, _Duration, _Options;

+ (instancetype)item
{
    return [[self alloc] init];
}

+ (instancetype)itemWithDuration:(CGFloat)duration delay:(CGFloat)delay options:(UIViewAnimationOptions)options animations:(QBAnimationBlock)animations
{
    return [[self alloc] initWithDuration:duration delay:delay options:options animations:animations];
}

- (instancetype)initWithDuration:(CGFloat)duration delay:(CGFloat)delay options:(UIViewAnimationOptions)options animations:(QBAnimationBlock)animations
{
    self = [super init];
    
    if (self) {
        self._Duration = duration;
        self._Delay = delay;
        self._Options = options;
        self._Animations = animations;
    }
    
    return self;
}

- (instancetype)init
{
    return [self initWithDuration:0 delay:0 options:UIViewAnimationOptionCurveLinear animations:NULL];
}


@end
