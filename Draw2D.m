//
//  Draw2D.m
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import "Draw2D.h"

@implementation Draw2D

@synthesize _FirstTouch;
@synthesize _LastTouch;
@synthesize _FirstTouchCircle, _LastTouchCircle;
@synthesize _FirstTouchRect, _LastTouchRect;
@synthesize _Circle, _Curve, _Line, _Rect;

// Line
static NSMutableArray *pointArray;
static NSMutableArray *lineArray;
// Curve
static NSMutableArray *pointCurveArray;
static NSMutableArray *curveArray;
// Circle
static NSMutableArray *pointCircleArray;
static NSMutableArray *circleArray;
// Rect
static NSMutableArray *pointRectArray;
static NSMutableArray *rectArray;

static float widthShape;

-(id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Khoi tao mang cac mau
        pointCurveArray=[[NSMutableArray alloc]init];
        curveArray=[[NSMutableArray alloc]init];
        
        pointArray=[[NSMutableArray alloc]init];
        lineArray=[[NSMutableArray alloc]init];
        
        pointCircleArray=[[NSMutableArray alloc]init];
        circleArray=[[NSMutableArray alloc]init];
        
        pointRectArray=[[NSMutableArray alloc]init];
        rectArray=[[NSMutableArray alloc]init];
        
        [self setlineWidth:2.5f];
        
        // Initialization code
    }
    return self;
}
// Ham thiet lap do day cho line
-(void)setlineWidth:(float)width
{
    widthShape = width;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
// Phuong thuc drawRect mac dinh la ghi de, co the tuy chinh lai
-(void)drawRect:(CGRect)rect
{
    // Lay boi canh hien tai
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, 2.5f);
    // Thiet lap style bo goc cua line
    CGContextSetLineJoin(context,kCGLineJoinRound);
    // Bat dau thiet lap che do lam min line
    CGContextSetLineCap(context, kCGLineCapRound);
    
    // Luu cac line vao mang array
    
    if ([circleArray count] > 0) {
        for (int i=0; i<[circleArray count]; i++) {
            NSArray * array=[NSArray
                             arrayWithArray:[circleArray objectAtIndex:i]];
            
            if ([array count]>0)
            {
                // Thiet lap mau duong ve trong CGColor thong qua UIColor
                CGContextSetStrokeColorWithColor(context, [[UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f] CGColor]);
                //-------------------------------------------------------
                // Thiet lap do day cua line
                CGContextSetLineWidth(context, widthShape);
                // Ve lai line khac da duoc khai bao
                CGContextBeginPath(context);
                CGPoint myStartPoint = CGPointFromString([array objectAtIndex:0]);
                
                for (int j=0; j<[array count]-1; j++)
                {
                    CGPoint myEndPoint = CGPointFromString([array objectAtIndex:j+1]);
                    //--------------------------------------------------------
                    CGRect currentRect = CGRectMake(
                                                    (myStartPoint.x > myEndPoint.x)?myEndPoint.x : myStartPoint.x,
                                                    (myStartPoint.y > myEndPoint.y)?myEndPoint.y : myStartPoint.y,
                                                    fabsf(myStartPoint.x - myEndPoint.x),
                                                    fabsf(myStartPoint.y - myEndPoint.y));
                    
                    CGContextAddEllipseInRect(context, currentRect);
                    CGContextStrokeEllipseInRect(context, currentRect);
                    
                }
                
            }
        }
    }
    
    if ([curveArray count]>0) {
        for (int i = 0; i<[curveArray count]; i++) {
            NSArray * array=[NSArray
                             arrayWithArray:[curveArray objectAtIndex:i]];
            
            if ([array count]>0)
            {
                CGContextBeginPath(context);
                CGPoint myStartPoint = CGPointFromString([array objectAtIndex:0]);
                CGContextMoveToPoint(context, myStartPoint.x, myStartPoint.y);
                
                for (int j=0; j<[array count]-1; j++)
                {
                    CGPoint myEndPoint = CGPointFromString([array objectAtIndex:j+1]);
                    //--------------------------------------------------------
                    CGContextAddLineToPoint(context, myEndPoint.x,myEndPoint.y);
                }
                
                // Thiet lap mau duong ve trong CGColor thong qua UIColor
                CGContextSetStrokeColorWithColor(context, [[UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f] CGColor]);
                //-------------------------------------------------------
                // Thiet lap do day cua line
                CGContextSetLineWidth(context, widthShape);
                // Ve lai line khac da duoc khai bao
                CGContextStrokePath(context);
            }
        }
    }
    
    if ([lineArray count]>0) {
        for (int i=0; i<[lineArray count]; i++) {
            NSArray * array=[NSArray
                             arrayWithArray:[lineArray objectAtIndex:i]];
            
            if ([array count]>0)
            {
                CGContextBeginPath(context);
                CGPoint myStartPoint=CGPointFromString([array objectAtIndex:0]);
                CGContextMoveToPoint(context, myStartPoint.x, myStartPoint.y);
                
                for (int j=0; j<[array count]-1; j++)
                {
                    CGPoint myEndPoint=CGPointFromString([array objectAtIndex:j+1]);
                    //--------------------------------------------------------
                    CGContextAddLineToPoint(context, myEndPoint.x,myEndPoint.y);
                }
                
                // Thiet lap mau duong ve trong CGColor thong qua UIColor
                CGContextSetStrokeColorWithColor(context, [[UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f] CGColor]);
                //-------------------------------------------------------
                // Thiet lap do day cua line
                CGContextSetLineWidth(context, widthShape);
                // Ve lai line khac da duoc khai bao
                CGContextStrokePath(context);
            }
        }
    }
    
    
    if ([rectArray count] > 0) {
        for (int i = 0; i < [rectArray count]; i++) {
            NSArray * array=[NSArray
                             arrayWithArray:[rectArray objectAtIndex:i]];
            
            if ([array count]>0)
            {
                // Thiet lap mau duong ve trong CGColor thong qua UIColor
                CGContextSetStrokeColorWithColor(context, [[UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f] CGColor]);
                //-------------------------------------------------------
                // Thiet lap do day cua line
                CGContextSetLineWidth(context, widthShape);
                // Ve lai line khac da duoc khai bao
                CGContextBeginPath(context);
                CGPoint myStartPoint=CGPointFromString([array objectAtIndex:0]);
                
                for (int j=0; j<[array count]-1; j++)
                {
                    CGPoint myEndPoint=CGPointFromString([array objectAtIndex:j+1]);
                    //--------------------------------------------------------
                    CGRect currentRect = CGRectMake(
                                                    (myStartPoint.x > myEndPoint.x)?myEndPoint.x : myStartPoint.x,
                                                    (myStartPoint.y > myEndPoint.y)?myEndPoint.y : myStartPoint.y,
                                                    fabsf(myStartPoint.x - myEndPoint.x),
                                                    fabsf(myStartPoint.y - myEndPoint.y));
                    
                    CGContextAddRect(context, currentRect);
                    CGContextStrokeRect(context, currentRect);
                    
                }
                
            }
        }
    }
    
    
    // Hinh ve line hien tai
    if (_Curve) {
        if ([pointCurveArray count] > 0)
        {
            CGContextBeginPath(context);
            CGPoint myStartPoint=CGPointFromString([pointCurveArray objectAtIndex:0]);
            CGContextMoveToPoint(context, myStartPoint.x, myStartPoint.y);
            
            for (int j=0; j<[pointCurveArray count]-1; j++)
            {
                CGPoint myEndPoint=CGPointFromString([pointCurveArray objectAtIndex:j+1]);
                //--------------------------------------------------------
                CGContextAddLineToPoint(context, myEndPoint.x,myEndPoint.y);
            }
            
            CGContextSetStrokeColorWithColor(context, [[UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f] CGColor]);
            //-------------------------------------------------------
            CGContextSetLineWidth(context, widthShape);
            CGContextStrokePath(context);
        }
    }
    else
    {
        if (_Line) {
            if ([pointArray count] > 0)
            {
                CGContextSetStrokeColorWithColor(context, [[UIColor colorWithRed:21.0f/255.0f green:140.0f/255.0f blue:232.0f/255.0f alpha:1.0f] CGColor]);
                //-------------------------------------------------------
                CGContextSetLineWidth(context, widthShape);
                CGContextBeginPath(context);
                CGContextMoveToPoint(context, _FirstTouch.x, _FirstTouch.y);
                
                CGContextAddLineToPoint(context, _LastTouch.x, _LastTouch.y);
                CGContextStrokePath(context);
                
            }
            
        }
        else
        {
            if (_Circle) {
                if ([pointCircleArray count] > 0)
                {
                    CGRect currentRect = CGRectMake(
                                                    (_FirstTouchCircle.x > _LastTouchCircle.x) ? _LastTouchCircle.x : _FirstTouchCircle.x,
                                                    (_FirstTouchCircle.y > _LastTouchCircle.y) ? _LastTouchCircle.y : _FirstTouchCircle.y,
                                                    fabsf(_FirstTouchCircle.x - _LastTouchCircle.x),
                                                    fabsf(_FirstTouchCircle.y - _LastTouchCircle.y));
                    
                    CGContextAddEllipseInRect(context, currentRect);
                    CGContextStrokeEllipseInRect(context, currentRect);
                }
                
            }
            else
            {
                if ([pointRectArray count] > 0)
                {
                    
                    if (_Rect) {
                        CGRect currentRect = CGRectMake(
                                                        (_FirstTouchRect.x > _LastTouchRect.x) ? _LastTouchRect.x : _FirstTouchRect.x,
                                                        (_FirstTouchRect.y > _LastTouchRect.y) ? _LastTouchRect.y : _FirstTouchRect.y,
                                                        fabsf(_FirstTouchRect.x - _LastTouchRect.x),
                                                        fabsf(_FirstTouchRect.y - _LastTouchRect.y));
                        CGContextAddRect(context, currentRect);
                        CGContextStrokeRect(context, currentRect);
                    }
                }
            }
        }
    }
    
}



// Add thong tin line vao mang
-(void)addLA{
    if (_Curve) {
        NSArray *array=[NSArray arrayWithArray:pointCurveArray];
        [curveArray addObject:array];
        pointCurveArray=[[NSMutableArray alloc]init];
    }
    else
    {
        if (_Line) {
            NSArray *array=[NSArray arrayWithArray:pointArray];
            [lineArray addObject:array];
            pointArray=[[NSMutableArray alloc]init];
            
        }
        else
        {
            if (_Circle) {
                NSArray *array=[NSArray arrayWithArray:pointCircleArray];
                [circleArray addObject:array];
                pointCircleArray=[[NSMutableArray alloc]init];
                
            }
            else
            {
                if (_Rect) {
                    NSArray *array=[NSArray arrayWithArray:pointRectArray];
                    [rectArray addObject:array];
                    pointRectArray=[[NSMutableArray alloc]init];
                }
            }
        }
    }
    
}

#pragma mark -
// Bat su kien bat dau cham tay
static CGPoint MyBeganpoint;
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch=[touches anyObject];
    
    if (_Line) {
        _FirstTouch = [touch locationInView:self];
        _LastTouch = [touch locationInView:self];
        
        NSString *sPoint=NSStringFromCGPoint(_FirstTouch);
        [pointArray addObject:sPoint];
    }
    else
    {
        if (_Circle) {
            _FirstTouchCircle = [touch locationInView:self];
            _LastTouchCircle = [touch locationInView:self];
            
            NSString *sPoint=NSStringFromCGPoint(_FirstTouchCircle);
            [pointCircleArray addObject:sPoint];
        }
        else
        {
            if (_Rect) {
                _FirstTouchRect = [touch locationInView:self];
                _LastTouchRect = [touch locationInView:self];
                
                NSString *sPoint=NSStringFromCGPoint(_FirstTouchRect);
                [pointRectArray addObject:sPoint];
                
            }
        }
    }
}
// Bat su kien di chuyen ngon tay
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    if (_Curve) {
        UITouch* touch=[touches anyObject];
        MyBeganpoint=[touch locationInView:self];
        NSString *sPoint=NSStringFromCGPoint(MyBeganpoint);
        [pointCurveArray addObject:sPoint];
        [self setNeedsDisplay];
        
    }
    else
    {
        if (_Line) {
            UITouch *touch = [[touches allObjects] objectAtIndex:0];
            _LastTouch = [touch locationInView:self];
            [self setNeedsDisplay];
        }
        else
        {
            if (_Circle) {
                UITouch *touch = [[touches allObjects] objectAtIndex:0];
                _LastTouchCircle = [touch locationInView:self];
                [self setNeedsDisplay];
            }
            else
            {
                if (_Rect) {
                    UITouch *touch = [[touches allObjects] objectAtIndex:0];
                    _LastTouchRect = [touch locationInView:self];
                    [self setNeedsDisplay];
                }
            }
        }
    }
}
// Bat su kien diem nhac ngon tay
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_Curve) {
        
    }
    else
    {
        if (_Line)
        {
            UITouch *touch = [[touches allObjects] objectAtIndex:0];
            _LastTouch = [touch locationInView:self];
            NSString *sPoint=NSStringFromCGPoint(_LastTouch);
            [pointArray addObject:sPoint];
            
        }
        else
        {
            if (_Circle) {
                UITouch *touch = [[touches allObjects] objectAtIndex:0];
                _LastTouchCircle = [touch locationInView:self];
                NSString *sPoint=NSStringFromCGPoint(_LastTouchCircle);
                [pointCircleArray addObject:sPoint];
                [self setNeedsDisplay];
            }
            else
            {
                if (_Rect) {
                    UITouch *touch = [[touches allObjects] objectAtIndex:0];
                    _LastTouchRect = [touch locationInView:self];
                    NSString *sPoint=NSStringFromCGPoint(_LastTouchRect);
                    [pointRectArray addObject:sPoint];
                    [self setNeedsDisplay];
                }
            }
        }
    }
    
    [self addLA];
    
    
    //    NSArray *array=[NSArray arrayWithArray:pointArray];
    //    [lineArray addObject:array];
    //    NSNumber *num=[[NSNumber alloc]initWithInt:colorCount];
    //    [colorArray addObject:num];
    //    pointArray=[[NSMutableArray alloc]init];
}
// Gui thong bao he thong khi co su kien
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
}

-(void)clear{
    // Loai bo tat ca thong tin cac line
    [curveArray removeAllObjects];
    [pointCurveArray removeAllObjects];
    
    [lineArray removeAllObjects];
    [pointArray removeAllObjects];
    
    [circleArray removeAllObjects];
    [pointCircleArray removeAllObjects];
    
    [rectArray removeAllObjects];
    [pointRectArray removeAllObjects];
    
    [self setNeedsDisplay];
    
}

@end


