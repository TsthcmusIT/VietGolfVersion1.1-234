//
//  PullableView.h
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PullableView;

/**
 Protocol for objects that wish to be notified when the state of a
 PullableView changes
 */
@protocol PullableViewDelegate <NSObject>

/**
 Notifies of a changed state
 @param pView PullableView whose state was changed
 @param opened The new state of the view
 */
- (void)pullableView:(PullableView *)pView didChangeState:(BOOL)isopened;

@end


@interface PullableView : UIView
{
    CGPoint _ClosedCenter;
    CGPoint _OpenedCenter;
    
    UIView *_HandleView;
    UIImageView *_ImageHandle;
    UIPanGestureRecognizer *_DragRecognizer;
    UITapGestureRecognizer *_TapRecognizer;
    
    CGPoint _StartPos;
    CGPoint _MinPos;
    CGPoint _MaxPos;
    
    BOOL _Opened;
    BOOL _VerticalAxis;

    BOOL _ToggleOnTap;
    
    BOOL _Animate;
    float _AnimationDuration;
    
    id <PullableViewDelegate> _DelegateH;
    
}


@property (nonatomic, retain) UIImageView *_ImageHandle;
/**
 The view that is used as the handle for the PullableView. You
 can style it, add subviews or set its frame at will.
 */
@property (nonatomic,readonly) UIView *_HandleView;

/**
 The point that defines the center of the view when in its closed
 state. You must set this before using the PullableView.
 */
@property (readwrite,assign) CGPoint _ClosedCenter;

/**
 The point that defines the center of the view when in its opened
 state. You must set this before using the PullableView.
 */
@property (readwrite,assign) CGPoint _OpenedCenter;

/**
 Gesture recognizer responsible for the dragging of the handle view.
 It is exposed as a property so you can change the number of touches
 or created dependencies to other recognizers in your views.
 */
@property (nonatomic,readonly) UIPanGestureRecognizer *_DragRecognizer;

/**
 Gesture recognizer responsible for handling tapping of the handle view.
 It is exposed as a property so you can change the number of touches
 or created dependencies to other recognizers in your views.
 */
@property (nonatomic,readonly) UITapGestureRecognizer *_TapRecognizer;

/**
 If set to YES, tapping the handle view will toggle the PullableView.
 Default value is YES.
 */
@property (readwrite,assign) BOOL _ToggleOnTap;

/**
 If set to YES, the opening or closing of the PullableView will
 be animated. Default value is YES.
 */
@property (readwrite,assign) BOOL _Animate;

/**
 Duration of the opening/closing animation, if enabled. Default
 value is 0.2.
 */
@property (readwrite,assign) float _AnimationDuration;

/**
 Delegate that will be notified when the PullableView changes state.
 If the view is set to animate transitions, the delegate will be
 called only when the animation finishes.
 */
@property (nonatomic,retain) id<PullableViewDelegate> _DelegateH;

/**
 The current state of the `PullableView`.
 */
@property (readonly, assign) BOOL _Opened;

/**
 Toggles the state of the PullableView
 @param op New state of the view
 @param anim Flag indicating if the transition should be animated
 */
- (void)setOpened:(BOOL)op animated:(BOOL)anim;

@end



