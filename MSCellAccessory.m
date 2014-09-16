//
//  MSCellAccessory.m
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import "MSCellAccessory.h"

#import "UIView + AccessViewController.h"

//if you change a UITableViewCell height, accessoryView this will affect change the right margin. so, the coordinates must be fixed. within layoutSubviews, drawRect. ( #issue prior to iOS7 )
#define kFixedPositionX                 (self.superview.frame.size.width - 38.0f)
#define kFlatDetailFixedPositionX       (self.superview.frame.size.width - 58.0f)

#define kAccessoryViewRect              CGRectMake(0, 0, 32.0f, 32.0f)
#define kCircleRect                     CGRectMake(6.0f, 3.5f, 21.0f, 21.0f)
#define kCircleOverlayRect              CGRectMake(2.0f, 12.5f, 29.0f, 21.0f)
#define kCircleShadowOverlayRect        CGRectMake(6.0f, 3.0f, 21.0f, 22.2f)
#define kStrokeWidth                    2.0f
#define kShadowRadius                   4.5f
#define kShadowOffset                   CGSizeMake(0.1f, 1.2f)
#define kShadowColor                    [UIColor colorWithWhite:0 alpha:1.0f]
#define kDetailDisclosurePositon        CGPointMake(20.0f, 14.0f)
#define kDetailDisclosureRadius         5.5f
#define kHighlightedColorGapH           9.0f/360.0f
#define kHighlightedColorGapS           9.5f/100.0f
#define kHighlightedFlatColorGapS       80.0f/100.0f
#define kHighlightedColorGapV          -4.5f/100.0f
#define kOverlayColorGapH               0/360.0f
#define kOverlayColorGapS              -50.0f/255.0f
#define kOverlayColorGapV               15.0f/255.0f

#define kDisclosureStartX               CGRectGetMaxX(self.bounds) - 7.0f
#define kDisclosureStartY               CGRectGetMidY(self.bounds)
#define kDisclosureRadius               4.5f
#define kDisclosureWidth                3.0f
#define kDisclosureShadowOffset         CGSizeMake(0, -1.0f)
#define kDisclosurePositon              CGPointMake(18.0f, 13.5f)

#define kCheckMarkStartX                kAccessoryViewRect.size.width/2.0f + 1.0f
#define kCheckMarkStartY                kAccessoryViewRect.size.height/2.0f - 1.0f
#define kCheckMarkLCGapX                3.5f
#define kCheckMarkLCGapY                5.0f
#define kCheckMarkCRGapX                10.0f
#define kCheckMarkCRGapY                -6.0f
#define kCheckMarkWidth                 2.5f

#define kToggleIndicatorStartX          CGRectGetMaxX(self.bounds) - 10.0f
#define kToggleIndicatorStartY          CGRectGetMidY(self.bounds)
#define kToggleIndicatorRadius          5.5f
#define kToggleIndicatorLineWidth       3.5f

#define kAddIndicatorShadowOffset         CGSizeMake(0, -1.0f)

#define FLAT_ACCESSORY_VIEW_RECT                            CGRectMake(0, 0, 52.0f, 32.0f)
#define FLAT_STROKE_WIDTH                                   1.0f
#define FLAT_DETAIL_CIRCLE_RECT                             CGRectMake(10.5f, 5.5f, 21.0f, 21.0f)
#define FLAT_DETAIL_BUTTON_DOT_FRAME                        CGRectMake(19.6f, 9.5f, 2.6f, 2.6f)
#define FLAT_DETAIL_BUTTON_VERTICAL_WIDTH                   2.0f
#define FLAT_DETAIL_BUTTON_VERTICAL_START_POINT             CGPointMake(21.0f, 13.5f)
#define FLAT_DETAIL_BUTTON_VERTICAL_END_POINT               CGPointMake(21.0f, 21.5f)
#define FLAT_DETAIL_BUTTON_HORIZONTAL_WIDTH                 0.5f
#define FLAT_DETAIL_BUTTON_TOP_HORIZONTAL_START_POINT       CGPointMake(19.0f, 13.5f + FLAT_DETAIL_BUTTON_HORIZONTAL_WIDTH * 0.5f)
#define FLAT_DETAIL_BUTTON_TOP_HORIZONTAL_END_POINT         CGPointMake(21.0f, 13.5f + FLAT_DETAIL_BUTTON_HORIZONTAL_WIDTH * 0.5f)
#define FLAT_DETAIL_BUTTON_BOTTOM_HORIZONTAL_START_POINT    CGPointMake(19.0f, 21.5f + FLAT_DETAIL_BUTTON_HORIZONTAL_WIDTH * 0.5f)
#define FLAT_DETAIL_BUTTON_BOTTOM_HORIZONTAL_END_POINT      CGPointMake(23.0f, 21.5f + FLAT_DETAIL_BUTTON_HORIZONTAL_WIDTH * 0.5f)

#define FLAT_DISCLOSURE_START_X                             CGRectGetMaxX(self.bounds) - 1.5f
#define FLAT_DISCLOSURE_START_Y                             CGRectGetMidY(self.bounds) + 0.25f
#define FLAT_DISCLOSURE_RADIUS                              4.8f
#define FLAT_DISCLOSURE_WIDTH                               2.2f
#define FLAT_DISCLOSURE_SHADOW_OFFSET                       CGSizeMake(0, - 1.0 )
#define FLAT_DISCLOSURE_POSITON                             CGPointMake(18.0f, 13.5f)

#define FLAT_CHECKMARK_START_X                              kAccessoryViewRect.size.width/2.0f + 4.25f
#define FLAT_CHECKMARK_START_Y                              kAccessoryViewRect.size.height/2.0f + 1.25f
#define FLAT_CHECKMARK_LC_GAP_X                             2.5f
#define FLAT_CHECKMARK_LC_GAP_Y                             2.5f
#define FLAT_CHECKMARK_CR_GAP_X                             9.875f
#define FLAT_CHECKMARK_CR_GAP_Y                             -4.375f
#define FLAT_CHECKMARK_WIDTH                                2.125f

#define FLAT_TOGGLE_INDICATOR_START_X                       CGRectGetMaxX(self.bounds)-7.0f
#define FLAT_TOGGLE_INDICATOR_START_Y                       CGRectGetMidY(self.bounds)
#define FLAT_TOGGLE_INDICATOR_RADIUS                        5.0f
#define FLAT_TOGGLE_INDICATOR_LINE_WIDTH                    2.0f

#define kFlatDrawLineWidth                                  1.0f
#define kFlatLineStartX                                     4.5f
#define kFlatLineStartY                                     4.5f
#define kFlatLineWidth                                     11.0f
#define kFlatLineHeight                                     11.0f

@interface MSCellAccessory()
@property (nonatomic, strong) UIColor *accessoryColor;
@property (nonatomic, strong) UIColor *highlightedColor;
@property (nonatomic, strong) NSArray *accessoryColors;
@property (nonatomic, strong) NSArray *highlightedColors;
@end

@implementation MSCellAccessory

#pragma mark - Factory

+(MSCellAccessory *)accessoryWithType:(MSCellAccessoryType)accessoryType color:(UIColor *)color
{
    return [self accessoryWithType:accessoryType color:color highlightedColor:NULL];
}

+(MSCellAccessory *)accessoryWithType:(MSCellAccessoryType)accessoryType color:(UIColor *)color highlightedColor:(UIColor *)highlightedColor
{
    return [[MSCellAccessory alloc] initWithFrame:kAccessoryViewRect color:color highlightedColor:highlightedColor accessoryType:accessoryType];
}

+(MSCellAccessory *)accessoryWithType:(MSCellAccessoryType)accessoryType colors:(NSArray *)colors
{
    if(accessoryType != FLAT_DETAIL_DISCLOSURE)
        return [self accessoryWithType:accessoryType color:colors[0]];
    
    return [self accessoryWithType:accessoryType colors:colors highlightedColors:NULL];
}

+(MSCellAccessory *)accessoryWithType:(MSCellAccessoryType)accessoryType colors:(NSArray *)colors highlightedColors:(NSArray *)highlightedColors
{
    if(accessoryType != FLAT_DETAIL_DISCLOSURE)
        return [self accessoryWithType:accessoryType color:colors[0] highlightedColor:highlightedColors[0]];
    
    return [[MSCellAccessory alloc] initWithFrame:FLAT_ACCESSORY_VIEW_RECT colors:colors highlightedColors:highlightedColors accessoryType:accessoryType];
}

#pragma mark -

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    if(_accType == FLAT_DETAIL_BUTTON || _accType == DETAIL_DISCLOSURE || _accType == PLUS_INDICATOR)
    {
        if(point.x > 0)
            return YES;
    }
    else if(_accType == FLAT_DETAIL_DISCLOSURE)
    {
        if(point.x > -3.0f && point.x < 46.0f)
            return YES;
    }
    
    return [super pointInside:point withEvent:event];
}

-(id)initWithFrame:(CGRect)frame color:(UIColor *)color highlightedColor:(UIColor *)highlightedColor accessoryType:(MSCellAccessoryType)accessoryType
{
    if ((self = [super initWithFrame:frame]))
    {
		self.backgroundColor = [UIColor clearColor];
        self.accessoryColor = color;
        self.accType = accessoryType;
        self.isAutoLayout = YES;
        
        if(!highlightedColor)
        {
            if(_accType >= FLAT_DETAIL_DISCLOSURE)
            {
                if(_accType == FLAT_DETAIL_BUTTON)
                {
                    CGFloat h = 0.0f;
                    CGFloat s = 0.0f;
                    CGFloat v = 0.0f;
                    CGFloat a = 0.0f;
                    // Crash below iOS 5
                    if ([_accessoryColor respondsToSelector:@selector(getHue:saturation:brightness:alpha:)])
                    {
                        [_accessoryColor getHue:&h saturation:&s brightness:&v alpha:&a];
                    }
                    self.highlightedColor = [UIColor colorWithHue:h saturation:s-kHighlightedFlatColorGapS brightness:v alpha:a];
                }
                else
                {
                    self.highlightedColor = self.accessoryColor;
                }
            }
            else
            {
                CGFloat h = 0.0f;
                CGFloat s = 0.0f;
                CGFloat v = 0.0f;
                CGFloat a = 0.0f;
                // Crash below iOS 5
                if ([_accessoryColor respondsToSelector:@selector(getHue:saturation:brightness:alpha:)])
                {
                    [_accessoryColor getHue:&h saturation:&s brightness:&v alpha:&a];
                }
                self.highlightedColor = [UIColor colorWithHue:h+kHighlightedColorGapH saturation:s+kHighlightedColorGapS brightness:v+kHighlightedColorGapV alpha:a];
            }
        }
        else
        {
            self.highlightedColor = highlightedColor;
        }
        
        self.userInteractionEnabled = NO;
        if(_accType == DETAIL_DISCLOSURE || _accType == FLAT_DETAIL_BUTTON)
        {
            [self addTarget:self action:@selector(accessoryButtonTapped:event:) forControlEvents:UIControlEventTouchUpInside];
            self.userInteractionEnabled = YES;
        }
    }
    
    return self;
}

-(id)initWithFrame:(CGRect)frame colors:(NSArray *)colors highlightedColors:(NSArray *)highlightedColors accessoryType:(MSCellAccessoryType)accessoryType
{
    if ((self = [super initWithFrame:frame]))
    {
		self.backgroundColor = [UIColor clearColor];
        self.accessoryColors = colors;
        self.accType = accessoryType;
        self.isAutoLayout = YES;
        
        if(!highlightedColors)
        {
            CGFloat h,s,v,a;
            [colors[0] getHue:&h saturation:&s brightness:&v alpha:&a];
            self.highlightedColors = @[[UIColor colorWithHue:h saturation:s-kHighlightedFlatColorGapS brightness:v alpha:a],colors[1]];
        }
        else
        {
            self.highlightedColors = highlightedColors;
        }
        
        [self addTarget:self action:@selector(accessoryButtonTapped:event:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if(!_isAutoLayout) return;
    //iOS5, iOS6
    if(![NSClassFromString(@"UIMotionEffect") class])
    {
        UITableView *tb = (UITableView *)self.superview.superview;
        
        if(tb.style == UITableViewStylePlain)
        {
            CGRect frame = self.frame;
            if(_accType != FLAT_DETAIL_DISCLOSURE)
                frame.origin.x = kFixedPositionX;
            else
                frame.origin.x = kFlatDetailFixedPositionX;
            self.frame = frame;
        }
    }
}

-(void)accessoryButtonTapped:(id)sender event:(UIEvent *)event
{
    UITableView *superTableView = NULL;
    UITableViewController *superController = NULL;
    UITableViewCell *superTableViewCell = NULL;
    NSIndexPath *indexPath = NULL;
    //iOS7 above
    if([NSClassFromString(@"UIMotionEffect") class])
    {
        superTableView = (UITableView *)self.superview.superview.superview.superview;
        superController = (UITableViewController *)superTableView.firstAvailableUIViewController;
        superTableViewCell = (UITableViewCell *)self.superview.superview;
        indexPath = [superTableView indexPathForCell:superTableViewCell];
    }
    //iOS5, iOS6
    else
    {
        superTableView = (UITableView *)self.superview.superview;
        superController = (UITableViewController *)superTableView.firstAvailableUIViewController;
        superTableViewCell = (UITableViewCell *)self.superview;
        indexPath = [superTableView indexPathForCell:superTableViewCell];
    }
    
    if ([superController respondsToSelector:@selector(tableView:accessoryButtonTappedForRowWithIndexPath:)]) {
        [superController tableView:superTableView accessoryButtonTappedForRowWithIndexPath:indexPath];
    }
    else {
        NSAssert(0, @"superController must implement tableView:accessoryButtonTappedForRowWithIndexPath:");
    }
}

-(void)drawRect:(CGRect)rect
{
    if(_accType == DETAIL_DISCLOSURE)
    {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        UIBezierPath *ddCircle = [UIBezierPath bezierPathWithOvalInRect:kCircleRect];
        
        CGContextSaveGState(ctx);
        {
            CGContextAddEllipseInRect(ctx, kCircleShadowOverlayRect);
            CGContextSetShadowWithColor(ctx, kShadowOffset, kShadowRadius, kShadowColor.CGColor );
            CGContextDrawPath(ctx, kCGPathFill);
        }
        CGContextRestoreGState(ctx);
        
        CGContextSaveGState(ctx);
        {
            CGContextAddPath(ctx, ddCircle.CGPath);
            CGFloat h,s,v,a;
            UIColor *color = NULL;
            color = self.touchInside?_highlightedColor:_accessoryColor;
            [color getHue:&h saturation:&s brightness:&v alpha:&a];
            UIColor *overlayColor = [UIColor colorWithHue:h saturation:s+kOverlayColorGapS brightness:v+kOverlayColorGapV alpha:a];
            CGContextSetFillColorWithColor(ctx, overlayColor.CGColor);
            CGContextDrawPath(ctx, kCGPathFill);
        }
        CGContextRestoreGState(ctx);
        
        CGContextSaveGState(ctx);
        {
            CGContextAddPath(ctx, ddCircle.CGPath);
            CGContextClip(ctx);
            CGContextAddEllipseInRect(ctx, kCircleOverlayRect);
            CGContextSetFillColorWithColor(ctx, self.touchInside?_highlightedColor.CGColor:_accessoryColor.CGColor);
            CGContextDrawPath(ctx, kCGPathFill);
        }
        CGContextRestoreGState(ctx);
        
        CGContextSaveGState(ctx);
        {
            CGContextAddPath(ctx, ddCircle.CGPath);
            CGContextSetLineWidth(ctx, kStrokeWidth);
            CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
            CGContextDrawPath(ctx, kCGPathStroke);
        }
        CGContextRestoreGState(ctx);
        
        CGContextSaveGState(ctx);
        {
            CGContextSetShadowWithColor(ctx, kDisclosureShadowOffset, .0, self.touchInside?_highlightedColor.CGColor:_accessoryColor.CGColor);
            CGContextMoveToPoint(ctx, kDetailDisclosurePositon.x-kDetailDisclosureRadius, kDetailDisclosurePositon.y-kDetailDisclosureRadius);
            CGContextAddLineToPoint(ctx, kDetailDisclosurePositon.x, kDetailDisclosurePositon.y);
            CGContextAddLineToPoint(ctx, kDetailDisclosurePositon.x-kDetailDisclosureRadius, kDetailDisclosurePositon.y+kDetailDisclosureRadius);
            CGContextSetLineWidth(ctx, kDisclosureWidth);
            CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
            CGContextStrokePath(ctx);
        }
        CGContextRestoreGState(ctx);
    }
    else if(_accType == DISCLOSURE_INDICATOR)
    {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextMoveToPoint(ctx, kDisclosureStartX-kDisclosureRadius, kDisclosureStartY-kDisclosureRadius);
        CGContextAddLineToPoint(ctx, kDisclosureStartX, kDisclosureStartY);
        CGContextAddLineToPoint(ctx, kDisclosureStartX-kDisclosureRadius, kDisclosureStartY+kDisclosureRadius);
        CGContextSetLineCap(ctx, kCGLineCapSquare);
        CGContextSetLineJoin(ctx, kCGLineJoinMiter);
        CGContextSetLineWidth(ctx, kDisclosureWidth);
        
        if (self.highlighted)
        {
            [self.highlightedColor setStroke];
        }
        else
        {
            [self.accessoryColor setStroke];
        }
        
        CGContextStrokePath(ctx);
    }
    else if(_accType == CHECKMARK)
    {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextMoveToPoint(ctx, kCheckMarkStartX, kCheckMarkStartY);
        CGContextAddLineToPoint(ctx, kCheckMarkStartX + kCheckMarkLCGapX, kCheckMarkStartY + kCheckMarkLCGapY);
        CGContextAddLineToPoint(ctx, kCheckMarkStartX + kCheckMarkCRGapX, kCheckMarkStartY + kCheckMarkCRGapY);
        CGContextSetLineCap(ctx, kCGLineCapRound);
        CGContextSetLineJoin(ctx, kCGLineJoinRound);
        CGContextSetLineWidth(ctx, kCheckMarkWidth);
        
        if (self.highlighted)
        {
            [self.highlightedColor setStroke];
        }
        else
        {
            [self.accessoryColor setStroke];
        }
        
        CGContextStrokePath(ctx);
    }
    else if(_accType == UNFOLD_INDICATOR)
    {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        CGContextMoveToPoint(   ctx, kToggleIndicatorStartX-kToggleIndicatorRadius, kToggleIndicatorStartY);
        CGContextAddLineToPoint(ctx, kToggleIndicatorStartX,                   kToggleIndicatorStartY+kToggleIndicatorRadius);
        CGContextAddLineToPoint(ctx, kToggleIndicatorStartX+kToggleIndicatorRadius, kToggleIndicatorStartY);
        CGContextSetLineCap(ctx, kCGLineCapSquare);
        CGContextSetLineJoin(ctx, kCGLineJoinMiter);
        CGContextSetLineWidth(ctx, kToggleIndicatorLineWidth);
        
        [self.accessoryColor setStroke];
        
        CGContextStrokePath(ctx);
    }
    else if(_accType == FOLD_INDICATOR)
    {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        CGContextMoveToPoint(   ctx, kToggleIndicatorStartX-kToggleIndicatorRadius, kToggleIndicatorStartY+kToggleIndicatorRadius);
        CGContextAddLineToPoint(ctx, kToggleIndicatorStartX,                   kToggleIndicatorStartY);
        CGContextAddLineToPoint(ctx, kToggleIndicatorStartX+kToggleIndicatorRadius, kToggleIndicatorStartY+kToggleIndicatorRadius);
        CGContextSetLineCap(ctx, kCGLineCapSquare);
        CGContextSetLineJoin(ctx, kCGLineJoinMiter);
        CGContextSetLineWidth(ctx, kToggleIndicatorLineWidth);
        
        [self.accessoryColor setStroke];
        
        CGContextStrokePath(ctx);
    }
    else if(_accType == PLUS_INDICATOR)
    {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        UIBezierPath *ddCircle = [UIBezierPath bezierPathWithOvalInRect:kCircleRect];
        
        CGContextSaveGState(ctx);
        {
            CGContextAddEllipseInRect(ctx, kCircleShadowOverlayRect);
            CGContextSetShadowWithColor(ctx, kShadowOffset, kShadowRadius, kShadowColor.CGColor );
            CGContextDrawPath(ctx, kCGPathFill);
        }
        CGContextRestoreGState(ctx);
        
        CGContextSaveGState(ctx);
        {
            CGContextAddPath(ctx, ddCircle.CGPath);
            CGFloat h,s,v,a;
            UIColor *color = NULL;
            color = self.touchInside?_highlightedColor:_accessoryColor;
            [color getHue:&h saturation:&s brightness:&v alpha:&a];
            UIColor *overlayColor = [UIColor colorWithHue:h saturation:s+kOverlayColorGapS brightness:v+kOverlayColorGapV alpha:a];
            CGContextSetFillColorWithColor(ctx, overlayColor.CGColor);
            CGContextDrawPath(ctx, kCGPathFill);
        }
        CGContextRestoreGState(ctx);
        
        CGContextSaveGState(ctx);
        {
            CGContextAddPath(ctx, ddCircle.CGPath);
            CGContextClip(ctx);
            CGContextAddEllipseInRect(ctx, kCircleOverlayRect);
            CGContextSetFillColorWithColor(ctx, self.touchInside?_highlightedColor.CGColor:_accessoryColor.CGColor);
            CGContextDrawPath(ctx, kCGPathFill);
        }
        CGContextRestoreGState(ctx);
        
        CGContextSaveGState(ctx);
        {
            CGContextAddPath(ctx, ddCircle.CGPath);
            CGContextSetLineWidth(ctx, kStrokeWidth);
            CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
            CGContextDrawPath(ctx, kCGPathStroke);
        }
        CGContextRestoreGState(ctx);
        
        CGContextSaveGState(ctx);
        {
            CGContextSetShadowWithColor(ctx, kAddIndicatorShadowOffset, 0, self.touchInside?_highlightedColor.CGColor:_accessoryColor.CGColor);
            CGContextMoveToPoint(ctx, kDetailDisclosurePositon.x - 3.5f, kDetailDisclosurePositon.y-kDetailDisclosureRadius - 1.0f);
            CGContextAddLineToPoint(ctx, kDetailDisclosurePositon.x - 3.5f, kDetailDisclosurePositon.y + 6.5f);
            CGContextMoveToPoint(ctx, kDetailDisclosurePositon.x - 10.0f, kDetailDisclosurePositon.y);
            CGContextAddLineToPoint(ctx, kDetailDisclosurePositon.x + 3.0f, kDetailDisclosurePositon.y);
            CGContextSetLineWidth(ctx, kDisclosureWidth);
            CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
            CGContextStrokePath(ctx);
        }
        CGContextRestoreGState(ctx);
    }
    else if(_accType == MINUS_INDICATOR)
    {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        UIBezierPath *ddCircle = [UIBezierPath bezierPathWithOvalInRect:kCircleRect];
        
        CGContextSaveGState(ctx);
        {
            CGContextAddEllipseInRect(ctx, kCircleShadowOverlayRect);
            CGContextSetShadowWithColor(ctx, kShadowOffset, kShadowRadius, kShadowColor.CGColor );
            CGContextDrawPath(ctx, kCGPathFill);
        }
        CGContextRestoreGState(ctx);
        
        CGContextSaveGState(ctx);
        {
            CGContextAddPath(ctx, ddCircle.CGPath);
            CGFloat h,s,v,a;
            UIColor *color = NULL;
            color = self.touchInside?_highlightedColor:_accessoryColor;
            [color getHue:&h saturation:&s brightness:&v alpha:&a];
            UIColor *overlayColor = [UIColor colorWithHue:h saturation:s+kOverlayColorGapS brightness:v+kOverlayColorGapV alpha:a];
            CGContextSetFillColorWithColor(ctx, overlayColor.CGColor);
            CGContextDrawPath(ctx, kCGPathFill);
        }
        CGContextRestoreGState(ctx);
        
        CGContextSaveGState(ctx);
        {
            CGContextAddPath(ctx, ddCircle.CGPath);
            CGContextClip(ctx);
            CGContextAddEllipseInRect(ctx, kCircleOverlayRect);
            CGContextSetFillColorWithColor(ctx, self.touchInside?_highlightedColor.CGColor:_accessoryColor.CGColor);
            CGContextDrawPath(ctx, kCGPathFill);
        }
        CGContextRestoreGState(ctx);
        
        CGContextSaveGState(ctx);
        {
            CGContextAddPath(ctx, ddCircle.CGPath);
            CGContextSetLineWidth(ctx, kStrokeWidth);
            CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
            CGContextDrawPath(ctx, kCGPathStroke);
        }
        CGContextRestoreGState(ctx);
        
        CGContextSaveGState(ctx);
        {
            CGContextSetShadowWithColor(ctx, kAddIndicatorShadowOffset, 0, self.touchInside?_highlightedColor.CGColor:_accessoryColor.CGColor);
            CGContextMoveToPoint(ctx, kDetailDisclosurePositon.x - 10.0f, kDetailDisclosurePositon.y);
            CGContextAddLineToPoint(ctx, kDetailDisclosurePositon.x + 3.0f, kDetailDisclosurePositon.y);
            CGContextSetLineWidth(ctx, kDisclosureWidth);
            CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
            CGContextStrokePath(ctx);
        }
        CGContextRestoreGState(ctx);
    }
    else if(_accType == FLAT_DISCLOSURE_INDICATOR)
    {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextMoveToPoint(ctx, FLAT_DISCLOSURE_START_X-FLAT_DISCLOSURE_RADIUS, FLAT_DISCLOSURE_START_Y-FLAT_DISCLOSURE_RADIUS);
        CGContextAddLineToPoint(ctx, FLAT_DISCLOSURE_START_X, FLAT_DISCLOSURE_START_Y);
        CGContextAddLineToPoint(ctx, FLAT_DISCLOSURE_START_X-FLAT_DISCLOSURE_RADIUS, FLAT_DISCLOSURE_START_Y+FLAT_DISCLOSURE_RADIUS);
        CGContextSetLineCap(ctx, kCGLineCapSquare);
        CGContextSetLineJoin(ctx, kCGLineJoinMiter);
        CGContextSetLineWidth(ctx, FLAT_DISCLOSURE_WIDTH);
        
        if (self.highlighted)
        {
            [self.highlightedColor setStroke];
        }
        else
        {
            [self.accessoryColor setStroke];
        }
        
        CGContextStrokePath(ctx);
        
    }
    else if(_accType == FLAT_DETAIL_DISCLOSURE)
    {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        UIBezierPath *markCircle = [UIBezierPath bezierPathWithOvalInRect:FLAT_DETAIL_CIRCLE_RECT];
        
        UIColor *color1 = (UIColor *)_accessoryColors[0];
        UIColor *color2 = (UIColor *)_highlightedColors[0];
        UIColor *color3 = (UIColor *)_accessoryColors[1];
        UIColor *color4 = (UIColor *)_highlightedColors[1];
        
        CGContextSaveGState(ctx);
        {
            CGContextAddPath(ctx, markCircle.CGPath);
            CGContextSetLineWidth(ctx, FLAT_STROKE_WIDTH);
            CGContextSetStrokeColorWithColor(ctx, self.touchInside?color2.CGColor:color1.CGColor);
            CGContextDrawPath(ctx, kCGPathStroke);
            CGContextSetLineCap(ctx, kCGLineCapSquare);
        }
        CGContextRestoreGState(ctx);
        
        CGContextSaveGState(ctx);
        {
            CGContextSetFillColorWithColor(ctx, self.touchInside?color2.CGColor:color1.CGColor);
            
            CGContextFillEllipseInRect(ctx, FLAT_DETAIL_BUTTON_DOT_FRAME);
            
            CGContextSetStrokeColorWithColor(ctx, self.touchInside?color2.CGColor:color1.CGColor);
            
            CGContextSetLineWidth(ctx, FLAT_DETAIL_BUTTON_VERTICAL_WIDTH);
            CGContextMoveToPoint(ctx, FLAT_DETAIL_BUTTON_VERTICAL_START_POINT.x, FLAT_DETAIL_BUTTON_VERTICAL_START_POINT.y);
            CGContextAddLineToPoint(ctx, FLAT_DETAIL_BUTTON_VERTICAL_END_POINT.x, FLAT_DETAIL_BUTTON_VERTICAL_END_POINT.y);
            CGContextStrokePath(ctx);
            
            CGFloat lineWidth = FLAT_DETAIL_BUTTON_HORIZONTAL_WIDTH;
            CGContextSetLineWidth(ctx, lineWidth);
            CGContextMoveToPoint(ctx, FLAT_DETAIL_BUTTON_TOP_HORIZONTAL_START_POINT.x, FLAT_DETAIL_BUTTON_TOP_HORIZONTAL_START_POINT.y);
            CGContextAddLineToPoint(ctx, FLAT_DETAIL_BUTTON_TOP_HORIZONTAL_END_POINT.x, FLAT_DETAIL_BUTTON_TOP_HORIZONTAL_END_POINT.y);
            
            CGContextMoveToPoint(ctx, FLAT_DETAIL_BUTTON_BOTTOM_HORIZONTAL_START_POINT.x, FLAT_DETAIL_BUTTON_BOTTOM_HORIZONTAL_START_POINT.y);
            CGContextAddLineToPoint(ctx, FLAT_DETAIL_BUTTON_BOTTOM_HORIZONTAL_END_POINT.x, FLAT_DETAIL_BUTTON_BOTTOM_HORIZONTAL_END_POINT.y);
            CGContextStrokePath(ctx);
        }
        CGContextRestoreGState(ctx);
        
        CGContextSaveGState(ctx);
        {
            CGContextMoveToPoint(ctx, FLAT_DISCLOSURE_START_X-FLAT_DISCLOSURE_RADIUS, FLAT_DISCLOSURE_START_Y-FLAT_DISCLOSURE_RADIUS);
            CGContextAddLineToPoint(ctx, FLAT_DISCLOSURE_START_X, FLAT_DISCLOSURE_START_Y);
            CGContextAddLineToPoint(ctx, FLAT_DISCLOSURE_START_X-FLAT_DISCLOSURE_RADIUS, FLAT_DISCLOSURE_START_Y+FLAT_DISCLOSURE_RADIUS);
            CGContextSetLineCap(ctx, kCGLineCapSquare);
            CGContextSetLineJoin(ctx, kCGLineJoinMiter);
            CGContextSetLineWidth(ctx, FLAT_DISCLOSURE_WIDTH);
            
            if (self.highlighted)
            {
                [color4 setStroke];
            }
            else
            {
                [color3 setStroke];
            }
            CGContextStrokePath(ctx);
        }
        CGContextRestoreGState(ctx);
    }
    else if(_accType == FLAT_DETAIL_BUTTON)
    {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        UIBezierPath *markCircle = [UIBezierPath bezierPathWithOvalInRect:FLAT_DETAIL_CIRCLE_RECT];
        
        CGContextSaveGState(ctx);
        {
            CGContextAddPath(ctx, markCircle.CGPath);
            CGContextSetLineWidth(ctx, FLAT_STROKE_WIDTH);
            CGContextSetStrokeColorWithColor(ctx, self.touchInside?_highlightedColor.CGColor:_accessoryColor.CGColor);
            CGContextDrawPath(ctx, kCGPathStroke);
            CGContextSetLineCap(ctx, kCGLineCapSquare);
        }
        CGContextRestoreGState(ctx);
        
        CGContextSaveGState(ctx);
        {
            CGContextSetFillColorWithColor(ctx, self.touchInside?_highlightedColor.CGColor:_accessoryColor.CGColor);
            
            CGContextFillEllipseInRect(ctx, FLAT_DETAIL_BUTTON_DOT_FRAME);
            
            CGContextSetStrokeColorWithColor(ctx, self.touchInside?_highlightedColor.CGColor:_accessoryColor.CGColor);
            
            CGContextSetLineWidth(ctx, FLAT_DETAIL_BUTTON_VERTICAL_WIDTH);
            CGContextMoveToPoint(ctx, FLAT_DETAIL_BUTTON_VERTICAL_START_POINT.x, FLAT_DETAIL_BUTTON_VERTICAL_START_POINT.y);
            CGContextAddLineToPoint(ctx, FLAT_DETAIL_BUTTON_VERTICAL_END_POINT.x, FLAT_DETAIL_BUTTON_VERTICAL_END_POINT.y);
            CGContextStrokePath(ctx);
            
            CGFloat lineWidth = FLAT_DETAIL_BUTTON_HORIZONTAL_WIDTH;
            CGContextSetLineWidth(ctx, lineWidth);
            CGContextMoveToPoint(ctx, FLAT_DETAIL_BUTTON_TOP_HORIZONTAL_START_POINT.x, FLAT_DETAIL_BUTTON_TOP_HORIZONTAL_START_POINT.y);
            CGContextAddLineToPoint(ctx, FLAT_DETAIL_BUTTON_TOP_HORIZONTAL_END_POINT.x, FLAT_DETAIL_BUTTON_TOP_HORIZONTAL_END_POINT.y);
            
            CGContextMoveToPoint(ctx, FLAT_DETAIL_BUTTON_BOTTOM_HORIZONTAL_START_POINT.x, FLAT_DETAIL_BUTTON_BOTTOM_HORIZONTAL_START_POINT.y);
            CGContextAddLineToPoint(ctx, FLAT_DETAIL_BUTTON_BOTTOM_HORIZONTAL_END_POINT.x, FLAT_DETAIL_BUTTON_BOTTOM_HORIZONTAL_END_POINT.y);
            CGContextStrokePath(ctx);
        }
        CGContextRestoreGState(ctx);
    }
    else if(_accType == FLAT_CHECKMARK)
    {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextMoveToPoint(ctx, FLAT_CHECKMARK_START_X, FLAT_CHECKMARK_START_Y);
        CGContextAddLineToPoint(ctx, FLAT_CHECKMARK_START_X + FLAT_CHECKMARK_LC_GAP_X, FLAT_CHECKMARK_START_Y + FLAT_CHECKMARK_LC_GAP_Y);
        CGContextMoveToPoint(ctx, FLAT_CHECKMARK_START_X + FLAT_CHECKMARK_LC_GAP_X + 0.5f, FLAT_CHECKMARK_START_Y + FLAT_CHECKMARK_LC_GAP_Y);
        CGContextAddLineToPoint(ctx, FLAT_CHECKMARK_START_X + FLAT_CHECKMARK_CR_GAP_X, FLAT_CHECKMARK_START_Y + FLAT_CHECKMARK_CR_GAP_Y);
        CGContextSetLineCap(ctx, kCGLineCapSquare);
        CGContextSetLineJoin(ctx, kCGLineJoinMiter);
        CGContextSetLineWidth(ctx, FLAT_CHECKMARK_WIDTH);
        
        if (self.highlighted)
        {
            [self.highlightedColor setStroke];
        }
        else
        {
            [self.accessoryColor setStroke];
        }
        
        CGContextStrokePath(ctx);
    }
    else if(_accType == FLAT_UNFOLD_INDICATOR)
    {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        CGContextMoveToPoint(   ctx, FLAT_TOGGLE_INDICATOR_START_X-FLAT_TOGGLE_INDICATOR_RADIUS, FLAT_TOGGLE_INDICATOR_START_Y);
        CGContextAddLineToPoint(ctx, FLAT_TOGGLE_INDICATOR_START_X, FLAT_TOGGLE_INDICATOR_START_Y+FLAT_TOGGLE_INDICATOR_RADIUS);
        CGContextAddLineToPoint(ctx, FLAT_TOGGLE_INDICATOR_START_X+FLAT_TOGGLE_INDICATOR_RADIUS, FLAT_TOGGLE_INDICATOR_START_Y);
        CGContextSetLineCap(ctx, kCGLineCapSquare);
        CGContextSetLineJoin(ctx, kCGLineJoinMiter);
        CGContextSetLineWidth(ctx, FLAT_TOGGLE_INDICATOR_LINE_WIDTH);
        
        [self.accessoryColor setStroke];
        
        CGContextStrokePath(ctx);
    }
    else if(_accType == FLAT_FOLD_INDICATOR)
    {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        CGContextMoveToPoint(   ctx, FLAT_TOGGLE_INDICATOR_START_X-FLAT_TOGGLE_INDICATOR_RADIUS, FLAT_TOGGLE_INDICATOR_START_Y+FLAT_TOGGLE_INDICATOR_RADIUS);
        CGContextAddLineToPoint(ctx, FLAT_TOGGLE_INDICATOR_START_X, FLAT_TOGGLE_INDICATOR_START_Y);
        CGContextAddLineToPoint(ctx, FLAT_TOGGLE_INDICATOR_START_X+FLAT_TOGGLE_INDICATOR_RADIUS, FLAT_TOGGLE_INDICATOR_START_Y+FLAT_TOGGLE_INDICATOR_RADIUS);
        CGContextSetLineCap(ctx, kCGLineCapSquare);
        CGContextSetLineJoin(ctx, kCGLineJoinMiter);
        CGContextSetLineWidth(ctx, FLAT_TOGGLE_INDICATOR_LINE_WIDTH);
        
        [self.accessoryColor setStroke];
        
        CGContextStrokePath(ctx);
    }
    else if(_accType == FLAT_PLUS_INDICATOR)
    {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        UIBezierPath *markCircle = [UIBezierPath bezierPathWithOvalInRect:FLAT_DETAIL_CIRCLE_RECT];
        
        CGContextSaveGState(ctx);
        {
            CGContextSetShadowWithColor(ctx, CGSizeMake(0, 2.5f), 0, [UIColor colorWithWhite:243/255.0f alpha:1.0f].CGColor);
            CGContextAddPath(ctx, markCircle.CGPath);
            CGContextDrawPath(ctx, kCGPathFill);
            CGContextSetBlendMode (ctx, kCGBlendModeNormal);
        }
        CGContextRestoreGState(ctx);
        
        CGContextSaveGState(ctx);
        {
            CGContextSetStrokeColorWithColor(ctx, _accessoryColor.CGColor);
            CGContextAddPath(ctx, markCircle.CGPath);
            CGContextSetFillColorWithColor(ctx, _accessoryColor.CGColor);
            CGContextDrawPath(ctx, kCGPathFillStroke);
            CGContextAddPath(ctx, markCircle.CGPath);
            CGContextDrawPath(ctx, kCGPathFillStroke);
            CGContextFillPath(ctx);
        }
        CGContextRestoreGState(ctx);
        
        CGContextSaveGState(ctx);
        {
            CGContextSetShadowWithColor(ctx, kAddIndicatorShadowOffset, 0, self.touchInside?_highlightedColor.CGColor:_accessoryColor.CGColor);
            CGContextMoveToPoint(ctx, FLAT_DETAIL_CIRCLE_RECT.origin.x + FLAT_DETAIL_CIRCLE_RECT.size.width/2.0f - kFlatDrawLineWidth/2.0f, FLAT_DETAIL_CIRCLE_RECT.origin.y + kFlatLineStartY);
            CGContextAddLineToPoint(ctx, FLAT_DETAIL_CIRCLE_RECT.origin.x + FLAT_DETAIL_CIRCLE_RECT.size.width/2.0f - kFlatDrawLineWidth/2.0f, FLAT_DETAIL_CIRCLE_RECT.origin.y + kFlatLineStartY + kFlatLineHeight);
            CGContextMoveToPoint(ctx, FLAT_DETAIL_CIRCLE_RECT.origin.x + kFlatLineStartX, FLAT_DETAIL_CIRCLE_RECT.origin.y + FLAT_DETAIL_CIRCLE_RECT.size.height/2.0f - kFlatDrawLineWidth/2.0f);
            CGContextAddLineToPoint(ctx, FLAT_DETAIL_CIRCLE_RECT.origin.x + kFlatLineStartX + kFlatLineWidth, FLAT_DETAIL_CIRCLE_RECT.origin.y + FLAT_DETAIL_CIRCLE_RECT.size.height/2.0f - kFlatDrawLineWidth/2.0f);
            CGContextSetLineWidth(ctx, kFlatDrawLineWidth);
            CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
            CGContextStrokePath(ctx);
        }
        CGContextRestoreGState(ctx);
    }
    else if(_accType == FLAT_MINUS_INDICATOR)
    {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        UIBezierPath *markCircle = [UIBezierPath bezierPathWithOvalInRect:FLAT_DETAIL_CIRCLE_RECT];
        
        CGContextSaveGState(ctx);
        {
            CGContextSetShadowWithColor(ctx, CGSizeMake(0, 2.5f), 0, [UIColor colorWithWhite:243.0f/255.0f alpha:1.0f].CGColor);
            CGContextAddPath(ctx, markCircle.CGPath);
            CGContextDrawPath(ctx, kCGPathFill);
            CGContextSetBlendMode (ctx, kCGBlendModeNormal);
        }
        CGContextRestoreGState(ctx);
        
        CGContextSaveGState(ctx);
        {
            CGContextSetStrokeColorWithColor(ctx, _accessoryColor.CGColor);
            CGContextAddPath(ctx, markCircle.CGPath);
            CGContextSetFillColorWithColor(ctx, _accessoryColor.CGColor);
            CGContextDrawPath(ctx, kCGPathFillStroke);
            CGContextAddPath(ctx, markCircle.CGPath);
            CGContextDrawPath(ctx, kCGPathFillStroke);
            CGContextFillPath(ctx);
        }
        CGContextRestoreGState(ctx);
        
        CGContextSaveGState(ctx);
        {
            CGContextSetShadowWithColor(ctx, kAddIndicatorShadowOffset, 0, self.touchInside?_highlightedColor.CGColor:_accessoryColor.CGColor);
            CGContextMoveToPoint(ctx, FLAT_DETAIL_CIRCLE_RECT.origin.x + kFlatLineStartX, FLAT_DETAIL_CIRCLE_RECT.origin.y + FLAT_DETAIL_CIRCLE_RECT.size.height/2.0f - kFlatDrawLineWidth/2.0f);
            CGContextAddLineToPoint(ctx, FLAT_DETAIL_CIRCLE_RECT.origin.x + kFlatLineStartX + kFlatLineWidth, FLAT_DETAIL_CIRCLE_RECT.origin.y + FLAT_DETAIL_CIRCLE_RECT.size.height/2.0f - kFlatDrawLineWidth/2.0f);
            CGContextSetLineWidth(ctx, kFlatDrawLineWidth);
            CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
            CGContextStrokePath(ctx);
        }
        CGContextRestoreGState(ctx);
    }
    
    if(!_isAutoLayout) return;
    
    //iOS5, iOS6
    if(![NSClassFromString(@"UIMotionEffect") class])
    {
        UITableView *tb = (UITableView *)self.superview.superview;
        
        if(tb.style == UITableViewStylePlain)
        {
            CGRect frame = self.frame;
            if(_accType != FLAT_DETAIL_DISCLOSURE)
                frame.origin.x = kFixedPositionX;
            else
                frame.origin.x = kFlatDetailFixedPositionX;
            self.frame = frame;
        }
        else
        {
            CGRect frame = self.frame;
            if(_accType != FLAT_DETAIL_DISCLOSURE)
                frame.origin.x = kFixedPositionX - 10.0f;
            else
                frame.origin.x = kFlatDetailFixedPositionX;
            self.frame = frame;
        }
    }
}

-(void)setHighlighted:(BOOL)highlighted
{
	[super setHighlighted:highlighted];
    
	[self setNeedsDisplay];
}

-(UIColor *)accessoryColor
{
	if (!_accessoryColor)
	{
		return [UIColor blackColor];
	}
    
	return _accessoryColor;
}

-(UIColor *)highlightedColor
{
	if (!_highlightedColor)
	{
		return [UIColor whiteColor];
	}
    
	return _highlightedColor;
}
@end


