//
//  QBAnimationSequence.m
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import "QBAnimationSequence.h"
#import "QBAnimationGroup.h"
#import "QBAnimationItem.h"

@interface QBAnimationSequence ()

@property (nonatomic, assign) BOOL _Running;
@property (nonatomic, assign) NSUInteger _CurrentGroup;
@property (nonatomic, assign) NSUInteger _FinishedCount;

- (void)performNextGroup;
- (void)animationFinished;

@end

@implementation QBAnimationSequence

@synthesize _CurrentGroup, _FinishedCount, _Groups, _Repeat, _Running;

+ (instancetype)sequence
{
    return [[self alloc] init];
}

+ (instancetype)sequenceWithAnimationGroups:(NSArray *)groups
{
    return [[self alloc] initWithAnimationGroups:groups];
}

+ (instancetype)sequenceWithAnimationGroups:(NSArray *)groups repeat:(BOOL)repeat
{
    return [[self alloc] initWithAnimationGroups:groups repeat:repeat];
}

- (instancetype)initWithAnimationGroups:(NSArray *)groups
{
    return [self initWithAnimationGroups:groups repeat:NO];
}

- (instancetype)initWithAnimationGroups:(NSArray *)groups repeat:(BOOL)repeat
{
    self = [super init];
    
    if (self) {
        self._Groups = groups;
        self._Repeat = repeat;
        
        self._Running = NO;
    }
    
    return self;
}

- (instancetype)init
{
    return [self initWithAnimationGroups:nil repeat:NO];
}


#pragma mark - Animation

- (void)start
{
    if (self._Running) return;
    
    self._Running = YES;
    
    self._CurrentGroup = 0;
    self._FinishedCount = 0;
    
    [self performNextGroup];
}

- (void)stop
{
    self._Running = NO;
}

- (void)performNextGroup
{
    if (!self._Running) return;
    
    if (self._CurrentGroup >= self._Groups.count) {
        if (self._Repeat) {
            self._Running = NO;
            
            [self start];
        }
        
        return;
    }
    
    QBAnimationGroup *group = (QBAnimationGroup *)[self._Groups objectAtIndex:self._CurrentGroup];
    
    for (NSInteger i = 0; i < group._Items.count; i++) {
        QBAnimationItem *item = (QBAnimationItem *)[group._Items objectAtIndex:i];
        
        if (group._WaitUntilDone) {
            [UIView animateWithDuration:item._Duration delay:item._Delay options:item._Options animations:item._Animations completion:^(BOOL finished) {
                if (finished) {
                    [self animationFinished];
                }
                else {
                    self._Running = NO;
                }
            }];
        } else {
            [UIView animateWithDuration:item._Duration delay:item._Delay options:item._Options animations:item._Animations completion:nil];
        }
    }
    
    if (!group._WaitUntilDone) {
        self._CurrentGroup++;
        
        [self performNextGroup];
    }
}

- (void)animationFinished
{
    self._FinishedCount++;
    
    QBAnimationGroup *group = (QBAnimationGroup *)[self._Groups objectAtIndex:self._CurrentGroup];
    
    if (self._FinishedCount == group._Items.count) {
        self._FinishedCount = 0;
        
        self._CurrentGroup++;
        [self performNextGroup];
    }
}
@end


