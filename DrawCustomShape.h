//
//  DrawCustomShape.h
//  VietGolfVersion1.1
//
//  Created by admin on 9/16/14.
//  Copyright (c) 2014 NguyenDuyThanh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/CALayer.h>

@interface DrawCustomShape : UIView
{
    CGPoint _MyStartPoint;
    CGPoint _MyEndPoint;
}

@property (nonatomic) CGPoint _MyStartPoint;
@property (nonatomic) CGPoint _MyEndPoint;

@end
