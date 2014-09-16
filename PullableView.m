//
//  PullableView.m
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import "PullableView.h"

@implementation PullableView

@synthesize _ImageHandle;
@synthesize _HandleView;
@synthesize _ClosedCenter;
@synthesize _OpenedCenter;
@synthesize _DragRecognizer;
@synthesize _TapRecognizer;
@synthesize _Animate;
@synthesize _AnimationDuration;
@synthesize _DelegateH;
@synthesize _Opened;
@synthesize _ToggleOnTap;


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _Animate = YES;
        _AnimationDuration = 0.2f;
        self.backgroundColor = [UIColor redColor];
        _ToggleOnTap = YES;
        
        // Creates the handle view. Subclasses should resize, reposition and style this view
        _HandleView = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width - 40.0f, 0, 40.0f, frame.size.height)];
        [self addSubview:_HandleView];
        
        _DragRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleDrag:)];
        _DragRecognizer.minimumNumberOfTouches = 1;
        _DragRecognizer.maximumNumberOfTouches = 1;
        
        [_HandleView addGestureRecognizer:_DragRecognizer];
        
        _TapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        _TapRecognizer.numberOfTapsRequired = 1;
        _TapRecognizer.numberOfTouchesRequired = 1;
        
        [_HandleView addGestureRecognizer:_TapRecognizer];
        
        _ImageHandle = [[UIImageView alloc] init];
        [self addSubview:_ImageHandle];
        
        
        _Opened = NO;
        
    }
    return self;
}

-(void)handleDrag:(UIPanGestureRecognizer *)sender {
    
    if ([sender state] == UIGestureRecognizerStateBegan) {
        
        _StartPos = self.center;
        
        // Determines if the view can be pulled in the x or y axis
        _VerticalAxis = _ClosedCenter.x == _OpenedCenter.x;
        
        // Finds the minimum and maximum points in the axis
        if (_VerticalAxis) {
            _MinPos = _ClosedCenter.y < _OpenedCenter.y ? _ClosedCenter : _OpenedCenter;
            _MaxPos = _ClosedCenter.y > _OpenedCenter.y ? _ClosedCenter : _OpenedCenter;
        } else {
            _MinPos = _ClosedCenter.x < _OpenedCenter.x ? _ClosedCenter : _OpenedCenter;
            _MaxPos = _ClosedCenter.x > _OpenedCenter.x ? _ClosedCenter : _OpenedCenter;
        }
        
    } else if ([sender state] == UIGestureRecognizerStateChanged) {
        
        CGPoint translate = [sender translationInView:self.superview];
        
        CGPoint newPos;
        
        // Moves the view, keeping it constrained between openedCenter and closedCenter
        if (_VerticalAxis) {
            
            newPos = CGPointMake(_StartPos.x, _StartPos.y + translate.y);
            
            if (newPos.y < _MinPos.y) {
                newPos.y = _MinPos.y;
                translate = CGPointMake(0, newPos.y - _StartPos.y);
            }
            
            if (newPos.y > _MaxPos.y) {
                newPos.y = _MaxPos.y;
                translate = CGPointMake(0, newPos.y - _StartPos.y);
            }
        } else {
            
            newPos = CGPointMake(_StartPos.x + translate.x, _StartPos.y);
            
            if (newPos.x < _MinPos.x) {
                newPos.x = _MinPos.x;
                translate = CGPointMake(newPos.x - _StartPos.x, 0);
            }
            
            if (newPos.x > _MaxPos.x) {
                newPos.x = _MaxPos.x;
                translate = CGPointMake(newPos.x - _StartPos.x, 0);
            }
        }
        
        [sender setTranslation:translate inView:self.superview];
        
        self.center = newPos;
        
    } else if ([sender state] == UIGestureRecognizerStateEnded) {
        
        // Gets the velocity of the gesture in the axis, so it can be
        // determined to which endpoint the state should be set.
        
        CGPoint vectorVelocity = [sender velocityInView:self.superview];
        CGFloat axisVelocity = _VerticalAxis ? vectorVelocity.y : vectorVelocity.x;
        
        CGPoint target = axisVelocity < 0 ? _MinPos : _MaxPos;
        BOOL op = CGPointEqualToPoint(target, _OpenedCenter);
        
        [self setOpened:op animated:_Animate];
    }
}

-(void)handleTap:(UITapGestureRecognizer *)sender {
    
    if ([sender state] == UIGestureRecognizerStateEnded) {
        [self setOpened:!_Opened animated:_Animate];
    }
}

-(void)setToggleOnTap:(BOOL)tap {
    _ToggleOnTap = tap;
    _TapRecognizer.enabled = tap;
}

-(BOOL)toggleOnTap {
    return _ToggleOnTap;
}

-(void)setOpened:(BOOL)op animated:(BOOL)anim {
    _Opened = op;
    
    if (anim) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:_AnimationDuration];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    }
    
    self.center = _Opened ? _OpenedCenter : _ClosedCenter;
    
    if (anim) {
        
        // For the duration of the animation, no further interaction with the view is permitted
        _DragRecognizer.enabled = NO;
        _TapRecognizer.enabled = NO;
        [UIView commitAnimations];
        
    } else {
        
        if ([_DelegateH respondsToSelector:@selector(pullableView:didChangeState:)]) {
            [_DelegateH pullableView:self didChangeState:_Opened];
        }
    }
}

-(void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    if (finished) {
        // Restores interaction after the animation is over
        _DragRecognizer.enabled = YES;
        _TapRecognizer.enabled = _ToggleOnTap;
        
        if ([_DelegateH respondsToSelector:@selector(pullableView:didChangeState:)]) {
            [_DelegateH pullableView:self didChangeState:_Opened];
        }
    }
}

-(void)pullableView:(PullableView *)pView didChangeState:(BOOL)isopened {
}

@end



