//
//  QBAnimationSequence.h
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, QBAnimationSequenceState) {
    QBAnimationSequenceStatePlaying,
    QBAnimationSequenceStateStopped
};

@interface QBAnimationSequence : NSObject

@property (nonatomic, copy) NSArray *_Groups;
@property (nonatomic, assign) BOOL _Repeat;

+ (instancetype)sequence;
+ (instancetype)sequenceWithAnimationGroups:(NSArray *)groups;
+ (instancetype)sequenceWithAnimationGroups:(NSArray *)groups repeat:(BOOL)repeat;

- (instancetype)initWithAnimationGroups:(NSArray *)groups;
- (instancetype)initWithAnimationGroups:(NSArray *)groups repeat:(BOOL)repeat;

- (void)start;
- (void)stop;


@end
