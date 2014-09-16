//
//  Draw2D.h
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/CALayer.h>
#import "SwingVideoTableViewController.h"

@interface Draw2D : UIView
{
    BOOL _Line;
    BOOL _Circle;
    BOOL _Curve;
    BOOL _Rect;
    CGPoint _FirstTouch;
    CGPoint _LastTouch;
    
    CGPoint _FirstTouchCircle;
    CGPoint _LastTouchCircle;
    
    CGPoint _FirstTouchRect;
    CGPoint _LastTouchRect;
}

@property BOOL _Line;
@property BOOL _Circle;
@property BOOL _Curve;
@property BOOL _Rect;
@property CGPoint _FirstTouch;
@property CGPoint _LastTouch;
@property CGPoint _FirstTouchCircle;
@property CGPoint _LastTouchCircle;
@property CGPoint _FirstTouchRect;
@property CGPoint _LastTouchRect;

-(void)addLA;
-(void)clear;
-(void)setlineWidth:(float)width;

@end
