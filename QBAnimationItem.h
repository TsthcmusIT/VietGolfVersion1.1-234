//
//  QBAnimationItem.h
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^QBAnimationBlock)(void);

@interface QBAnimationItem : NSObject

@property (nonatomic, assign) CGFloat _Duration;
@property (nonatomic, assign) CGFloat _Delay;
@property (nonatomic, assign) UIViewAnimationOptions _Options;
@property (nonatomic, copy) QBAnimationBlock _Animations;

+ (instancetype)item;
+ (instancetype)itemWithDuration:(CGFloat)duration delay:(CGFloat)delay options:(UIViewAnimationOptions)options animations:(QBAnimationBlock)animations;

- (instancetype)initWithDuration:(CGFloat)duration delay:(CGFloat)delay options:(UIViewAnimationOptions)options animations:(QBAnimationBlock)animations;

@end
