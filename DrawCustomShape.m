//
//  DrawCustomShape.m
//  VietGolfVersion1.1
//
//  Created by admin on 9/16/14.
//  Copyright (c) 2014 NguyenDuyThanh. All rights reserved.
//

#import "DrawCustomShape.h"

@implementation DrawCustomShape

@synthesize _MyStartPoint, _MyEndPoint;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _MyStartPoint = CGPointMake(self.frame.size.width/2.0f, self.frame.size.height/2.0f);
        _MyEndPoint = CGPointMake(self.frame.size.width/2.0f + self.frame.size.height, self.frame.size.height/2.0f + self.frame.size.height);
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, 2.5f);
    CGContextSetStrokeColorWithColor(context, [[UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f] CGColor]);
    // Thiet lap style bo goc cua line
    CGContextSetLineJoin(context,kCGLineJoinRound);
    // Bat dau thiet lap che do lam min line
    CGContextSetLineCap(context, kCGLineCapRound);
    
    //CGContextMoveToPoint(context, _MyStartPoint.x, _MyEndPoint.y);
    //--------------------------------------------------------
    float radius = sqrtf(powf(fabsf(_MyEndPoint.x - _MyStartPoint.x), 2.0f) + powf(fabsf(_MyEndPoint.y - _MyStartPoint.y), 2.0f));
    CGContextAddArc(context, _MyStartPoint.x, _MyStartPoint.y, radius, 0, 2*M_PI, 0);
    //CGContextStrokePath(context);
    CGContextSetFillColorWithColor(context, [[UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f] CGColor]);
    CGContextFillPath(context);
}


@end
